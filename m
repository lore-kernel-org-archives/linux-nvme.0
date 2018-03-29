From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Thu, 29 Mar 2018 16:14:37 +0000
Subject: [PATCH 3/4] nvmet-fc: Don't use the count returned by the
 dma_map_sg call
In-Reply-To: <20180329160721.4691-4-logang@deltatee.com>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-4-logang@deltatee.com>
Message-ID: <a60ddb463159bcc287998ecfafdc2753973a4828.camel@wdc.com>

On Thu, 2018-03-29@10:07 -0600, Logan Gunthorpe wrote:
> +	ret = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
> +			    ((fod->io_dir == NVMET_FCP_WRITE) ?
> +				    DMA_FROM_DEVICE : DMA_TO_DEVICE));
> +			    /* note: write from initiator perspective */

If you have to repost this patch please remove the four superfluous parentheses.

Thanks,

Bart.
