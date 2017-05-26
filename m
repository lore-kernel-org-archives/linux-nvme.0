From: rakesh@tuxera.com (Rakesh Pandit)
Date: Fri, 26 May 2017 23:12:16 +0300
Subject: [PATCH V2 1/1] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170525083023.GA22852@lst.de>
References: <20170524142623.GA27721@dhcp-216.srv.tuxera.com>
 <20170525083023.GA22852@lst.de>
Message-ID: <20170526201216.GA21624@dhcp-216.srv.tuxera.com>

On Thu, May 25, 2017@10:30:23AM +0200, Christoph Hellwig wrote:
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 4c2ff2b..ba54e2a 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -1903,9 +1903,6 @@ static void nvme_reset_work(struct work_struct *work)
> >  	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
> >  	int result = -ENODEV;
> >  
> > -	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))
> > -		goto out;
> 
> Can we keep a
> 
> 	WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
> 
> here?

Yes. Will do in V3.

Taking it consideration Keith's suggestion of using new state makes
things better so V3 wouldn't touch RESETTING state.

> 
> >  		goto out;
> > @@ -2009,8 +2003,8 @@ static int nvme_reset(struct nvme_dev *dev)
> >  {
> >  	if (!dev->ctrl.admin_q || blk_queue_dying(dev->ctrl.admin_q))
> >  		return -ENODEV;
> > -	if (work_busy(&dev->reset_work))
> > -		return -ENODEV;
> > +	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
> > +		return -EBUSY;
> >  	if (!queue_work(nvme_workq, &dev->reset_work))
> >  		return -EBUSY;
> 
> nvme_probe will also have to set the state to NVME_CTRL_RESETTING to
> keep the old behavior, which had some error handling implications.
>

Will keep.

> Also we can replace the work_busy(&dev->reset_work) check in
> nvme_should_reset with a check for the NVME_CTRL_RESETTING state now.

Not replacing it seems better as nvme_reset is always called if
nvme_should_reset returns true and takes care of synchrozation.
Replacing it wouldn't make it possible to use same logic in nvme_reset
as nvme_reset would always be called after.

Thanks,
