From: keith.busch@intel.com (Keith Busch)
Date: Wed, 9 Oct 2013 09:48:17 -0600 (MDT)
Subject: [PATCH RFC 0/2] Convert from bio-based to blk-mq
In-Reply-To: <20131008183949.GB23288@kernel.dk>
References: <1381224862-5299-1-git-send-email-m@bjorling.me>
 <20131008131036.GC7422@linux.intel.com> <20131008183949.GB23288@kernel.dk>
Message-ID: <alpine.LRH.2.03.1310090921220.4763@AMR>

On Tue, 8 Oct 2013, Jens Axboe wrote:
> On Tue, Oct 08 2013, Matthew Wilcox wrote:
>> On Tue, Oct 08, 2013@11:34:20AM +0200, Matias Bj?rling wrote:
>>> The nvme driver implements itself as a bio-based driver. This primarily because
>>> of high lock congestion for high-performance nvm devices. To remove the
>>> congestion, a multi-queue block layer is being implemented.
>>
>> Um, no.  You'll crater performance by adding another memory allocation
>> (of the struct request).  multi-queue is not the solution.
>
> That's a rather "jump to conclusions" statement to make. As Matias
> mentioned, there are no extra fast path allocations. Once the tagging is
> converted as well, I'd be surprised if it performs worse than before.
> And that on top of a net reduction in code.
>
> blk-mq might not be perfect as it stands, but it's a helluva lot better
> than a bunch of flash based drivers with lots of duplicated code and
> mechanisms. We need to move away from that.
>
> -- 
> Jens Axboe

But this wastes copious amounts of memory on an NVMe device with more
than 1 namespace. The hardware's queues are shared among all namespaces,
so you can't possibly have all the struct requests in use. What would
be better is if I can create one blk-mq for each device/host and attach
multiple gendisks to that.
