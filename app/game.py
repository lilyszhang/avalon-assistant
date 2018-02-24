import random
from constants import Constants
from player import Player

class Game(object):

    def __init__(self):
        self.players = []

    def add_player(self, uuid, name):
        self.players.append(Player(uuid, name))
        return self.players

    def assign_roles(self):
        # random.shuffle(self.players)
        #
        # num_bad_players = 2 if len(self.players) in [5, 6] else 3 if len(self.players) in [7, 8, 9] else 4
        #
        # for player in self.players[2:num_bad_players + 2]:
        #     player.team = Constants.TEAM_BAD
        #     player.role = Constants.ROLE_BAD_NORMAL
        #
        self.players[0].role = Constants.ROLE_MERLIN
        # self.players[1].role = Constants.ROLE_ASSASSIN
        # self.players[1].team = Constants.TEAM_BAD

        return self.players
