From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 14:03:40 +0200
Subject: [PATCH 8/9] nvme: remove dead controllers from a work item
In-Reply-To: <1445515421-4940-1-git-send-email-hch@lst.de>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
Message-ID: <1445515421-4940-9-git-send-email-hch@lst.de>

Compared to the kthread this gives us multiple call prevention for free.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 696749d..e1fe093 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -77,7 +77,7 @@ struct nvme_queue;
 
 static int nvme_reset(struct nvme_dev *dev);
 static int nvme_process_cq(struct nvme_queue *nvmeq);
-static void nvme_dead_ctrl(struct nvme_dev *dev);
+static void nvme_remove_dead_ctrl(struct nvme_dev *dev);
 
 struct async_cmd_info {
 	struct kthread_work work;
@@ -110,6 +110,7 @@ struct nvme_dev {
 	void __iomem *bar;
 	struct work_struct reset_work;
 	struct work_struct scan_work;
+	struct work_struct remove_work;
 	bool subsystem;
 	u32 page_size;
 	void __iomem *cmb;
@@ -2193,7 +2194,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 * initialization loops.
 	 */
 	if (test_bit(NVME_CTRL_RESETTING, &dev->flags)) {
-		nvme_dead_ctrl(dev);
+		nvme_remove_dead_ctrl(dev);
 		return;
 	}
 
@@ -2260,31 +2261,25 @@ static void nvme_reset_work(struct work_struct *work)
  unmap:
 	nvme_dev_unmap(dev);
  out:
-	if (!work_pending(&dev->reset_work))
-		nvme_dead_ctrl(dev);
+	nvme_remove_dead_ctrl(dev);
 }
 
-static int nvme_remove_dead_ctrl(void *arg)
+static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 {
-	struct nvme_dev *dev = (struct nvme_dev *)arg;
+	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	if (pci_get_drvdata(pdev))
 		pci_stop_and_remove_bus_device_locked(pdev);
 	nvme_put_ctrl(&dev->ctrl);
-	return 0;
 }
 
-static void nvme_dead_ctrl(struct nvme_dev *dev)
+static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 {
-	dev_warn(dev->dev, "Device failed to resume\n");
+	dev_warn(dev->dev, "Removing after probe failure\n");
 	kref_get(&dev->ctrl.kref);
-	if (IS_ERR(kthread_run(nvme_remove_dead_ctrl, dev, "nvme%d",
-						dev->ctrl.instance))) {
-		dev_err(dev->dev,
-			"Failed to start controller remove task\n");
+	if (!schedule_work(&dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
-	}
 }
 
 static int nvme_reset(struct nvme_dev *dev)
@@ -2365,6 +2360,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_LIST_HEAD(&dev->node);
 	INIT_WORK(&dev->scan_work, nvme_dev_scan);
 	INIT_WORK(&dev->reset_work, nvme_reset_work);
+	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
-- 
1.9.1
