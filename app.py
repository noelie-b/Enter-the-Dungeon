from flask import Flask, flash, render_template, request, redirect, url_for, Markup
from lxml import etree

app = Flask(__name__)
app.secret_key = 'la vie est belle'

from player import Player
from interaction import Interaction
from prop import Prop
from scene import Scene
from world import World

global player
world = World()
player = world.getPlayer()
global valid
interactions = []
info = True
global nextScene


def validate(fichier):

    parser = etree.XMLParser(dtd_validation=True)
    fichier_xslt = "map.xsl"
    dom = etree.parse(fichier)  # XML file
    xslt = etree.parse(fichier_xslt)  # XSLT file
    transform = etree.XSLT(xslt)
    newdom = transform(dom)
    newdom.write("static/map.svg")
    try:
        global valid
        valid = etree.parse(fichier, parser=parser)

        return "Le document XML est bien formé et valide."
    except etree.XMLSyntaxError as error:
        return repr(error)



def load():
    # player
    nodeList = valid.findall('.//player')
    for i in range(len(nodeList)):
        attrList = []
        attrList = nodeList[i].items()
        player.setCurrentScene(attrList[0][1])

    # scene
    nodeList = valid.findall('.//scene')
    for i in range(len(nodeList)):
        id = ""
        numDoors = 0
        numBoxes = 0
        numSlabs = 0
        numShelves = 0
        numCreatures = 0
        numWalls = 0
        numPortals = 0
        numButtons = 0
        numStairs = 0
        msj = ""
        attrList = []

        # attributes
        attrList = nodeList[i].items()
        for j in range(len(attrList)):
            if attrList[j][0] == "id":
                id = attrList[j][1]
            elif attrList[j][0] == "numDoors":
                numDoors = attrList[j][1]
            elif attrList[j][0] == "numBoxes":
                numBoxes = attrList[j][1]
            elif attrList[j][0] == "numSlabs":
                numSlabs = attrList[j][1]
            elif attrList[j][0] == "numShelves":
                numShelves = attrList[j][1]
            elif attrList[j][0] == "numCreatures":
                numCreatures = attrList[j][1]
            elif attrList[j][0] == "numWalls":
                numWalls = attrList[j][1]
            elif attrList[j][0] == "numPortals":
                numPortals = attrList[j][1]
            elif attrList[j][0] == "numButtons":
                numButtons = attrList[j][1]
            elif attrList[j][0] == "numStairs":
                numStairs = attrList[j][1]
            elif attrList[j][0] == "msj":
                msj = attrList[j][1]
        global scene
        scene = Scene(id, numDoors, numBoxes, numSlabs, numShelves, numCreatures,
                      numWalls, numPortals, numButtons, numStairs, msj)

        # actions
        actionList = nodeList[i].findall('.//action')
        for j in range(len(actionList)):
            variable = ""
            msj = ""
            attrList = []

            attrList = actionList[j].items()
            for k in range(len(attrList)):
                if attrList[k][0] == "dest":
                    variable = attrList[k][1]
                elif attrList[k][0] == "msj":
                    msj = attrList[k][1]
            scene.addInteraction(Interaction(variable, msj))

        world.addScene(scene)

    # props
    nodeList = valid.findall('.//prop')
    for i in range(len(nodeList)):
        id = ""
        kind = ""
        state = ""
        param01 = ""
        param02 = ""
        attrList = []

        # attributes
        attrList = nodeList[i].items()
        for j in range(len(attrList)):
            if attrList[j][0] == "id":
                id = attrList[j][1]
            elif attrList[j][0] == "kind":
                kind = attrList[j][1]
            elif attrList[j][0] == "state":
                state = attrList[j][1]
            elif attrList[j][0] == "scene01":
                param01 = attrList[j][1]
            elif attrList[j][0] == "scene02":
                param02 = attrList[j][1]
            elif attrList[j][0] == "unlock":
                param02 = attrList[j][1]

        if kind == "door" or kind == "stairs" or kind == "creature" or kind == "portal":
            prop = Prop(id, kind, state, param01, param02)
        elif kind == "box" or kind == "shelves" or kind == "button" or kind == "slab" or kind == "wall":
            prop = Prop(id, kind, param01, param02)
        else:
            break

        # actions
        actionList = nodeList[i].findall('.//action')
        for j in range(len(actionList)):
            variable = ""
            msj = ""

            attrList = actionList[j].items()
            for k in range(len(attrList)):
                if attrList[k][0] == "condition":
                    variable = attrList[k][1]
                elif attrList[k][0] == "msj":
                    msj = attrList[k][1]
            prop.addInteraction(Interaction(variable, msj))

        scene = world.getScene(param01)
        scene.addProp(prop)

        if kind == "door" or kind == "stairs" or kind == "creature" or kind == "portal" and param01 != param02:
            scene = world.getScene(param02)
            scene.addProp(prop)


