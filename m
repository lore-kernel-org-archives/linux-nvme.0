From: hch@lst.de (Christoph Hellwig)
Date: Wed, 24 Apr 2019 18:18:34 +0200
Subject: [PATCH V7 1/9] blk-mq: grab .q_usage_counter when queuing
 request from plug code path
In-Reply-To: <20190424110221.17435-2-ming.lei@redhat.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-2-ming.lei@redhat.com>
Message-ID: <20190424161834.GA23854@lst.de>

On Wed, Apr 24, 2019@07:02:13PM +0800, Ming Lei wrote:
>  		if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx) {
>  			if (this_hctx) {
>  				trace_block_unplug(this_q, depth, !from_schedule);
> +
> +				percpu_ref_get(&this_q->q_usage_counter);
>  				blk_mq_sched_insert_requests(this_hctx, this_ctx,
>  								&rq_list,
>  								from_schedule);
> +				percpu_ref_put(&this_q->q_usage_counter);
>  			}
>  
>  			this_q = rq->q;
> @@ -1757,8 +1760,11 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  	 */
>  	if (this_hctx) {
>  		trace_block_unplug(this_q, depth, !from_schedule);
> +
> +		percpu_ref_get(&this_q->q_usage_counter);
>  		blk_mq_sched_insert_requests(this_hctx, this_ctx, &rq_list,
>  						from_schedule);
> +		percpu_ref_put(&this_q->q_usage_counter);

Why don't we push this into blk_mq_sched_insert_requests?  Yes, it
would need a request_queue argument, but that still seems saner
than duplicating it in both callers.
