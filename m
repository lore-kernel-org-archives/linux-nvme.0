From: keith.busch@intel.com (Keith Busch)
Date: Wed, 30 Dec 2015 17:00:37 -0700
Subject: [RFC] Add CPU state for iopoll
Message-ID: <1451520039-18220-1-git-send-email-keith.busch@intel.com>

Hi everyone,

I'm just submitting to storage lists to see if anyone else thinks
this is useful. 

Linux kernel 4.4 adds a new block mode to poll IO for low-latency
storage. When not polling, we can see CPU time spent in system vs. in
iowait. For example, 'mpstat' may show:


  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
    0    0.00    0.00   40.96   59.04    0.00    0.00    0.00    0.00    0.00


and that's useful to see the iowait, and, when combined with other data,
indicates how the h/w is performing. If we've enabled IO polling, though,
we get something like this:


  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
    0    0.00    0.00  100.00    0.00    0.00    0.00    0.00    0.00    0.00


Which is pretty useless for gaining insights on how the h/w is
doing. Right now I use 'perf record' to measure where CPU cycles are
spent, but that's not always feasible or convenient.

The following series proposes a new CPU state called "iopoll" so we can
get similarly useful information. The result looks like this:


  CPU    %usr   %nice    %sys %iowait %iopoll   %irq   %soft  %steal  %guest  %gnice   %idle
    0    1.00    0.00   34.00    0.00   65.00    0.00    0.00    0.00    0.00    0.00    0.00


The first patch is the kernel part. The second is for sysstat. I might
be concerned about the potential for breaking older stats tools...

Thanks!

Keith Busch (1):
  CPU: New state for iopoll

 block/blk-core.c            | 7 ++++++-
 fs/proc/stat.c              | 8 ++++++--
 include/linux/kernel_stat.h | 1 +
 include/linux/sched.h       | 1 +
 kernel/sched/cpuacct.c      | 1 +
 kernel/sched/cputime.c      | 7 ++++++-
 6 files changed, 21 insertions(+), 4 deletions(-)

Keith Busch (1):
  sysstat: Report iopoll CPU percentage

 common.c   |  4 ++--
 iostat.c   | 10 ++++++----
 mpstat.c   | 18 ++++++++++++------
 rd_stats.c | 10 ++++++----
 rd_stats.h |  1 +
 5 files changed, 27 insertions(+), 16 deletions(-)
-- 
2.6.2.307.g37023ba
