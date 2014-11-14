From: keith.busch@intel.com (Keith Busch)
Date: Fri, 14 Nov 2014 17:56:43 +0000 (UTC)
Subject: [PATCH] NVMe: limit max completion iterations in nvme_process_cq()
In-Reply-To: <20141114164836.GB12860@kernel.dk>
References: <20141114164836.GB12860@kernel.dk>
Message-ID: <alpine.LNX.2.00.1411141749470.4225@localhost.lm.intel.com>

On Fri, 14 Nov 2014, Jens Axboe wrote:
> This is an unbounded loop. If we have per-cpu queues this is
> usually not a problem, but if CPUs share a queue, then we could
> have some of them continually queueing IO and the loop could take
> forever to exit.
>
> Limit max iterations to the queue depth of the given completion
> queue, which seems like a nice number to use.

I think the loop implicitly already has the same max iteration: the
queue lock is held when it's called, so new commands can't be posted on
the submission queue while the completions are reaped, so we can't loop
more than the depth.
