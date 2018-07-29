---
title: Understanding linux load average and CPU measurement.
date: 2018-07-09 00:00:00
layout: post
tags:
  - gnu-linux
---

Reference: 
* This is original article, I read from. Kept here for personal refrence.[http://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html](http://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html)


### Opening

Linux load averages track not just runnable tasks, but also tasks in the uninterruptible sleep state. Why? I've never seen an explanation. In this post I'll solve this mystery, and summarize load averages as a reference for everyone trying to interpret them.

Linux load averages are "system load averages" that show the running thread (task) demand on the system as an average number of running plus waiting threads. This measures demand, which can be greater than what the system is currently processing. Most tools show three averages, for 1, 5, and 15 minutes:



### Linux Uninterruptible Tasks

* When load averages first appeared in Linux, they reflected CPU demand, as with other operating systems. 
* later on Linux changed them to include not only runnable tasks, but also tasks in the uninterruptible state (`TASK_UNINTERRUPTIBLE` or `nr_uninterruptible`). 
* This state is used by code paths that want to avoid interruptions by signals, which includes tasks blocked on disk I/O and some locks. You may have seen this state before: it shows up as the `D` state in the output ps and top. The ps(1) man page calls it `uninterruptible` sleep (usually IO)".

Adding the uninterruptible state means that __Linux load averages can increase due to a disk (or NFS) I/O workload, not just CPU demand__.


### Chase

He was looking for the code with made the change in system average file.

* He checked `loadavg.c`, but the change was older than 2005, when Linus imported Linux 2.6.12-rc2.
* He checked historical changes in linux repo, but wasn't able to find anything up there.
* He searched tarballs on kernel.org and found that it had changed by 0.99.15, and not by 0.99.13 – however, the tarball for 0.99.14 was missing.
* He found it elsewhere, and confirmed that the change was in Linux 0.99 patchlevel 14, Nov 1993, but the changelog was

        "Changes to the last official release (p13) are too numerous to mention (or even to remember)..." – Linus

* Based on the date, he looked up the kernel mailing list archives to find the actual patch, but the oldest email available is from June 1995, when the sysadmin writes:

        "While working on a system to make these mailing archives scale more effecitvely I accidently destroyed the current set of archives (ah whoops)."

* He found some older linux-devel mailing list archives, rescued from server backups, often stored as tarballs of digests. I searched over 6,000 digests containing over 98,000 emails, 30,000 of which were from 1993. But it was somehow missing from all of them.

### The origin of uninterruptible

Fortunately, he did finally find the change, in a compressed mailbox file from 1993 on oldlinux.org. Here it is:

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


### Better tools for measuring CPUs.

* mpstat: To monitor individual processor performance, issue following command
  * per-CPU utilization: eg, using `mpstat -P ALL 1`
* iostat : The iostat command reports Central Processing Unit (CPU) statistics and input/output statistics for devices and partitions. It can be use to find out your system's average CPU utilization since the last reboot.
  * `iostat`
* vmstat: CPU run queue length: eg, using vmstat 1 and the 'r' column

$ iostat
mpstat -P ALL



### Conclusion

In 1993, a Linux engineer found a nonintuitive case with load averages, and with a three-line patch changed them forever from "CPU load averages" to what one might call "system load averages." His change included tasks in the uninterruptible state, so that load averages reflected demand for disk resources and not just CPUs. These system load averages count the number of threads working and waiting to work, and are summarized as a triplet of exponentially-damped moving sum averages that use 1, 5, and 15 minutes as constants in an equation. This triplet of numbers lets you see if load is increasing or decreasing, and their greatest value may be for relative comparisons with themselves.

The use of the uninterruptible state has since grown in the Linux kernel, and nowadays includes uninterruptible lock primitives. If the load average is a measure of demand in terms of running and waiting threads (and not strictly threads wanting hardware resources), then they are still working the way we want them to.

In this post, I dug up the Linux load average patch from 1993 – which was surprisingly difficult to find – containing the original explanation by the author. I also measured stack traces and time in the uninterruptible state using bcc/eBPF on a modern Linux system, and visualized this time as an off-CPU flame graph. This visualization provides many examples of uninterruptible sleeps, and can be generated whenever needed to explain unusually high load averages. I also proposed other metrics you can use to understand system load in more detail, instead of load averages.

I'll finish by quoting from a comment at the top of `kernel/sched/loadavg.c` in the Linux source, by scheduler maintainer Peter Zijlstra:

        This file contains the magic bits required to compute the global loadavg
        figure. Its a silly number but people think its important. We go through
        great pains to make it work on big machines and tickless kernels.
