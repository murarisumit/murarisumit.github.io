---
title: docker swarn setup 
date: '2016-04-24 12:00:00'
layout: post
tags:
- misc
---


For basic docker swarn setup.

* Install 3 nodes with docker.
    * Manager1 and worker1 and worker2
    * Create a docker manager node: `docker swarm init --advertise-addr 10.0.2.13`
    * Then it would create the the URL with token, put the url into worker nodes and make it work
* Deploy the a service on node(do it on manager nodes)
    * `docker service create --replicas 1 --name helloworld alpine ping docker.com`
* Run **docker service ls** to see the list of running services: 
    * `docker service ls`
* List all services running.
    * `docker service ps helloworld`
* Scale the service in swarn.
    * `docker service scale helloworld=5`
* Delete the service.
    * `docker service rm helloworld`