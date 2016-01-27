From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 27 Jan 2016 13:47:45 +0200
Subject: [PATCH 1/2] NVMe: Make surprise removal work again
In-Reply-To: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
References: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
Message-ID: <56A8AE61.6070100@dev.mellanox.co.il>


> @@ -1187,15 +1194,20 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>
>   	if (kill) {
>   		blk_set_queue_dying(ns->queue);
> +		mb();
>
>   		/*
>   		 * The controller was shutdown first if we got here through
>   		 * device removal. The shutdown may requeue outstanding
>   		 * requests. These need to be aborted immediately so
>   		 * del_gendisk doesn't block indefinitely for their completion.
> +		 * The queue needs to be restarted to let pending requests
> +		 * fail.
>   		 */
>   		blk_mq_abort_requeue_list(ns->queue);
> +		__nvme_start_queue_locked(ns);

Why not making sure that all the pending requests are moved to
the requeue list before we even get here? call nvme_cancel_io on
pending requests which would either fail the requests (blk_queue_dying)
or move them to the requeue list?

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 72ef832..bdf148e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -640,6 +640,10 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	struct nvme_command cmnd;
>   	int ret = BLK_MQ_RQ_QUEUE_OK;
>
> +	if (unlikely(blk_queue_dying(req->q))) {
> +		blk_mq_end_request(req, -EIO);
> +		return BLK_MQ_RQ_QUEUE_OK;
> +	}

This is something we should try our best to move away from IMO...
