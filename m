From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 28 Oct 2018 09:10:58 -0700
Subject: [PATCH 01/14] blk-mq: kill q->mq_map
In-Reply-To: <20181025211626.12692-2-axboe@kernel.dk>
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-2-axboe@kernel.dk>
Message-ID: <20181028161058.GA26904@infradead.org>

On Thu, Oct 25, 2018@03:16:13PM -0600, Jens Axboe wrote:
>  static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>  		int cpu)
>  {
> -	return q->queue_hw_ctx[q->mq_map[cpu]];
> +	struct blk_mq_tag_set *set = q->tag_set;
> +
> +	return q->queue_hw_ctx[set->mq_map[cpu]];

Nitpick: this would be a little more readable without the local
set variable:

	return q->queue_hw_ctx[q->tag_set->mq_map[cpu]];

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
