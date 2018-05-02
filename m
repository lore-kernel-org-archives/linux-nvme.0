From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 2 May 2018 10:54:09 -0600
Subject: [PATCH] nvme: configure discard at init time
In-Reply-To: <42987d9b-7e55-940c-79a3-c0454358d342@kernel.dk>
References: <b3e2875b-f58a-f49c-1ded-a8c362b026ca@kernel.dk>
 <20180502163258.GI5938@localhost.localdomain>
 <42987d9b-7e55-940c-79a3-c0454358d342@kernel.dk>
Message-ID: <20180502165408.GJ5938@localhost.localdomain>

On Wed, May 02, 2018@10:41:03AM -0600, Jens Axboe wrote:
> If we add discard through a firmware upgrade, we should also handle
> the case where we lose discard through a firmware upgrade/downgrade.
> Not that any of them are likely to ever happen, but...
> 
> How about this? Also handles the case where streams values are updated.

Good call. You also have it updating granularity when a format changes
the logical block size, so that's also a good thing.

One minor issue below:
 
> -static void nvme_config_discard(struct nvme_ctrl *ctrl,
> -		unsigned stream_alignment, struct request_queue *queue)
> +static void nvme_config_discard(struct nvme_ns *ns)
>  {
> +	struct nvme_ctrl *ctrl = ns->ctrl;
> +	struct request_queue *queue = ns->queue;
>  	u32 size = queue_logical_block_size(queue);
>  
> -	if (stream_alignment)
> -		size *= stream_alignment;
> +	if (!(ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
> +		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, queue);
> +		return;
> +	}
> +
> +	if (ctrl->nr_streams && ns->sws && ns->sgs)
> +		size *= ns->sws * ns->sgs;
>  
>  	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
>  			NVME_DSM_MAX_RANGES);
> @@ -1361,6 +1367,10 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl,
>  	queue->limits.discard_alignment = 0;
>  	queue->limits.discard_granularity = size;
>  
> +	/* If discard is already enabled, don't reset queue limits */
> +	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
> +		return;
> +
>  	blk_queue_max_discard_sectors(queue, UINT_MAX);
>  	blk_queue_max_discard_segments(queue, NVME_DSM_MAX_RANGES);
>  	blk_queue_flag_set(QUEUE_FLAG_DISCARD, queue);
> @@ -1407,10 +1417,6 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  {
>  	sector_t capacity = le64_to_cpup(&id->nsze) << (ns->lba_shift - 9);
>  	unsigned short bs = 1 << ns->lba_shift;
> -	unsigned stream_alignment = 0;
> -
> -	if (ns->ctrl->nr_streams && ns->sws && ns->sgs)
> -		stream_alignment = ns->sws * ns->sgs;
>  
>  	blk_mq_freeze_queue(disk->queue);
>  	blk_integrity_unregister(disk);
> @@ -1427,7 +1433,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	set_capacity(disk, capacity);
>  
>  	if (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)
> -		nvme_config_discard(ns->ctrl, stream_alignment, disk->queue);
> +		nvme_config_discard(ns);

Since nvme_config_discard now handles disabling the queue limit, we need
to call this unconditionally regardless of the ONCS_DSM
