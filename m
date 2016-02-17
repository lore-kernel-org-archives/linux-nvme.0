From: keith.busch@intel.com (Keith Busch)
Date: Wed, 17 Feb 2016 11:36:53 -0700
Subject: [PATCH-4.5-v3 3/5] NVMe: Simplify device reset failure
In-Reply-To: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
References: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455734215-20396-4-git-send-email-keith.busch@intel.com>

A reset failure schedules the device to unbind from the driver through
the pci driver's remove. This cleans up all intialization, so there is
no need to duplicate the potentially racy cleanup.

To help understand why a reset failed, the status is logged with the
existing warning message.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f0e97a3..9e050dd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -86,7 +86,6 @@ struct nvme_queue;
 
 static int nvme_reset(struct nvme_dev *dev);
 static void nvme_process_cq(struct nvme_queue *nvmeq);
-static void nvme_remove_dead_ctrl(struct nvme_dev *dev);
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 
 /*
@@ -1902,10 +1901,19 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	kfree(dev);
 }
 
+static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
+{
+	dev_warn(dev->dev, "Removing after probe failure status: %d\n", status);
+
+	kref_get(&dev->ctrl.kref);
+	if (!schedule_work(&dev->remove_work))
+		nvme_put_ctrl(&dev->ctrl);
+}
+
 static void nvme_reset_work(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
-	int result;
+	int result = -ENODEV;
 
 	if (WARN_ON(test_bit(NVME_CTRL_RESETTING, &dev->flags)))
 		goto out;
@@ -1925,26 +1933,26 @@ static void nvme_reset_work(struct work_struct *work)
 
 	result = nvme_configure_admin_queue(dev);
 	if (result)
-		goto unmap;
+		goto out;
 
 	nvme_init_queue(dev->queues[0], 0);
 	result = nvme_alloc_admin_tags(dev);
 	if (result)
-		goto disable;
+		goto out;
 
 	result = nvme_init_identify(&dev->ctrl);
 	if (result)
-		goto free_tags;
+		goto out;
 
 	result = nvme_setup_io_queues(dev);
 	if (result)
-		goto free_tags;
+		goto out;
 
 	dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
 
 	result = nvme_dev_list_add(dev);
 	if (result)
-		goto remove;
+		goto out;
 
 	/*
 	 * Keep the controller around but remove all namespaces if we don't have
@@ -1961,19 +1969,8 @@ static void nvme_reset_work(struct work_struct *work)
 	clear_bit(NVME_CTRL_RESETTING, &dev->flags);
 	return;
 
- remove:
-	nvme_dev_list_remove(dev);
- free_tags:
-	nvme_dev_remove_admin(dev);
-	blk_put_queue(dev->ctrl.admin_q);
-	dev->ctrl.admin_q = NULL;
-	dev->queues[0]->tags = NULL;
- disable:
-	nvme_disable_admin_queue(dev, false);
- unmap:
-	nvme_dev_unmap(dev);
  out:
-	nvme_remove_dead_ctrl(dev);
+	nvme_remove_dead_ctrl(dev, result);
 }
 
 static void nvme_remove_dead_ctrl_work(struct work_struct *work)
@@ -1986,14 +1983,6 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
-{
-	dev_warn(dev->dev, "Removing after probe failure\n");
-	kref_get(&dev->ctrl.kref);
-	if (!schedule_work(&dev->remove_work))
-		nvme_put_ctrl(&dev->ctrl);
-}
-
 static int nvme_reset(struct nvme_dev *dev)
 {
 	if (!dev->ctrl.admin_q || blk_queue_dying(dev->ctrl.admin_q))
@@ -2115,6 +2104,11 @@ static void nvme_shutdown(struct pci_dev *pdev)
 	nvme_dev_disable(dev, true);
 }
 
+/*
+ * The driver's remove may be called on a device in a partially initialized
+ * state. This function must not have any dependencies on the device state in
+ * order to proceed.
+ */
 static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-- 
2.6.2.307.g37023ba
