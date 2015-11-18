From: keith.busch@intel.com (Busch, Keith)
Date: Wed, 18 Nov 2015 23:08:49 +0000
Subject: Drives with MDTS set to zero
In-Reply-To: <20151118230226.GC24252@localhost.localdomain>
References: <564B9366.1090904@ranbarg.com>
 <20151118225820.GB24252@localhost.localdomain>
 <20151118230226.GC24252@localhost.localdomain>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93D37DBA9@fmsmsx104.amr.corp.intel.com>

Ugh, broken again, sorry, having a distracted day...

I'll resend as a proper patch that really works.

> On Wed, Nov 18, 2015@10:58:20PM +0000, Keith Busch wrote:
> > We can fix this by reordering the math instead of artificially reducing
> > the transfer size.
> 
> Resend with an actually compilable patch.
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5aca81c..f17e3d3 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2266,7 +2266,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
>  	if (dev->max_hw_sectors) {
>  		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
>  		blk_queue_max_segments(ns->queue,
> -			((dev->max_hw_sectors << 9) / dev->page_size) + 1);
> +			(dev->max_hw_sectors / (dev->page_size >> 9) + 1);
>  	}
>  	if (dev->stripe_size)
>  		blk_queue_chunk_sectors(ns->queue, dev->stripe_size >> 9);
> --
