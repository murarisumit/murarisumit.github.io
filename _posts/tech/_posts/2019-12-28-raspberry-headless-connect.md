---
title: Raspberry pi 3Bplus setup headless 
date: 2019-12-28 00:00:00 Z
layout: post
tags:
- raspberrypi
category:
- tech
---

Below is archive link which has reference on how to set up raspberry pi 3B+ in headless mode. It will will also help in setting up ssh and wifi if required.
* [https://web.archive.org/web/20191227222211](https://web.archive.org/web/20191227222211/https://desertbot.io/blog/headless-raspberry-pi-3-bplus-ssh-wifi-setup/)


**To update the default password**: 
* ssh to rpi using instruction above
* Use `passwd` command to update the password or add your ssh public key to `~/.ssh/authorized_keys` folder.

**To add ssh keys for login**: You can also your public keys for ssh, which give seamless way to login without password hassle, but then you need to have ssh keys to login.
* Create a $HOME/.ssh folder: `mkdir ~/.ssh`
* Create a file called `authorized_keys`: `touch authorized_keys`
* Add you public key to file: `cat <pub_key> >> authorized_keys`


---

Further reading:
* How does .local work: [https://en.wikipedia.org/wiki/.local](https://en.wikipedia.org/wiki/.local)
* What is mDNS: [https://en.wikipedia.org/wiki/Multicast_DNS](https://en.wikipedia.org/wiki/Multicast_DNS)
* What does avahi daemon: [https://en.wikipedia.org/wiki/Avahi_(software)](https://en.wikipedia.org/wiki/Avahi_(software))



