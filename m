From: keith.busch@intel.com (Keith Busch)
Date: Tue, 9 Dec 2014 16:18:31 +0000 (UTC)
Subject: [PATCHv2] NVMe: Fix partition detection issue(hot remove followed
 by hot add)
In-Reply-To: <027101d013be$b7731170$26593450$@samsung.com>
References: <1411467843-3003-1-git-send-email-indraneel.m@samsung.com>
 <alpine.LRH.2.03.1409230733000.4696@AMR>
 <027101d013be$b7731170$26593450$@samsung.com>
Message-ID: <alpine.LNX.2.00.1412091615120.3973@localhost.lm.intel.com>

On Tue, 9 Dec 2014, Indraneel Mukherjee wrote:
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -2735,7 +2735,6 @@ static void nvme_free_dev(struct kref *kref)
>
>        pci_dev_put(dev->pci_dev);
>        nvme_free_namespaces(dev);
> -       nvme_release_instance(dev);
>        free_percpu(dev->io_queue);
>        kfree(dev->queues);
>        kfree(dev->entry);
> @@ -2996,6 +2995,7 @@ static void nvme_remove(struct pci_dev *pdev)
>        nvme_dev_shutdown(dev);
>        nvme_free_queues(dev, 0);
>        nvme_dev_remove(dev);
> +       nvme_release_instance(dev);
>        nvme_release_prp_pools(dev);
>        kref_put(&dev->kref, nvme_free_dev);
> }
>
> This ensures that the new node gets a different name (in case there is a
> stale node).
>
> If the fix is okay, I can send this separately as a patch.

Yes, please send as a patch and I'd Ack it. You might want to make one
against Jens' linux-block tree as well.
