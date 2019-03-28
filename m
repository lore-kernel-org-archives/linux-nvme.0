From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Thu, 28 Mar 2019 09:42:51 +0800
Subject: [PATCH 5/5] nvme/pci: Remove queue IO flushing hack
In-Reply-To: <20190327132116.GA8419@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-5-keith.busch@intel.com> <20190311184031.GA11707@lst.de>
 <20190311193753.GE10411@localhost.localdomain>
 <20190327083142.GQ20525@lst.de> <20190327132116.GA8419@localhost.localdomain>
Message-ID: <3d72ec9f-0aa5-d455-b453-40c319871287@oracle.com>



On 3/27/19 9:21 PM, Keith Busch wrote:
> On Wed, Mar 27, 2019@01:31:42AM -0700, Christoph Hellwig wrote:
>>> Okay, I may even be able to drop the new block exports if we do request
>>> termination in generic block layer. That's probably the right thing
>>> anyway since that layer is in a better position to check the necessary
>>> conditions that make tag iteration safe. Bart did point out that is
>>> generally not safe for drives to do, so it'd be good to safegaurd against
>>> incorrect usage.
>>
>> Did you get a chance to look into this?
> 
> I haven't had a chance to put it through the proper tests (I no longer
> have a hotplug machine), but this is what I'd written if you can give it
> a quick look:
> 
> From 5afd8e3765eabf859100fda84e646a96683d7751 Mon Sep 17 00:00:00 2001
> From: Keith Busch <keith.busch at intel.com>
> Date: Tue, 12 Mar 2019 13:58:12 -0600
> Subject: [PATCH] blk-mq: Provide request termination API
> 
> A driver that determined hardware contexts backing its request queue
> is unable to service new commands, it would have to end those commands
> in its IO path. This requires unlikely checks per-IO.
> 
> Create a new API that terminates all requests directly rather than
> requiring those requests get flushed through the low level driver. This
> is safe only if the current request allocation state is unchanging, so
> driver must have quiesced and initiated a freeze on its queue, and after
> it has reclaimed any in flight requests so that the tag iterator is not
> racing with in flux requests. The new API enforces these conditions in
> order to successfully terminate requests.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  block/blk-mq.c         | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  1 +
>  2 files changed, 37 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a9c181603cbd..ad98c27e2b34 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -952,6 +952,42 @@ static void blk_mq_timeout_work(struct work_struct *work)
>  	blk_queue_exit(q);
>  }
>  
> +static bool blk_mq_terminate_request(struct blk_mq_hw_ctx *hctx,
> +		struct request *rq, void *priv, bool reserved)
> +{
> +	int *hctx_idx = priv;
> +
> +	if (WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE))
> +		return false;
> +	if (hctx->queue_num >= *hctx_idx)
> +		blk_mq_end_request(rq, BLK_STS_IOERR);
> +	return true;
> +}
> +
> +/**
> + * blk_mq_terminate_queued_requests() - end requests with an error queued on
> + *					hardware contexts at and above the
> + *					provided index.
> + * @q: request queue
> + * @hctx_idx: starting hardware context, 0 for all hctx's
> + *
> + * A low level driver should invoke this routine when its hardware contexts are
> + * not capable of handling future requests. The caller must ensure their
> + * request_queue is quiesced, freeze initiated, and all dispatched requests
> + * have been reclaimed so the tag iteration has a static request allocation to
> + * consider.
> + */
> +void blk_mq_terminate_queued_requests(struct request_queue *q, int hctx_idx)
> +{
> +	if (WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth)))
> +		return;
> +	if (WARN_ON_ONCE(!blk_queue_quiesced(q)))
> +		return;
> +	blk_sync_queue(q);
> +	blk_mq_queue_tag_busy_iter(q, blk_mq_terminate_request, &hctx_idx);
> +}


Is it really OK to end these requests directly w/o dequeue ?
All of them are on ctx->rq_list, or hctx->dispatch list or internal queue of io scheduler.

Terrible things may happen after we unquiesce the queue.

Thanks
Jinchao

> +EXPORT_SYMBOL(blk_mq_terminate_queued_requests);
> +
>  struct flush_busy_ctx_data {
>  	struct blk_mq_hw_ctx *hctx;
>  	struct list_head *list;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index a64b3fdce0b0..d47cd4575abb 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -334,6 +334,7 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
>  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
>  
>  void blk_mq_quiesce_queue_nowait(struct request_queue *q);
> +void blk_mq_terminate_queued_requests(struct request_queue *q, int hctx_idx);
>  
>  unsigned int blk_mq_rq_cpu(struct request *rq);
>  
> 
