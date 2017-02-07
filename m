From: keith.busch@intel.com (Keith Busch)
Date: Tue, 7 Feb 2017 13:34:54 -0500
Subject: [PATCH 4/4] nvme: support ranged discard requests
In-Reply-To: <20170207164658.32449-5-hch@lst.de>
References: <20170207164658.32449-1-hch@lst.de>
 <20170207164658.32449-5-hch@lst.de>
Message-ID: <20170207183453.GC10133@localhost.localdomain>

On Tue, Feb 07, 2017@05:46:58PM +0100, Christoph Hellwig wrote:
> @@ -1233,6 +1243,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>  	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
>  		vwc = true;
>  	blk_queue_write_cache(q, vwc, vwc);
> +	blk_queue_max_discard_segments(q,
> +			PAGE_SIZE / sizeof(struct nvme_dsm_range));

We need to use ctrl->page_size rather than PAGE_SIZE.

Otherwise, this looks really good!
