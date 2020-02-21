---
title: iptables and netfilter tutorial.
date: '2018-07-06 00:00:00 +0000'
tags:
- gnu-linux
- networking
layout: post
category:
- tech
---

Reference:
* [https://www.digitalocean.com/community/tutorials/a-deep-dive-into-iptables-and-netfilter-architecture](https://www.digitalocean.com/community/tutorials/a-deep-dive-into-iptables-and-netfilter-architecture)
* [https://www.karlrupp.net/en/computer/nat_tutorial](https://www.karlrupp.net/en/computer/nat_tutorial)
* [https://goyalankit.com/blog/iptables](https://goyalankit.com/blog/iptables)
* [http://ipset.netfilter.org/iptables.man.html](http://ipset.netfilter.org/iptables.man.html)

---

Iptables interfaces with the kernel's netfilter packet filtering framework, it works by interacting with the packet filtering hooks, these kernel hooks are known as the netfilter framework.

Every packet that enters networking system (incoming or outgoing) will trigger these hooks as it progresses through the stack, allowing programs that register with these hooks to interact with the traffic at key points.

---

## Netfilter Hooks

There are five netfilter hooks that programs can register with. Tollowing hooks represent various well-defined points in the networking stack:

* __NF_IP_PRE_ROUTING__: This hook will be triggered by any incoming traffic very soon after entering the network stack. This hook is processed before any routing decisions have been made regarding where to send the packet.
* __NF_IP_LOCAL_IN__: This hook is triggered after an incoming packet has been routed if the packet is destined for the local system.
* __NF_IP_FORWARD__: This hook is triggered after an incomin host.
* __NF_IP_LOCAL_OUT__: This hook is triggered by any locally created outbound traffic as soon it hits the network stack.g packet has been routed if the packet is to be forwarded to another
* __NF_IP_POST_ROUTING__: This hook is triggered by any outgoing or forwarded traffic after routing has taken place and just before being put out on the wire.


---

## IPTables Tables and Chains

iptables is userland tool that works with netfilter. Below diagram explains more about the relation between table, chains and rule.

<img src="/static/img/iptables-netfilter/table-chain-rules.png" class="img-responsive" alt="table-chain-rule"/>


### Tables
* The iptables firewall uses tables to organize its rules.
* For instance, if a rule deals with network address translation, it will be put into the nat table. If the rule is used to decide whether to allow the packet to continue to its destination, it would probably be added to the filter table.

#### Available tables.

##### The Filter Table:
* The filter table is used to make decisions about whether to let a packet continue to its intended destination or to deny its request.
* Operation like these are usually known as "filtering" packets.

##### The NAT Table
* Used for nat rules
* As packets enter the network stack, rules in this table will determine whether and how to modify the packet's source or destination addresses in order to impact the way that the packet and any response traffic are routed
* This is often used to route packets to networks when direct access is not possible.
* Only the first packet in a connection will be evaluated against the NAT rules. Any nat decisions made for the first packet will be applied to all subsequent packets in the connection without additional evaluationx

##### The Mangle Table
* The mangle table is used to alter the IP headers of the packet in various ways.
* For instance, you can adjust the TTL (Time to Live)/MTU/TOS value of a packet, either lengthening or shortening the number of valid network hops the packet can sustain


##### The Raw Table : #TODO

##### The Security Table : #TODO

### Chains


![packet_flow](/static/img/iptables-netfilter/nat-chains.gif)
* Within each iptables table, rules are further organized within separate "chains".
* Chains basically determine when rules will be evaluated and packet goes through following chains

* Name of chains:
  * PREROUTING: Triggered by the NF_IP_PRE_ROUTING hook and packet goes through this chain before any routing decision is made.
  * FORWARD: Triggered by the NF_IP_FORWARD hook and if the message is not intended for local machine; it can be either dropped or routed to other machine based on the policy.
  * INPUT: Triggered by the NF_IP_LOCAL_IN hook and if the packet is targeted for local machine, it passes through the INPUT chain.

  * OUTPUT: Triggered by the NF_IP_LOCAL_OUT hook, any packet originating from local machine goes through the OUTPUT chain.
  * POSTROUTING: Triggered by the NF_IP_POST_ROUTING hook and all outbound packet goes through post routing state.


#### Chain Traversal Order


* Incoming packets destined for the local system: PREROUTING -> INPUT
* Incoming packets destined to another host: PREROUTING -> FORWARD -> POSTROUTING.
* Locally generated packets: OUTPUT -> POSTROUTING

---

## Flow

* It first goes through the PREROUTING chain; where you can change the TCP headers, setup nat rules, etc; before passing it on for the Routing. Routing decides if the packet is targeted for current system based on IP headers.
* If it is not meant for the current system, packet passes through the FORWARD chain where one can decide to either forward the packet or drop it based on the set policy. If the forwarding is allowed, the packet is passed on to the POSTROUTING chain, otherwise it’s dropped or rejected.
* If the packet is meant for the current system, it is passed to the INPUT chain where packets can be filtered, header can be modified, etc and once rules in this chain are applied, packet is passed on to the local machine for processing.
* Any new packet from local machine passes through OUTPUT chain, where packet can be modified before the routing decision is made. Once the routing decision is made, packet goes through the POSTROUTING chain.
* POSTROUTING change can modify the headers, filter the packets before packet is finally put onto the network.


---
## IPTables Rules

* **Rules are placed within a specific chain of a specific table.**
* As each chain is called, the packet in question will be checked against each rule within the chain in order.
* As each chain is called, the packet in question will be checked against each rule within the chain in order.
* Each rule has a __matching component__ and an __action component__.
* Abstract structure of an iptables instruction: `iptables [-t table] command [match pattern] [action]`


### Matching:
* Matching specifies the criteria that packet must meet for action execution.
* Matching system can be extended with iptables extensions.
* Rules can be constructed to match by protocol type, destination or source address, destination or source port, destination or source network, input or output interface, headers, or connection state among other criteria.

#### match patterns
* TCP packets from 192.168.1.2: `$> iptables -t nat -A POSTROUTING -p tcp -s 192.168.1.2 [...]`
* UDP packets to 192.168.1.2  :  $> iptables -t nat -A POSTROUTING -p udp -d 192.168.1.2 [...]
* All packets from 192.168.x.x arriving at eth0: `$> iptables -t nat -A PREROUTING -s 192.168.0.0/16 -i eth0 [...]`
* All packets except TCP packets and except packets from 192.168.1.2: $> `iptables -t nat -A PREROUTING -p ! tcp -s ! 192.168.1.2 [...]`
* Packets leaving at eth1:  `$> iptables -t nat -A POSTROUTING -o eth1 [...]`



### Targets/Jumps/Actions (-j flag)

Ref: [http://www.faqs.org/docs/iptables/targets.html](http://www.faqs.org/docs/iptables/targets.html)

Each rule has a predicate and a possible action which is called a target. For a detailed list of possible target and jump values, refer: iptables - targets and Jumps.

Some of the most common ones are:

* ACCEPT: This can be used to allow traffic based on the other specifications in the rule.
* DROP: This can be used to drop the messages. No further processing is done; and no further information will be sent back to sender.
* REJECT: This is similar to DROP but it also sends back an error message back to host sending the packet.
* SNAT: It allows one to modify source ip address in the packet. It’s only valid in POSTROUTING chain and nat table.
* DNAT: It allows one to modify destination ip address in the packet. It’s only valid in PREROUTING chaing and nat table.
* MASQUERADE: This is same as SNAT but it doesn’t require a --to-source option. I.e., this is preferable if you don’t know the external ip during the rule creation, as it may be retrieved later using DHCP.  #TODO


Note:  IP masquerading allows you to use a private (reserved) IP network address on your LAN and have your Linux-based router perform some clever, real-time translation of IP addresses and ports. When it receives a datagram from a computer on the LAN, it takes note of the type of datagram it is, "TCP," "UDP," "ICMP," etc., and modifies the datagram so that it looks like it was generated by the router machine itself (and remembers that it has done so). It then transmits the datagram onto the Internet with its single connected IP address. When the destination host receives this datagram, it believes the datagram has come from the routing host and sends any reply datagrams back to that address. When the Linux masquerade router receives a datagram from its Internet connection, it looks in its table of established masqueraded connections to see if this datagram actually belongs to a computer on the LAN, and if it does, it reverses the modification it did on the forward path and transmits the datagram to the LAN computer.

![ip-masquerqading](/static/img/iptables-netfilter/ip-masquerade.gif)

### Example:

* Connect a LAN to the internet:
  * `$ iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE`
  * iptables      : The command line utility for configuring the kernel
  * -t nat        : Select table "nat" for configuration of NAT rules.
  * -A POSTROUTING: Append a rule to the POSTROUTING chain (-A stands for "append").
  * -o eth1 	  :	This rule is valid for packets that leave on the second network interface (-o stands for "output")
  * -j MASQUERADE : Using the MASQUERADE target/action every packet receives the IP of the router's outgoing interface.

* To list the rules in output chain :
  * `$ iptables -L OUTPUT -n`
  * Default table is `filter` table i.e. -t filter
  * -L OUTPUT   : List rules in output chain.
  * -n          : avoid long reverse DNS lookups.

* To drop all traffic to a certain IP address:
  * `$ iptables -t filter -d 192.12.33.12 -A OUTPUT -j REJECT`
  * -d or --dst : Destination specification, address can be either a network name, a hostname, a network IP address (with /mask), or a plain IP address.
  * -j REJECT   : See above for that action means


* Reject all packets coming from given source:
  * `$ iptables -A INPUT -s 192.12.33.12 -j REJECT`
  *  -A INPUT        : Append rule in INPUT chain, i.e. evaluated only if packet is intend for local machine(PREROUTING can get packet will forward packets not intended for local machine)
  * -s 192.12.33.13  : or `--source` specification for source host.
  * -j REJECT        : Action we will reject packets coming to this host

* Route TCP packets from 192.168.1.2, port 12345 to 12356 to 123.123.123.123, Port 22
    * 
    ```
       $ iptables -t nat -A POSTROUTING -p tcp -s 192.168.1.2 \
       --sport 12345:12356 -d 123.123.123.123 --dport 22 [...]
    ```
    * -A POSTROUTING       : Add to postrouting chain
    * -p tcp               : protocol is tcp
    * --sport 12345:12356  : source port
    * --dport 22           : Destination port

* Transparent proxy, redirecting packets from port 80 to 8080:
  * `iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-ports 8080`
  * -j REDIRECT : Action is to redirect

* More examples are here :
  * [https://www.tecmint.com/linux-iptables-firewall-rules-examples-commands/](https://www.tecmint.com/linux-iptables-firewall-rules-examples-commands/)
  * [https://www.thegeekstuff.com/2011/06/iptables-rules-examples/?utm_source=feedburner](https://www.thegeekstuff.com/2011/06/iptables-rules-examples/)

---

A picture I found at [https://stuffphilwrites.com/2014/09/iptables-processing-flowchart/](https://stuffphilwrites.com/2014/09/iptables-processing-flowchart/) was quite nice, it shows flow of packet.
<img src="https://stuffphilwrites.com/wp-content/uploads/2018/11/FW-IDS-iptables-Flowchart-v2018-11-14.png" class="img-responsive" alt="iptables-flow"/>

---

