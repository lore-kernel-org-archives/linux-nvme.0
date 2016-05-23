From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 May 2016 10:55:56 -0400
Subject: [PATCH] NVMe: Fix possible scheduling while atomic error
In-Reply-To: <20160523143631.GA28107@infradead.org>
References: <1463521062-16488-1-git-send-email-keith.busch@intel.com>
 <20160523105807.GC26331@infradead.org>
 <20160523134116.GA17208@localhost.localdomain>
 <20160523143631.GA28107@infradead.org>
Message-ID: <20160523145556.GB17208@localhost.localdomain>

On Mon, May 23, 2016@07:36:31AM -0700, Christoph Hellwig wrote:
> On Mon, May 23, 2016@09:41:16AM -0400, Keith Busch wrote:
> > On Mon, May 23, 2016@03:58:07AM -0700, Christoph Hellwig wrote:
> > > On Tue, May 17, 2016@03:37:42PM -0600, Keith Busch wrote:
> > > >  	rcu_read_lock();
> > > >  	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
> > > > -		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
> > > > +		spin_lock_irq(ns->queue->queue_lock);
> > > > +		queue_flag_clear(QUEUE_FLAG_STOPPED, ns->queue);
> > > > +		spin_unlock_irq(ns->queue->queue_lock);
> > > 
> > > What's the rationale for this change? 
> > 
> > That was to make it so nvme_queue_rq wouldn't see a stopped flag just
> > before it was starting.
> 
> I don't really see how that helps us with any race..

Without the additional spin lock protecting QUEUE_FLAG_STOPPED:

  CPU A                                      CPU B
  -----                                      -----
  nvme_start_queues                          nvme_queue_rq
                                              if (nvmeq->cq_vector < 0) <--  queue is disabled during reset, returning BLK_MQ_RQ_QUEUE_BUSY
                                                 goto out;
                                              if (blk_queue_stopped())  <--  returns true
    queue_flag_clear
    blk_mq_start_stopped_hw_queues
                                                blk_mq_stop_hw_queues() <--  incorrectly stops h/w queues

Locking the queue in nvme_start_queues before clearing the flag fixes
that up.


> > It's moved out of that function holding the rcu read lock since
> > blk_mq_stop_hw_queues potentially sleeps.
> 
> blk_mq_stop_hw_queues is a loop around blk_mq_stop_hw_queue,
> which itself does two calls to cancel_delayed_work and a set_bit.
> None of them can block.

Oops, I'm crossing wires and mixing up what API's do what ... need to
wake up before starting work.
