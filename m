From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Wed, 18 Jul 2018 17:18:45 +0000
Subject: [RFC PATCH] blk-mq: move timeout handling from queue to tagset
In-Reply-To: <20180718170018.31395-1-keith.busch@intel.com>
References: <20180718170018.31395-1-keith.busch@intel.com>
Message-ID: <11f7a7aff754b9bb0e4243ac4502319f376378c3.camel@wdc.com>

On Wed, 2018-07-18@11:00 -0600, Keith Busch wrote:
>  void blk_sync_queue(struct request_queue *q)
>  {
> -	del_timer_sync(&q->timeout);
> -	cancel_work_sync(&q->timeout_work);
> -
>  	if (q->mq_ops) {
>  		struct blk_mq_hw_ctx *hctx;
>  		int i;
> @@ -415,6 +412,8 @@ void blk_sync_queue(struct request_queue *q)
>  		queue_for_each_hw_ctx(q, hctx, i)
>  			cancel_delayed_work_sync(&hctx->run_work);
>  	} else {
> +		del_timer_sync(&q->timeout);
> +		cancel_work_sync(&q->timeout_work);
>  		cancel_delayed_work_sync(&q->delay_work);
>  	}
>  }

What is the impact of this change on the md driver, which is the only driver
that calls blk_sync_queue() directly? What will happen if timeout processing
happens concurrently with or after blk_sync_queue() has returned?

>  static void blk_mq_timeout_work(struct work_struct *work)
>  {
> -	struct request_queue *q =
> -		container_of(work, struct request_queue, timeout_work);
> +	struct blk_mq_tag_set *set =
> +		container_of(work, struct blk_mq_tag_set, timeout_work);
> +	struct request_queue *q;
>  	unsigned long next = 0;
>  	struct blk_mq_hw_ctx *hctx;
>  	int i;
>  
> -	/* A deadlock might occur if a request is stuck requiring a
> -	 * timeout at the same time a queue freeze is waiting
> -	 * completion, since the timeout code would not be able to
> -	 * acquire the queue reference here.
> -	 *
> -	 * That's why we don't use blk_queue_enter here; instead, we use
> -	 * percpu_ref_tryget directly, because we need to be able to
> -	 * obtain a reference even in the short window between the queue
> -	 * starting to freeze, by dropping the first reference in
> -	 * blk_freeze_queue_start, and the moment the last request is
> -	 * consumed, marked by the instant q_usage_counter reaches
> -	 * zero.
> -	 */
> -	if (!percpu_ref_tryget(&q->q_usage_counter))
> -		return;
> -
> -	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
> +	blk_mq_tagset_busy_iter(set, blk_mq_check_expired, &next);
>  
>  	if (next != 0) {
> -		mod_timer(&q->timeout, next);
> -	} else {
> +		mod_timer(&set->timer, next);
> +		return;
> +	}
> +
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>  		/*
>  		 * Request timeouts are handled as a forward rolling timer. If
>  		 * we end up here it means that no requests are pending and
> @@ -881,7 +868,6 @@ static void blk_mq_timeout_work(struct work_struct *work)
>  				blk_mq_tag_idle(hctx);
>  		}
>  	}
> -	blk_queue_exit(q);
>  }

What prevents that a request queue is removed from set->tag_list while the above
loop examines tag_list? Can blk_cleanup_queue() queue be called from the context
of another thread while this loop is examining hardware queues?
 
> +	timer_setup(&set->timer, blk_mq_timed_out_timer, 0);
> +	INIT_WORK(&set->timeout_work, blk_mq_timeout_work);
> [ ... ]
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -86,6 +86,8 @@ struct blk_mq_tag_set {
>  
>  	struct blk_mq_tags	**tags;
>  
> +	struct timer_list	timer;
> +	struct work_struct	timeout_work;

Can the timer and timeout_work data structures be replaced by a single
delayed_work instance?

Thanks,

Bart.
