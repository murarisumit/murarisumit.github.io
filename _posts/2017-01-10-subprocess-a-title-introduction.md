---
title: Subprocess, a small introduction
date: 2017-01-10 00:00:00 Z
layout: post
---

> The [subprocess](https://docs.python.org/3.4/library/subprocess.html) module allows you to spawn new processes, connect to their input/output/error pipes, and obtain their return codes.

Examples using subprocess

* Subprocess to execute and get output by executing `dpkg -l` .
<script src="https://gist.github.com/{{site.github}}/1b07f9dbcff3958a22a502bc57504d92.js"></script>

* Piping command using subprocess by executing `dpkg -l | grep lsof`.
<script src="https://gist.github.com/{{site.github}}/da6d7e3f54cab9474b935d3a75c23e8a.js"></script>
