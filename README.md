# docker-maltrak

### Build the Caldera image


`sudo docker build -t caldera .`

**note:** the `-t` flag is to tag your Docker image with a name


### Run the image in a detached container & map ports

`sudo docker run -d -p 8888:8888 --name caldera-demo3 caldera`

**note:** port mapping is <host_port>:<container_port>


### Run an interactive shell in container

`sudo docker exec -it caldera-demo3 bash`

This opens up the container's bash where we can run `venv/bin/python server.py --insecure`


### Login to Caldera on host machine

Once the systems are ready, in your host machine:

`sudo docker inspect caldera-demo3 | grep IPAddress`

then in your browser, add that IP followed by the mapped port ex: `http://172.1x.x.x:8888/`