From: kbusch@kernel.org (Keith Busch)
Date: Thu, 16 May 2019 08:24:11 -0600
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <20190516062528.GA29930@lst.de>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-6-keith.busch@intel.com>
 <20190516062528.GA29930@lst.de>
Message-ID: <20190516142411.GC23333@localhost.localdomain>

On Wed, May 15, 2019@11:25:28PM -0700, Christoph Hellwig wrote:
> >  
> >  #ifdef CONFIG_PM_SLEEP
> > +static int nvme_deep_state(struct nvme_dev *dev)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> > +	struct nvme_ctrl *ctrl = &dev->ctrl;
> > +	int ret = -EBUSY;;
> > +
> > +	nvme_start_freeze(ctrl);
> > +	nvme_wait_freeze(ctrl);
> > +	nvme_sync_queues(ctrl);
> > +
> > +	if (ctrl->state != NVME_CTRL_LIVE &&
> > +	    ctrl->state != NVME_CTRL_ADMIN_ONLY)
> > +		goto unfreeze;
> > +
> > +	if (dev->host_mem_descs) {
> > +		ret = nvme_set_host_mem(dev, 0);
> > +		if (ret < 0)
> > +			goto unfreeze;
> > +	}
> 
> I've still not heard an explanation of anyone why we need to disable
> the HMB here. Even if there are states where we have to disable it
> we need to restrict it to just those system power states where we have
> to, as reclaiming and recreating the HMB is very costly for the device.

We're not really reclaiming the HMB here. We're just telling the
controller to stop using it for a moment, and we return it back to the
device in the same condition it left it via NVME_HOST_MEM_RETURN. That
should minimize bringup latency.

But also I don't think we should have to do this, or would at least like
to see something more authoritative explaining which device or platform
power states require disabling HMB.

> > +	if (ret) {
> > +		/*
> > +		 * Clearing npss forces a controller reset on resume. The
> > +		 * correct value will be resdicovered then.
> > +		 */
> > +		ctrl->npss = 0;
> > +		nvme_dev_disable(dev, true);
> 
> Can't we just reuse the nvme_dev_disable call in the caller?

We could, but it looks less pleasent for the caller since needs to handle
three return possibilities: success, disable, and abort suspend.


> > +	if (dev->host_mem_descs) {
> > +		ret = nvme_setup_host_mem(dev);
> > +		if (ret)
> > +			goto reset;
> > +	}
> 
> This call could/should set the Memory Return bit in the Set Features
> call to enable the HMB.

Yep.
 
> >  static int nvme_suspend(struct device *dev)
> >  {
> >  	struct pci_dev *pdev = to_pci_dev(dev);
> >  	struct nvme_dev *ndev = pci_get_drvdata(pdev);
> >  
> > +	if (!pm_suspend_via_firmware() && ndev->ctrl.npss)
> > +		return nvme_deep_state(ndev);
> 
> And this still needs a comment why we try to just meddle with the
> power state and queues instead of turning the device off only if
> not suspended via firmware.

Sure thing.
