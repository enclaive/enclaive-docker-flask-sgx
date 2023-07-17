# Flask-SGX Demo: file encryption and integrity
In this demo we will show gramine-sgx's capabilities of file encryption and its ability to prevent file tampering.

## build and run the demo
```sh
git clone -b demo git@github.com:enclaive/enclaive-docker-flask-sgx.git
docker compose up -d --build
```
## query both server

```sh
docker exec -it flask-vanilla curl localhost:5000/
docker exec -it flask-sgx curl localhost:5000/
```
Querying the servers will generate log entries and let the servers return contents of a static file as a reply. We will use this to show the different behaviour of the servers storing the log files and their reaction to tampering with static files. 

## Encrypted files
### Vanilla:
```sh
docker exec -it flask-vanilla cat data/flask.log
``` 
We can see that the vanilla container shows the content of our log to the host system in plaintext.
### SGX:
```sh
docker exec -it flask-sgx cat /data/flask.log | xxd
``` 
For our SGX container we defined the `/data/`-folder as an encrypted location. This results in files created or present on startup to be encrypted. We can observe that the content written to the log file is no longer visible to the host system and only readable inside the SGX enclave. Therefore we can effectively hide certain info from the host system. 

## Trusted files
### Vanilla:
```sh
docker exec -it flask-vanilla bash -c "echo 'Goodbye Vanilla' > /app/static/message.txt"
docker exec -it flask-vanilla curl localhost:5000/
```
We modify the content of the static file that is served as reply with each request to the server. The flask app running inside the vanilla container will serve the updated content without issues.
### SGX:
```sh
docker exec -it flask-sgx bash -c "echo 'Goodbye SGX' > /app/static/message.txt"
docker exec -it flask-sgx curl localhost:5000/
```
Trying the same within the SGX container will lead to a `500`-error from the endpoint.

```sh
docker exec -it flask-sgx cat flask-gramine-sgx.log
```
Looking at the gramine log we can see that the static file will not be accepted since its hash value
no longer matches the initial value at startup. Hence we are able to prevent unnoticed tampering on predefined files by the host system.