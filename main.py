from flask import Flask, jsonify, render_template, request, make_response
from trained import *
from flask_cors import CORS
import base64

app = Flask(__name__)
CORS(app)

@app.route('/', methods=['POST', 'GET'])
def index():
    if request.method == 'GET':
        return render_template('index.html')
    response = make_response()
    response.headers.add("Access-Control-Allow-Origin", "*")
    base64String = str.encode(request.json['base64Image'][23:])

    with open("uploads/img.jpg", "wb") as fh:
        fh.write(base64.decodebytes(base64String))

    result = classify('uploads/img.jpg')

    return jsonify(result), 200

if __name__ == '__main__':
    app.run(debug=True)