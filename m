From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Apr 2019 18:16:52 +0200
Subject: [PATCH V3 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <20190408161505.GA32613@localhost.localdomain>
References: <20190408094047.29150-1-ming.lei@redhat.com>
 <20190408094047.29150-2-ming.lei@redhat.com>
 <20190408161505.GA32613@localhost.localdomain>
Message-ID: <20190408161652.GA4381@lst.de>

On Mon, Apr 08, 2019@10:15:05AM -0600, Keith Busch wrote:
> > +bool blk_mq_complete_request_sync(struct request *rq)
> > +{
> > +	if (unlikely(blk_should_fake_timeout(rq->q)))
> > +		return false;
> > +
> > +	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
> > +	rq->q->mq_ops->complete(rq);
> > +	return true;
> > +}
> > +EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
> 
> Could we possibly drop the fake timeout in this path? We're using this
> in error handling that is past pretending completing requests didn't
> happen.

.. and at that point we can also drop the return value.
