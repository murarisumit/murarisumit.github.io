---
title: 12 factor; Methodology for software development
date: 2017-09-11 05:30:00 +05:30
tags:
- software-development
layout: post
---

This is taken all from [12factor.net](12factor.net). This methodology include the 12 factors or 12 parts of software engineering, which should be used while engineering  softwares. <br/>
My app should be a follow these 12 factor or confor with as my factor possible. <br/>

**In my opinion**
* It's most important to get it done.
* While doing any of 12 factors given below(maintaining configs/dependencies  management, or trying build,release), read below mentioned best practices.

**The Twelve Factors**

1. [Codebase](https://12factor.net/config) :  One codebase tracked in revision control, many deploys
2. [Dependencies](https://12factor.net/dependencies) : Explicitly declare and isolate dependencies
3. [Config](https://12factor.net/config) : Store config in the environment
4. [Backing services](https://12factor.net/backing-services) : Treat backing services as attached resources
5. [Build, release, run](https://12factor.net/build-release-run) : Strictly separate build and run stages
6. [Processes](https://12factor.net/processes) : Execute the app as one or more stateless processes
7. [Port binding](https://12factor.net/port-binding) : Export services via port binding
8. [Concurrency](https://12factor.net/concurrency) : Scale out via the process model
9. [Disposability](https://12factor.net/disposability) : Maximize robustness with fast startup and graceful shutdown
10.  [Dev/prod parity](https://12factor.net/dev-prod-parity) : Keep development, staging, and production as similar as possible
11.  [Logs](https://12factor.net/logs) : Treat logs as event streams
12. [Admin processes](https://12factor.net/admin-processes) : Run admin/management tasks as one-off processes


**References**:
* This post is copied from [https://12factor.net/](https://12factor.net/) and kept here for my personal reference.
