---
title: Linux User/Group managment utilites
date: 2017-09-16 05:30:00 +05:30
categories:
- tech
tags:
- gnu-linux
layout: post
---

---

All the below operation use **/etc/login.defs** configuration file for creating user, home dir and other,
It's part of [shadow password suite](http://man7.org/linux/man-pages/man5/login.defs.5.html).


* Add user to system : `useradd user_name`
* Create user without home-directory : `useradd -M user-name`
* Create user but not create group with same user-name:  `useradd -N user_name`
    * It will not create group with same as user-name while creting new user.
* Create user with specific shell on login : `useradd -s /bin/bash user-name`
* Create user with specific user-id and group-id : `useradd -u 123 -g 133 user-name`
    * **-u** for user-id.
    * **-g** for group-id.
* Create user with specific shell, specific home directory, some comments, specific user-id 
* `useradd -m -d /var/www/home-dir -s /usr/sbin/nologin -c "first last" -u 1019 avishek`
    * **-c** : Sort description of the login, usually used to write user's full name.
    * **-m** : Create home-dir if doesn't exist.
    * **-d** : Home directory path

* Add user to multiple groups: `useradd -G group1,group2 user-name`
* List the groups user is added to : 
    * `groups username` or
    * `cat /etc/groups` | grep username
* List all the members of group : 
    * `members groupsname` or
    * `cat /etc/groups` | grep groupname



Reference: 

* [https://superuser.com](https://superuser.com/questions/547966/whats-the-difference-between-adduser-and-useradd)
* [https://www.tecmint.com](https://www.tecmint.com/add-users-in-linux/)
* <a href="http://www.binarytides.com" target="_blank" >http://www.binarytides.com/linux-find-command-examples/</a>

