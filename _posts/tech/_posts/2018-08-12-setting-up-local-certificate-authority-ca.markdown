---
layout: post
title: "Local Certificate Authority(CA) for self sign certificate"
date: 2018-08-12T11:14:25+00:00
tags:
 - crypto
category:
- tech
---

Here we will be creating local certificate authority.

1. Create keys for CA
2. Add the cert to trusted keychain.
3. Now keys signed with keys of CA will work without issues.
4. Create new certs
5. Sign the certs using our created CA

Used commands :

* To create the root ca key: `openssl genrsa -out rootCA.key 2048`
    * To create password protected key: `openssl genrsa -des3 -out rootCA.key 2048`


* Self sign the certificate: `openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem`

* Add that cert to macos keychain to trust it.


* Create for creating certs that are trusting it:
    * Create private key: `openssl genrsa -out device.key 2048`
    * Create csr : `openssl req -new -key device.key -out device.csr`
    * Sign the key and get certificate: `openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 365 -sha256`
    * Now use the private key and newly created certicate where you have trusted the base(ca) certificate and all will work fine.


---
Reference: 
* [https://deliciousbrains.com/https-locally-without-browser-privacy-errors/#comment-3285792308](https://deliciousbrains.com/https-locally-without-browser-privacy-errors/#comment-3285792308){:target="_blank"}
