From: keith.busch@intel.com (Keith Busch)
Date: Thu, 14 May 2015 18:50:56 +0000 (UTC)
Subject: [PATCH 2/2] NVMe: Kill request queues on dead controllers
In-Reply-To: <1430331622-12638-2-git-send-email-keith.busch@intel.com>
References: <1430331622-12638-1-git-send-email-keith.busch@intel.com>
 <1430331622-12638-2-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.LNX.2.00.1505141847500.15930@localhost.lm.intel.com>

Hi,

Any thoughts on this one? Hot plug regressions are very concerning to
me. Can we try to get this, or a different fix if there are issues with
this, in 4.1?


On Wed, 29 Apr 2015, Keith Busch wrote:
> This fixes device removal from waiting forever on a h/w queue that isn't
> available. There are two parts for this:
>
> First, the controller is shutdown after the disks are removed. This
> allows del_gendisk to sync dirty pages in an orderly removal scenario.
>
> Second, if the nvme controller is incapable of performing IO, kill the
> request queue prior to deleting gendisks. This prevents del_gendisk
> from waiting indefinitely to sync dirty pages when there controller is
> no longer accepting new requests.
>
> Reported-by: Sunad Bhandary <sunad.s at samsung.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> drivers/block/nvme-core.c |   20 +++++++++++++++++---
> 1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 85b8036..77aa061 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -2633,17 +2633,31 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
> 		nvme_clear_queue(dev->queues[i]);
> }
>
> +static inline bool nvme_io_incapable(struct nvme_dev *dev)
> +{
> +	return (!dev->bar || readl(&dev->bar->csts) == -1 ||
> +						dev->online_queues < 2);
> +}
> +
> static void nvme_dev_remove(struct nvme_dev *dev)
> {
> 	struct nvme_ns *ns;
>
> +	/*
> +	 * If controller is not IO capable, kill request queues prior to
> +	 * deleting gendisks to prevent filesystem sync from blocking.
> +	 */
> +	bool kill = nvme_io_incapable(dev);
> +
> 	list_for_each_entry(ns, &dev->namespaces, list) {
> +		if (kill && !blk_queue_dying(ns->queue))
> +			blk_set_queue_dying(ns->queue);
> 		if (ns->disk->flags & GENHD_FL_UP) {
> 			if (blk_get_integrity(ns->disk))
> 				blk_integrity_unregister(ns->disk);
> 			del_gendisk(ns->disk);
> 		}
> -		if (!blk_queue_dying(ns->queue)) {
> +		if (kill || !blk_queue_dying(ns->queue)) {
> 			blk_mq_abort_requeue_list(ns->queue);
> 			blk_cleanup_queue(ns->queue);
> 		}
> @@ -2879,8 +2893,8 @@ static void nvme_remove_disks(struct work_struct *ws)
> {
> 	struct nvme_dev *dev = container_of(ws, struct nvme_dev, reset_work);
>
> -	nvme_free_queues(dev, 1);
> 	nvme_dev_remove(dev);
> +	nvme_free_queues(dev, 1);
> }
>
> static int nvme_dev_resume(struct nvme_dev *dev)
> @@ -3042,8 +3056,8 @@ static void nvme_remove(struct pci_dev *pdev)
> 	pci_set_drvdata(pdev, NULL);
> 	flush_work(&dev->probe_work);
> 	flush_work(&dev->reset_work);
> -	nvme_dev_shutdown(dev);
> 	nvme_dev_remove(dev);
> +	nvme_dev_shutdown(dev);
> 	nvme_dev_remove_admin(dev);
> 	device_destroy(nvme_class, MKDEV(nvme_char_major, dev->instance));
> 	nvme_free_queues(dev, 0);
> --
