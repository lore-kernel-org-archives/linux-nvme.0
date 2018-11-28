From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 27 Nov 2018 23:20:37 -0800
Subject: [PATCH 4/8] nvme: implement mq_ops->commit_rqs() hook
In-Reply-To: <20181126163556.5181-5-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-5-axboe@kernel.dk>
Message-ID: <20181128072037.GB11774@infradead.org>

> +static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
> +{
> +	if (++index == nvmeq->q_depth)
> +		return 0;
> +
> +	return index;

Can you please just drop this helper?  It makes the code not only
less readable but also longer.

Otherwise the change looks fine to me.
