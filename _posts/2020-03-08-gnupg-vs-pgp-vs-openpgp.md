---
title: Introduction to GnuPG, PGP and OpenPGP
date: 2020-03-08 05:30:00 +05:30
categories:
- tech
tags:
- crypto
layout: post
---

#### Terms
 * PGP 5.x: This version of PGP is formerly known as "PGP 3" in the community.

 * OpenPGP - This is a term for security software that uses PGP 5.x
   as a basis, formalized in [RFC 2440](https://tools.ietf.org/html/rfc2440) and [RFC 4880](https://tools.ietf.org/html/rfc4880).

 * PGP - Pretty Good Privacy.  PGP is a family of software systems
   developed by Philip R. Zimmermann from which OpenPGP is based.

 * GnuPG - GNU Privacy Guard, also called GPG.  GnuPG is an OpenPGP
   implementation that avoids all encumbered algorithms.
   Consequently, early versions of GnuPG did not include RSA public
   keys.  GnuPG may or may not have (depending on version) support
   for IDEA or other encumbered(restrict in such a way that free action or movement is difficult.) algorithms.

---

#### Timelines

PGP
* RFC 1991 PGP Message Exchange Formats (obsolete)

OpenPGP

* RFC 2440 OpenPGP Message Format (obsolete)
* RFC 4880 OpenPGP Message Format
* RFC 5581 The Camellia Cipher in OpenPGP
* RFC 6637 Elliptic Curve Cryptography (ECC) in OpenPGP


---

#### OpenPGP core technologies:

* digital signatures.
* encryption
* compression
* Radix-64 conversion

---


### Limitation

With the advancement of cryptography, parts of PGP have been criticized for being dated:

* The long length of PGP public keys[41]
* Difficulty for the users to comprehend and poor usability[42]
* Lack of ubiquity[42]
* Lack of forward secrecy[41

Further read: 
* [https://blog.cryptographyengineering.com/2014/08/13/whats-matter-with-pgp/](https://web.archive.org/web/20200302172022/https://blog.cryptographyengineering.com/2014/08/13/whats-matter-with-pgp/)

---
Reference:
* [https://tools.ietf.org/html/rfc4880](https://tools.ietf.org/html/rfc4880)
