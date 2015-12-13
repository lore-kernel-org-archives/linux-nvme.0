From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 13 Dec 2015 16:59:52 +0200
Subject: [PATCH for-4.4] NVMe: IO ending fixes on surprise removal
In-Reply-To: <1449864868-8216-1-git-send-email-keith.busch@intel.com>
References: <1449864868-8216-1-git-send-email-keith.busch@intel.com>
Message-ID: <566D87E8.3000305@dev.mellanox.co.il>


> -	if (kill)
> +	if (kill) {
>   		blk_set_queue_dying(ns->queue);
> +
> +		/*
> +		 * The controller was shutdown first if we got here through
> +		 * device removal. The shutdown may requeue outstanding
> +		 * requests. These need to be aborted immediately so
> +		 * del_gendisk doesn't block indefinitely for their completion.
> +		 */
> +		blk_mq_abort_requeue_list(ns->queue);

Something looks convoluted a bit here.
We abort_requeue_list here and...

> +	}
>   	if (ns->disk->flags & GENHD_FL_UP)
>   		del_gendisk(ns->disk);
>   	if (kill || !blk_queue_dying(ns->queue)) {

Here again?
