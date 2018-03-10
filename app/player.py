from constants import Constants

class Player(object):

    def __init__(self, uuid, name):
        self.id = uuid
        self.name = name
        self.team = Constants.TEAM['GOOD']
        self.role = Constants.ROLE['GOOD_NORMAL']

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'team': self.team,
            'role': self.role
        }
