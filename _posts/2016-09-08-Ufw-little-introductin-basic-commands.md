---
title: UFW basic command snippets
date: 2016-09-08 00:00:00 Z
tags:
- GNU\Linux
- Technical
- Security
layout: post
---

UFW(uncomplicated firewall) is the simple easy firewall to manage and protect your server. Few command snippets to manage it.


* Check status of ufw: It lists all the rules configured in ufw.
    * `sudo ufw status`


* Add a rule to firewall: It will allow the connection to machine given on specific port(here 7865).
    * `sudo ufw allow 7865/tcp`
    * `sudo ufw allow 22/tcp` 

* Enable Ufw: By default ufw will be started on your machine, but **ufw itself will not be in enabled state**.
    * To enable it: `sudo ufw enable`  

   <hr/> 
	 *Remember to enable incoming ssh connection to machine, else you'll not be able to login to machine*  
	 <hr/>


* Reject all connections to machine: It will implicitly reject all the connection, that are not allowed by the firewall. 
    * `sudo ufw default reject incoming`

* View configured rules in ufw: It'll list all the allowed/rejected rules for ufw.
    * `sudo ufw status`

**References**

* [https://www.digitalocean.com/community/tutorials/how-to-setup-a-firewall-with-ufw-on-an-ubuntu-and-debian-cloud-server](https://www.digitalocean.com/community/tutorials/how-to-setup-a-firewall-with-ufw-on-an-ubuntu-and-debian-cloud-server)
