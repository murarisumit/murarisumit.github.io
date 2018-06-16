---
layout: post
title: "SS command snippets"
date: 2018-01-15T08:30:05+00:00
tags:
 - GNU/Linux
---


[ss](http://man7.org/linux/man-pages/man8/ss.8.html) as page says another utility to investigate sockets. It comes default with debian and ubuntu distribution. It's very similar to [netstat](http://man7.org/linux/man-pages/man8/netstat.8.html) and but gives us more details about sockets.


Base command format: `ss [options] [ FILTER ]`

Some basic snippets to use it are.


* List all sockets : `ss -a`
* List tcp/udp/unix-sockets : `ss -t` or `ss -u` or `ss -x`
* List listening sockets: `ss -l`
* List all tcp sockets: `ss -la`
* We can combine flags like `netstat` i.e. get listening tcp sockets:  `ss -tl`
* List only ipv4 sockets: `ss -4`
* List only ipv6 listening sockets: `ss -6l`
* List time duration for connection: `ss -o`
* List all ipv4 sync-sent packet sent: `ss -t4 state syn-sent`
* List all established connection with duration: `ss -o state established`
* List all sockets other than `TIME_WAIT` : `ss exclude TIME_WAIT`
* List connections to ip:port : `ss -nt dst 10.0.0.1:80`
* List connections to ip:port with pid: `ss -npt dst 10.0.0.1:80`
* List all ssh connections: `ss -0 state established '( dport = :ssh or sport = :ssh )'`
* List all connection with destination port: 
    * All connection with destination port 6379: `sudo ss -na dport = :6379`
    * TCP connection with destination port 6379: `sudo ss -nt dport = :6379`
    * All connection with establish connection and port 6379: `sudo ss -na state established dport = :6379`
* List all connection with subnet: `ss -nt dst 10.0.0.0/16`
* List connections in subnet and specific port: `ss -na dst 10.20.0.0/16 dport = :6379`

<hr/>
**A bit advanced here**, you'll be okay with above section for daily use.

* List connection with extended details like uid: `ss -e`
    * Output format: `uid:<uid_number> ino:<inode_number> sk:<cookie>`
        * uid_number: the user id the socket belongs to
        * inode_number: the socket's inode number in VFS
        * cookie:  an uuid of the socket

* List memory usage for socket :  `ss -m`
    * The output format is: `skmem:(r[rmem-alloc],rb[rcv-buf],t[wmem-alloc],tb[snd-buf],f[fwd-alloc],w[wmem-queued],o[opt-mem],bl[back-log])`

        * rmem-alloc: the memory allocated for receiving packet

        * rcv-buf: the total memory can be allocated for receiving packet

        * wmem-alloc: the memory used for sending packet (which has been sent
         to layer 3)

        * snd-buf: the total memory can be allocated for sending packet

        * fwd-alloc: the memory allocated by the socket as cache, but not
         used for receiving/sending packet yet. If need memory
         to send/receive packet, the memory in this cache will
         be used before allocate additional memory.

        * wmem-queued: The memory allocated for sending packet (which has not
         been sent to layer 3)

        * opt-mem: The memory used for storing socket option, e.g., the
         key for TCP MD5 signature

        * back-log: The memory used for the sk backlog queue. On a process
         context, if the process is receiving packet, and a new
         packet is received, it will be put into the sk backlog
         queue, so it can be received by the process immediately




---
Reference: 
* [http://man7.org/linux/man-pages/man8/ss.8.html](http://man7.org/linux/man-pages/man8/ss.8.html)
