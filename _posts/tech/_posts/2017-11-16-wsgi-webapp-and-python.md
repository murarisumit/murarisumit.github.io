---
title: WSGI and Webapp in python
date: '2017-11-15 00:00:00 +0000'
tags:
- python
layout: post
category:
- tech
---

WSGI : Stands for Web server gateway interface.

* So all WSGI does is solves the problem of web-servers(apache/nginx) to serve the python application.
* By default they(nginx/apache) know how to serve html files, ask them for html file and they return it but how to process python they don't know.
* For web-server to serve an application, we need to -
    1. Either make web-server learn to read python and process it up (mod_wsgi or mod_python)
    2. Or bring some thing in between, which know know how to talk to python application and can talk with web-server too (guicorn or uwsgi)

* In first way we add module in web-server that'll make web-server process python.
* Or we can have something like gunicorn which knows how to talk to application that conforms to wsgi interface.

* What is WSGI interface
    * WSGI interface is simple, for python application to implement WSGI, **it should expose the [callable object](https://stackoverflow.com/questions/111234/what-is-a-callable-in-python#answer-139469)(function/class), which should take two arguments: a environment(dictionary) and function(which is called before sending the body) and should return iterable object(list/string).**
        * Well you don't see that type of callable object in flask or bottle or django, because working with direct WSGI is pain.
        * Framework does all heavy lifting for you all wsgi things and allows you to just write code.
    * What is callable object ?
        * A callable object is an object that can accept some paramters and possibly return an object (often a tuple containing multiple objects). Something like our function, which take some parameters and can give some output.
        * A function is the simplest callable object in Python.
        * Stackoverflow [answer](https://stackoverflow.com/questions/111234/what-is-a-callable-in-python#answer-139469) can help you too.
    * What is iterable object ?
        * It can any object which is iterable like list( for a in list:) or a string as string is iterable in character.

    * Here is method(hello_world), which takes two argument first-one(environ) accepts environment variable and other a method.
    * Sample python app confirming with wsgi 
    <pre>def hello_world(environ, start_response):
    body = b'Hello world!\n'
    status = '200 OK'
    headers = [('Content-type', 'text/plain')]
    start_response(status, headers)
    return [body] </pre>

* We can call the above callable object **hello_world** method from a default wsgi server that python provides because the callable object conforms with wsgi requirement hence wsgi server can serve our application. In python **a function** is callable object(as we can call a function)

    <pre>
    if __name__ == '__main__':
        from wsgiref.simple_server import make_server
        srv = make_server('localhost', 8080, hello_world)
        srv.serve_forever()
    </pre>

* We can use gunicorn as well for serving above wsgi application.

* If above function defination is stored in file called app.py then.
* For gunicorn try :  `gunicorn app:hello_world --bind=localhost:8051`
* For uwsgi try : `uwsgi --socket 0.0.0.0:8080 --protocol=http -w  app:hello_world`


* On wsgi server side(i.e. gunicorn/uwsgi), some where code will be like:

    <pre>
    def write(chunk):
        '''Write data back to client'''
        ...

    def send_status(status):
       '''Send HTTP status code'''
       ...

    def send_headers(headers):
        '''Send HTTP headers'''
        ...

    def start_response(status, headers):
        '''WSGI start_response callable'''
        send_status(status)
        send_headers(headers)
        return write

    response = application(environ, start_response) # Making request to wsgi application
    try:
        for chunk in response:  #returned object should be iterable.
            write(chunk)
    finally:
        if hasattr(response, 'close'):
            response.close()
     </pre>

* One of code that you can read is here [https://github.com/grisha/mod_python/blob/master/lib/python/mod_python/wsgi.py](https://github.com/grisha/mod_python/blob/master/lib/python/mod_python/wsgi.py)


* So basically we do with gunicorn is:
    * run a  WSGI server is a separate process and runs on a different port than your web server(nginx/apache)
    * Web server is configured to pass requests to the WSGI servers(app server) which runs your web application, then pass the response (in the form of HTML) back to the requester i.e. webserver(nginx or apache)

---
**Reference**: 
* [https://www.python.org/dev/peps/pep-0333/](https://www.python.org/dev/peps/pep-0333/)
* [https://slobaray.com/category/python-programming/](https://slobaray.com/category/python-programming/)
* [https://www.fullstackpython.com/wsgi-servers.html](https://www.fullstackpython.com/wsgi-servers.html)
* [https://en.wikibooks.org/wiki/Python_Programming/Functions](https://en.wikibooks.org/wiki/Python_Programming/Functions)
* [http://lucumr.pocoo.org/2007/5/21/getting-started-with-wsgi/](http://lucumr.pocoo.org/2007/5/21/getting-started-with-wsgi/)
* [http://agiliq.com/blog/2013/07/basics-wsgi/](http://agiliq.com/blog/2013/07/basics-wsgi/)
