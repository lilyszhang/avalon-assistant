from constants import Constants

class Player(object):

    def __init__(self, uuid, name):
        self.id = uuid
        self.name = name
        self.team = Constants.TEAM_GOOD
        self.role = Constants.ROLE_GOOD_NORMAL
