From: hch@lst.de (Christoph Hellwig)
Date: Mon, 23 Jul 2018 10:09:41 +0200
Subject: [PATCH 1/2] blk-mq: export setting request completion state
In-Reply-To: <20180719212618.2406-1-keith.busch@intel.com>
References: <20180719212618.2406-1-keith.busch@intel.com>
Message-ID: <20180723080941.GA19247@lst.de>

> +/*
> + * Returns true if request was not in flight.
> + */
> +static inline bool blk_mq_mark_complete(struct request *rq)
> +{
> +	return (cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) !=
> +			MQ_RQ_IN_FLIGHT);
> +}

This needs a much better comment describing when and how to use it.

Also the outer braces in the return statement are not required.
