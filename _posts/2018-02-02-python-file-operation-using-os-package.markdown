---
layout: post
title: "File Operation Using 'os' Package"
date: 2018-02-02T09:25:11+00:00
tags:
 - python
---

Here I'll be using [os](https://docs.python.org/3/library/os.html) package, it provides operating system interfaces to talk to file system. To read more about it, follow about link.

* Start from dirt basics, import os package using : `import os`

* View current working directory path: `os.getcwd()`

* View current directory contents in python: `os.listdir()`

* View content of directory of given path: `os.listdir('/Users/username/tasks/')`
    * Above will list content of directory: */Users/username/tasks/*
    * It return error **NotADirectoryError: [Errno 20] Not a directory**, if path given isn't a directory.

* Change current directory: `os.chdir('/home/user/')`

* To move to subdirectory: `os.chdir(os.path.join(os.curdir(), subdirectory_name))`
    * `os.path.join(base_path, subdirectory)`: Returns path of subdirectory 

* Rename a file, replace *_* to *-* in files; i.e. change *file_name* to *file-name*:
    * If file is in current directory: 
        * `os.rename(os.path.join(os.getcwd(),file), os.path.join(os.getcwd(), file.replace('_','-')))`


* Repeat above example for all files in current directory
    ```python
    import os
    onlyfiles = [f for f in os.listdir() if isfile(f)]
    for file in onlyfiles:
        os.rename(os.path.join(os.getcwd(),file), os.path.join(os.getcwd(), file.replace('_','-')))
    ```


