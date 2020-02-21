---
title: Virtualenv, a small internal dive
date: 2016-12-23 14:46:56 Z
layout: post
tags:
- python
category:
- tech
---

Virtualenv gives a clean working environment for python project. To understand *virtualenv*, we need to understand how python works,

*   When you execute `python` binary in command line,
	*   It implicitly read *site.py* (defaults to `/usr/lib/python$version/site.py`)
	*   Sets **sys.prefix** and this *sys.prefix*(platform independent packages) and **sys.exec_prefix**(platform dependent packages)
	*   Sets *sys.path* and these variable decide where the packages will go.

*   How it sets **sys.prefix** (in-order to precedence) ??

    *  Check for PYTHONHOME variable, if this variable is set than value of $PYTHONHOME is *sys.prefix* and all packages will go in that directory.
    *  Look for landmark(in python's case **os.py** file) lib/python$version/os.py and where it finds this relative path structure that is sys.prefix
    *  Else whatever value is fixed during compile time.


*   A simpler of virtualenv will do is:
	*    copy python binary in your project location(e.g. `LOCATION=/home/user/PROJECTDIR/bin`)
	*    you need to have directory structure like $LOCATION/lib/python$version/os.py
	*    python/pip binary at $LOCATION will put all those packages to *$LOCATION/lib/python$version/site-packages/ *.


*   What **bin/activate** does:  It calls your copied python/pip binary instead of system binary, so that it sets **sys.prefix** to your specified directory and install packages over there.


*   By default python puts packages to global location i.e. */usr/lib/python$version/site-packages*


*   To find *sys.prefix*  use:  ```python -c "import sys; print sys.prefix"```

<br/>
Reference: [http://pyvideo.org/pycon-us-2011/pycon-2011--reverse-engineering-ian-bicking--39-s.html](http://pyvideo.org/pycon-us-2011/pycon-2011--reverse-engineering-ian-bicking--39-s.html)
