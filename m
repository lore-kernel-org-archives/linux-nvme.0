From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Jun 2015 13:36:39 -0600
Subject: [PATCH 1/2] NVMe: Failed controller initialization fixes
Message-ID: <1434656200-32497-1-git-send-email-keith.busch@intel.com>

This fixes an infinite device reset loop that may occur on devices that
fail initialization. If the drive fails to become ready for any reason
that does not involve an admin command timeout, the probe task should
assume the drive is unavailable and remove it from the topology. In
the case an admin command times out during device probing, the driver's
existing reset action will handle removing the drive.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Dependent on these other fixes:

  http://lists.infradead.org/pipermail/linux-nvme/2015-June/001915.html

 drivers/block/nvme-core.c |   33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 318dcdb..9bc0b06 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2930,6 +2930,18 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 	return 0;
 }
 
+static void nvme_dead_ctrl(struct nvme_dev *dev)
+{
+	dev_warn(dev->dev, "Device failed to resume\n");
+	kref_get(&dev->kref);
+	if (IS_ERR(kthread_run(nvme_remove_dead_ctrl, dev, "nvme%d",
+						dev->instance))) {
+		dev_err(dev->dev,
+			"Failed to start controller remove task\n");
+		kref_put(&dev->kref, nvme_free_dev);
+	}
+}
+
 static void nvme_dev_reset(struct nvme_dev *dev)
 {
 	bool in_probe = work_busy(&dev->probe_work);
@@ -2943,14 +2955,7 @@ static void nvme_dev_reset(struct nvme_dev *dev)
 	/* Fail this device if reset occured during probe to avoid
 	 * infinite initialization loops. */
 	if (in_probe) {
-		dev_warn(dev->dev, "Device failed to resume\n");
-		kref_get(&dev->kref);
-		if (IS_ERR(kthread_run(nvme_remove_dead_ctrl, dev, "nvme%d",
-							dev->instance))) {
-			dev_err(dev->dev,
-				"Failed to start controller remove task\n");
-			kref_put(&dev->kref, nvme_free_dev);
-		}
+		nvme_dead_ctrl(dev);
 		return;
 	}
 	/* Schedule device resume asynchronously so the reset work is available
@@ -3085,16 +3090,8 @@ static void nvme_async_probe(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, probe_work);
 
-	if (nvme_dev_resume(dev))
-		goto reset;
-	return;
- reset:
-	spin_lock(&dev_list_lock);
-	if (!work_busy(&dev->reset_work)) {
-		dev->reset_workfn = nvme_reset_failed_dev;
-		queue_work(nvme_workq, &dev->reset_work);
-	}
-	spin_unlock(&dev_list_lock);
+	if (nvme_dev_resume(dev) && !work_busy(&dev->reset_work))
+		nvme_dead_ctrl(dev);
 }
 
 static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
-- 
1.7.10.4
