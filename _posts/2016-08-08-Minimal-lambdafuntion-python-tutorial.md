---
title: Lambda Function python little introduction
date: '2016-08-08 00:00:00 +0000'
tags:
- Python
layout: post
---

> **Lambda functions**

lambda operator or lambda function is a way to create small anonymous functions, i.e. functions without a name.
These functions are throw-away functions, i.e. they are just needed where they have been created.

Lambda functions are mainly used in combination with the functions filter(), map() and reduce()

The general syntax of a lambda function is quite simple:

        lambda argument_list: expression

The argument_list consists of a comma separated list of arguments and the expression is an arithmetic expression using these arguments.
You can assign the function to a variable to give it a name.

    >>> f = lambda x, y : x + y
    >>> f(1,1)
    2


> **The map() function**

The advantage of the lambda operator can be seen when it is used in combination with the map() function.

map() is a function with two arguments:

    r = map(func, seq)

map() applies the function `func` to all elements of sequence `seq`. It returns a new list with the elements changed by func


**Without lambda**
    
        def fahrenheit(T):
            return ((float(9)/5)*T + 32)
        def celsius(T):
            return (float(5)/9)*(T-32)
        temp = (36.5, 37, 37.5,39)

        F = map(fahrenheit, temp)
        C = map(celsius, F)
	

**With lambda**

        >>> Celsius = [39.2, 36.5, 37.3, 37.8]
        >>> Fahrenheit = map(lambda x: (float(9)/5)*x + 32, Celsius)
        >>> print Fahrenheit
        [102.56, 97.700000000000003, 99.140000000000001, 100.03999999999999]
        >>> C = map(lambda x: (float(5)/9)*(x-32), Fahrenheit)
        >>> print C
        [39.200000000000003, 36.5, 37.300000000000004, 37.799999999999997]
        >>> 

Map can be applied on one or more lists.

* The lists have to have the same length. 
* map() will apply its lambda function to the elements of the argument lists, 

        >>> a = [1,2,3,4]
        >>> b = [17,12,11,10]
        >>> c = [-1,-4,5,9]
        >>> map(lambda x,y:x+y, a,b)
        [18, 14, 14, 14]
        >>> map(lambda x,y,z:x+y+z, a,b,c)
        [17, 10, 19, 23]
        >>> map(lambda x,y,z:x+y-z, a,b,c)
        [19, 18, 9, 5]

> **The filter() function**

The function **filter(f,l)** needs a `function f` as its first argument. `f` returns a Boolean value, i.e. either True or False. 

This function will be applied to every element of the list `l`. Only if `f` returns **True** will the element of the list be included in the result list. 

Here the function will list the even fiboancei numbers

        >>> fib = [0,1,1,2,3,5,8,13,21,34,55]
        >>> result = filter(lambda x: x % 2, fib)
        >>> print result
        [1, 1, 3, 5, 13, 21, 55]
        >>> result = filter(lambda x: x % 2 == 0, fib)
        >>> print result
        [0, 2, 8, 34]

> **reduce()**

Reduce function take the list as input and applies all the input. In other we reduce the list to single number applying a specific function. 


	>>> from functools import reduce
	>>> reduce(lambda x,y: x+y, [47,11,42,14])
	114
	>>>

or 

	>>> f = lambda a,b: a if (a > b) else b
	>>> reduce(f, [47,11,42,102,13])
	102
	>>> 



---
**Reference:**

* [http://www.python-course.eu/lambda.php](http://www.python-course.eu/lambda.php)

