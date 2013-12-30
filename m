From: keith.busch@intel.com (Keith Busch)
Date: Mon, 30 Dec 2013 07:52:27 -0700 (MST)
Subject: [PATCH RFC 1/5] NVMe: Code cleanup and minor checkpatch correction
In-Reply-To: <1388399240-13828-2-git-send-email-santoshsy@gmail.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
 <1388399240-13828-2-git-send-email-santoshsy@gmail.com>
Message-ID: <alpine.LRH.2.03.1312300741560.4958@AMR>

On Mon, 30 Dec 2013, Santosh Y wrote:
> Remove redunduant 'dev->node' deletion which is being
> handled in nvme_dev_shutdown() and a minor checkpatch error.
>
> Signed-off-by: Ravi Kumar <ravi.android at gmail.com>
> Signed-off-by: Santosh Y <santoshsy at gmail.com>
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index b59a93a..a523296 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -2120,7 +2120,7 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
>
> struct nvme_delq_ctx {
> 	struct task_struct *waiter;
> -	struct kthread_worker* worker;
> +	struct kthread_worker *worker;
> 	atomic_t refcount;
> };
>
> @@ -2556,10 +2556,6 @@ static void nvme_remove(struct pci_dev *pdev)
> {
> 	struct nvme_dev *dev = pci_get_drvdata(pdev);
>
> -	spin_lock(&dev_list_lock);
> -	list_del_init(&dev->node);
> -	spin_unlock(&dev_list_lock);
> -
> 	pci_set_drvdata(pdev, NULL);
> 	flush_work(&dev->reset_work);
> 	misc_deregister(&dev->miscdev);

We have to delete it from the list here to prevent a surprise removed
device from being polled after the pci layer calls the driver's
'remove'. Work can not be queued if the device is not polled, so we have
to remove from the list before calling flush_work, otherwise work could
potentially be queued after this point, and that's not okay.
