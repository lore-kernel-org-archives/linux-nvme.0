From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 17 Dec 2018 19:23:58 +0800
Subject: [PATCH 1/2] blk-mq: only dispatch to non-defauly queue maps if
 they have queues
In-Reply-To: <20181217111627.22635-1-hch@lst.de>
References: <20181217111627.22635-1-hch@lst.de>
Message-ID: <20181217112357.GE1329@ming.t460p>

On Mon, Dec 17, 2018@12:16:26PM +0100, Christoph Hellwig wrote:
> We should check if a given queue map actually has queues enabled before
> dispatching to it.  This allows drivers to not initialize optional but
> not used map types, which subsequently will allow fixing problems with
> queue map rebuilds for that case.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  block/blk-mq.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index b63a0de8a07a..d1ed096723fb 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -105,14 +105,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>  {
>  	enum hctx_type type = HCTX_TYPE_DEFAULT;
>  
> -	if (q->tag_set->nr_maps > HCTX_TYPE_POLL &&
> -	    ((flags & REQ_HIPRI) && test_bit(QUEUE_FLAG_POLL, &q->queue_flags)))
> +	if ((flags & REQ_HIPRI) &&
> +	    q->tag_set->nr_maps > HCTX_TYPE_POLL && 
> +	    q->tag_set->map[HCTX_TYPE_POLL].nr_queues &&
> +	    test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
>  		type = HCTX_TYPE_POLL;
>  
> -	else if (q->tag_set->nr_maps > HCTX_TYPE_READ &&
> -		 ((flags & REQ_OP_MASK) == REQ_OP_READ))
> +	else if (((flags & REQ_OP_MASK) == REQ_OP_READ) &&
> +	         q->tag_set->nr_maps > HCTX_TYPE_READ &&
> +		 q->tag_set->map[HCTX_TYPE_READ].nr_queues)
>  		type = HCTX_TYPE_READ;
> -
> +	
>  	return blk_mq_map_queue_type(q, type, cpu);
>  }

Reviewed-by: Ming Lei <ming.lei at redhat.com>

Thanks,
Ming
