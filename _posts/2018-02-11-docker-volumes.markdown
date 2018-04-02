---
layout: post
title: "Docker Volumes"
date: 2018-02-11T14:48:13+00:00
tags:
 - Docker
---

Note: Take this post and pinch of salt, this is for personal reference and copy pasted commands. Will improve and update this post later.


Docker volume:

Two types
1. Bind directory on host system
    * `docker run -it —name test2 -v ~/somepath/data:/data ubuntu  bash`
    * `docker run -it —name test2(name_of_container) -v ~/somepath/data(host_dir):/data(container_dir) ubuntu(image_name) bash(start bash)`


2. Docker Volumes

Advantages of docker volume
* Volumes are easier to back up or migrate than bind mounts.
* You can manage volumes using Docker CLI commands or the Docker API.
* Volumes work on both Linux and Windows containers.
* Volumes can be more safely shared among multiple containers.
* Volume drivers allow you to store volumes on remote hosts or cloud providers, to encrypt the contents of volumes, or to add other functionality.
* A new volume’s contents can be pre-populated by a container.

* Create data volume `docker volume create my-vol`  
* This is crate volume if not exist and run container: `docker run -it —name test2 -v data:/data ubuntu bash`
    * `docker run -it —name test2 -v data(docker volume name):/data(container-dir) ubuntu bash`

* Docker volume commands:
    * `docker volume ls`
    * `docker volume —help`
    * `docker volume rm data`

* Mount all the volumes in new container mount in old container
    * `docker run -it —name slave1 —volume-from master ubuntu bash`
    * `docker run -it —name slave1(new_container_name) —volume-from master(old_container_name) ubuntu bash`

---
Reference: 
* [https://docs.docker.com/storage/volumes/](https://docs.docker.com/storage/volumes/)
