from flask import Flask
import logging

app = Flask(__name__)

@app.route('/')
def hello():
    file_content = read_file('/app/static/message')
    write_to_log_file("RETURN: " + file_content)
    return file_content + '\n'

def read_file(file_name):
    with open(file_name, 'r') as file:
        content = file.read()
    return content

def write_to_log_file(message):
    log_file_path = '/app/data/flask.log'

    with open(log_file_path, 'a') as file:
        file.write(message + '\n')