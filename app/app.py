from flask import Flask, request, jsonify
import click

from game import Game

app = Flask(__name__)
game = Game()

@app.route('/join', methods=['GET','POST'])
def join():
    click.echo('New player joined')

    json = request.get_json()
    players = game.add_player(json['id'], json['name'])
    return jsonify({'player_count': len(players)})

@app.route('/start', methods=['POST'])
def start():
    click.echo('Starting game')

    special_roles = request.get_json()
    # click.echo(special_roles)
    players = game.assign_roles(special_roles)
    serialized_players = [player.serialize() for player in players]
    return jsonify(serialized_players)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
