from flask import Flask

app = Flask(__name__)


@app.route("/")
def hello():
    return "Hello, World!"


@app.route("/debugger/<number>")
def debugger(number):
    number = int(number) + 10
    return f"Hello, Debugger {number}!"


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")
