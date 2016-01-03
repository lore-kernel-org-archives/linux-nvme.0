From: keith.busch@intel.com (Keith Busch)
Date: Sun, 3 Jan 2016 16:26:25 +0000
Subject: [PATCH 5/5] NVMe: IO queue deletion re-write
In-Reply-To: <20160103161704.GA5111@infradead.org>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-6-git-send-email-keith.busch@intel.com>
 <20151230180430.GA12828@infradead.org>
 <20151230190706.GC12454@localhost.localdomain>
 <20160102170730.GA30184@infradead.org>
 <20160102213008.GA10969@localhost.localdomain>
 <20160103114052.GA24893@infradead.org>
 <20160103154331.GA31375@localhost.localdomain>
 <20160103161704.GA5111@infradead.org>
Message-ID: <20160103162625.GB31375@localhost.localdomain>

On Sun, Jan 03, 2016@08:17:04AM -0800, Christoph Hellwig wrote:
> On Sun, Jan 03, 2016@03:43:31PM +0000, Keith Busch wrote:
> We'd get a reset for both cases, which isn't really what we what.
> I think we should be setting NVME_CTRL_RESETTING before doing a shutdown
> so that errors get reported in line.

We hold a mutex while resetting. The second reset will be stuck there.
 
> > You'll also need something to end
> > work waiting for a request when more queues exist than admin tags.
> 
> It's called the block layer.  blk_mq_alloc_request will block until
> the tag is available unless we explicitly request non-blocking behavior.

In the scenario I'm describing you _don't_ want it to succeed in getting
a request. You don't want it to wait indefinitely for one either.
