From: keith.busch@intel.com (Keith Busch)
Date: Wed, 30 Dec 2015 19:07:06 +0000
Subject: [PATCH 5/5] NVMe: IO queue deletion re-write
In-Reply-To: <20151230180430.GA12828@infradead.org>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-6-git-send-email-keith.busch@intel.com>
 <20151230180430.GA12828@infradead.org>
Message-ID: <20151230190706.GC12454@localhost.localdomain>

On Wed, Dec 30, 2015@10:04:30AM -0800, Christoph Hellwig wrote:
> I love the overall scheme, but I think some of the implementation
> detail will need a few changes to be long term maintainable:

Thanks! I don't think anyone liked the existing way, but it hasn't been
completely trivial to replace it and preserve functionality.

> First the 'wait' workqueue is a per-controller wait, so it should
> be in nvme_ctrl instead of a union inside the queue. 

Okay. I was trying to save a few bytes. Certainly not worth it.

> Second it
> should really be a wait queue, and it should only wake the caller
> when all pending queues have been deleted to avoid spurious wakeups.

The "completion" API counts the completions so the driver doesn't have to,
and waking the thread on each completion notifies the waiter a request
tag is available so it may continue submitting queue deletions.

> The other things is the use of nvme_requeue_req for submitting
> a different command, which looks rather hacky.  I'd suggest to
> just wake a per-queue work item to do a proper command allocation
> and submission, which also means we can use the normal on-stack
> commands.

Aww, I really liked the re-queuing! :) It encapsulates deleting a
queue-pair as a single, two-step operation.

There's a failure scenario that complicates work item handling. It has
the same flaw kthread workers had if work is queued deeper than available
tags, and then the controller stops responding. It's a mess to clean
that up and synchronize when everything times out. Issuing everything
from the main thread and irq callback is painless in comparison.

But I didn't like having to store the "struct command" in the nvme_queue
either, so I'm happy to consider alternatives if I've missed seeing an
elegant solution.
