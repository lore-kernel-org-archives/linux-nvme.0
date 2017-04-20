From: hch@lst.de (Christoph Hellwig)
Date: Thu, 20 Apr 2017 17:25:58 +0200
Subject: [PATCH 22/23] blktrace: remove the unused block_rq_abort
 tracepoint
In-Reply-To: <20170420152056.GP13676@linux-x5ow.site>
References: <20170420140316.6546-1-hch@lst.de>
 <20170420140316.6546-23-hch@lst.de> <20170420152056.GP13676@linux-x5ow.site>
Message-ID: <20170420152558.GA23516@lst.de>

On Thu, Apr 20, 2017@05:20:56PM +0200, Johannes Thumshirn wrote:
> On Thu, Apr 20, 2017@04:03:15PM +0200, Christoph Hellwig wrote:
> > Signed-off-by: Christoph Hellwig <hch at lst.de>
> > ---
> 
> Just to be sure nothings forgotten, does this change need an update for
> blktrace as well?

I don't think so.  It will just never get this event before or after
this patch.
