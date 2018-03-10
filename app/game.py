import random
from constants import Constants
from player import Player

class Game(object):

    def __init__(self):
        self.players = []

    def add_player(self, uuid, name):
        self.players.append(Player(uuid, name))
        return self.players

    def assign_roles(self, special_roles):
        # random.shuffle(self.players)
        roles = [role for role, value in special_roles.items() if value]

        # get number of bad players
        num_bad_players = 2 if len(self.players) in [5, 6] else 3 if len(self.players) in [7, 8, 9] else 4

        self.players[0].role = Constants.ROLE['MERLIN']
        self.players[1].role = Constants.ROLE['ASSASSIN']
        self.players[1].team = Constants.TEAM['BAD']

        if 'percival' in roles:
            self.players[-1].role = Constants.ROLE['PERCIVAL']
            roles.remove('percival')

        counter = 0  # for iterating through the roles

        for player in self.players[2:num_bad_players + 1]:
            player.team = Constants.TEAM['BAD']
            if counter < len(roles):
                player.role = Constants.ROLE[roles[counter].upper()]
                counter += 1
            else:
                player.role = Constants.ROLE['BAD_NORMAL']

        # for player in self.players:
        #     print([player.team, player.role])

        return self.players
