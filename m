From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 13 Jan 2017 22:39:38 +0200
Subject: [PATCH 4/6] blk-mq: Update queue map when changing queue count
In-Reply-To: <1483569671-1462-5-git-send-email-keith.busch@intel.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
 <1483569671-1462-5-git-send-email-keith.busch@intel.com>
Message-ID: <5daa7b54-d797-1485-04ae-f5318b22a7f2@grimberg.me>

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a8e67a1..9b7ed03 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2223,7 +2223,6 @@ static void blk_mq_queue_reinit(struct request_queue *q,
>  	 * we should change hctx numa_node according to new topology (this
>  	 * involves free and re-allocate memory, worthy doing?)
>  	 */
> -

This looks mis-placed.

>  	blk_mq_map_swqueue(q, online_mask);
>
>  	blk_mq_sysfs_register(q);
> @@ -2481,6 +2480,11 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
>  		blk_mq_freeze_queue(q);
>
>  	set->nr_hw_queues = nr_hw_queues;
> +	if (set->ops->map_queues)
> +		set->ops->map_queues(set);
> +	else
> +		blk_mq_map_queues(set);
> +

Makes sense,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
