From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 27 Nov 2018 23:26:55 -0800
Subject: [PATCH 8/8] blk-mq: add plug case for devices that implement
 ->commits_rqs()
In-Reply-To: <20181126163556.5181-9-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-9-axboe@kernel.dk>
Message-ID: <20181128072655.GE11774@infradead.org>

> +	} else if (plug && q->mq_ops->commit_rqs) {
> +		/*
> +		 * If we have a ->commit_rqs(), then we know the driver can
> +		 * batch submission doorbell updates. Add rq to plug list,
> +		 * and flush if we exceed the plug count only.
> +		 */
> +		blk_mq_bio_to_request(rq, bio);
> +		blk_mq_put_ctx(data.ctx);
> +
> +		/*
> +		 * If we have requests for more than one queue here, we
> +		 * should sort the list when it's flushed.
> +		 */
> +		if (!plug->do_sort && !list_empty(&plug->mq_list)) {
> +			same_queue_rq = list_first_entry(&plug->mq_list,
> +						struct request, queuelist);
> +			if (same_queue_rq->q != q)
> +				plug->do_sort = true;
> +		}
> +
> +		list_add_tail(&rq->queuelist, &plug->mq_list);
> +		plug->rq_count++;
> +		if (plug->rq_count >= BLK_MAX_REQUEST_COUNT) {
> +			blk_flush_plug_list(plug, false);
> +			trace_block_plug(q);
> +		}

This seems like a slight variation of the the single queue plug
case.  Can we share the code instead of having slightly differing
logic?

Also that should this respect blk_queue_nomerges?
