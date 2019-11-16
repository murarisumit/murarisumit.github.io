---
title: IP Command Minimal Tutorial
date: 2018-12-17 00:00:00 Z
layout: post
tags:
- networking
category:
- tech
---

`ip` command is used to show / manipulate routing, devices, policy routing and tunnels. Below are simple usage of ip command to viewing basic details.


Q: To see your packet routes from your machine ? <br/>
A: Use command : `ip route list`

Below are few different kind of lines, that you will see as output

```
192.168.1.0/24 dev en0  scope link
192.168.1.1/32 dev en0  scope link
192.168.1.6/32 dev en0  scope link
192.168.2.0/24 dev wlan0  proto kernel  scope link  src 192.168.1.100
192.168.196.0/23 via 192.168.196.200 dev utun2
192.168.196.200/32 via 192.168.196.200 dev utun2
224.0.0.0/4 dev en0  scope link
255.255.255.255/32 dev en0  scope link
```

What does it mean:

* `192.168.1.0/24 dev en0  scope link`: Any packet with ip address within range `192.168.1.0/24` with do via `device en0`. Scope means the area where this address is valid.

    Different scope values in route list

    | Scope	 | Description |
    | --- | --- |
    | global | valid everywhere |
    | site	 | valid only within this site (IPv6) |
    | link	 | valid only on this device |
    | host	 | valid only inside this host (machine) |

* Similar is for 2 and 3rd line.

* `192.168.2.0/24 dev wlan0  proto kernel  scope link  src 192.168.1.100`: Any packet with ip range within `192.168.2.0/24`, should go via `device wlan0` with scope of link i.e. valid for this device only with `192.168.1.100` as the source IP address, which in this case is the IP address assigned to wlan0 via DHCP.

* `192.168.196.0/23 via 192.168.196.200 dev utun2`: Any packet with ip range within `192.168.196.0/23` should do via `device utun2` with source address as `192.168.196.200`.

---

Q: How can we see all networking devices like en0, utun2, wlan0, eth0? <br/>
A: To see each interface: `ip link show [ DEVICE ]`. E.g `ip link show utun2`

---
Q: How can we see address for the networking device ? <br/>
A: Use command: `Usage: ip addr show [ dev STRING ]`. E.g. `ip addr show dev utun2`

---

To see all network interfaces: `ip link show`
To view all network interfaces: `ip addr show`


Ref: http://linux-ip.net/html/tools-ip-address.html
