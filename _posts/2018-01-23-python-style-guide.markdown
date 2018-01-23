---
layout: post
title: "Python Style Guide"
date: 2018-01-23T09:23:30+00:00
tags:
 - Python
---

Base style guide  python.

* Function invocation.
```python
    # Aligned with opening delimiter.
    foo = long_function_name(var_one, var_two,
                             var_three, var_four)

    # More indentation included to distinguish this from the rest.
    def long_function_name(
            var_one, var_two, var_three,
            var_four):
        print(var_one)

    # Hanging indents should add a level.
    foo = long_function_name(
        var_one, var_two,
        var_three, var_four)
```


---
###### Note: I'll be keep on updating it.

---
Reference: 
* [https://www.python.org/dev/peps/pep-0008/](https://www.python.org/dev/peps/pep-0008/)
