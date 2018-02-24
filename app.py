from flask import Flask, request
import json
app = Flask(__name__)

@app.route('/join', methods=['GET','POST'])
def join():
    print 'hi'

if __name__ == '__main__':
    app.run(debug = True)
