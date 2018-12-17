---
title: Minimal DHCP
date: 2018-12-17 00:00:00 Z
layout: post
tags:
- dhcp
category:
- tech
---

> The Dynamic Host Configuration Protocol (DHCP) is a network management protocol used on UDP/IP networks whereby a DHCP server dynamically assigns an IP address and other network configuration parameters to each device on a network so they can communicate with other IP networks <sup>wiki</sup>

How it does internally in nutshell is like:

* The device broadcasts a request called a DHCPDISCOVER request, looking for a server on the network that can send out DHCP configuration information. If there's such a server and it's working correctly, it responds with a DHCPOFFER message specifying the IP address and other configuration data that is available.

* If the device accepts what's on offer, it sends a DHCPREQUEST to reserve the IP address. The server responds with an acknowledgment specifying that the device has a DHCP lease on that IP address for a specified amount of time. The limited lease durations ensure that devices check in with the DHCP server from time to time in case configuration details need to be updated.

