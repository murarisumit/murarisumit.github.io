---
title: AWK minimal tutorial
date: 2016-04-25 00:00:00
layout: post
---

AWK is an interpreted programming language. It's designed for text processing. Input is read line by line and awk script/command is executed.

<b><u>Basic examples</u><b>

*   Input processing

    *   Get input from _input.txt_ file and process file line by line:  `awk '{ }' input.txt`
    *   Get piped input  and process output line by line:   `cat input.txt | awk '{}'`
    
*   Read  _input.txt_ and print the 3rd word from each line: `awk '{ print $3 }' input.txt`

*   Read input line by line, and print each line: `cat input.txt | awk '{print $0}'`

*   Check for pattern, if found print first word: `awk ' /pattern/ {print $1}' input.txt`

*   If _str_ matches the 2nd word, print 3rd word: `awk '$2=="str" {print $3}' input.txt` 

*   If 1st word **partly** matches _str_, then print 3rd word: `awk '$1 ~ "str" {print $3}' input.txt` 

*   Ignorecase string comparision, if 2nd element is "find/Find/fInd/fiND", then print third element :
  
     >  `awk '{ if (tolower($2) == "find") print $3}' input.txt`
     
*   Variable in awk: 

	>  `awk -v name=Jerry 'BEGIN{printf "Name = %s\n", name}'`

*   Add two numbers: 

	> `awk ' BEGIN { a = 50; b = 20; print "(a + b) = ", (a + b) }'`

*   Increment operation:  

	> `awk 'BEGIN { a = 10; b = ++a; printf "a = %d, b = %d\n", a, b }'`

*   Looping and other construct are also there, which you can read from [here](http://www.tutorialspoint.com/awk/awk_loops.htm), but above basic stuff will get you started.

References: [Tutorials Point](http://www.tutorialspoint.com/awk/): http://www.tutorialspoint.com/awk/
