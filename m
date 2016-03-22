From: hch@lst.de (Christoph Hellwig)
Date: Tue, 22 Mar 2016 08:37:48 +0100
Subject: [PATCH v2 3/4] nvme: rewrite discard support
In-Reply-To: <1458631486-14120-4-git-send-email-mlin@kernel.org>
References: <1458631486-14120-1-git-send-email-mlin@kernel.org>
 <1458631486-14120-4-git-send-email-mlin@kernel.org>
Message-ID: <20160322073748.GA23403@lst.de>

On Tue, Mar 22, 2016@12:24:45AM -0700, Ming Lin wrote:
> +static inline int nvme_setup_discard(struct nvme_ns *ns, struct request *req,
> +		struct nvme_command *cmnd)
>  {
>  	struct nvme_dsm_range *range;
> +	struct page *page;
> +	int offset;
> +	unsigned int nr_bytes = blk_rq_bytes(req);
>  
> +	range = kmalloc(sizeof(*range), GFP_ATOMIC);
>  	if (!range)
>  		return BLK_MQ_RQ_QUEUE_BUSY;

I've been a bit worried about alignment vs dma transfers here, but it
seems like we should be fine after all as NVMe doesn't limit our
DMA payload alignment, and I couldn't see any platform limitations
either.

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
