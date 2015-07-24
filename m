From: junjie.qian@yahoo.com (Junjie Qian)
Date: Fri, 24 Jul 2015 20:00:00 +0000 (UTC)
Subject: Extremely high context switches of i/o to NVM
Message-ID: <2140969145.2200151.1437768000851.JavaMail.yahoo@mail.yahoo.com>

Hi List,

I run experiment with NVM on NUMA, and found the context switch is extremely high.

The platform is, 1. Linux 4.1-rc7 with multi-queue enabled, kernel is polling enabled (5 secs polling, but the results show little difference between polling and interrupt); 2. 4-socket NUMA machine; 3. Intel PC3700 NVM

The command is sudo perf state -e context-switches nice -n -20 numactl -C 0 fio-master/fio --name=1 --bs=4k --ioengine=libaio --iodepth=1 --rw=read --numjobs=1 --filename=/dev/nvme0n1 --thread --direct=1 --group_reporting --time_based=1 --runtime=60

The result is 3,567,428 context switches.

Would someone give me some help on explaining this? Is this reasonable?
 Thanks!
Best
Junjie
