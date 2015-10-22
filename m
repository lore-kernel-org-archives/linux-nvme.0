From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 14:03:39 +0200
Subject: [PATCH 7/9] nvme: merge probe_work and reset_work
In-Reply-To: <1445515421-4940-1-git-send-email-hch@lst.de>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
Message-ID: <1445515421-4940-8-git-send-email-hch@lst.de>

If we're using two work queues we're always going to run into races where
one item is tearing down what the other one is initializing.  So insted
merge the two work queues, and let the old probe_work also tear the
controller down first if it was alive.  Togethe with the better detection
of the probe path using a flag this gives us a properly serialized
reset/probe path that also doesn't accidentally trigger when two command
time out and the second one tries to reset the controller while the first
reset is still in progress.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 59 ++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 73d015d..696749d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -109,7 +109,6 @@ struct nvme_dev {
 	struct msix_entry *entry;
 	void __iomem *bar;
 	struct work_struct reset_work;
-	struct work_struct probe_work;
 	struct work_struct scan_work;
 	bool subsystem;
 	u32 page_size;
@@ -117,6 +116,8 @@ struct nvme_dev {
 	dma_addr_t cmb_dma_addr;
 	u64 cmb_size;
 	u32 cmbsz;
+	unsigned long flags;
+#define NVME_CTRL_RESETTING	0
 
 	struct nvme_ctrl ctrl;
 };
@@ -2182,11 +2183,29 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	kfree(dev);
 }
 
-static void nvme_probe_work(struct work_struct *work)
+static void nvme_reset_work(struct work_struct *work)
 {
-	struct nvme_dev *dev = container_of(work, struct nvme_dev, probe_work);
+	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
 	int result;
 
+	/*
+	 * Fail this device if reset occured during probe to avoid infinite
+	 * initialization loops.
+	 */
+	if (test_bit(NVME_CTRL_RESETTING, &dev->flags)) {
+		nvme_dead_ctrl(dev);
+		return;
+	}
+
+	/*
+	 * If we're called to reset a live controller first shut it down before
+	 * moving on.
+	 */
+	if (dev->bar)
+		nvme_dev_shutdown(dev);
+
+	set_bit(NVME_CTRL_RESETTING, &dev->flags);
+
 	result = nvme_dev_map(dev);
 	if (result)
 		goto out;
@@ -2226,6 +2245,7 @@ static void nvme_probe_work(struct work_struct *work)
 		nvme_dev_add(dev);
 	}
 
+	clear_bit(NVME_CTRL_RESETTING, &dev->flags);
 	return;
 
  remove:
@@ -2240,7 +2260,7 @@ static void nvme_probe_work(struct work_struct *work)
  unmap:
 	nvme_dev_unmap(dev);
  out:
-	if (!work_busy(&dev->reset_work))
+	if (!work_pending(&dev->reset_work))
 		nvme_dead_ctrl(dev);
 }
 
@@ -2267,28 +2287,6 @@ static void nvme_dead_ctrl(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_reset_work(struct work_struct *ws)
-{
-	struct nvme_dev *dev = container_of(ws, struct nvme_dev, reset_work);
-	bool in_probe = work_busy(&dev->probe_work);
-
-	nvme_dev_shutdown(dev);
-
-	/* Synchronize with device probe so that work will see failure status
-	 * and exit gracefully without trying to schedule another reset */
-	flush_work(&dev->probe_work);
-
-	/* Fail this device if reset occured during probe to avoid
-	 * infinite initialization loops. */
-	if (in_probe) {
-		nvme_dead_ctrl(dev);
-		return;
-	}
-	/* Schedule device resume asynchronously so the reset work is available
-	 * to cleanup errors that may occur during reinitialization */
-	schedule_work(&dev->probe_work);
-}
-
 static int nvme_reset(struct nvme_dev *dev)
 {
 	if (!dev->ctrl.admin_q || blk_queue_dying(dev->ctrl.admin_q))
@@ -2298,7 +2296,6 @@ static int nvme_reset(struct nvme_dev *dev)
 		return -EBUSY;
 
 	flush_work(&dev->reset_work);
-	flush_work(&dev->probe_work);
 	return 0;
 }
 
@@ -2367,7 +2364,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	INIT_LIST_HEAD(&dev->node);
 	INIT_WORK(&dev->scan_work, nvme_dev_scan);
-	INIT_WORK(&dev->probe_work, nvme_probe_work);
 	INIT_WORK(&dev->reset_work, nvme_reset_work);
 
 	result = nvme_setup_prp_pools(dev);
@@ -2379,7 +2375,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release_pools;
 
-	schedule_work(&dev->probe_work);
+	schedule_work(&dev->reset_work);
 	return 0;
 
  release_pools:
@@ -2400,7 +2396,7 @@ static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
 	if (prepare)
 		nvme_dev_shutdown(dev);
 	else
-		schedule_work(&dev->probe_work);
+		schedule_work(&dev->reset_work);
 }
 
 static void nvme_shutdown(struct pci_dev *pdev)
@@ -2418,7 +2414,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	spin_unlock(&dev_list_lock);
 
 	pci_set_drvdata(pdev, NULL);
-	flush_work(&dev->probe_work);
 	flush_work(&dev->reset_work);
 	flush_work(&dev->scan_work);
 	nvme_remove_namespaces(&dev->ctrl);
@@ -2452,7 +2447,7 @@ static int nvme_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
-	schedule_work(&ndev->probe_work);
+	schedule_work(&ndev->reset_work);
 	return 0;
 }
 #endif
-- 
1.9.1
