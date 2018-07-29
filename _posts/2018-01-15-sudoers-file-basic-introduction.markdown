---
layout: post
title: "Sudoers file notes"
date: 2018-01-15T19:33:31+00:00
tags:
 - gnu-linux
---

Sudo is a program that allows users to 
    * Run program as some specific privilage level.
    * Logs the user actions

Sudo's configuration file, the sudoers(/etc/sudoers) file, help us in configuring the rules about delagating authority.


Examples:

* dgb boulder = (operator) /bin/ls, /bin/kill
    * The user dgb may run /bin/ls, /bin/kill— only on boulder host and only as operator user.
        * `$ sudo -u operator /bin/ls`

* dgb boulder = (operator) /bin/ls, (root) /bin/kill, /usr/bin/lprm
    * Then user dgb is now allowed to run /bin/ls as operator, but /bin/kill and /usr/bin/lprm as root. 

* dgb	boulder = (operator : operator) /bin/ls, (root) /bin/kill, /usr/bin/lprm
    * Allow user to execute command as operator user/group.
    * The following would all be permitted by the sudoers entry above:
        * `$ sudo -u operator /bin/ls`
        * `$ sudo -u operator -g operator /bin/ls`
        * `$ sudo -g operator /bin/ls`

<hr/>
We can add various tags to the commands
*  There are ten possible tag values: EXEC, NOEXEC, FOLLOW, NOFOLLOW, LOG_INPUT, NOLOG_INPUT, LOG_OUTPUT, NOLOG_OUTPUT, MAIL, NOMAIL, PASSWD, NOPASSWD, SETENV, and NOSETENV

* We’ll see about :NOPASSWD 
    * By default, sudo requires that a user authenticate him or herself before running a command. 
    * This behavior can be modified via the NOPASSWD tag. 
    * Conversely, the PASSWD tag can be used to Reverse things. For example:  
        * ray	rushmore = NOPASSWD: /bin/kill, /bin/ls, /usr/bin/lprm
            * Above command would allow the user ray to run /bin/kill, /bin/ls, and /usr/bin/lprm as root on the machine rushmore without authenticating himself.
        * ray	rushmore = NOPASSWD: /bin/kill, PASSWD: /bin/ls, /usr/bin/lprm
            * We wil only able to run /bin/kill without a password, but /bin/ls and /usr/bin/lprm after authenitication
<hr/>

The User specification is the part that actually determines who may run what.

* We let root and any user in group wheel run any command on any host as any user.
root		ALL = (ALL) ALL
%wheel		ALL = (ALL) ALL


* User part of FULLTIMER group can run command without password authentication.
* FULLTIMERS	ALL = NOPASSWD: ALL

* Part time sysadmins bostley, jwfox, and crawl) may run any command on any host but they must authenticate themselves first (since the entry lacks the NOPASSWD tag).
    * PARTTIMERS	ALL = ALL

* The user jack may run any command on the machines in the CSNETS alias (the networks 128.138.243.0, 128.138.204.0, and 128.138.242.0). Of those networks, only 128.138.204.0 has an explicit netmask (in CIDR notation) indicating it is a class C network. For the other networks in CSNETS, the local machine's netmask will be used during matching. 
    * jack		CSNETS = ALL

* The user lisa may run any command on any host in the CUNETS alias (the class B network 128.138.0.0). 
    * lisa		CUNETS = ALL

* The user pete is allowed to change anyone's password except for root on the HPPA machines 
    * pete		HPPA = /usr/bin/passwd [A-Za-z]*, !/usr/bin/passwd root
    *  ^ Because command line arguments are matched as a single, concatenated string, the ‘*’ wildcard will match multiple words. This example assumes that passwd(1) does not take multiple user names on the command line. Note that on GNU systems, options to passwd(1) may be specified after the user argument. As a result, this rule will also allow:
    * passwd username --expire : which may not be desirable. 

* The user bob may run anything on the SPARC and SGI machines as any user listed in the OP Runas_Alias (root and operator.) 
    * bob		SPARC = (OP) ALL : SGI = (OP) ALL

* The user jim may run any command on machines in the biglab netgroup. sudo knows that “biglab” is a netgroup due to the ‘+’ prefix. 
    * jim		+biglab = ALL

* Users in the secretaries netgroup need to help manage the printers as well as add and remove users, so they are allowed to run those commands on all machines. 
    * +secretaries	ALL = PRINTING, /usr/bin/adduser, /usr/bin/rmuser

* The user fred can run commands as any user in the DB Runas_Alias (oracle or sybase) without giving a password.
    * fred		ALL = (DB) NOPASSWD: ALL

* On the ALPHA machines, user john may su to anyone except root but he is not allowed to specify any options to the su(1) command. 
    * `john		ALPHA = /usr/bin/su [!-]*, !/usr/bin/su *root*`

* The user jen may run any command on any machine except for those in the SERVERS Host_Alias (master, mail, www and ns). 
    * jen		ALL, !SERVERS = ALL

* For any machine in the SERVERS Host_Alias, jill may run any commands in the directory /usr/bin/ except for those commands belonging to the SU and SHELLS Cmnd_Aliases.
    * jill		SERVERS = /usr/bin/, !SU, !SHELLS


* On his personal workstation, valkyrie, matt needs to be able to kill hung processes. 
    * matt		valkyrie = KILL

