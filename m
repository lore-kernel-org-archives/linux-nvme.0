From: kbusch@kernel.org (Keith Busch)
Date: Fri, 15 Mar 2019 10:16:08 -0600
Subject: [PATCH 2/8] blk-mq: change the method of iterating busy tags of
 a request_queue
In-Reply-To: <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20190315161608.GB15153@localhost.localdomain>

On Fri, Mar 15, 2019@01:57:38AM -0700, Jianchao Wang wrote:
> tags->rqs[] will not been cleaned when free driver tag and there
> is a window between get driver tag and write tags->rqs[], so we
> may see stale rq in tags->rqs[] which may have been freed, as
> following case,
> blk_mq_get_request         blk_mq_queue_tag_busy_iter
>   -> blk_mq_get_tag
>                              -> bt_for_each
>                                -> bt_iter
>                                  -> rq = taags->rqs[]
>                                  -> rq->q
>   -> blk_mq_rq_ctx_init
>     -> data->hctx->tags->rqs[rq->tag] = rq;
> 
> To fix this, the blk_mq_queue_tag_busy_iter is changed in this
> patch to use tags->static_rqs[] instead of tags->rqs[]. We have
> to identify whether there is a io scheduler attached to decide
> to use hctx->tags or hctx->sched_tags. And we will try to get a
> non-zero q_usage_counter before that, so it is safe to access
> them. Add 'inflight' parameter to determine to iterate in-flight
> requests or just busy tags. A correction here is that
> part_in_flight should count the busy tags instead of rqs that
> have got driver tags.
> 
> Moreover, get rid of the 'hctx' parameter in iter function as
> we could get it from rq->mq_hctx and export this interface for
> drivers.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> ---
>  block/blk-mq-tag.c     | 76 +++++++++++++++++++++++++++++++++-----------------
>  block/blk-mq-tag.h     |  2 --
>  block/blk-mq.c         | 31 ++++++++------------
>  include/linux/blk-mq.h |  5 ++--
>  4 files changed, 64 insertions(+), 50 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index b792537..cdec2cd 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -216,26 +216,38 @@ struct bt_iter_data {
>  	busy_iter_fn *fn;
>  	void *data;
>  	bool reserved;
> +	bool inflight;
>  };
>  
>  static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  {
>  	struct bt_iter_data *iter_data = data;
>  	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
> -	struct blk_mq_tags *tags = hctx->tags;
>  	bool reserved = iter_data->reserved;
> +	struct blk_mq_tags *tags;
>  	struct request *rq;
>  
> +	tags =  hctx->sched_tags ? hctx->sched_tags : hctx->tags;
> +
>  	if (!reserved)
>  		bitnr += tags->nr_reserved_tags;
> -	rq = tags->rqs[bitnr];
> +	/*
> +	 * Because tags->rqs[] will not been cleaned when free driver tag
> +	 * and there is a window between get driver tag and write tags->rqs[],
> +	 * so we may see stale rq in tags->rqs[] which may have been freed.
> +	 * Using static_rqs[] is safer.
> +	 */
> +	rq = tags->static_rqs[bitnr];
>  
>  	/*
> -	 * We can hit rq == NULL here, because the tagging functions
> -	 * test and set the bit before assigning ->rqs[].
> +	 * There is a small window between get tag and blk_mq_rq_ctx_init,
> +	 * so rq->q and rq->mq_hctx maybe different.
>  	 */
> -	if (rq && rq->q == hctx->queue)
> -		return iter_data->fn(hctx, rq, iter_data->data, reserved);
> +	if (rq && rq->q == hctx->queue &&
> +	    rq->mq_hctx == hctx &&
> +	    (!iter_data->inflight ||
> +	     blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT))
> +		return iter_data->fn(rq, iter_data->data, reserved);

There is still a window where the check may succeed, but the request is
being assigned to a completely different request_queue. The callback
then operates on a request it doesn't own.

Tag iteration from a driver can be safe only if the driver initiates a
freeze and quiesced all queues sharing the same tagset first. The nvme
driver does that, but I think there may need to be an additional grace
period to wait for the allocation's queue_enter to call queue_exit to
ensure the request is initialized through blk_mq_rq_ctx_init().
