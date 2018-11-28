From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 28 Nov 2018 09:38:54 +0800
Subject: [PATCH 3/8] blk-mq: add mq_ops->commit_rqs()
In-Reply-To: <20181126163556.5181-4-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-4-axboe@kernel.dk>
Message-ID: <20181128013852.GD11128@ming.t460p>

On Mon, Nov 26, 2018@09:35:51AM -0700, Jens Axboe wrote:
> blk-mq passes information to the hardware about any given request being
> the last that we will issue in this sequence. The point is that hardware
> can defer costly doorbell type writes to the last request. But if we run
> into errors issuing a sequence of requests, we may never send the request
> with bd->last == true set. For that case, we need a hook that tells the
> hardware that nothing else is coming right now.
> 
> For failures returned by the drivers ->queue_rq() hook, the driver is
> responsible for flushing pending requests, if it uses bd->last to
> optimize that part. This works like before, no changes there.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>  include/linux/blk-mq.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index ca0520ca6437..1fd139b65a6e 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -117,6 +117,7 @@ struct blk_mq_queue_data {
>  
>  typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
>  		const struct blk_mq_queue_data *);
> +typedef void (commit_rqs_fn)(struct blk_mq_hw_ctx *);
>  /* takes rq->cmd_flags as input, returns a hardware type index */
>  typedef int (rq_flags_to_type_fn)(struct request_queue *, unsigned int);
>  typedef bool (get_budget_fn)(struct blk_mq_hw_ctx *);
> @@ -144,6 +145,15 @@ struct blk_mq_ops {
>  	 */
>  	queue_rq_fn		*queue_rq;
>  
> +	/*
> +	 * If a driver uses bd->last to judge when to submit requests to
> +	 * hardware, it must define this function. In case of errors that
> +	 * make us stop issuing further requests, this hook serves the
> +	 * purpose of kicking the hardware (which the last request otherwise
> +	 * would have done).
> +	 */
> +	commit_rqs_fn		*commit_rqs;
> +
>  	/*
>  	 * Return a queue map type for the given request/bio flags
>  	 */
> -- 
> 2.17.1
>

Looks fine,

Reviewed-by: Ming Lei <ming.lei at redhat.com>

Thanks,
Ming
