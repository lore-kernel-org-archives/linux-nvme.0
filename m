From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Feb 2017 16:27:13 +0100
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <1486768553-13738-6-git-send-email-keith.busch@intel.com>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
Message-ID: <20170217152713.GA27158@lst.de>

>  	u32 csts = -1;
> +	bool drain_queue = pci_is_enabled(to_pci_dev(dev->dev));
>  
>  	del_timer_sync(&dev->watchdog_timer);
>  	cancel_work_sync(&dev->reset_work);
>  
>  	mutex_lock(&dev->shutdown_lock);
> -	if (pci_is_enabled(to_pci_dev(dev->dev))) {
> +	if (drain_queue) {
> +		if (shutdown)
> +			nvme_start_freeze(&dev->ctrl);

So if the devices is enabled and we are going to shut the device
down we're going to freeze all I/O queues here.

Question 1:  why skip the freeze if we are not shutting down?

>  		nvme_stop_queues(&dev->ctrl);

Especially as we're now going to wait for all I/O to finish here in
all shutdown cases.

>  		csts = readl(dev->bar + NVME_REG_CSTS);
>  	}
> @@ -1701,6 +1704,25 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  
>  	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
>  	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);

And kill all busy requests down here.

> +
> +	/*
> +	 * If shutting down, the driver will not be starting up queues again,
> +	 * so must drain all entered requests to their demise to avoid
> +	 * deadlocking blk-mq hot-cpu notifier.
> +	 */
> +	if (drain_queue && shutdown) {
> +		nvme_start_queues(&dev->ctrl);
> +		/*
> +		 * Waiting for frozen increases the freeze depth. Since we
> +		 * already start the freeze earlier in this function to stop
> +		 * incoming requests, we have to unfreeze after froze to get
> +		 * the depth back to the desired.
> +		 */
> +		nvme_wait_freeze(&dev->ctrl);
> +		nvme_unfreeze(&dev->ctrl);
> +		nvme_stop_queues(&dev->ctrl);

And all this (just like the start_free + quience sequence above)
really sounds like something we'd need to move to the core.

> +		/*
> +		 * If we are resuming from suspend, the queue was set to freeze
> +		 * to prevent blk-mq's hot CPU notifier from getting stuck on
> +		 * requests that entered the queue that NVMe had quiesced. Now
> +		 * that we are resuming and have notified blk-mq of the new h/w
> +		 * context queue count, it is safe to unfreeze the queues.
> +		 */
> +		if (was_suspend)
> +			nvme_unfreeze(&dev->ctrl);

And this change I don't understand at all.  It doesn't seem to pair
up with anything else in the patch.
