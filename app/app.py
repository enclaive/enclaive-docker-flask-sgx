from flask import Flask
import logging

app = Flask(__name__)

@app.route('/')
def hello():
    write_to_log_file("Sensitive Log Entry")
    return 'Hello there!\n'


def write_to_log_file(message):
    log_file_path = '/app/data/flask.log'

    with open(log_file_path, 'a') as file:
        file.write(message + '\n')