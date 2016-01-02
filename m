From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 2 Jan 2016 09:07:30 -0800
Subject: [PATCH 5/5] NVMe: IO queue deletion re-write
In-Reply-To: <20151230190706.GC12454@localhost.localdomain>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-6-git-send-email-keith.busch@intel.com>
 <20151230180430.GA12828@infradead.org>
 <20151230190706.GC12454@localhost.localdomain>
Message-ID: <20160102170730.GA30184@infradead.org>

> Aww, I really liked the re-queuing! :) It encapsulates deleting a
> queue-pair as a single, two-step operation.

I think it can still be nicely encapsulated when using the
workqueue.  And I think that's essential as requeuing for
a different command breaks all kinds of assumptions.

> There's a failure scenario that complicates work item handling. It has
> the same flaw kthread workers had if work is queued deeper than available
> tags, and then the controller stops responding. It's a mess to clean
> that up and synchronize when everything times out. Issuing everything
> from the main thread and irq callback is painless in comparison.

True, that's not getting simpler.

> But I didn't like having to store the "struct command" in the nvme_queue
> either, so I'm happy to consider alternatives if I've missed seeing an
> elegant solution.

Just curious:  why do we even both with the async queue shutdown.  At
least the controllers I have access to complete queue deletions very
quickly.
