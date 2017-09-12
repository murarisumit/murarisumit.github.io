---
title: FIND minimal tutorial 
date: 2017-03-07 00:00:00 Z
tags:
- GNU/Linux
layout: post
---

##### `find` command is used for searching file in directory structure, below are some basic examples for getting started...
---

* Basic syntax: `find directory comparison search-term`

* Search file in directory: `find ./dir_name -name "*.txt"`
    * `.` represents current directory
    * It will list for file in  dir_name directory with .txt extension

* Search file in directory: `find ./dir_name -iname "*.txt"`
    * -iname search while ignoring case

* Search file in directory: `find ./test -not -name "*.txt"`
    * Lists all file which don't have .txt in filename(i.e. list all files execept .txt files)

* Search file modified last N days: `find ./dir_name -mtime N`
    * File modified in 10 days: `find /home/bob -mtime -10`
    * File modified in last 10 minutes: `find /home/bob -cmin -10`

* Find files by file size:
    * Find all file greater than 50MB: `find / -size 50M`
    * Files greater than 50MB and less than 100MB: `find / -size +50M -size -100M`
    * Files greater than 50MB and are not debian packages: `find / -size +50M ! -name "*.deb" -ls`

* **Find and exec**: You can use find command to list all files with criteria and perform operation on the all the output files.
    * List file with specific criteria and delete them :  `find ./dir_name -name "*.txt" -exec rm -rf {} \;`
        * `{}`: represent for each output for criteria
        * `\;`  : Termination of command


Reference: <a href="http://www.binarytides.com/linux-find-command-examples/" target="_blank" >http://www.binarytides.com/linux-find-command-examples/</a>
