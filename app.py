from flask import Flask, request
import click
import json
app = Flask(__name__)

@app.route('/join', methods=['GET','POST'])
def join():
    json = request.get_json()
    click.echo(json['name'])
    return 'placeholder'

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
