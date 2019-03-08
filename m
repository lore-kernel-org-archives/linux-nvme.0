From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 08 Mar 2019 10:07:23 -0800
Subject: [PATCH 1/5] blk-mq: Export reading mq request state
In-Reply-To: <20190308174006.5032-1-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
Message-ID: <1552068443.45180.24.camel@acm.org>

On Fri, 2019-03-08@10:40 -0700, Keith Busch wrote:
> Drivers may need to know the state of their requets.

Hi Keith,

What makes you think that drivers should be able to check the state of their
requests? Please elaborate.

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index faed9d9eb84c..db113aee48bb 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -241,6 +241,15 @@ struct request {
>  	struct request *next_rq;
>  };
>  
> +/**
> + * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
> + * @rq: target request.
> + */
> +static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
> +{
> +	return READ_ONCE(rq->state);
> +}

Please also explain how drivers can use this function without triggering a
race condition with the code that modifies rq->state.

Thanks,

Bart.
