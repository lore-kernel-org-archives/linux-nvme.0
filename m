From: jmoyer@redhat.com (Jeff Moyer)
Date: Wed, 08 Jun 2016 09:58:38 -0400
Subject: [PATCH 01/11] Revert "blk-mq: add blk_mq_alloc_request_hctx"
In-Reply-To: <1465389066-19119-2-git-send-email-hch@lst.de> (Christoph
 Hellwig's message of "Wed, 8 Jun 2016 14:30:56 +0200")
References: <1465389066-19119-1-git-send-email-hch@lst.de>
 <1465389066-19119-2-git-send-email-hch@lst.de>
Message-ID: <x49mvmv235d.fsf@segfault.boston.devel.redhat.com>

Christoph Hellwig <hch at lst.de> writes:

> Just for book keeping. The next patch brings it back with some changes.

That's a strange thing to do, and breaks bisectability.  Why not just
update the function?

-Jeff

>
> This reverts commit 98878e0f0b80520575b31147f7cff28e28d9a725.
> ---
>  block/blk-mq.c         | 33 ---------------------------------
>  include/linux/blk-mq.h |  2 --
>  2 files changed, 35 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 049356d..13f4603 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -267,39 +267,6 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
>  }
>  EXPORT_SYMBOL(blk_mq_alloc_request);
>  
> -struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
> -		unsigned int flags, unsigned int hctx_idx)
> -{
> -	struct blk_mq_hw_ctx *hctx;
> -	struct blk_mq_ctx *ctx;
> -	struct request *rq;
> -	struct blk_mq_alloc_data alloc_data;
> -	int ret;
> -
> -	ret = blk_queue_enter(q, flags & BLK_MQ_REQ_NOWAIT);
> -	if (ret)
> -		return ERR_PTR(ret);
> -
> -	hctx = q->queue_hw_ctx[hctx_idx];
> -	ctx = __blk_mq_get_ctx(q, cpumask_first(hctx->cpumask));
> -
> -	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
> -
> -	rq = __blk_mq_alloc_request(&alloc_data, rw);
> -	if (!rq && !(flags & BLK_MQ_REQ_NOWAIT)) {
> -		__blk_mq_run_hw_queue(hctx);
> -
> -		rq =  __blk_mq_alloc_request(&alloc_data, rw);
> -	}
> -	if (!rq) {
> -		blk_queue_exit(q);
> -		return ERR_PTR(-EWOULDBLOCK);
> -	}
> -
> -	return rq;
> -}
> -EXPORT_SYMBOL(blk_mq_alloc_request_hctx);
> -
>  static void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx,
>  				  struct blk_mq_ctx *ctx, struct request *rq)
>  {
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 9a5d581..faa7d5c2 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -198,8 +198,6 @@ enum {
>  
>  struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
>  		unsigned int flags);
> -struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
> -		unsigned int flags, unsigned int hctx_idx);
>  struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag);
>  struct cpumask *blk_mq_tags_cpumask(struct blk_mq_tags *tags);
