From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 30 Dec 2015 09:58:29 -0800
Subject: [PATCH 4/5] NVMe: Shutdown controller only for power-off
In-Reply-To: <1451496471-29370-5-git-send-email-keith.busch@intel.com>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-5-git-send-email-keith.busch@intel.com>
Message-ID: <20151230175829.GE21400@infradead.org>

On Wed, Dec 30, 2015@10:27:50AM -0700, Keith Busch wrote:
> We don't need to shutdown a controller for a reset. A controller in a
> shutdown state may take longer to become ready than one that was simply
> disabled. This patch has the driver shut down a controller only if the
> device is about to be powered off or being removed. When the taking
> the controller down for a reset reason, the controller will be disabled
> instead.
> 
> Function names have been updated in this patch to reflect their changed
> semantics.

Am I missing something?  What happens to the calls to nvme_disable_queue
in nvme_disable_io_queues and nvme_wait_dq?

> -static void nvme_disable_queue(struct nvme_dev *dev, int qid)
> +static void nvme_disable_admin_queue(struct nvme_dev *dev, bool disable_ctrl)
>  {
> -	struct nvme_queue *nvmeq = dev->queues[qid];
> +	struct nvme_queue *nvmeq = dev->queues[0];
>  
>  	if (!nvmeq)
>  		return;
>  	if (nvme_suspend_queue(nvmeq))
>  		return;
>  
> -	/* Don't tell the adapter to delete the admin queue.
> -	 * Don't tell a removed adapter to delete IO queues. */
> -	if (qid && readl(dev->bar + NVME_REG_CSTS) != -1) {
> -		adapter_delete_sq(dev, qid);
> -		adapter_delete_cq(dev, qid);
> -	}
> +	if (disable_ctrl)
> +		nvme_disable_ctrl(&dev->ctrl,
> +			lo_hi_readq(dev->bar + NVME_REG_CAP));

Why can't this be done outside this function, similar to the
shutdown case?
