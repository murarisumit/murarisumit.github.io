---
title: Building basic linux modules
date: '2018-07-06 00:00:00 +0000'
tags:
- gnu-linux
layout: post
---

--- 
Ref:
* It's a pure rip-off from [https://goyalankit.com/blog/linux-device-drivers](https://goyalankit.com/blog/linux-device-drivers) kept here for my convinence: 


---
### Environment setup

* You need linux headers to be able to compile new module.

* To make sure you have linux headers, see if the following path exists:

        $ ls /usr/src/linux-headers-`uname -r`
        arch   crypto         drivers   fs       init  Kbuild   kernel
        ...

* If the above directory is not present, you can install the headers using:
  * `sudo apt-get update && sudo apt-get install linux-headers-$(uname -r)`

Once the headers are installed you are good to go.

### Writing hello module

* To start off, create the following file in any directory.

        // hello.c
        #include <linux/module.h>
        MODULE_LICENSE("Dual BSD/GPL");

* Create the following Makefile to compile your module.

        obj-m := hello.o
        KDIR := /usr/src/linux-headers-3.2.0-23-generic

        all:
            make -C $(KDIR) M=$(PWD) modules
        clean:
            make -C $(KDIR) M=$(PWD) clean

* After running `make`, you should see following:

* Check that .ko is created.

        vagrant@precise64:~$ ls
        hello.c  hello.ko  hello.mod.c  hello.mod.o  hello.o  Makefile

### Install the module.
* `vagrant@precise64:~$ sudo insmod hello.ko`

* Confirm the it's installed.

        vagrant@precise64:~$ lsmod | grep hello
        hello                   8217  0

### Remove the module.
* `vagrant@precise64:~$ sudo rmmod hello`

### Confirm that it's removed.
* `vagrant@precise64:~$ lsmod | grep hello`


Expanding further, each module needs to have an init and exit method.

```c
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

MODULE_LICENSE("Dual BSD/GPL");

static int hello_init(void) {
  printk("<1> Hola Mundo!\n");
  return 0;
}

static void hello_exit(void) {
  printk("<1>Hasta Luego\n");
}

module_init(hello_init);
module_exit(hello_exit);
```


Again, use __inmod__ to install the command and you should see Hola Mundo! in `$ dmesg`. 
`printk` is important here; as kernel will print it to the syslog. Pretty useful in understanding other drivers.


