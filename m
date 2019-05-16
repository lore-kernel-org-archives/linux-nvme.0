From: hch@lst.de (Christoph Hellwig)
Date: Thu, 16 May 2019 08:25:28 +0200
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <20190515163625.21776-6-keith.busch@intel.com>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-6-keith.busch@intel.com>
Message-ID: <20190516062528.GA29930@lst.de>

>  
>  #ifdef CONFIG_PM_SLEEP
> +static int nvme_deep_state(struct nvme_dev *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +	struct nvme_ctrl *ctrl = &dev->ctrl;
> +	int ret = -EBUSY;;
> +
> +	nvme_start_freeze(ctrl);
> +	nvme_wait_freeze(ctrl);
> +	nvme_sync_queues(ctrl);
> +
> +	if (ctrl->state != NVME_CTRL_LIVE &&
> +	    ctrl->state != NVME_CTRL_ADMIN_ONLY)
> +		goto unfreeze;
> +
> +	if (dev->host_mem_descs) {
> +		ret = nvme_set_host_mem(dev, 0);
> +		if (ret < 0)
> +			goto unfreeze;
> +	}

I've still not heard an explanation of anyone why we need to disable
the HMB here. Even if there are states where we have to disable it
we need to restrict it to just those system power states where we have
to, as reclaiming and recreating the HMB is very costly for the device.

> +	if (ret) {
> +		/*
> +		 * Clearing npss forces a controller reset on resume. The
> +		 * correct value will be resdicovered then.
> +		 */
> +		ctrl->npss = 0;
> +		nvme_dev_disable(dev, true);

Can't we just reuse the nvme_dev_disable call in the caller?

> +	if (dev->host_mem_descs) {
> +		ret = nvme_setup_host_mem(dev);
> +		if (ret)
> +			goto reset;
> +	}

This call could/should set the Memory Return bit in the Set Features
call to enable the HMB.

>  static int nvme_suspend(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct nvme_dev *ndev = pci_get_drvdata(pdev);
>  
> +	if (!pm_suspend_via_firmware() && ndev->ctrl.npss)
> +		return nvme_deep_state(ndev);

And this still needs a comment why we try to just meddle with the
power state and queues instead of turning the device off only if
not suspended via firmware.
