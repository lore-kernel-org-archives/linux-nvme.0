From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 16 May 2018 15:27:57 -0600
Subject: nvme: batch completions and do them outside of the queue lock
In-Reply-To: <528cf765-16ae-5499-8843-9a62b4fd8326@kernel.dk>
References: <528cf765-16ae-5499-8843-9a62b4fd8326@kernel.dk>
Message-ID: <20180516212757.GD20223@localhost.localdomain>

On Wed, May 16, 2018@02:37:40PM -0600, Jens Axboe wrote:
> This patch splits up the reaping of completion entries, and the
> block side completion. The advantage of this is two-fold:
> 
> 1) We can batch completions, this patch pulls them off in units
>    of 8, but that number is fairly arbitrary. I wanted it to be
>    big enough to hold most use cases, but not big enough to be
>    a stack burden.
> 
> 2) We complete the block side of things outside of the queue lock.

Interesting idea. Since you bring this up, I think there may be more
optimizations on top of this concept. I'll stare at this a bit before
applying, or may have a follow-up proposal later.
 
> Note that this kills the ->cqe_seen as well. I haven't been able
> to trigger any ill effects of this. If we do race with polling
> every so often, it should be rare enough NOT to trigger any issues.

We'll know who to blame if spurious interrupt messages are seen. :)
