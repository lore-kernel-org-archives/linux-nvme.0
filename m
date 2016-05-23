From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 May 2016 09:41:16 -0400
Subject: [PATCH] NVMe: Fix possible scheduling while atomic error
In-Reply-To: <20160523105807.GC26331@infradead.org>
References: <1463521062-16488-1-git-send-email-keith.busch@intel.com>
 <20160523105807.GC26331@infradead.org>
Message-ID: <20160523134116.GA17208@localhost.localdomain>

On Mon, May 23, 2016@03:58:07AM -0700, Christoph Hellwig wrote:
> On Tue, May 17, 2016@03:37:42PM -0600, Keith Busch wrote:
> >  	rcu_read_lock();
> >  	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
> > -		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
> > +		spin_lock_irq(ns->queue->queue_lock);
> > +		queue_flag_clear(QUEUE_FLAG_STOPPED, ns->queue);
> > +		spin_unlock_irq(ns->queue->queue_lock);
> 
> What's the rationale for this change? 

That was to make it so nvme_queue_rq wouldn't see a stopped flag just
before it was starting.
 
> > @@ -609,6 +609,12 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
> >  	spin_unlock_irq(&nvmeq->q_lock);
> >  	return BLK_MQ_RQ_QUEUE_OK;
> >  out:
> > +	if (ret == BLK_MQ_RQ_QUEUE_BUSY) {
> > +		spin_lock_irq(ns->queue->queue_lock);
> > +		if (blk_queue_stopped(req->q))
> > +			blk_mq_stop_hw_queues(ns->queue);
> > +		spin_unlock_irq(ns->queue->queue_lock);
> 
> Shouldn't we do this where set the stopped flag on the queue instead?

It's moved out of that function holding the rcu read lock since
blk_mq_stop_hw_queues potentially sleeps.

But the above is also broken because it's holding a spinlock, so this
patch is no good.
