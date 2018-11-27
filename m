From: osandov@osandov.com (Omar Sandoval)
Date: Tue, 27 Nov 2018 15:49:54 -0800
Subject: [PATCH 7/8] blk-mq: use bd->last == true for list inserts
In-Reply-To: <20181126163556.5181-8-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-8-axboe@kernel.dk>
Message-ID: <20181127234954.GF846@vader>

On Mon, Nov 26, 2018@09:35:55AM -0700, Jens Axboe wrote:
> If we are issuing a list of requests, we know if we're at the last one.
> If we fail issuing, ensure that we call ->commits_rqs() to flush any
> potential previous requests.

One comment below, otherwise

Reviewed-by: Omar Sandoval <osandov at fb.com>

> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>  block/blk-core.c |  2 +-
>  block/blk-mq.c   | 32 ++++++++++++++++++++++++--------
>  block/blk-mq.h   |  2 +-
>  3 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index c9758d185357..808a65d23f1a 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1334,7 +1334,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
>  	 * bypass a potential scheduler on the bottom device for
>  	 * insert.
>  	 */
> -	return blk_mq_request_issue_directly(rq);
> +	return blk_mq_request_issue_directly(rq, true);
>  }
>  EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 6a249bf6ed00..0a12cec0b426 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1260,6 +1260,14 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  	if (!list_empty(list)) {
>  		bool needs_restart;
>  
> +		/*
> +		 * If we didn't flush the entire list, we could have told
> +		 * the driver there was more coming, but that turned out to
> +		 * be a lie.
> +		 */
> +		if (q->mq_ops->commit_rqs)
> +			q->mq_ops->commit_rqs(hctx);
> +

This hunk seems like it should go with the patch adding commit_rqs.

>  		spin_lock(&hctx->lock);
>  		list_splice_init(list, &hctx->dispatch);
>  		spin_unlock(&hctx->lock);
> @@ -1736,12 +1744,12 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
>  
>  static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>  					    struct request *rq,
> -					    blk_qc_t *cookie)
> +					    blk_qc_t *cookie, bool last)
>  {
>  	struct request_queue *q = rq->q;
>  	struct blk_mq_queue_data bd = {
>  		.rq = rq,
> -		.last = true,
> +		.last = last,
>  	};
>  	blk_qc_t new_cookie;
>  	blk_status_t ret;
> @@ -1776,7 +1784,7 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>  static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  						struct request *rq,
>  						blk_qc_t *cookie,
> -						bool bypass_insert)
> +						bool bypass_insert, bool last)
>  {
>  	struct request_queue *q = rq->q;
>  	bool run_queue = true;
> @@ -1805,7 +1813,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  		goto insert;
>  	}
>  
> -	return __blk_mq_issue_directly(hctx, rq, cookie);
> +	return __blk_mq_issue_directly(hctx, rq, cookie, last);
>  insert:
>  	if (bypass_insert)
>  		return BLK_STS_RESOURCE;
> @@ -1824,7 +1832,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  
>  	hctx_lock(hctx, &srcu_idx);
>  
> -	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false);
> +	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
>  	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
>  		blk_mq_sched_insert_request(rq, false, true, false);
>  	else if (ret != BLK_STS_OK)
> @@ -1833,7 +1841,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	hctx_unlock(hctx, srcu_idx);
>  }
>  
> -blk_status_t blk_mq_request_issue_directly(struct request *rq)
> +blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
>  {
>  	blk_status_t ret;
>  	int srcu_idx;
> @@ -1841,7 +1849,7 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq)
>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  
>  	hctx_lock(hctx, &srcu_idx);
> -	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true);
> +	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true, last);
>  	hctx_unlock(hctx, srcu_idx);
>  
>  	return ret;
> @@ -1856,7 +1864,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  				queuelist);
>  
>  		list_del_init(&rq->queuelist);
> -		ret = blk_mq_request_issue_directly(rq);
> +		ret = blk_mq_request_issue_directly(rq, list_empty(list));
>  		if (ret != BLK_STS_OK) {
>  			if (ret == BLK_STS_RESOURCE ||
>  					ret == BLK_STS_DEV_RESOURCE) {
> @@ -1866,6 +1874,14 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  			blk_mq_end_request(rq, ret);
>  		}
>  	}
> +
> +	/*
> +	 * If we didn't flush the entire list, we could have told
> +	 * the driver there was more coming, but that turned out to
> +	 * be a lie.
> +	 */
> +	if (!list_empty(list) && hctx->queue->mq_ops->commit_rqs)
> +		hctx->queue->mq_ops->commit_rqs(hctx);
>  }
>  
>  static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 9ae8e9f8f8b1..7291e5379358 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -69,7 +69,7 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
>  				struct list_head *list);
>  
>  /* Used by blk_insert_cloned_request() to issue request directly */
> -blk_status_t blk_mq_request_issue_directly(struct request *rq);
> +blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last);
>  void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>  				    struct list_head *list);
>  
> -- 
> 2.17.1
> 
