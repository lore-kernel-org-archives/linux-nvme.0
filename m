From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 20 Apr 2017 12:13:14 -0600
Subject: [PATCH 22/23] blktrace: remove the unused block_rq_abort
 tracepoint
In-Reply-To: <20170420152056.GP13676@linux-x5ow.site>
References: <20170420140316.6546-1-hch@lst.de>
 <20170420140316.6546-23-hch@lst.de>
 <20170420152056.GP13676@linux-x5ow.site>
Message-ID: <20170420181313.GB22378@kernel.dk>

On Thu, Apr 20 2017, Johannes Thumshirn wrote:
> On Thu, Apr 20, 2017@04:03:15PM +0200, Christoph Hellwig wrote:
> > Signed-off-by: Christoph Hellwig <hch at lst.de>
> > ---
> 
> Just to be sure nothings forgotten, does this change need an update for
> blktrace as well?

blktrace doesn't use this event for anything internally, so the change is
fine.

-- 
Jens Axboe
