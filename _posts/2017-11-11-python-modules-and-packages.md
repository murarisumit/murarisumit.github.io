---
title: Modules and packages python
date: 2017-11-11 05:30:00 +05:30
categories:
- tech
tags:
- python
layout: post
---

> Most of it has content from [stackoverflow question](https://stackoverflow.com/questions/7948494/whats-the-difference-between-a-python-module-and-a-python-package).

* Modules :
    * These are simple python files with the .py extension, which implement a set of functions/functionality.
    * Modules are imported from other modules using the *import* command like `import file`
    * Above will import variables/funtions/classes from *file.py*.


* Packages :
    * Package is a directory of Python modules containing an additional __init__.py file.
    * For python package or module are of same type
    <pre>
        >>> import some_module
        >>> type(some_module)
        <type 'module'>
        >>> import some_package
        >>> type(some_package)
        <type 'module'>
    </pre>
    * When we import module we get all it's function, classes and variable defined in it.
    * When we import package only variables/functions/classes in the __init__.py file of that package are directly visible, not sub-packages or modules.
    * The directory to be identified as package by python, should have *__init__.py* file in that directory 
    * Packages can have sub-packages, those directories should have __init__.py file in the sub-directory.


