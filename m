From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 16 Dec 2013 12:54:08 -0500
Subject: [PATCHv2] NVMe: Disable admin queue on init failure
In-Reply-To: <1384537630-11052-1-git-send-email-keith.busch@intel.com>
References: <1384537630-11052-1-git-send-email-keith.busch@intel.com>
Message-ID: <20131216175408.GK6900@linux.intel.com>

On Fri, Nov 15, 2013@10:47:10AM -0700, Keith Busch wrote:
> Disable the admin queue if device fails during initialization so the
> queue's irq is freed.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> v1->v2:
> Moved the responsibilty of handling the admin queue to the funtion that
> set it up. This fixes the case where the controller is responsive but
> unable to handle io, so the cdev is still usable.
> 
> Fixed my typo in commit message from the sad rush to post the patch
> yesterday.
> 
>  drivers/block/nvme-core.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index da52092..145d621 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1864,7 +1864,11 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  	return 0;
>  
>   free_queues:
> -	nvme_free_queues(dev);
> +	for (i = dev->queue_count - 1; i > 0; i--) {
> +		nvme_free_queue(dev->queues[i]);
> +		dev->queue_count--;
> +		dev->queues[i] = NULL;
> +	}

I don't really like duplicating the guts of nvme_free_queues here.
How about this?

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ca0222d..3f5d67a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1151,11 +1151,11 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
 	kfree(nvmeq);
 }
 
-static void nvme_free_queues(struct nvme_dev *dev)
+static void nvme_free_queues(struct nvme_dev *dev, int lowest)
 {
 	int i;
 
-	for (i = dev->queue_count - 1; i >= 0; i--) {
+	for (i = dev->queue_count - 1; i >= lowest; i--) {
 		nvme_free_queue(dev->queues[i]);
 		dev->queue_count--;
 		dev->queues[i] = NULL;
@@ -1985,7 +1985,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	return 0;
 
  free_queues:
-	nvme_free_queues(dev);
+	nvme_free_queues(dev, 1);
 	return result;
 }
 
@@ -2405,6 +2405,7 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	return result;
 
  disable:
+	nvme_disable_queue(dev, 0);
 	spin_lock(&dev_list_lock);
 	list_del_init(&dev->node);
 	spin_unlock(&dev_list_lock);
@@ -2536,7 +2537,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  shutdown:
 	nvme_dev_shutdown(dev);
  release_pools:
-	nvme_free_queues(dev);
+	nvme_free_queues(dev, 0);
 	nvme_release_prp_pools(dev);
  release:
 	nvme_release_instance(dev);
@@ -2560,7 +2561,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	misc_deregister(&dev->miscdev);
 	nvme_dev_remove(dev);
 	nvme_dev_shutdown(dev);
-	nvme_free_queues(dev);
+	nvme_free_queues(dev, 0);
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
