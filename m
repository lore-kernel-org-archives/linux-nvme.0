From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 16 Jan 2017 09:40:17 -0800
Subject: nvme queue load balanced distribution of requests
In-Reply-To: <259VaPBGA7184S06.1484530406@web06.cms.usa.net>
References: <259VaPBGA7184S06.1484530406@web06.cms.usa.net>
Message-ID: <20170116174017.GA14171@infradead.org>

On Sun, Jan 15, 2017@07:33:26PM -0600, Joshua Mora wrote:
> Hello.
> I am benchmarking different NVMEs that have 8, 16 or upto 32 queues.
> Despite I provide a queue depth in the benchmark (like fio) and also run
> concurrently multiple threads to different files to the same NVME (ie.
> multiple jobs), I do not succeed to use all those queues.
> Is there any parameter somewhere to configure that ?

Linux assigns the queue to CPUs to provide a lock less or at least
low on contention I/O submission and completion path.  So to use
all queues you needd to

 a) have a CPU core count bigger or equal to the number of queues
 b) have I/O issued on all CPUs

Note that using more queues doesn't automatically mean getting better
IOPS numbers.
