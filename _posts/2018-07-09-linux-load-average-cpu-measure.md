---
title: Understanding linux load average and CPU measurement.
date: 2018-07-09 05:30:00 +05:30
categories:
- tech
tags:
- gnu-linux
layout: post
---

Reference: 
* This is original article, I read from. Kept here for personal refrence.[http://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html](http://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html)


### Linux Uninterruptible Tasks

* When load averages first appeared in Linux, they reflected CPU demand, as with other operating systems. 
* later on Linux changed them to include not only runnable tasks, but also tasks in the uninterruptible state (`TASK_UNINTERRUPTIBLE` or `nr_uninterruptible`). 
* This state is used by code paths that want to avoid interruptions by signals, which includes tasks blocked on disk I/O and some locks. You may have seen this state before: it shows up as the `D` state in the output ps and top. The ps(1) man page calls it `uninterruptible` sleep (usually IO)".

Adding the uninterruptible state means that __Linux load averages can increase due to a disk (or NFS) I/O workload, not just CPU demand__.


### The origin of uninterruptible

        From: Matthias Urlichs <urlichs@smurf.sub.org>
        Subject: Load average broken ?
        Date: Fri, 29 Oct 1993 11:37:23 +0200


        The kernel only counts "runnable" processes when computing the load average.
        I don't like that; the problem is that processes which are swapping or
        waiting on "fast", i.e. noninterruptible, I/O, also consume resources.

        It seems somewhat nonintuitive that the load average goes down when you
        replace your fast swap disk with a slow swap disk...

        Anyway, the following patch seems to make the load average much more
        consistent WRT the subjective speed of the system. And, most important, the
        load is still zero when nobody is doing anything. ;-)

        --- kernel/sched.c.orig Fri Oct 29 10:31:11 1993
        +++ kernel/sched.c  Fri Oct 29 10:32:51 1993
        @@ -414,7 +414,9 @@
            unsigned long nr = 0;

            for(p = &LAST_TASK; p > &FIRST_TASK; --p)
        -       if (*p && (*p)->state == TASK_RUNNING)
        +       if (*p && ((*p)->state == TASK_RUNNING) ||
        +                  (*p)->state == TASK_UNINTERRUPTIBLE) ||
        +                  (*p)->state == TASK_SWAPPING))
                    nr += FIXED_1;
            return nr;
         }
        --
        Matthias Urlichs        \ XLink-POP N|rnberg   | EMail: urlichs@smurf.sub.org
        Schleiermacherstra_e 12  \  Unix+Linux+Mac     | Phone: ...please use email.
        90491 N|rnberg (Germany)  \   Consulting+Networking+Programming+etc'ing      42

"It's amazing to read the thoughts behind this change from almost 24 years ago."

* This confirms that the load averages were deliberately changed to reflect demand for other system resources, not just CPUs. 
* Linux changed from "CPU load averages" to what one might call "system load averages".

His example of using a slower swap disk makes sense: by degrading the system's performance, the demand on the system (measured as running + queued) should increase. However, load averages decreased because they only tracked the CPU running states and not the swapping states. Matthias thought this was nonintuitive, which it is, so he fixed it.


### Making sense of Linux load averages

* Usally with other OSes where load averages meant CPU load averages, so the Linux version is different. 
* Perhaps the real problem all along is that the words "load averages" are about as ambiguous as "I/O". Which type of I/O? Disk I/O? File system I/O? Network I/O? 
* Likewise, which load averages? CPU load averages? System load averages? Clarifying it this way lets me make sense of it like this:

        On Linux, load averages are (or try to be) "system load averages", for the system as a whole, measuring the number of threads that are working and waiting to work (CPU, disk, uninterruptible locks). Put differently, it measures the number of threads that aren't completely idle. Advantage: includes demand for different resources.
        On other OSes, load averages are "CPU load averages", measuring the number of CPU running + CPU runnable threads. Advantage: can be easier to understand and reason about (for CPUs only).

Note that there's another possible type: "physical resource load averages", which would include load for physical resources only (CPU + disk).

Perhaps one day we'll add additional load averages to Linux, and let the user choose what they want to use: a separate "CPU load averages", "disk load averages", "network load averages", etc. Or just use different metrics altogether.



### Conclusion

In 1993, a Linux engineer found a nonintuitive case with load averages, and with a three-line patch changed them forever from "CPU load averages" to what one might call "system load averages." His change included tasks in the uninterruptible state, so that load averages reflected demand for disk resources and not just CPUs. These system load averages count the number of threads working and waiting to work, and are summarized as a triplet of exponentially-damped moving sum averages that use 1, 5, and 15 minutes as constants in an equation. This triplet of numbers lets you see if load is increasing or decreasing, and their greatest value may be for relative comparisons with themselves.

The use of the uninterruptible state has since grown in the Linux kernel, and nowadays includes uninterruptible lock primitives. If the load average is a measure of demand in terms of running and waiting threads (and not strictly threads wanting hardware resources), then they are still working the way we want them to.

As original author post this also finishes by quoting from a comment at the top of `kernel/sched/loadavg.c` in the Linux source, by scheduler maintainer Peter Zijlstra:

        This file contains the magic bits required to compute the global loadavg
        figure. Its a silly number but people think its important. We go through
        great pains to make it work on big machines and tickless kernels.
