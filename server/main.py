from flask import Flask, jsonify
from cache import Cacher

app = Flask(__name__)
app.debug = True

Cacher = Cacher()

# this returns the dictionary object returned by Cache object as JSON
@app.route("/cache")
def getCachedJSON():
    return jsonify(Cacher.getCache()), 200

if __name__ == "__main__":
    app.run(port=5000)