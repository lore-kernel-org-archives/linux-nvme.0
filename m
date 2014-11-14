From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 13 Nov 2014 18:29:37 -0700
Subject: [PATCH] NVMe: Add rw_page support
In-Reply-To: <1415923538-18760-1-git-send-email-keith.busch@intel.com>
References: <1415923538-18760-1-git-send-email-keith.busch@intel.com>
Message-ID: <54655B01.9090206@kernel.dk>

On 2014-11-13 17:05, Keith Busch wrote:
> This adds the rw_page entry point to the nvme driver so a page can be
> written/read without going through the block layer and not requiring
> additional allocations.
>
> Just because we implement this doesn't mean we want to use it. I only see
> a performance win on some types of work, like swap where I see about 15%
> reduction in system time (compared to 20% prior to blk-mq when we didn't
> allocate a request to get a command id). Even then, system time accounts
> for very little of the real time anyway, and it's only an over-all win
> if the device has very low-latency. But the driver doesn't know this
> nor if the expected workload will even benefit from using page io,
> so I added a queue flag that a user can toggle on/off.

Of the reduced system time, where was that spent?

> The other benefit besides reduced system time is that we can swap
> pages in/out without having to allocate anything since everything is
> preallocated in this path.

I have an iod prealloc patch that gets rid of the last kmalloc/kfree in 
the IO path for nvme, for smaller IO (defaults to 8KB, or 2 segments), 
making the generic IO path contain no allocations/frees for smaller IO. 
Probably that would get us pretty close to rw_page. For direct/sync IO, 
we'll go direct to ->queue_rq mostly, too.

The downside I see is that this is an OOB IO path. Once we start adding 
IO scheduling for those that need that, then this will completely bypass 
that.

-- 
Jens Axboe
