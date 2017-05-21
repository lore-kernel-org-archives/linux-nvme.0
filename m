From: hch@lst.de (Christoph Hellwig)
Date: Sun, 21 May 2017 08:20:02 +0200
Subject: [PATCH v2 1/3] nvme: use blk_mq_start_hw_queues() in
 nvme_kill_queues()
In-Reply-To: <20170520035605.21785-2-ming.lei@redhat.com>
References: <20170520035605.21785-1-ming.lei@redhat.com>
 <20170520035605.21785-2-ming.lei@redhat.com>
Message-ID: <20170521062002.GB12287@lst.de>

> index d5e0906262ea..ce0d96913ee6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2437,7 +2437,13 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>  		revalidate_disk(ns->disk);
>  		blk_set_queue_dying(ns->queue);
>  		blk_mq_abort_requeue_list(ns->queue);
> -		blk_mq_start_stopped_hw_queues(ns->queue, true);
> +
> +		/*
> +		 * We have to force to start queues for avoiding hang
> +		 * forever, and we have to make sure that queues won't
> +		 * be stopped forever from now on.
> +		 */

		/*
		 * Forcibly start all queues to avoid having stuck requests.
		 * Note: We must make sure to not stop the queues from
		 * now until the final removal.
		 */

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
