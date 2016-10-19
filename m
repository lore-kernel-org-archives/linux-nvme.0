From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Oct 2016 15:23:21 +0200
Subject: [PATCH v3 04/11] blk-mq: Introduce blk_mq_quiesce_queue()
In-Reply-To: <e42a952c-f245-eb39-d0a1-0336035573f9@sandisk.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
 <e42a952c-f245-eb39-d0a1-0336035573f9@sandisk.com>
Message-ID: <20161019132321.GD6323@lst.de>

> +/**
> + * blk_mq_quiesce_queue() - wait until all ongoing queue_rq calls have finished
> + *
> + * Note: this function does not prevent that the struct request end_io()
> + * callback function is invoked. Additionally, it is not prevented that
> + * new queue_rq() calls occur unless the queue has been stopped first.
> + */
> +void blk_mq_quiesce_queue(struct request_queue *q)

If this is intended to be a kerneldoc comment you need to document the 'q'
parameter.  If not you should drop the magic "/**" marker.

> +static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
> +{
> +	int srcu_idx;
> +
> +	WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
> +		cpu_online(hctx->next_cpu));
> +
> +	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> +		rcu_read_lock();
> +		blk_mq_process_rq_list(hctx);
> +		rcu_read_unlock();
> +	} else {
> +		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
> +		blk_mq_process_rq_list(hctx);
> +		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
> +	}
> +}

Can you document these synchronization changes in detail in the changelog?

> +static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> +				      struct request *rq, blk_qc_t *cookie)
> +{
> +	if (blk_mq_hctx_stopped(hctx) ||
> +	    blk_mq_direct_issue_request(rq, cookie) != 0)
> +		blk_mq_insert_request(rq, false, true, true);
> +}

Any reason not to merge this function with blk_mq_direct_issue_request?

Otherwise this change looks fine to me.
