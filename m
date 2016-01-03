From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 3 Jan 2016 08:17:04 -0800
Subject: [PATCH 5/5] NVMe: IO queue deletion re-write
In-Reply-To: <20160103154331.GA31375@localhost.localdomain>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-6-git-send-email-keith.busch@intel.com>
 <20151230180430.GA12828@infradead.org>
 <20151230190706.GC12454@localhost.localdomain>
 <20160102170730.GA30184@infradead.org>
 <20160102213008.GA10969@localhost.localdomain>
 <20160103114052.GA24893@infradead.org>
 <20160103154331.GA31375@localhost.localdomain>
Message-ID: <20160103161704.GA5111@infradead.org>

On Sun, Jan 03, 2016@03:43:31PM +0000, Keith Busch wrote:
> On Sun, Jan 03, 2016@03:40:52AM -0800, Christoph Hellwig wrote:
> > How about something like the lightly tested patch below.  It uses
> > synchronous command submission, but schedules a work item on the
> > system unbound workqueue for each queue, allowing the scheduler
> > to execture them in parallel.
> 
> This works if everything else works, but the failure cases are the hard
> ones. This'll deadlock if the controller stops responding during a reset,
> which might be why the reset occured in the first place, and we can't
> invoke another reset to clean up a failed reset.

We'd get a reset for both cases, which isn't really what we what.
I think we should be setting NVME_CTRL_RESETTING before doing a shutdown
so that errors get reported in line.

> You'll also need something to end
> work waiting for a request when more queues exist than admin tags.

It's called the block layer.  blk_mq_alloc_request will block until
the tag is available unless we explicitly request non-blocking behavior.
