From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Jan 2015 18:55:49 -0700
Subject: [PATCHv3 08/12] NVMe: Reference count admin queue usage
In-Reply-To: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
References: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420682153-3756-9-git-send-email-keith.busch@intel.com>

Since there is no gendisk associated with the admin queue, the driver
needs to hold a reference to it until all open references to the
controller are closed.

This also combines queue cleanup with freeing the tag set since these
should not be separate.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 286fa4c..beb8d48 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1369,6 +1369,14 @@ static struct blk_mq_ops nvme_mq_ops = {
 	.timeout	= nvme_timeout,
 };
 
+static void nvme_dev_remove_admin(struct nvme_dev *dev)
+{
+	if (dev->admin_q && !blk_queue_dying(dev->admin_q)) {
+		blk_cleanup_queue(dev->admin_q);
+		blk_mq_free_tag_set(&dev->admin_tagset);
+	}
+}
+
 static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 {
 	if (!dev->admin_q) {
@@ -1388,17 +1396,15 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 			blk_mq_free_tag_set(&dev->admin_tagset);
 			return -ENOMEM;
 		}
+		if (!blk_get_queue(dev->admin_q)) {
+			nvme_dev_remove_admin(dev);
+			return -ENODEV;
+		}
 	}
 
 	return 0;
 }
 
-static void nvme_free_admin_tags(struct nvme_dev *dev)
-{
-	if (dev->admin_q)
-		blk_mq_free_tag_set(&dev->admin_tagset);
-}
-
 static int nvme_configure_admin_queue(struct nvme_dev *dev)
 {
 	int result;
@@ -1465,7 +1471,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	return result;
 
  free_tags:
-	nvme_free_admin_tags(dev);
+	nvme_dev_remove_admin(dev);
  free_nvmeq:
 	nvme_free_queues(dev, 0);
 	return result;
@@ -2415,12 +2421,6 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	nvme_dev_unmap(dev);
 }
 
-static void nvme_dev_remove_admin(struct nvme_dev *dev)
-{
-	if (dev->admin_q && !blk_queue_dying(dev->admin_q))
-		blk_cleanup_queue(dev->admin_q);
-}
-
 static void nvme_dev_remove(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns;
@@ -2510,6 +2510,7 @@ static void nvme_free_dev(struct kref *kref)
 	nvme_free_namespaces(dev);
 	nvme_release_instance(dev);
 	blk_mq_free_tag_set(&dev->tagset);
+	blk_put_queue(dev->admin_q);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
@@ -2795,7 +2796,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_shutdown(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
-	nvme_free_admin_tags(dev);
 	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
 }
-- 
1.7.10.4