@app.route('/', methods=["GET", "POST"])
def main():
    if request.method == 'POST':
        fichier = request.form['fichier']
        result = validate(fichier)
        if result == "Le document XML est bien formé et valide.":
            load()
            flash(result)
            return redirect(url_for('main'))
        else:
            flash(result)
            return redirect(url_for('main'))
    else:
        return render_template("index.html")

# Point on the map
def showPlayer():
    xml = etree.parse('static/map.svg')
    svg = xml.getroot()
    player_id = scene.getID()  # current scene's ID
    # visibility attribute is in the rect tag
    rect = svg.findall(".//{http://www.w3.org/2000/svg}rect")
    for elem in rect:
        id = elem.get("id")
        visibility = elem.get("style")

        if id == player_id and visibility == "visibility:hidden":

            elem.set("style", "visibility:visible'")
            xml.write("static/map.svg")

def hidePlayer():
    xml = etree.parse('static/map.svg')
    svg = xml.getroot()
    player_id = player.getCurrentScene()  # current scene's ID
    # visibility attribute is in the rect tag
    rect = svg.findall(".//{http://www.w3.org/2000/svg}rect")
    for elem in rect:
        id = elem.get("id")
        visibility = elem.get("style")
        if id != player_id:
            if visibility:
                elem.set("style", "visibility:hidden")
                xml.write("static/map.svg")

def showScene():
    xml = etree.parse('static/map.svg')
    svg = xml.getroot()
    scene_id = scene.getID()
    g = svg.findall(".//{http://www.w3.org/2000/svg}g")
    for elem in g:
        id = elem.get("id")
        visibility = elem.get("style")
        if id == scene_id and visibility == "visibility:hidden":
            elem.set("style", "visibility:visible")
            xml.write("static/map.svg")



@app.route('/game.html', methods=["GET", "POST"])
def startGame():
    global interactions
    global scene
    global nextScene
    global info
    info = request.args.get('info')
    if request.method == 'POST':
        answer = int(request.form.get('answer'))
        dest = interactions[answer].getVariable()
        prop = scene.getProp(dest)

        kind = prop.getType()
        state = prop.getState()
        param01 = prop.getParam01()
        param02 = prop.getParam02()
        interactions = prop.getInteractions()
        if kind == "door" or kind == "creature" or kind == "stairs" or kind == "portal":
            if (state is True):
                msj = "open"
                info = True
                if (player.getCurrentScene() == param01):
                    if (param02 == param01):
                        info = False
                    else:
                        if param02 == "final" or param02 == "final_alt":  # Other ending
                            nextScene = False
                        player.setCurrentScene(param02)
                elif (player.getCurrentScene() == param02):
                    if (param01 == param02):
                        info = False
                    else:
                        if param01 == "final" or param01 == "final_alt":  # Other ending
                            nextScene = False
                        player.setCurrentScene(param01)
            else:
                msj = "closed"
                info = False
            for i in range(len(interactions)):
                if (interactions[i].getVariable() == msj):
                    msj = interactions[i].getDescription()
        elif kind == "box" or kind == "shelves" or kind == "slab" or kind == "button" or kind == "wall":
            prop = world.getProp(param02)
            if (prop != None):
                prop.openProp()
            msj = interactions[0].getDescription()
            info = False
        if (nextScene):
            hidePlayer()
            scene = world.getScene(player.getCurrentScene())
            print(player.getCurrentScene())
            showScene()
            showPlayer()
            nextScene = True
            interactions = scene.getInteractions()
            flash(msj)
            return redirect(url_for('startGame'))
        else:
            return render_template("final.html", msj=world.getScene(player.getCurrentScene()).getDescription())

    else:
        scene = world.getScene(player.getCurrentScene())
        nextScene = True
        interactions = scene.getInteractions()
        return render_template("game.html", interactions=interactions, msj=scene.getDescription(),
                               len=(len(interactions)))


if __name__ == '__main__':
    app.run(debug=True)