From: keith.busch@intel.com (Keith Busch)
Date: Mon,  8 Jun 2015 10:08:15 -0600
Subject: [PATCH 3/3] NVMe: Unify controller probe and resume
In-Reply-To: <1433779695-15866-1-git-send-email-keith.busch@intel.com>
References: <1433779695-15866-1-git-send-email-keith.busch@intel.com>
Message-ID: <1433779695-15866-4-git-send-email-keith.busch@intel.com>

This unifies probe and resume so they both may be scheduled in the same
way. This is necessary for error handling that may occur during device
initialization since the task to cleanup the device wouldn't be able to
run if it is blocked on device initialization.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   52 +++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 52742d4..326abff 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2360,19 +2360,20 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	}
 	kfree(ctrl);
 
-	dev->tagset.ops = &nvme_mq_ops;
-	dev->tagset.nr_hw_queues = dev->online_queues - 1;
-	dev->tagset.timeout = NVME_IO_TIMEOUT;
-	dev->tagset.numa_node = dev_to_node(dev->dev);
-	dev->tagset.queue_depth =
+	if (!dev->tagset.tags) {
+		dev->tagset.ops = &nvme_mq_ops;
+		dev->tagset.nr_hw_queues = dev->online_queues - 1;
+		dev->tagset.timeout = NVME_IO_TIMEOUT;
+		dev->tagset.numa_node = dev_to_node(dev->dev);
+		dev->tagset.queue_depth =
 				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
-	dev->tagset.cmd_size = nvme_cmd_size(dev);
-	dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
-	dev->tagset.driver_data = dev;
-
-	if (blk_mq_alloc_tag_set(&dev->tagset))
-		return 0;
+		dev->tagset.cmd_size = nvme_cmd_size(dev);
+		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
+		dev->tagset.driver_data = dev;
 
+		if (blk_mq_alloc_tag_set(&dev->tagset))
+			return 0;
+	}
 	schedule_work(&dev->scan_work);
 	return 0;
 }
@@ -2923,7 +2924,7 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 		spin_unlock(&dev_list_lock);
 	} else {
 		nvme_unfreeze_queues(dev);
-		schedule_work(&dev->scan_work);
+		nvme_dev_add(dev);
 		nvme_set_irq_hints(dev);
 	}
 	return 0;
@@ -2931,8 +2932,17 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 
 static void nvme_dev_reset(struct nvme_dev *dev)
 {
+	bool in_probe = work_busy(&dev->probe_work);
+
 	nvme_dev_shutdown(dev);
-	if (nvme_dev_resume(dev)) {
+
+	/* Synchronize with device probe so that work will see failure status
+	 * and exit gracefully without trying to schedule another reset */
+	flush_work(&dev->probe_work);
+
+	/* Fail this device if reset occured during probe to avoid
+	 * infinite initialization loops. */
+	if (in_probe) {
 		dev_warn(dev->dev, "Device failed to resume\n");
 		kref_get(&dev->kref);
 		if (IS_ERR(kthread_run(nvme_remove_dead_ctrl, dev, "nvme%d",
@@ -2941,7 +2951,11 @@ static void nvme_dev_reset(struct nvme_dev *dev)
 				"Failed to start controller remove task\n");
 			kref_put(&dev->kref, nvme_free_dev);
 		}
+		return;
 	}
+	/* Schedule device resume asynchronously so the reset work is available
+	 * to cleanup errors that may occur during reinitialization */
+	schedule_work(&dev->probe_work);
 }
 
 static void nvme_reset_failed_dev(struct work_struct *ws)
@@ -2973,6 +2987,7 @@ static int nvme_reset(struct nvme_dev *dev)
 
 	if (!ret) {
 		flush_work(&dev->reset_work);
+		flush_work(&dev->probe_work);
 		return 0;
 	}
 
@@ -3069,18 +3084,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void nvme_async_probe(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, probe_work);
-	int result;
-
-	result = nvme_dev_start(dev);
-	if (result)
-		goto reset;
 
-	if (dev->online_queues > 1)
-		result = nvme_dev_add(dev);
-	if (result)
+	if (nvme_dev_resume(dev))
 		goto reset;
-
-	nvme_set_irq_hints(dev);
 	return;
  reset:
 	spin_lock(&dev_list_lock);
-- 
1.7.10.4
