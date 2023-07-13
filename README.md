## build and run
```sh
git clone -b demo https://github.com/ole-hansen/docker-flask-sgx.git
docker compose up -d --build
```

## query server
We generate log entries through querying both servers running inside the their respective containers

```sh
docker exec -it flask-sgx curl localhost:5000/
docker exec -it flask-vanilla curl localhost:5000/
```

## observe: We can read the content of the logfile inside the vanilla container
```sh
docker exec -it flask-vanilla cat data/flask.log
``` 

## observe: We CAN'T read the content of the logfile in use by the sgx process
```sh
docker exec -it flask-sgx cat /data/flask.log
```
Terminating the SGX process would lead to a container shutdown. The content of the logfile will be encrypted.
