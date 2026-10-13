import os
from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def home():
    return jsonify({
        "status": "ok",
        "service": "toko-makanan",
        "instance": os.getenv("INSTANCE_NAME", "unknown")
    })


@app.route("/health")
def health():
    return jsonify({
        "status": "healthy",
        "instance": os.getenv("INSTANCE_NAME", "unknown")
    }), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)