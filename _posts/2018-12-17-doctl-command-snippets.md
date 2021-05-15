---
title: doctl command snippets
date: 2018-12-17 05:30:00 +05:30
categories:
- tech
tags:
- digitalocean
- snippets
layout: post
---

Doctl is command-line utility like aws cli to manage resources in digitalocean.

Installation instructions: https://github.com/digitalocean/doctl#installing-doctl

Getting started: https://www.digitalocean.com/community/tutorials/how-to-use-doctl-the-official-digitalocean-command-line-client

DOCTL cheatsheet.
#### List:

* List all the droplet: 
```
doctl compute droplet list
```

* List all droplet with test: 
```
doctl compute droplet list 'test*
```

* List all distribution images available: 
```
doctl compute image list-distribution
```

* Use `Slug` name to create droplet.

* List all regions : 
```
doctl compute region list
```  

* List ssh keys :
```
doctl compute ssh-key list
```

#### Create:

* Ssh keys : 
```
doctl compute ssh-key create sumit-mbp --public-key="<ssh-public-key>"
```

* Tag :
```
doctl compute tag create <tag-name>
doctl compute tag create sumit
```

* Droplet :

```
doctl compute droplet create sumit-master-1 --size 512mb --image ubuntu-16-04-x64 --region blr1 --ssh-keys 22432270 --tag-name sumit

doctl compute droplet create sumit-master-2 --size 4gb --image ubuntu-16-04-x64 --region blr1 --ssh-keys 22432270 --enable-private-networking --tag-name sumit
```

* Load-balancer:

```
doctl compute load-balancer create --name sumit-master-lb --region blr1 --forwarding-rules entry_protocol:tcp,entry_port:5521,target_protocol:tcp,target_port:8443 --tag-name sumit
```

* Delete compute: 

```
doctl compute droplet delete test-sumit

doctl compute droplet delete sumit-master-0 sumit-master-1 sumit-master-2 sumit-worker-1
```


