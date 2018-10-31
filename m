From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Oct 2018 17:37:59 -0700
Subject: [PATCH 04/16] blk-mq: pass in request/bio flags to queue mapping
In-Reply-To: <20181030183252.17857-5-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-5-axboe@kernel.dk>
Message-ID: <50a9c2d1-abc5-b04f-1f95-878f216a47b1@grimberg.me>


>   static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
> +						     unsigned int flags,
>   						     unsigned int cpu)
>   {
>   	struct blk_mq_tag_set *set = q->tag_set;
> @@ -84,7 +85,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
>   							  unsigned int hctx_type,
>   							  unsigned int cpu)
>   {
> -	return blk_mq_map_queue(q, cpu);
> +	return blk_mq_map_queue(q, hctx_type, cpu);
>   }

Haven't read through the rest of the patch set, but it looks a bit
strange that a type enumeration is being passed on as flags field.
