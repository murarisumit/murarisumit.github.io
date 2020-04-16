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


--

https://openid.net/connect/

OpenID Connect performs many of the same tasks as OpenID 2.0, but does so in a way that is API-friendly, and usable by native and mobile applications. OpenID Connect defines optional mechanisms for robust signing and encryption. Whereas integration of OAuth 1.0a and OpenID 2.0 required an extension, in OpenID Connect, OAuth 2.0 capabilities are integrated with the protocol itself

OpenID Connect performs many of the same tasks as OpenID 2.0, but does so in a way that is API-friendly, and usable by native and mobile applications. OpenID Connect defines optional mechanisms for robust signing and encryption. Whereas integration of OAuth 1.0a and OpenID 2.0 required an extension, in OpenID Connect, OAuth 2.0 capabilities are integrated with the protocol itself
OpenID Connect 1.0 is a simple identity layer on top of the OAuth 2.0 protocol. It allows Clients to verify the identity of the End-User based on the authentication performed by an Authorization Server, as well as to obtain basic profile information about the End-User in an interoperable and REST-like manner.


How is OpenID Connect different than OpenID 2.0?
OpenID Connect performs many of the same tasks as OpenID 2.0, but does so in a way that is API-friendly, and usable by native and mobile applications. OpenID Connect defines optional mechanisms for robust signing and encryption. Whereas integration of OAuth 1.0a and OpenID 2.0 required an extension, in OpenID Connect, OAuth 2.0 capabilities are integrated with the protocol itself

---

---
https://openid.net/connect/faq/

What problem does OpenID Connect solve?

It lets app and site developers authenticate users without taking on the responsibility of storing and managing passwords in the face of an Internet that is well-populated with people trying to compromise your users’ accounts for their own gain.
What is the history of OpenID?

OpenID Connect is the third generation of OpenID technology. The first was the original OpenID, a visionary’s tool that never got much commercial adoption, but got industry leaders thinking about what was possible. OpenID 2.0 was much more fully thought through, offered excellent security, and worked well when implemented properly. However, it suffered from several design limitations – foremost among them that Relying Parties could be Web pages but not native applications; it also relied upon XML, leading to some adoption problems.

OpenID Connect’s goal is to be much more developer-friendly, while expanding the set of use cases where it can be used. It has already been successful in this; there are production deployments operating at huge scale. Any programmer with sufficient experience to send and receive JSON messages over HTTP (which is most of them these days) should be able to implement OpenID Connect from scratch using standard crypto signature-verification libraries. Fortunately, most won’t even have to go that far, as there are good commercial and open-source libraries that take care of the authentication mechanics.


How is OpenID Connect different from OpenID 2.0 and how does it overcome the problems experienced with OpenID 2.0?

OpenID Connect has many architectural similarities to OpenID 2.0, and in fact the protocols solve a very similar set of problems. However, OpenID 2.0 used XML and a custom message signature scheme that in practice sometimes proved difficult for developers to get right, with the effect that OpenID 2.0 implementations would sometimes mysteriously refuse to interoperate. OAuth 2.0, the substrate for OpenID Connect, outsources the necessary encryption to the Web’s built-in TLS (also called HTTPS or SSL) infrastructure, which is universally implemented on both client and server platforms. OpenID Connect uses standard JSON Web Token (JWT) data structures when signatures are required. This makes OpenID Connect dramatically easier for developers to implement, and in practice has resulted in much better interoperability.

The OpenID Connect interoperability story has been proven in practice during an extended series of interoperability trials conducted by members of the OpenID Connect Working Group and the developers behind numerous OpenID Connect implementations.


How does OpenID Connect relate to SAML?

The Security Assertion Markup Language (SAML) is an XML-based federation technology used in some enterprise and academic use cases. OpenID Connect can satisfy these same use cases but with a simpler, JSON/REST based protocol. OpenID Connect was designed to also support native apps and mobile applications, whereas SAML was designed only for Web-based applications. SAML and OpenID Connect will likely coexist for quite some time, with each being deployed in situations where they make sense.

---

---
OpenID vs OpenID Connect

[https://security.stackexchange.com/a/182083]
OpenID 2.0 and OpenID Connect are very different standards with completely different parameters and response body formats. Both are built on top of OAuth 2.0 by putting additional values into otherwise valid OAuth 2.0 requests and responses, in order to provide identity information needed for authentication (whereas OAuth 2.0 only provides authorization, not authentication). OpenID Connect improved naming and structure of OpenID 2.0 fields and parameters in order to be easier to use. I can easily read the OpenID Connect specification and understand what all the values are used for and what to set them to, but trying to read the OpenID 2.0 specification is a bit more difficult and convoluted.

At this point the choice is easy, OpenID 2.0 is deprecated. You should use OpenID Connect.

---


---
https://www.youtube.com/watch?v=t18YB3xDfXI

---
