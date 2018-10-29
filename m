From: hare@suse.de (Hannes Reinecke)
Date: Mon, 29 Oct 2018 08:30:57 +0100
Subject: [PATCH 03/14] blk-mq: provide dummy blk_mq_map_queue_type() helper
In-Reply-To: <20181025211626.12692-4-axboe@kernel.dk>
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-4-axboe@kernel.dk>
Message-ID: <3c7a769e-03bd-8c2f-7ecd-12043ca32f7a@suse.de>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> Doesn't do anything right now, but it's needed as a prep patch
> to get the interfaces right.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>   block/blk-mq.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 889f0069dd80..79c300faa7ce 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -80,6 +80,12 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>   	return q->queue_hw_ctx[set->map[0].mq_map[cpu]];
>   }
>   
> +static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
> +							  int type, int cpu)
> +{
> +	return blk_mq_map_queue(q, cpu);
> +}
> +
>   /*
>    * sysfs helpers
>    */
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
