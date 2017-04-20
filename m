From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 20 Apr 2017 17:38:56 +0200
Subject: [PATCH 22/23] blktrace: remove the unused block_rq_abort
 tracepoint
In-Reply-To: <20170420152558.GA23516@lst.de>
References: <20170420140316.6546-1-hch@lst.de>
 <20170420140316.6546-23-hch@lst.de>
 <20170420152056.GP13676@linux-x5ow.site>
 <20170420152558.GA23516@lst.de>
Message-ID: <20170420153856.GR13676@linux-x5ow.site>

On Thu, Apr 20, 2017@05:25:58PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 20, 2017@05:20:56PM +0200, Johannes Thumshirn wrote:
> > On Thu, Apr 20, 2017@04:03:15PM +0200, Christoph Hellwig wrote:
> > > Signed-off-by: Christoph Hellwig <hch at lst.de>
> > > ---
> > 
> > Just to be sure nothings forgotten, does this change need an update for
> > blktrace as well?
> 
> I don't think so.  It will just never get this event before or after
> this patch.

Ok then,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
