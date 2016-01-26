From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 26 Jan 2016 08:53:34 -0800
Subject: [PATCH 1/2] NVMe: Make surprise removal work again
In-Reply-To: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
References: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160126165334.GB609@infradead.org>

> +static void __nvme_start_queue_locked(struct nvme_ns *ns)
> +{
> +	queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
> +	blk_mq_start_stopped_hw_queues(ns->queue, true);
> +	blk_mq_kick_requeue_list(ns->queue);
> +}

This almost screams for a block level helper.

> +
>  static void nvme_ns_remove(struct nvme_ns *ns)
>  {
>  	bool kill = nvme_io_incapable(ns->ctrl) &&
> @@ -1187,15 +1194,20 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  
>  	if (kill) {
>  		blk_set_queue_dying(ns->queue);
> +		mb();

Please always comment memory barriers, I can't really make any sense
of this one.

>  		/*
>  		 * The controller was shutdown first if we got here through
>  		 * device removal. The shutdown may requeue outstanding
>  		 * requests. These need to be aborted immediately so
>  		 * del_gendisk doesn't block indefinitely for their completion.
> +		 * The queue needs to be restarted to let pending requests
> +		 * fail.
>  		 */
>  		blk_mq_abort_requeue_list(ns->queue);
> +		__nvme_start_queue_locked(ns);

Also why do we need a kick of the requeue list above if we just aborted
all requests on it?

> index 72ef832..bdf148e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -640,6 +640,10 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	struct nvme_command cmnd;
>  	int ret = BLK_MQ_RQ_QUEUE_OK;
>  
> +	if (unlikely(blk_queue_dying(req->q))) {
> +		blk_mq_end_request(req, -EIO);
> +		return BLK_MQ_RQ_QUEUE_OK;
> +	}

Seems like this is something blk-mq should be doing.
