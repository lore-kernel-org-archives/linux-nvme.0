From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 8 Oct 2013 12:39:49 -0600
Subject: [PATCH RFC 0/2] Convert from bio-based to blk-mq
In-Reply-To: <20131008131036.GC7422@linux.intel.com>
References: <1381224862-5299-1-git-send-email-m@bjorling.me>
 <20131008131036.GC7422@linux.intel.com>
Message-ID: <20131008183949.GB23288@kernel.dk>

On Tue, Oct 08 2013, Matthew Wilcox wrote:
> On Tue, Oct 08, 2013@11:34:20AM +0200, Matias Bj?rling wrote:
> > The nvme driver implements itself as a bio-based driver. This primarily because
> > of high lock congestion for high-performance nvm devices. To remove the
> > congestion, a multi-queue block layer is being implemented.
> 
> Um, no.  You'll crater performance by adding another memory allocation
> (of the struct request).  multi-queue is not the solution.

That's a rather "jump to conclusions" statement to make. As Matias
mentioned, there are no extra fast path allocations. Once the tagging is
converted as well, I'd be surprised if it performs worse than before.
And that on top of a net reduction in code.

blk-mq might not be perfect as it stands, but it's a helluva lot better
than a bunch of flash based drivers with lots of duplicated code and
mechanisms. We need to move away from that.

-- 
Jens Axboe
