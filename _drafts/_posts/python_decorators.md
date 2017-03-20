---
title: Python_decorators
date: 2016-09-16 08:21:26 Z
---

## Decorators:

A function returning another function
The decorator syntax is merely syntactic sugar.
e.g.

    @f1(arg)
    @f2
    def func(): pass

    is equivalent to

    def func(): pass
    func = f1(arg)(f2(func))
    ===

    the following two function definitions are semantically equivalent:
    def f(...):
        ...
    f = staticmethod(f)

    @staticmethod
    def f(...):
        ...
