From: junjie.qian@yahoo.com (Junjie Qian)
Date: Fri, 24 Jul 2015 23:03:44 +0000 (UTC)
Subject: Extremely high context switches of i/o to NVM
In-Reply-To: <alpine.LNX.2.00.1507242006210.15930@localhost.lm.intel.com>
References: <alpine.LNX.2.00.1507242006210.15930@localhost.lm.intel.com>
Message-ID: <796822148.2252044.1437779024198.JavaMail.yahoo@mail.yahoo.com>

Hi Keith,

Thank you for the explanation! Yes, the number of context switch is equal to the number of IOs times the IO depth.

In my understanding, the IOs are submitted continuously by one thread, and the context switch only happens when the thread is scheduled out of execution. I did not know that it needs context switch between the IOs.
 Thanks!
Best
Junjie


----- Original Message -----
From: Keith Busch <keith.busch@intel.com>
To: Junjie Qian <junjie.qian at yahoo.com>
Cc: "linux-nvme at lists.infradead.org" <linux-nvme at lists.infradead.org>
Sent: Friday, July 24, 2015 3:27 PM
Subject: Re: Extremely high context switches of i/o to NVM

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

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
