---
title: Tcpdump's minimal tutorial
date: '2017-08-25 02:18:53 +0000'
layout: post
tags:
- GNU/Linux
---

From the man page:  **tcpdump - dump traffic on a network**

Basic use cases would be: 
* Check if packets are coming from specific host
	*  `sudo tcpdump -t -A -s0 src host 10.101.1.25 -i eth0` 
	*   `-t` : Doesn't show any timestamp.
	*   `-A` : Show the packet data in ASCII
	*   `-s0`: Will show the the whole packet(headers and body)
	*   `-i` : Listen to data on given interfaces.
		*   List all intefaces available:
			*   `tcpdump -D` or `tcpdump--list-interfaces` or
			*    `ip link show` or
			*    `netstat -i`

* Check if packets are coming from specific network
	*  `sudo tcpdump -t -s0 src net 10.101.0.0/16 -i eth0`

* View packet's you're receiving at `22` port:
	* `sudo tcpdump -t -A -s0 port 22 -i eth0`
	* or `sudo tcpdump -t -A -s0 src port 22 -i eth0`

* View packet's with destination port of 80:
	* Packets you are sending to some machine at `80` port
	* `sudo tcpdump -t -A -s0 dst port 80 -i wlan0`

* Capture any packets with destination IP 10.1.1.2 and destination port 80. Display IP addresses and port numbers:
	* `tcpdump -n "dst host 10.1.1.2 and dst port 80" -i wlan0`

* Dump the network packets captured to file.
	* `sudo tcpdump -t -A -s0 src net 10.101.0.0/16 -i eth0 -v -w packets.cap`

* Read those dump you've captured.
	* `tcpdump -r packets.cap`

Advanced:
* Next article to read: [https://hackertarget.com/tcpdump-examples/](https://hackertarget.com/tcpdump-examples/)

Reference: 
* [http://www.tcpdump.org/tcpdump_man.html](http://www.tcpdump.org/tcpdump_man.html)
* [https://www.rationallyparanoid.com/articles/tcpdump.html](https://www.rationallyparanoid.com/articles/tcpdump.html)


