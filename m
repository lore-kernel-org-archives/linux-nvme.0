From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 Jul 2015 20:27:16 +0000 (UTC)
Subject: Extremely high context switches of i/o to NVM
In-Reply-To: <2140969145.2200151.1437768000851.JavaMail.yahoo@mail.yahoo.com>
References: <2140969145.2200151.1437768000851.JavaMail.yahoo@mail.yahoo.com>
Message-ID: <alpine.LNX.2.00.1507242006210.15930@localhost.lm.intel.com>

On Fri, 24 Jul 2015, Junjie Qian wrote:
> Hi List,
>
> I run experiment with NVM on NUMA, and found the context switch is extremely high.
>
> The platform is, 1. Linux 4.1-rc7 with multi-queue enabled, kernel is polling enabled (5 secs polling, but the results show little difference between polling and interrupt); 2. 4-socket NUMA machine; 3. Intel PC3700 NVM
>
> The command is sudo perf state -e context-switches nice -n -20 numactl -C 0 fio-master/fio --name=1 --bs=4k --ioengine=libaio --iodepth=1 --rw=read --numjobs=1 --filename=/dev/nvme0n1 --thread --direct=1 --group_reporting --time_based=1 --runtime=60
>
> The result is 3,567,428 context switches.
>
> Would someone give me some help on explaining this? Is this reasonable?
> Thanks!

Sounds about right with an IO depth of 1. You're going to get a context
switch per IO, right?
