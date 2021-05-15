---
title: OSI model
date: 2020-01-31 05:30:00 +05:30
categories:
- tech
tags:
- networking
layout: post
---

## OSI model 

It has seven layers:

* Physical
* DataLink 
* Network
* Transport
* Session
* Presentation
* Application

First four are usually very clear
* Physical: This is bottom layer, it has all signalling, electrical or light. All physical things after all manipulation being done.

* Data Link: This layer dictates us how devices in same network communicate. Here the identifier is Media Access Control(MAC) address. This address is exptected to be unique and it is 6byte(48 bits).

* Network: IP address comes up here. If two devices are in different network, this comes to rescue. 

* Transport: This layer corresponds to delievery of information to specific port in machine i.e. multiplexing of networking communications to single host. 

* Session: 
    * By transport we are able to communicate between two machines, now session layer manages how communication between these two hosts will be like, e.g. will it be full or half duplex.

    * It establishes, manages (including providing security) and terminates connections between applications at each end. 

    > [Wikipedia]  An example of a session-layer protocol is the OSI protocol suite session-layer protocol, also known as X.225 or ISO 8327. In case of a connection loss this protocol may try to recover the connection. If a connection is not used for a long period, the session-layer protocol may close it and re-open it.

    * Examples of session layer protocols include DLC (data link control), PAP (printer access control), SMB (server message block), ASP (AppleTalk session protocol), NetBIOS (network basic input/output system) and ZIP (zone information protocol). 

    *  Session layer protocols are particularly useful for multimedia applications for which it is necessary to coordinate the timing of two or more types of data, such as voice and moving images, with a high degree of precision. Examples include video conferencing and streaming. 

* Presentation<sup>1<sup>: 
    * This layer handles conversion between the network communication and the application. 
    * It relieves the application layer of concern regarding syntactical differences in data representation within the end-user systems.
    * An example of a presentation service would be the conversion of an EBCDIC-coded text computer file to an ASCII-coded file. 
    * Any data encoding and decoding or formatting are done at this layer. JPEG and GIF files are handled at this layer<sup>1<sup> 
    * Encryption is typically done at this level too, although it can be done on the application, session, transport, or network layers, each having its own advantages and disadvantages. Decryption is also handled at the presentation layer. 


* Application: This is top layer in OSI model, where APIs would exist.


## TCP/IP Protocol Suite:

TCP/IP is sometimes referred as Department of Defence(DOD) model, because the DoD provided funding for the Arpanet, when TCP and IP were developed(Book Page: 18)

In TCP Protocol suite:


| TCP             | OSI                              |
|-----------------|----------------------------------|
| Link Layer      | Physical + data link             |
| Internet Laye   | Network                          |
| Transport Layer | Transport                        |
| Application     | Session + Transport+ Application |




---

Reference:

1. [Network Forensics by Ric Messier](https://amzn.to/2u9CM3v)
2. [http://www.linfo.org/session_layer.html](http://www.linfo.org/session_layer.html)
3. [https://en.wikipedia.org/wiki/Presentation_layer](https://en.wikipedia.org/wiki/Presentation_layer)
