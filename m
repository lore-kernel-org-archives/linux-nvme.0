From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 May 2016 07:36:31 -0700
Subject: [PATCH] NVMe: Fix possible scheduling while atomic error
In-Reply-To: <20160523134116.GA17208@localhost.localdomain>
References: <1463521062-16488-1-git-send-email-keith.busch@intel.com>
 <20160523105807.GC26331@infradead.org>
 <20160523134116.GA17208@localhost.localdomain>
Message-ID: <20160523143631.GA28107@infradead.org>

On Mon, May 23, 2016@09:41:16AM -0400, Keith Busch wrote:
> On Mon, May 23, 2016@03:58:07AM -0700, Christoph Hellwig wrote:
> > On Tue, May 17, 2016@03:37:42PM -0600, Keith Busch wrote:
> > >  	rcu_read_lock();
> > >  	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
> > > -		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
> > > +		spin_lock_irq(ns->queue->queue_lock);
> > > +		queue_flag_clear(QUEUE_FLAG_STOPPED, ns->queue);
> > > +		spin_unlock_irq(ns->queue->queue_lock);
> > 
> > What's the rationale for this change? 
> 
> That was to make it so nvme_queue_rq wouldn't see a stopped flag just
> before it was starting.

I don't really see how that helps us with any race..

> > > @@ -609,6 +609,12 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
> > >  	spin_unlock_irq(&nvmeq->q_lock);
> > >  	return BLK_MQ_RQ_QUEUE_OK;
> > >  out:
> > > +	if (ret == BLK_MQ_RQ_QUEUE_BUSY) {
> > > +		spin_lock_irq(ns->queue->queue_lock);
> > > +		if (blk_queue_stopped(req->q))
> > > +			blk_mq_stop_hw_queues(ns->queue);
> > > +		spin_unlock_irq(ns->queue->queue_lock);
> > 
> > Shouldn't we do this where set the stopped flag on the queue instead?
> 
> It's moved out of that function holding the rcu read lock since
> blk_mq_stop_hw_queues potentially sleeps.

blk_mq_stop_hw_queues is a loop around blk_mq_stop_hw_queue,
which itself does two calls to cancel_delayed_work and a set_bit.
None of them can block.
