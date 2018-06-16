---
title: DiG basic commands snippets
date: '2017-10-16 00:00:00 +0000'
tags:
- GNU/Linux
layout: post
---

##### `dig` is basic command to fetch details from to nameservers
---


* Basic example: `dig redhat.com`
    * `dig` output has following section
        * **Header**: It has basic details like dig version and metadata about response.
        * **Question section**: It has the query we've asked for.
        * **Answer section**: Response given by the nameservers.
        * **Authority section**: It has the nameservers for the domains
        * **Additional section**: It lists the IP's of nameservers.

* To fetch the shortned version of dig's output
    * `dig redhat.com +noall +answer +question`
        * **+noall** : will not show any output
        * **+answer** :  will show answer section
        * **+question** : will show question section
    * `dig redhat.com +short`

* List the MX record for the domain.
    * `dig redhat.com MX +noall +answer +question`

* List NS records for any domain.
    * `dig redhat.com NS +noall +answer +question`

* Resolve a domain record.
    * `dig www.redhat.com +noall +answer +question`
    <pre>
    $ > dig www.redhat.com +noall +answer +question

    ; <<>> DiG 9.8.3-P1 <<>> www.redhat.com +noall +answer +question
    ;; global options: +cmd
    ;www.redhat.com.			IN	A
    www.redhat.com.		3600	IN	CNAME	ds-www.redhat.com.edgekey.net.
    ds-www.redhat.com.edgekey.net. 13481 IN	CNAME	ds-www.redhat.com.edgekey.net.globalredir.akadns.net.
    ds-www.redhat.com.edgekey.net.globalredir.akadns.net. 3600 IN CNAME e3396.dscx.akamaiedge.net.
    e3396.dscx.akamaiedge.net. 20	IN	A	173.222.31.161
    </pre>

* Get response from specific nameserver.
    * dig @namserver_address domain_url:  `dig @ns2.redhat.com. www.redhat.com`

* Get reverse dns i.e. get record from given ip.
    * dig -x @nameserver_address ip_addr: `dig -x @ns.homebox.in 1.2.3.4` OR
    * dig -x ip_addr: `dig -x 1.2.3.4`
