From: keith.busch@intel.com (Keith Busch)
Date: Tue, 7 Jun 2016 10:57:36 -0400
Subject: [PATCH 1/8] blk-mq: add blk_mq_alloc_request_hctx
In-Reply-To: <1465248119-17875-2-git-send-email-hch@lst.de>
References: <1465248119-17875-1-git-send-email-hch@lst.de>
 <1465248119-17875-2-git-send-email-hch@lst.de>
Message-ID: <20160607145736.GB28414@localhost.localdomain>

On Mon, Jun 06, 2016@11:21:52PM +0200, Christoph Hellwig wrote:
> +struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
> +		unsigned int flags, unsigned int hctx_idx)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	struct blk_mq_ctx *ctx;
> +	struct request *rq;
> +	struct blk_mq_alloc_data alloc_data;
> +	int ret;
> +
> +	ret = blk_queue_enter(q, flags & BLK_MQ_REQ_NOWAIT);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	hctx = q->queue_hw_ctx[hctx_idx];

We probably want to check 'if (hctx_idx < q->nr_hw_queues)' before
getting the hctx. Even if hctx_idx was origially valid, it's possible
(though unlikely) blk_queue_enter waits on reallocating h/w contexts,
which can make hctx_idx invalid.
