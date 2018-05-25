From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 25 May 2018 08:41:25 -0600
Subject: [PATCHv3 3/9] nvme: Move all IO out of controller reset
In-Reply-To: <20180525130057.GF23463@lst.de>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-4-keith.busch@intel.com>
 <20180525130057.GF23463@lst.de>
Message-ID: <20180525144125.GP11037@localhost.localdomain>

On Fri, May 25, 2018@03:00:57PM +0200, Christoph Hellwig wrote:
> On Thu, May 24, 2018@02:34:54PM -0600, Keith Busch wrote:
> > IO may be retryable, so don't wait for them in the reset path.
> 
> Can't parse this.
> 
> 
> > These
> > commands may trigger a reset if that IO expires without a completion,
> 
> What are "these commands"?

Sorry, I'm referring to the failed requests that were requeued after
a controller disabling. We've been dispatching them from reset_work and
just hoping they don't time out.
 
> > placing it on the requeue list, so waiting for these would deadlock the
> > reset handler.
> > 
> > To fix the theoretical deadlock, this patch unblocks IO submission from
> 
> How did you find it if it is theoretical?

Variants of the blktests block/011 can trigger this. I've neven seen it
in real life, but its not too much of a leap to imagine it can happen.
 
> > This patch is also renaming the function 'nvme_dev_add' to a
> > more appropriate name that describes what it's actually doing:
> > nvme_alloc_io_tags.
> 
> Can you split this out into a separate patch?

Sure thing.
 
> > @@ -3175,6 +3175,8 @@ static void nvme_scan_work(struct work_struct *work)
> >  	struct nvme_id_ctrl *id;
> >  	unsigned nn;
> >  
> > +	if (ctrl->ops->update_hw_ctx)
> > +		ctrl->ops->update_hw_ctx(ctrl);
> 
> nvme_scan_work gets kicked from all kinds of places including
> ioctls and AERs. I don't think the code you added below should
> be called from all of them.

True, most of the time nothing happens on this call. I'm trying to not
require another work_struct, and scan_work provides a safe context for
what this needs to accomplish, but I can try to find another way.

> > +static void nvme_pci_update_hw_ctx(struct nvme_ctrl *ctrl)
> > +{
> > +	struct nvme_dev *dev = to_nvme_dev(ctrl);
> > +	bool unfreeze;
> > +
> > +	mutex_lock(&dev->shutdown_lock);
> > +	unfreeze = dev->queues_froze;
> > +	mutex_unlock(&dev->shutdown_lock);
> 
> No need to take a mutex here is you sample as single <= register
> sized value.
> 
> > +	if (!unfreeze)
> > +		return;
> 
> But this whole scheme stinks to me.  For one we are adding more ad-hoc
> state outside the state machine, second it all seems very "ad-hoc".
> 
> > +
> > +	nvme_wait_freeze(&dev->ctrl);
> > +	blk_mq_update_nr_hw_queues(ctrl->tagset, dev->online_queues - 1);
> > +	nvme_free_queues(dev, dev->online_queues);
> > +	nvme_unfreeze(&dev->ctrl);
> > +
> > +	mutex_lock(&dev->shutdown_lock);
> > +	dev->queues_froze = false;
> > +	mutex_unlock(&dev->shutdown_lock);
> 
> Same here.  Simple READ_ONCE/WRITE_ONCE will give you the right
> memory barriers with no need for the lock.

Good point.
 
> Also except for the nvme_free_queues this all is generic code,
> so I think we want this in the core.

That can be arranged.

> And I wonder where this would fit better than the scan work, but I
> can't think of anything else but an entirely new work_struct, which
> isn't all that great either.

Yeah, I was trying to avoid introducing yet another work_struct here.

> > @@ -2211,7 +2228,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> >  	     dev->ctrl.state == NVME_CTRL_RESETTING)) {
> >  		u32 csts = readl(dev->bar + NVME_REG_CSTS);
> >  
> > -		nvme_start_freeze(&dev->ctrl);
> > +		if (!dev->queues_froze)	{
> > +			nvme_start_freeze(&dev->ctrl);
> > +			dev->queues_froze = true;
> > +		}
> 
> And this sounds like another indicator for a new FROZEN state.  Once
> the ctrl already is frozen we really shouldn't even end up in here
> anymore.

I'll have to think about this idea.
