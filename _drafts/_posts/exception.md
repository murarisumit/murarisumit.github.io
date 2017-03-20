---
title: Exception
date: 2016-09-16 08:21:26 Z
---

Exception in python:



try:
    try_body
except E as N:
    except_body
...


* The except clause(s) specify one or more exception handlers
* When an exception occurs in the try suite, a search for an exception handler is started. This search inspects the except clauses in turn until one is found that matches the exception
*  An expression-less except clause, if present, must be last;
* If no except clause matches the exception, the search for an exception handler continues in the surrounding code and on the invocation stack


* When a matching except clause is found, the exception is assigned to the target specified after the as keyword in that except clause

* All except clauses must have an executable block

* When the end of this block is reached, execution continues normally after the entire try statement. 

* When an exception has been assigned using as target, it is cleared at the end of the except clause.
    except E as N:
    foo
  It means N is cleared after excution of the block, if you want to be able to refer to it after the except clause you have to assign the exception to a different name
        [The reason for this is that with the traceback attached to them, exceptions will form a reference cycle with the stack frame, keeping all locals in that frame alive until the next garbage collection occurs.]

* Inorder to use exception object we use sys module. Before an except clause’s suite is executed, details about the exception are stored in the sys module and can be access via sys.exc_info(). 
    
* sys.exc_info() returns a 3-tuple consisting of: exc_type, the exception class; exc_value, the exception instance; exc_traceback, a traceback object
*  sys.exc_info() values are restored to their previous values (before the call) when returning from a function that handled an exception.
* If finally is present, it specifies a ‘cleanup’ handler.
* When a return, break or continue statement is executed in the try suite of a try...finally statement, the finally clause is also executed ‘on the way out.’ A continue statement is illegal in the finally clause. (The reason is a problem with the current implementation — this restriction may be lifted in the future).



## Continue on raise
https://docs.python.org/release/3.0.1/reference/simple_stmts.html#raise
