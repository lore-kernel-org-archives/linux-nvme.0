From: keith.busch@intel.com (Keith Busch)
Date: Wed, 14 Nov 2018 08:37:07 -0700
Subject: [PATCH 1/6] nvme: don't disable local ints for polled queue
In-Reply-To: <20181114084322.GA14954@infradead.org>
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-2-axboe@kernel.dk>
 <20181114084322.GA14954@infradead.org>
Message-ID: <20181114153706.GA11416@localhost.localdomain>

On Wed, Nov 14, 2018@12:43:22AM -0800, Christoph Hellwig wrote:
> static int nvme_poll_noirq(struct blk_mq_hw_ctx *hctx, unsigned int tag)
> {
>         struct nvme_queue *nvmeq = hctx->driver_data;
> >  	u16 start, end;
> 	bool found;
> >  
> >  	if (!nvme_cqe_pending(nvmeq))
> >  		return 0;
> >  
> > +	spin_lock(&nvmeq->cq_lock);
> >  	found = nvme_process_cq(nvmeq, &start, &end, tag);
> > +	spin_unlock(&nvmeq->cq_lock);
> > +
> >  	nvme_complete_cqes(nvmeq, start, end);
> >  	return found;
> 
> And while we are at it:  I think for the irq-driven queues in a
> separate queue for poll setup we might not even need to take the
> CQ lock.  Which might be an argument for only allowing polling
> if we have the separate queues just to keep everything simple.

That's a pretty cool observation. We still poll interrupt driven queues
in the timeout path as a sanity check (it really has helped in debugging
timeout issues), but we can temporarily disable the cq's irq and be
lockless.
