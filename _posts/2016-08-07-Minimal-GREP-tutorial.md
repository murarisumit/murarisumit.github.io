---
title: GREP minimal tutorial
date: 2016-08-07 00:00:00 Z
layout: post
---

##### Grep command is used for searching the content of file returning the result.


* Basic syntax: `grep -in "search_term" filename`
    * -n : gives the line-number of matching term in a file
    * -i : Ignore case

* Search in directory: `grep -nr search_term directory`
    * -r : searches recursively in given directory 

* List all the file containing the search_term: `grep -l "search_term" *`
    * -l : Input needs to be list of files

* List all the lines **not** containing the search_term: `grep -nv "search_term" filename`

* List all file containing the search **in given directory**: `grep -lr search_term .`
    * `.` represents current directory

* Select  only  those  matches  that exactly match the whole line:  `grep -xr tabular ..`
    * `..` represents the parent directory

Reference: <a href="http://www.uccs.edu/~ahitchco/grep/" target="_blank" >http://www.uccs.edu/~ahitchco/grep/</a>
