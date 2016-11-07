From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 07 Nov 2016 10:07:39 -0800
Subject: [PATCH v1] nvmet: Don't queue fatal error work if csts.cfs is set
In-Reply-To: <20161106164140.GG15675@lst.de>
References: <1478423778-29829-1-git-send-email-sagi@grimberg.me>
 <20161106164140.GG15675@lst.de>
Message-ID: <1478542059.3350.3.camel@linux.intel.com>

On Sun, 2016-11-06@17:41 +0100, Christoph Hellwig wrote:
> On Sun, Nov 06, 2016@11:16:18AM +0200, Sagi Grimberg wrote:
> > 
> > In the transport, in case of an interal queue error like
> > error completion in rdma we trigger a fatal error. However,
> > multiple queues in the same controller can serr error completions
> > and we don't want to trigger fatal error work more than once.
> > 
> > Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> 
> Looks fine, although I'd avoid the goto and just use a if blocks
> for the rest of the action..

I agree, this is such a short function, I would think the goto could be
removed and still have an obvious yet easy to maintain error return
path using basic if()/else().

But looks good otherwise.

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>


> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
