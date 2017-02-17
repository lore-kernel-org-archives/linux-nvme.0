From: keith.busch@intel.com (Keith Busch)
Date: Fri, 17 Feb 2017 11:33:28 -0500
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <20170217152713.GA27158@lst.de>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
 <20170217152713.GA27158@lst.de>
Message-ID: <20170217163328.GC18275@localhost.localdomain>

On Fri, Feb 17, 2017@04:27:13PM +0100, Christoph Hellwig wrote:
> >  	u32 csts = -1;
> > +	bool drain_queue = pci_is_enabled(to_pci_dev(dev->dev));
> >  
> >  	del_timer_sync(&dev->watchdog_timer);
> >  	cancel_work_sync(&dev->reset_work);
> >  
> >  	mutex_lock(&dev->shutdown_lock);
> > -	if (pci_is_enabled(to_pci_dev(dev->dev))) {
> > +	if (drain_queue) {
> > +		if (shutdown)
> > +			nvme_start_freeze(&dev->ctrl);
> 
> So if the devices is enabled and we are going to shut the device
> down we're going to freeze all I/O queues here.
> 
> Question 1:  why skip the freeze if we are not shutting down?

That is a great question!

If we are not shutting down, we are in one of two scenarios: a simple
reset, or we are killing this controller's request queues.

If the former, we don't want to freeze and flush because we are about
to bring the hctx back online, and anything queued may continue as normal.

For the latter, we will flush all entered requests to their failed
completion through nvme_kill_queues.

> >  		nvme_stop_queues(&dev->ctrl);
> 
> Especially as we're now going to wait for all I/O to finish here in
> all shutdown cases.

nvme_stop_queues only quieces. This doesn't actually wait for any IO to
complete.
 
> >  		csts = readl(dev->bar + NVME_REG_CSTS);
> >  	}
> > @@ -1701,6 +1704,25 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> >  
> >  	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
> >  	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
> 
> And kill all busy requests down here.

This only completes requests that were submitted to the controller but have
not been returned, and those requests are probably going to get requeued on
q->requeue_list, leaving the entered reference non-zero.

There may also be requests that entered the queue but are stuck there
after the quiece.
 
> > +
> > +	/*
> > +	 * If shutting down, the driver will not be starting up queues again,
> > +	 * so must drain all entered requests to their demise to avoid
> > +	 * deadlocking blk-mq hot-cpu notifier.
> > +	 */
> > +	if (drain_queue && shutdown) {
> > +		nvme_start_queues(&dev->ctrl);
> > +		/*
> > +		 * Waiting for frozen increases the freeze depth. Since we
> > +		 * already start the freeze earlier in this function to stop
> > +		 * incoming requests, we have to unfreeze after froze to get
> > +		 * the depth back to the desired.
> > +		 */
> > +		nvme_wait_freeze(&dev->ctrl);
> > +		nvme_unfreeze(&dev->ctrl);
> > +		nvme_stop_queues(&dev->ctrl);
> 
> And all this (just like the start_free + quience sequence above)
> really sounds like something we'd need to move to the core.

Maybe. I'm okay with moving it to the core and document the intended
usage, but the sequence inbetween initiating the freeze and waiting for
frozen is specific to the driver, as well as knowing when it needs to
be done. The above could be moved to core, but it only makes sense to
call it only if the request to start the freeze was done prior to
reclaiming controller owned IO.
 
> > +		/*
> > +		 * If we are resuming from suspend, the queue was set to freeze
> > +		 * to prevent blk-mq's hot CPU notifier from getting stuck on
> > +		 * requests that entered the queue that NVMe had quiesced. Now
> > +		 * that we are resuming and have notified blk-mq of the new h/w
> > +		 * context queue count, it is safe to unfreeze the queues.
> > +		 */
> > +		if (was_suspend)
> > +			nvme_unfreeze(&dev->ctrl);
> 
> And this change I don't understand at all.  It doesn't seem to pair
> up with anything else in the patch.

If we had done a controller shutdown, as would happen on a system suspend,
the resume needs to restore the queue freeze depth. That's all this
is doing.
