---
title: Python_grammer
date: 2016-09-16 08:21:26 Z
---

Grammer in python for compound statement:

https://docs.python.org/release/3.0.1/reference/compound_stmts.html
Compound statement

    Function and class definitions are also syntactically compound statements.

    Compound statements consist of one or more ‘clauses.’ A clause consists of a header and a ‘suite.’ 


    Each clause header begins with a uniquely identifying keyword and ends with a colon.

    A suite is a group of statements controlled by a clause
         * A suite can be one or more semicolon-separated simple statements on the same line as the header, following the header’s colon,
         * It can be one or more indented statements on subsequent lines.

    The clause headers of a particular compound statement are all at the same indentation level


Understanding python is easy after this:

compound_stmt ::=  if_stmt
                   | while_stmt
                   | for_stmt
                   | try_stmt
                   | with_stmt
                   | funcdef
                   | classdef
suite         ::=  stmt_list NEWLINE | NEWLINE INDENT statement+ DEDENT
statement     ::=  stmt_list NEWLINE | compound_stmt
stmt_list     ::=  simple_stmt (";" simple_stmt)* [";"]


