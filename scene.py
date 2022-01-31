class Scene:
    id = ''
    numDoors = 0
    numShelves = 0
    numCreatures = 0
    numButtons = 0
    numSlabs = 0
    numBoxes = 0
    numPortals = 0
    numWalls = 0
    numStairs = 0
    msj = ''

    def __init__(self, idScene, doors, boxes, slabs, shelves, creatures, walls, portals, buttons, stairs, desc):
        self.interactions = []
        self.props = []
        self.id = idScene
        self.numDoors = doors
        self.numBoxes = boxes
        self.numCreatures = creatures
        self.numSlabs = slabs
        self.numPortals = portals
        self.numButtons = buttons
        self.numWalls = walls
        self.numShelves = shelves
        self.numStairs = stairs
        self.msj = desc

    def getID(self):
        return self.id

    def getNumDoors(self):
        return self.numDoors

    def getNumBoxes(self):
        return self.numBoxes

    def getNumCreatures(self):
        return self.numCreatures

    def getNumPortals(self):
        return self.numPortals

    def getNumButtons(self):
        return self.numButtons

    def getNumWalls(self):
        return self.numWalls

    def getNumSlabs(self):
        return self.numSlabs

    def getNumShelves(self):
        return self.numShelves

    def getNumStairs(self):
        return self.numStairs

    def getDescription(self):
        return self.msj

    def getInteractions(self):
        return self.interactions

    def getProps(self):
        return self.props

    def addInteraction(self, action):
        self.interactions.append(action)

    def addProp(self, newProp):
        self.props.append(newProp)

    def removeProp(self, idProp):
        self.props.remove(self.getProp(idProp))

    def getProp(self, idProp):
        for prop in self.props:
            if prop.getID() == idProp:
                return prop
        return None
