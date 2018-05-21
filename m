From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Mon, 21 May 2018 23:29:06 +0000
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <20180521231131.6685-4-keith.busch@intel.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
Message-ID: <e7a287827b4c00151bb7714deca7ea6453177504.camel@wdc.com>

On Mon, 2018-05-21@17:11 -0600, Keith Busch wrote:
> @@ -650,27 +600,10 @@ static u64 blk_mq_rq_aborted_gstate(struct request *rq)
>  void blk_mq_complete_request(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
> -	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
> -	int srcu_idx;
>  
>  	if (unlikely(blk_should_fake_timeout(q)))
>  		return;
> -	[ ... ]
> +	__blk_mq_complete_request(rq);
>  }
>  EXPORT_SYMBOL(blk_mq_complete_request);
> [ ... ]
>  static void blk_mq_rq_timed_out(struct request *req, bool reserved)
>  {
>  	const struct blk_mq_ops *ops = req->q->mq_ops;
>  	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
>  
> -	req->rq_flags |= RQF_MQ_TIMEOUT_EXPIRED;
> -
>  	if (ops->timeout)
>  		ret = ops->timeout(req, reserved);
>  
>  	switch (ret) {
>  	case BLK_EH_HANDLED:
> -		__blk_mq_complete_request(req);
> -		break;
> -	case BLK_EH_RESET_TIMER:
>  		/*
> -		 * As nothing prevents from completion happening while
> -		 * ->aborted_gstate is set, this may lead to ignored
> -		 * completions and further spurious timeouts.
> +		 * If the request is still in flight, the driver is requesting
> +		 * blk-mq complete it.
>  		 */
> -		blk_mq_rq_update_aborted_gstate(req, 0);
> +		if (blk_mq_rq_state(req) == MQ_RQ_IN_FLIGHT)
> +			__blk_mq_complete_request(req);
> +		break;
> +	case BLK_EH_RESET_TIMER:
>  		blk_add_timer(req);
>  		break;
>  	case BLK_EH_NOT_HANDLED:
> @@ -880,64 +782,64 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
>  	}
>  }

I think the above changes can lead to concurrent calls of
__blk_mq_complete_request() from the regular completion path and the timeout
path. That's wrong: the __blk_mq_complete_request() caller should guarantee
that no concurrent calls from another context to that function can occur.

Bart.
