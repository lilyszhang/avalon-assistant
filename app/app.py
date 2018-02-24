from flask import Flask, request, jsonify
import click

from game import Game

app = Flask(__name__)
game = Game()

@app.route('/join', methods=['GET','POST'])
def join():
    json = request.get_json()
    click.echo(json)
    players = game.add_player(json['uuid'], json['name'])
    return jsonify({'player_count': len(players)})

@app.route('/start', methods['GET'])
def start():
    players = game.assign_roles()
    return jsonify(players)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
