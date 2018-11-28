From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 28 Nov 2018 09:49:24 +0800
Subject: [PATCH 7/8] blk-mq: use bd->last == true for list inserts
In-Reply-To: <20181126163556.5181-8-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-8-axboe@kernel.dk>
Message-ID: <20181128014922.GE11128@ming.t460p>

On Mon, Nov 26, 2018@09:35:55AM -0700, Jens Axboe wrote:
> If we are issuing a list of requests, we know if we're at the last one.
> If we fail issuing, ensure that we call ->commits_rqs() to flush any
> potential previous requests.
> 
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

Looks you miss to do it for blk_mq_do_dispatch_sched() and
blk_mq_do_dispatch_ctx(), in which only one request is added to
the rq_list.

Maybe we can call the .commit_rqs(hctx) just at the end of
blk_mq_sched_dispatch_requests() for cover all non-direct-issue
cases.

Thanks,
Ming
