From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Dec 2018 09:24:44 +0100
Subject: [PATCH v2 1/6] block: introduce blk_execute_rq_polled
In-Reply-To: <20181213063819.13614-2-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-2-sagi@grimberg.me>
Message-ID: <20181213082444.GA869@lst.de>

On Wed, Dec 12, 2018@10:38:13PM -0800, Sagi Grimberg wrote:
> Used forsynchronous requests that needs polling. If we are knowingly
> sending a request down to a poll queue, we need a synchronous interface
> to poll for its completion.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  block/blk-exec.c       | 29 +++++++++++++++++++++++++++++
>  block/blk-mq.c         |  8 --------
>  include/linux/blk-mq.h |  8 ++++++++
>  include/linux/blkdev.h |  2 ++
>  4 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index a34b7d918742..572032d60001 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -90,3 +90,32 @@ void blk_execute_rq(struct request_queue *q, struct gendisk *bd_disk,
>  		wait_for_completion_io(&wait);
>  }
>  EXPORT_SYMBOL(blk_execute_rq);
> +
> +/**
> + * blk_execute_rq_polled - execute a request and poll for its completion
> + * @q:		queue to insert the request in
> + * @bd_disk:	matching gendisk
> + * @rq:		request to insert
> + * @at_head:    insert request at head or tail of queue
> + *
> + * Description:
> + *    Insert a fully prepared request at the back of the I/O scheduler queue
> + *    for execution and wait for completion.
> + */
> +void blk_execute_rq_polled(struct request_queue *q, struct gendisk *bd_disk,
> +		   struct request *rq, int at_head)
> +{
> +	DECLARE_COMPLETION_ONSTACK(wait);
> +
> +	WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
> +
> +	rq->cmd_flags |= REQ_HIPRI;
> +	rq->end_io_data = &wait;
> +	blk_execute_rq_nowait(q, bd_disk, rq, at_head, blk_end_sync_rq);
> +
> +	while (!completion_done(&wait)) {
> +		blk_poll(q, request_to_qc_t(rq->mq_hctx, rq), true);
> +		cond_resched();
> +	}

Can we just open code this in nvme for now?

> +static inline blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)

Too long line.

> +{
> +	if (rq->tag != -1)
> +		return blk_tag_to_qc_t(rq->tag, hctx->queue_num, false);
> +
> +	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
> +}

Also these are only two users of blk_tag_to_qc_t, it might be worth
to fold it into request_to_qc_t:

static inline blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx,
		struct request *rq)
{
	if (rq->tag != -1)
		return rq->tag | (hctx->queue_num << BLK_QC_T_SHIFT);
	return rq->internal_tag | (hctx->queue_num << BLK_QC_T_SHIFT) |
			BLK_QC_T_INTERNAL;
}
