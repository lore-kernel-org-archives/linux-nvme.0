From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 13:05:44 -0700
Subject: [PATCHv2-4.5 07/10] NVMe: Simplify device reset failure
In-Reply-To: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455221147-24228-8-git-send-email-keith.busch@intel.com>

A reset failure schedules the device to unbind from the driver through
the pci driver's 'remove'. This already cleans up all intialization
from a partial or completed state, so there is no need to duplicate the
cleanup that could potentially race with a pci hot removal.

To help understand why a reset failed, the status is logged with the
existing warning message.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/pci.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 09cc4da..9e1be57 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -86,7 +86,6 @@ struct nvme_queue;
 
 static int nvme_reset(struct nvme_dev *dev);
 static void nvme_process_cq(struct nvme_queue *nvmeq);
-static void nvme_remove_dead_ctrl(struct nvme_dev *dev);
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 
 /*
@@ -1899,10 +1898,19 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
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
@@ -1922,26 +1930,26 @@ static void nvme_reset_work(struct work_struct *work)
 
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
@@ -1958,19 +1966,8 @@ static void nvme_reset_work(struct work_struct *work)
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
@@ -1983,14 +1980,6 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
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
@@ -2112,6 +2101,11 @@ static void nvme_shutdown(struct pci_dev *pdev)
 	nvme_dev_disable(dev, true);
 }
 
+/*
+ * The driver's remove may be called on a device in a partially initialized
+ * state. This function must not have any dependencies on the init state in
+ * order to proceed, and may even execute while initiazation is in progress.
+ */
 static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-- 
2.6.2.307.g37023ba
