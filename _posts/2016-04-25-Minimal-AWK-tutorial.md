---
title: AWK minimal tutorial
date: '2016-04-24 12:00:00'
layout: post
tags:
- gnu-linux
---

AWK is an interpreted programming language. It's designed for text processing. Input is read line by line and awk script/command is executed.

<b><u>Basic examples</u><b>

*   Input processing

    *   Get input from _input.txt_ file and process file line by line:  `awk '{ }' input.txt`
    *   Get piped input  and process output line by line:   `cat input.txt | awk '{}'`

*   Read  _input.txt_ and print the 3rd word from each line: `awk '{ print $3 }' input.txt`

*   Read input line by line, and print each line: `cat input.txt | awk '{print $0}'`

*   Check for pattern, if found print first word: `awk ' /pattern/ {print $1}' input.txt`

*   If _str_ matches with 2nd word, print 3rd word: `awk '$2=="str" {print $3}' input.txt`

*   Specify field saperator for parsed line: `awk -F'&' '$2=="str" {print $3}' input.txt`
    * Now each field i.e. $1, $2 will be string saperated by '&' unlike 'space' is default case.

*   If 1st word **partly** matches _str_, then print 3rd word: `awk '$1 ~ "str" {print $3}' input.txt`

*   Ignorecase string comparision, if 2nd element is "find/Find/fInd/fiND", then print third element :

     >  `awk '{ if (tolower($2) == "find") print $3}' input.txt`

**BEGIN, END and NR are some of [in-built variables](https://www.gnu.org/software/gawk/manual/html_node/Auto_002dset.html) in AWK**

*   Variable in awk:
	* **BEGIN** block runs only once and at beginning.
	>  `awk -v name=Jerry 'BEGIN{printf "Name = %s\n", name}'`

*   Add two numbers:

	> `awk ' BEGIN { a = 50; b = 20; print "(a + b) = ", (a + b) }'`

* Read number of lines in file.
	* **END** block executes after executing all the awk codes.
	* **NR** is in-built variable which line number is excuted.
	> `awk 'END { print NR }' inputfile`

*  Using BEGIN, END and NR
>`awk 'BEGIN{print "Begin";print "multiple"} {print "Line " NR ":" $0 }END{print "END"} inputfile`

*   Looping and other construct are also there, which you can read from [here](http://www.tutorialspoint.com/awk/awk_loops.htm), but above basic stuff will get you started.

<br/>
References: [Tutorials Point](http://www.tutorialspoint.com/awk/): http://www.tutorialspoint.com/awk/
