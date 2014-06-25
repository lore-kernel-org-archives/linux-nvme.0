From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Jun 2014 11:06:56 -0600 (MDT)
Subject: [PATCH] NVMe: Skip orderly shutdown on failed devices
In-Reply-To: <20140625123717.GR12025@linux.intel.com>
References: <1403545595-525-1-git-send-email-keith.busch@intel.com>
 <20140625123717.GR12025@linux.intel.com>
Message-ID: <alpine.LRH.2.03.1406251055290.4699@AMR>

On Wed, 25 Jun 2014, Matthew Wilcox wrote:
> On Mon, Jun 23, 2014@11:46:35AM -0600, Keith Busch wrote:
>> Rather than skipping shutdown only for device's that have been removed,
>> skip the orderly shutdown on failed devices to avoid the long timeout
>> handling that inevitably happens when deleting queues on such a device.
>
> How about this instead?

Yes, that's much better.

I also just encountered a device that dropped the ready bit. I'm not
sure why, but the device definitely wasn't ready to do anything, so I
can add the check and skip shutdown there as well.

> @@ -2500,11 +2500,14 @@ static void nvme_dev_list_remove(struct nvme_dev *dev)
> static void nvme_dev_shutdown(struct nvme_dev *dev)
> {
>        int i;
> +       u32 csts = -1;
>
>        dev->initialized = 0;
>        nvme_dev_list_remove(dev);
> +       if (dev->bar)
> +               csts = readl(&dev->bar->csts);
>
> -       if (!dev->bar || (dev->bar && readl(&dev->bar->csts) == -1)) {
> +       if (csts & NVME_CSTS_CFS) {
>                for (i = dev->queue_count - 1; i >= 0; i--) {
>                        struct nvme_queue *nvmeq = raw_nvmeq(dev, i);
>                        nvme_suspend_queue(nvmeq);
