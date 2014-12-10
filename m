From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Dec 2014 20:00:07 +0000 (UTC)
Subject: [PATCH] NVMe: Fix FS mount issue (hot-remove followed by hot-add)
In-Reply-To: <1418221540-3696-1-git-send-email-indraneel.m@samsung.com>
References: <1418221540-3696-1-git-send-email-indraneel.m@samsung.com>
Message-ID: <alpine.LNX.2.00.1412101949260.4026@localhost.lm.intel.com>

On Wed, 10 Dec 2014, Indraneel M wrote:
> After Hot-remove of a device with a mounted partition,
> when the device is hot-added again, the new node reappears
> as nvme0n1. Mounting this new node fails with the error:
>
> mount: mount /dev/nvme0n1p1 on /mnt failed: File exists.
>
> The old nodes's FS entries still exist and the kernel can't re-create
> procfs and sysfs entries for the new node with the same name.
> The patch fixes this issue.
>
> Signed-off-by: Indraneel M <indraneel.m at samsung.com>

Acked-by: Keith Busch <keith.busch at intel.com>

Now where is this going? It won't apply to linux-block/for-next (though
it is a trivial manual merge), which I think is where the 3.19 pull
request to mainline will come from. I hope these trees get synced up
soon so we don't have these fragmented drivers.

> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 00fa5d2..5c151d7 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -2735,6 +2735,7 @@ static void nvme_free_dev(struct kref *kref)
>
> 	pci_dev_put(dev->pci_dev);
> 	nvme_free_namespaces(dev);
> +	nvme_release_instance(dev);
> 	free_percpu(dev->io_queue);
> 	kfree(dev->queues);
> 	kfree(dev->entry);
> @@ -2995,7 +2996,6 @@ static void nvme_remove(struct pci_dev *pdev)
> 	nvme_dev_shutdown(dev);
> 	nvme_free_queues(dev, 0);
> 	nvme_dev_remove(dev);
> -	nvme_release_instance(dev);
> 	nvme_release_prp_pools(dev);
> 	kref_put(&dev->kref, nvme_free_dev);
> }
