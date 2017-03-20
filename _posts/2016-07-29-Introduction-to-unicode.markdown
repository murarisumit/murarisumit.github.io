---
title: Unicode little introduction
date: 2016-07-29 00:00:00 Z
layout: post
---

> Unicode

Unicode is a character encoding standard.

* In Unicode, each character has code-points. Unicode has more than **1 million code-points** representing character for every language.

* Unicode is text less. For saving code-points in Unicode to disk you have to encode it. 

* Unicode code-points e.g. **U+004E** for **N** for saving, has be encoded to UTF-8 or some other encoding techniques like UTF-16 or Shift-JIS

    * In UTF-8, first 128 character are encoded just like ASCII, so it takes 1-4 byte for per code-points for storing to disk.

    * In UTF-16, we use 2-4 byte for storing per code-points. It is optimised for language that use 2 bytes to use character.

    * In UTF-32, here it's fixed 4 byte(32 bits) to store code-points. It's fastest

---
Code points for **ć** character.

| letter | C-Point |
|:------:|:----------:|
| `ć`    |  `U+0107`  |


---
**Byte Encodings**

|letter | UTF-8   | UTF-16  | Shift-JIS |
|:-----:|:-------:|:-------:|:---------:|
| `ć`   | `\xc4\x87`| `\x07\x01`| `\x85\xc9`  |
