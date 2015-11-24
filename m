From: axboe@fb.com (Jens Axboe)
Date: Tue, 24 Nov 2015 12:42:50 -0700
Subject: [PATCHv2 2/2] NVMe: Shutdown fixes
In-Reply-To: <1448390128-25758-2-git-send-email-keith.busch@intel.com>
References: <1448390128-25758-1-git-send-email-keith.busch@intel.com>
 <1448390128-25758-2-git-send-email-keith.busch@intel.com>
Message-ID: <5654BDBA.9080406@fb.com>

On 11/24/2015 11:35 AM, Keith Busch wrote:
> The controller must be disabled prior to completing a presumed lost
> command. This patch makes the shutdown safe to simultaneous invocations,
> and directly calls it from the timeout handler if timeout occurs during
> initialization.
>
> blk-mq marks requests as completed in its timeout handler, though the
> driver still owns the request. To propagate the appropriate status
> to the caller, the driver must directly set req->errors. This also
> happens to fix a race if the controller being reset actually completes
> the request that timed out.
>
> A side effect of this patch is a controller that times out IO queue
> creation will be failed. The driver silently proceeded before, so this
> sounds like an improvement. There hasn't been any reports of such
> a condition actually occurring, though.
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

> @@ -2023,6 +2039,11 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
>
>   	nvme_dev_list_remove(dev);
>
> +	if (test_and_set_bit(NVME_CTRL_SHUTDOWN, &dev->flags)) {
> +		wait_event(dev->shutdown_wait, !test_bit(NVME_CTRL_SHUTDOWN,
> +								&dev->flags));
> +		return;
> +	}
>   	if (dev->bar) {
>   		nvme_freeze_queues(dev);
>   		csts = readl(dev->bar + NVME_REG_CSTS);
> @@ -2041,6 +2062,9 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
>
>   	for (i = dev->queue_count - 1; i >= 0; i--)
>   		nvme_clear_queue(dev->queues[i]);
> +
> +	clear_bit(NVME_CTRL_SHUTDOWN, &dev->flags);
> +	wake_up_all(&dev->shutdown_wait);
>   }

I don't like this. You're essentially protecting the code here, not the 
data structure. There must be a cleaner way to solve this.

It this hiding missing references somewhere else?

-- 
Jens Axboe
