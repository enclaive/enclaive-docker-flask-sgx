from flask import Flask
import logging

app = Flask(__name__)

@app.route('/')
def hello():
    with open('/app/static/message.txt', 'r') as file:
        file_content = file.read()
        write_to_log_file("[GET] Sending: " + file_content)
        return file_content + '\n'

def write_to_log_file(message):
    log_file_path = '/app/data/flask.log'

    with open(log_file_path, 'a') as file:
        file.write(message + '\n')