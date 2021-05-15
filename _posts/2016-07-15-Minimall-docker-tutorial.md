---
title: Docker minimal commands
date: 2016-07-15 05:30:00 +05:30
categories:
- tech
tags:
- docker
layout: post
---

Here are some basic commands used in docker. Hope it helps you.


* **Create a docker file** : create a file named **Dockerfile** in the folder.
    * <script src="https://gist.github.com/murarisumit/1c0a3a1f7fda6ba43cb28761d809292e.js"></script>

* **Create docker image** : Execute command in the directory containing *Dockerfile*: `docker build -t image_tag_name .`
	* [`.`] indicated the current folder where file named *Dockerfile* is

* **List all docker images**:
    * `docker images`

* **Run docker image** : `docker run -it --name container_name_here image_tag_name`
	* `-it`: It will open interactive terminal after running it, to interact with container
	
* **To connect to running container**: `docker exec -it container_name shell[/bin/bash]`
    * E.g `docker exec -it debian /bin/bash`

* **Start any stopped container**: 
	* Just start the container: `docker start container_name`
	* Start container and connect: `docker start -i container_name`

* **List all container**: `docker ps -a`

* **List all running container**: `docker ps`

* **Find ip address of running container**: 
    * `docker inspect container_name| grep IPAddress`

* **Renaming the docker** : `docker rename old_container_name new_container_name`

* **Remove**
    * Container : `docker rm -f container_name`
        * Running container need to be stopped first, then removed. To do it forcefully use `-f` flag.
        * All stopped containers : `docker rm $(docker ps --filter "status=exited" -q)`
    * Image : `docker rmi image_name` 

* **Container to host port connection**
    * `docker run -p <host_port>:<container_port> -p <host_port>:<container_port> -d -it --name container_name image-name`

