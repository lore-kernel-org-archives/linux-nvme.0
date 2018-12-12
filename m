From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Dec 2018 08:11:40 +0100
Subject: [PATCH RFC 4/4] nvme-multipath: disable polling for underlying
 namespace request queue
In-Reply-To: <20181211233652.9705-5-sagi@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181211233652.9705-5-sagi@grimberg.me>
Message-ID: <20181212071140.GD28461@lst.de>

[adding Jens]

> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1547,6 +1547,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  	if (ns->head->disk) {
>  		nvme_update_disk_info(ns->head->disk, ns, id);
>  		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
> +		/* XXX: multipath device does not support polling for now... */
> +		blk_queue_flag_clear(QUEUE_FLAG_POLL, ns->queue);

I'd drop the XXX.  But I think we actually have a block layer problem
here.  Currently stacking devices will just pass through REQ_HIPRI,
despite none of them supporting any polling for it.

So we need to make sure in the block layer or I/O submitter that
REQ_HIPRI is only set if QUEUE_FLAG_POLL is supported.  I think it would
also help if we rename it to REQ_POLL to make this more obvious.
