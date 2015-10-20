From: keith.busch@intel.com (Busch, Keith)
Date: Tue, 20 Oct 2015 14:07:58 +0000
Subject: [PATCH 01/18] nvme: add missing unmaps in nvme_queue_rq
In-Reply-To: <562611A8.1060804@dev.mellanox.co.il>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-2-git-send-email-hch@lst.de>
 <562611A8.1060804@dev.mellanox.co.il>
Message-ID: <20151020140758.GB22742@localhost.localdomain>

On Tue, Oct 20, 2015@01:04:24PM +0300, Sagi Grimberg wrote:
> On 10/16/2015 8:58 AM, Christoph Hellwig wrote:
> >  			sg_init_table(iod->meta_sg, 1);
> >  			if (blk_rq_map_integrity_sg(
> >-					req->q, req->bio, iod->meta_sg) != 1)
> >+					req->q, req->bio, iod->meta_sg) != 1) {
> >+				dma_unmap_sg(dev->dev, iod->sg, iod->nents,
> >+						dma_dir);
> >  				goto error_cmd;
> >+			}
> 
> This is not related to the patch itself. But this condition seems bogus
> to me. We passed meta_sg that consists of a single entry. If we
> happened to map more than a single entry we're already in trouble as we
> overrun meta_sg (modified the iod->sg pointer).
> 
> I think a WARN_ON_ONCE statement is more suitable here (which should
> probably come as a separate patch).

We are in trouble if it maps more than 1, but I think the condition
here is intended to guard against 0 rather than > 1. We should already
be ensured it won't be > 1 from a previous check.

Based on the implementation of blk_rq_map_integrity_sg and the functions
earlier setup, I don't think we can ever see 0 here either.
