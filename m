From: yaolin@marvell.com (Yao Lin)
Date: Fri, 12 Oct 2018 16:02:57 +0000
Subject: [EXT] Re: bad IOPS when running multiple btest/fio in parallel
In-Reply-To: <1539359350.249485.6.camel@acm.org>
References: <1539319463418.78556@marvell.com>
 <1539359350.249485.6.camel@acm.org>
Message-ID: <707ebd2e96d9460f9a6188c9cb6ae141@SC-EXCH03.marvell.com>

Thanks Bart. In my original post, I list the performance from 2 different 100G NICs. I worked with the engineer for the NIC that performs better. Their driver does support large number of IRQ which are assigned to all 28 CPUs in a round-robin manner. But even with this  design, that NIC can hit only 76Gb/s for RoCEv2 traffic. 

I haven't got the response from the other NIC vendor. Their RoCEv2 throughput has never exceed 55Gb/s. I will take a look at the source code.

-----Original Message-----
From: Bart Van Assche [mailto:bvanassche@acm.org] 
Sent: Friday, October 12, 2018 8:49 AM
To: Yao Lin ; linux-nvme at lists.infradead.org
Subject: [EXT] Re: bad IOPS when running multiple btest/fio in parallel

External Email

----------------------------------------------------------------------
On Fri, 2018-10-12@04:44 +0000, Yao Lin wrote:
> Today I changed to a much simpler setup and the same issue persists.
> 
> Directly connect 2 PCs (identical hardware) with a pair of 100G rNICs.
> Create a null block device on the target PC and configure it as the 
> NVMeOF target. So, there is no switch or SSD in this setup. And this 
> is a single FIO, not the 4 FIO in parallel I mentioned earlier.
> 
> Start fio test against that null block device from the host, the best 
> IOPS is 1550K. That's the best IOPS after I try out many different QD, 
> # of job, and CPU affinity setting. Run the same fio test on the 
> target, I get 2250K IOPS (it jumps to 3650K when I increased the 
> number of threads).
> 
> So it seems to me that Linux NVMe stack is quite good and can support 
> 100Gb/s + throughput. But the same can not be said of the NVMeOF stack.
> Any tuning possible?

Many high-speed network adapters need multiple connections between initiator and target to achieve line rate (typically 2-4 connections).
>From the NVMeOF initiator driver:

		set->nr_hw_queues = nctrl->queue_count - 1;

I think the "queue_count" parameter can be configured when creating a connection. From the drivers/nvme/host/fabrics.c source file:

static const match_table_t opt_tokens = {
	[ ... ]
	{ NVMF_OPT_NR_IO_QUEUES,	"nr_io_queues=%d"	},
	[ ... ]
};

Have you tried to modify the nr_io_queues parameter? Have you verified whether the 100G NICs you are using allocate multiple MSI/X vectors and whether each vector has been assigned to another CPU?

Bart.
