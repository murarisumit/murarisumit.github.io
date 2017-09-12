---
title: GREP minimal tutorial
date: 2016-08-07 00:00:00
layout: post
tags:
  - GNU/Linux
---


##### Grep command is used for searching the content of file returning the result.

* Basic syntax: `grep -in "search_term" filename`
  * -n : gives the line-number of matching term in a file
  * -i : Ignore case
* Search in directory: `grep -nr search_term directory`
  * -r : searches recursively in given directory
* List all file with the search_term: `grep -l "search_term" \*`
  * -l : Input needs to be list of files
* List all lines **not/invert-match** with the search_term: `grep -nv "search_term" filename`

* List all file with the search_term **in given directory**: `grep -lr search_term .`
  * `.` represents current directory
* Select only matches that exactly match the whole line: `grep -xr tabular ..`
  * `..` represents the parent directory

Reference: 
* [http://www.uccs.edu/~ahitchco/grep/](http://www.uccs.edu/~ahitchco/grep/)
