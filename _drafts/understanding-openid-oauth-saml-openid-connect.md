---
title: Understanding Federated Identity protocols
date: '2017-09-11 00:00:00 +0000'
tags:
- tech
layout: post
---

Basics:

Difference between authentication vs authorisation

* Authentication is the process of ascertaining that somebody really is who they claim to be.
* Authorization refers to rules that determine who is allowed to do what. E.g. Adam may be authorized to create and delete databases, while Usama is only authorised to read.


What happens now is, "for companies instead of maintaining username/password for people" and "hassle for people to maintain ID and password for individual site", we(humans) came up with idea of identity provider(idP), which means you create account at one place and then people use that as identity provider to authenticate and authorise you.

---
OpenID vs OpenID Connect

[https://security.stackexchange.com/a/182083]
OpenID 2.0 and OpenID Connect are very different standards with completely different parameters and response body formats. Both are built on top of OAuth 2.0 by putting additional values into otherwise valid OAuth 2.0 requests and responses, in order to provide identity information needed for authentication (whereas OAuth 2.0 only provides authorization, not authentication). OpenID Connect improved naming and structure of OpenID 2.0 fields and parameters in order to be easier to use. I can easily read the OpenID Connect specification and understand what all the values are used for and what to set them to, but trying to read the OpenID 2.0 specification is a bit more difficult and convoluted.

At this point the choice is easy, OpenID 2.0 is deprecated. You should use OpenID Connect.

---