<hr/>

A bit advanced section here, we'll be looking for grammer for alias here.


* The sudoers file is composed of two types of entries: 
    * aliases (basically variables)  
    * user specifications (which specify who may run what). 
* When multiple entries match for a user, they are applied in order. Where there are multiple matches, the last match is used (which is not necessarily the most specific match). 
* There are four kinds of aliases: `User_Alias`, `Runas_Alias`, `Host_Alias` and `Cmnd_Alias`.
    * Each alias definition is of the form : Alias_Type NAME = item1, item2, ...
    * Alias_Type NAME = item1, item2, item3 : NAME = item4, item5
    * Cmnd_Alias MINECRAFT_CMDS = /bin/systemctl start minecraft, /bin/systemctl restart minecraft



Grammer for sudoers

```
Alias ::= 'User_Alias'  User_Alias (':' User_Alias)* |
          'Runas_Alias' Runas_Alias (':' Runas_Alias)* |
          'Host_Alias'  Host_Alias (':' Host_Alias)* |
          'Cmnd_Alias'  Cmnd_Alias (':' Cmnd_Alias)*
 
 
Runas_Alias ::= NAME '=' Runas_List
 
Host_Alias ::= NAME '=' Host_List
 
Cmnd_Alias ::= NAME '=' Cmnd_List
 
NAME ::= [A-Z]([A-Z][0-9]_)*

```

```
# User alias specification
User_Alias	FULLTIMERS = millert, mikef, dowdy
User_Alias	PARTTIMERS = bostley, jwfox, crawl
User_Alias	WEBMASTERS = will, wendy, wim

User_Alias ::= NAME '=' User_List
User_List ::= User |
              User ',' User_List
 
User ::= '!'* user name |
         '!'* #uid |
         '!'* %group |
         '!'* %#gid |
         '!'* +netgroup |
         '!'* %:nonunix_group |
         '!'* %:#nonunix_gid |
         '!'* User_Alias
```

```
# Runas alias specification
Runas_Alias	OP = root, operator
Runas_Alias	DB = oracle, sybase
Runas_Alias	ADMINGRP = adm, oper
 
Runas_List ::= Runas_Member | 
			Runas_Member ',' Runas_List
Runas_Member ::= '!'* user name |
                 '!'* #uid |
                 '!'* %group |
                 '!'* %#gid |
                 '!'* %:nonunix_group |
                 '!'* %:#nonunix_gid |
                 '!'* +netgroup |
                 '!'* Runas_Alias
Runas_Alias ::= NAME '=' Runas_List

```

```
A Host_List is made up of one or more host names, IP addresses, network numbers, netgroups (prefixed with ‘+’) and other aliases
* Again, the value of an item may be negated with the ‘!’ operator i.e. not to run at given host or ip_addr

# Host alias specification
Host_Alias	CUNETS = 128.138.0.0/255.255.0.0
Host_Alias	CSNETS = 128.138.243.0, 128.138.204.0/24, 128.138.242.0
Host_Alias	SERVERS = master, mail, www, ns
Host_Alias	CDROM = orion, perseus, hercules
 
* Host_List ::= Host |
              Host ',' Host_List 
* Host ::= '!'* host name |
         '!'* ip_addr |
         '!'* network(/netmask)? |
         '!'* +netgroup |
         '!'* Host_Alias
```

```
# Cmnd alias specification
Cmnd_Alias	DUMPS = /usr/bin/mt, /usr/sbin/dump, /usr/sbin/rdump,\
			/usr/sbin/restore, /usr/sbin/rrestore,\
			sha224:0GomF8mNN3wlDt1HD9XldjJ3SNgpFdbjO1+NsQ== \
			/home/operator/bin/start_backups
Cmnd_Alias	KILL = /usr/bin/kill
Cmnd_Alias	PRINTING = /usr/sbin/lpc, /usr/bin/lprm
Cmnd_Alias	SHUTDOWN = /usr/sbin/shutdown
Cmnd_Alias	HALT = /usr/sbin/halt
Cmnd_Alias	REBOOT = /usr/sbin/reboot
Cmnd_Alias	SHELLS = /usr/bin/sh, /usr/bin/csh, /usr/bin/ksh,\
			 /usr/local/bin/tcsh, /usr/bin/rsh,\
			 /usr/local/bin/zsh
Cmnd_Alias	SU = /usr/bin/su
Cmnd_Alias	PAGERS = /usr/bin/more, /usr/bin/pg, /usr/bin/less


Command in sudoers file:

Cmnd_Alias ::= NAME '=' Cmnd_List
* Cmnd_List ::= Cmnd |
              Cmnd ',' Cmnd_List
* Cmnd ::= Digest_Spec? '!'* command name |
         '!'* directory |
         '!'* "sudoedit" |
         '!'* Cmnd_Alias

* command name ::= file name |
                 file name args |
                 file name '""'

```


---
Reference: 
* [https://www.sudo.ws/](https://www.sudo.ws/)
* [http://www.uccs.edu/~ahitchco/grep/](http://www.uccs.edu/~ahitchco/grep/)
* [https://www.sudo.ws/man/1.8.15/sudoers.man.html](https://www.sudo.ws/man/1.8.15/sudoers.man.html)
