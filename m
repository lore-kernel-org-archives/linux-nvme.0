From: keith.busch@intel.com (Keith Busch)
Date: Wed, 2 Mar 2016 19:10:21 +0000
Subject: [PATCH 2/5] nvme: set queue limits for the admin queue
In-Reply-To: <1456938434-20387-3-git-send-email-hch@lst.de>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
 <1456938434-20387-3-git-send-email-hch@lst.de>
Message-ID: <20160302191020.GC27636@localhost.localdomain>

On Wed, Mar 02, 2016@06:07:11PM +0100, Christoph Hellwig wrote:
> Factor out a helper to set all the device specific queue limits and apply
> them to the admin queue in addition to the I/O queues.  Without this the
> command size on the admin queue is arbitrarily low, and the missing
> other limitations are just minefields waiting for victims.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reported-by: Jeff Lien <Jeff.Lien at hgst.com>
> Tested-by: Jeff Lien <Jeff.Lien at hgst.com>

Looks fine. The chunk size and flush settings don't hurt, but are
unnecessary for an admin queue.

Reviewed-by: Keith Busch <keith.busch at intel.com>

> +static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
> +		struct request_queue *q)
> +{
> +	if (ctrl->max_hw_sectors) {
> +		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
> +		blk_queue_max_segments(q,
> +			(ctrl->max_hw_sectors / (ctrl->page_size >> 9)) + 1);
> +	}
> +	if (ctrl->stripe_size)
> +		blk_queue_chunk_sectors(q, ctrl->stripe_size >> 9);
> +	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
> +		blk_queue_flush(q, REQ_FLUSH | REQ_FUA);
> +	blk_queue_virt_boundary(q, ctrl->page_size - 1);
> +}
