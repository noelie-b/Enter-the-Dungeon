class Prop:

    def __init__(self, *args):
        self.id = ''
        self.type = ''
        self.param01 = ''
        self.param02 = ''
        self.state = ''
        self.interactions = []

        if len(args) == 5:
            self.id = args[0]
            self.type = args[1]
            self.state = eval(args[2])
            self.param01 = args[3]
            self.param02 = args[4]
        elif len(args) == 4:
            self.id = args[0]
            self.type = args[1]
            self.param01 = args[2]
            self.param02 = args[3]

    def getID(self):
        return self.id

    def getType(self):
        return self.type

    def getState(self):
        return self.state

    def getParam01(self):
        return self.param01

    def getParam02(self):
        return self.param02

    def getInteractions(self):
        return self.interactions

    def addInteraction(self, action):
        self.interactions.append(action)

    def openProp(self):
        if (self.state == False):
            self.state = True
