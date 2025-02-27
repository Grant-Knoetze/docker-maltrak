# docker-maltrak

## Configs
In addition to creating a virtual environment within the Docker container, the file `local.yml` is copied into `caldera/conf/` for customized server configuration. Modify its values before building the image or within the container's shell, before running `server.py`

For documentation on the configurations, see [Caldera's Server Configuration](https://caldera.readthedocs.io/en/latest/Server-Configuration.html#configuration-file)

## Linux

### Build the Caldera image


`sudo docker build -t caldera .`

**note:** the `-t` flag is to tag your Docker image with a name


### Run the image in a detached container & map ports

`sudo docker run -d -p 8888:8888 --name caldera-demo3 caldera`
**note:** port mapping is <host_port>:<container_port>


### Run an interactive shell in container

`sudo docker exec -it caldera-demo3 bash`

This opens up the container's bash where we can run `venv/bin/python server.py -E local`

### Login to Caldera on host machine

Once the systems are ready, in your host machine:

`sudo docker inspect caldera-demo3 | grep IPAddress`

then in your browser, add that IP followed by the mapped port ex: `http://172.1x.x.x:8888/`

## Windows

There are 2 Methods to setup the Caldera docker image on Windows:

1. Manual Setup

2. Windows Batch Script

## Method 1: Manual Setup

### Prerequisites
If you have downloaded Docker Desktop for Windows, 

- Ensure you have installed [WSL](https://docs.docker.com/desktop/install/windows-install/#system-requirements)

- Turn on Docker [Desktop WSL ](https://docs.docker.com/desktop/wsl)

### Build the Caldera image


`docker build -t caldera .`

**note:** the `-t` flag is to tag your Docker image with a name


### Run the image in a detached container & map ports

`docker run -d -p 8888:8888 --name caldera-demo3 caldera`
**note:** port mapping is <host_port>:<container_port>


### Run an interactive shell in container

`docker exec -it caldera-demo3 bash`

This opens up the container's bash where we can run `venv/bin/python server.py -E local`

### Login to Caldera on host machine

To access the Caldera web interface on your host machine:

- Open the Docker Desktop application
- Click on the "Containers/Apps" tab
- Locate the `caldera-demo3` container and copy the IP address listed under the "IPAddress" column
- Open a web browser and navigate to http://<IPAddress>:8888/


## Method 2: Windows Batch Script
### Prerequisites


- Ensure you have installed [WSL's](https://docs.docker.com/desktop/install/windows-install/#system-requirements) latest release
- Ensure you have [Docker](https://docs.docker.com/desktop/install/windows-install/) installed 
- Turn on Docker [Desktop WSL ](https://docs.docker.com/desktop/wsl)
- - Ensure you have installed [Chocolatey](https://chocolatey.org/install)


### Setup
- In your windows machine, double click on the [setup_caldera.bat](setup_caldera.bat) script or run it via command line.
- Follow the on-screen instructions. You will need to restart the batch script if Chocolatey and/or Docker were not previously installed.


### Login to Caldera on host machine

To access the Caldera web interface on your host machine:

- Open the Docker Desktop application
- Click on the "Containers/Apps" tab
- Locate the `caldera-demo3` container and copy the IP address listed under the "IPAddress" column
- Open a web browser and navigate to http://<IPAddress>:8888/
