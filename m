From: joshua_mora@usa.net (Joshua Mora)
Date: Mon, 16 Jan 2017 14:18:48 -0600
Subject: nvme queue load balanced distribution of requests
Message-ID: <940VaPuRW9216S05.1484597928@web05.cms.usa.net>

Thanks Christoph for your quick reply.

I want to limit the number of cpu cores used per NVME but I want to use all
the queues available. This is important for read requests at low record
length.
How do I control that ?
It seems that in order to use more queues I have to use more cores and that is
precisely what I want to restrict to 2-4 cores at most but using all the
queues available.

I have many NVME drives and many cores within the system so I want to
"manually" assign a limited set of cores and their NVME interrupts to the same
few cores.
Is it possible for instance to assign 4 cores to deal with a device with 32
queues ?
How do I make sure that the 32 queues are used ? with few cores ?

Where is in the code where that decision is made ?
Also, related with power management on the nvme, is there any tool for that
(nvme-cli ?)

Joshua

------ Original Message ------
Received: 11:40 AM CST, 01/16/2017
From: Christoph Hellwig <hch@infradead.org>
To: Joshua Mora <joshua_mora at usa.net>Cc: linux-nvme at lists.infradead.org
Subject: Re: nvme queue load balanced distribution of requests

> On Sun, Jan 15, 2017@07:33:26PM -0600, Joshua Mora wrote:
> > Hello.
> > I am benchmarking different NVMEs that have 8, 16 or upto 32 queues.
> > Despite I provide a queue depth in the benchmark (like fio) and also run
> > concurrently multiple threads to different files to the same NVME (ie.
> > multiple jobs), I do not succeed to use all those queues.
> > Is there any parameter somewhere to configure that ?
> 
> Linux assigns the queue to CPUs to provide a lock less or at least
> low on contention I/O submission and completion path.  So to use
> all queues you needd to
> 
>  a) have a CPU core count bigger or equal to the number of queues
>  b) have I/O issued on all CPUs
> 
> Note that using more queues doesn't automatically mean getting better
> IOPS numbers.
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
