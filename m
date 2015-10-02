From: hch@lst.de (Christoph Hellwig)
Date: Fri,  2 Oct 2015 19:58:19 +0200
Subject: [PATCH 7/7] nvme: remove failed controllers directly from probe/reset
 context
In-Reply-To: <1443808699-4738-1-git-send-email-hch@lst.de>
References: <1443808699-4738-1-git-send-email-hch@lst.de>
Message-ID: <1443808699-4738-8-git-send-email-hch@lst.de>

Now that all probing and resets happen from workqueue context we can remove
the controller directly without any risk of deadlocking.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 48688d6..39c40bb 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -87,7 +87,6 @@ static struct class *nvme_class;
 static int __nvme_reset(struct nvme_dev *dev);
 static int nvme_reset(struct nvme_dev *dev);
 static int nvme_process_cq(struct nvme_queue *nvmeq);
-static void nvme_dead_ctrl(struct nvme_dev *dev);
 
 struct async_cmd_info {
 	struct kthread_work work;
@@ -2960,6 +2959,15 @@ static void nvme_set_irq_hints(struct nvme_dev *dev)
 	}
 }
 
+static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	dev_warn(dev->dev, "Device failed to start.\n");
+
+	if (pci_get_drvdata(pdev))
+		pci_stop_and_remove_bus_device_locked(pdev);
+}
 
 static void nvme_probe_work(struct work_struct *work)
 {
@@ -3033,30 +3041,7 @@ static void nvme_probe_work(struct work_struct *work)
 	nvme_dev_unmap(dev);
  out:
 	if (!work_busy(&dev->reset_work))
-		nvme_dead_ctrl(dev);
-}
-
-static int nvme_remove_dead_ctrl(void *arg)
-{
-	struct nvme_dev *dev = (struct nvme_dev *)arg;
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
-
-	if (pci_get_drvdata(pdev))
-		pci_stop_and_remove_bus_device_locked(pdev);
-	kref_put(&dev->kref, nvme_free_dev);
-	return 0;
-}
-
-static void nvme_dead_ctrl(struct nvme_dev *dev)
-{
-	dev_warn(dev->dev, "Device failed to resume\n");
-	kref_get(&dev->kref);
-	if (IS_ERR(kthread_run(nvme_remove_dead_ctrl, dev, "nvme%d",
-						dev->instance))) {
-		dev_err(dev->dev,
-			"Failed to start controller remove task\n");
-		kref_put(&dev->kref, nvme_free_dev);
-	}
+		nvme_remove_dead_ctrl(dev);
 }
 
 static void nvme_reset_work(struct work_struct *ws)
@@ -3073,7 +3058,7 @@ static void nvme_reset_work(struct work_struct *ws)
 	/* Fail this device if reset occured during probe to avoid
 	 * infinite initialization loops. */
 	if (in_probe) {
-		nvme_dead_ctrl(dev);
+		nvme_remove_dead_ctrl(dev);
 		return;
 	}
 	/* Schedule device resume asynchronously so the reset work is available
-- 
1.9.1
