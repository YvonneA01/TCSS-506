from flask import Flask, jsonify
import datetime

app = Flask(__name__)

@app.route('/<student_name>')
def hello_student(student_name):
    return f"Hello world from {student_name}"

@app.route('/datetime')
def current_datetime():
    now = datetime.datetime.now()
    return jsonify({'datetime': now.strftime("%Y-%m-%d %H:%M:%S")})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

