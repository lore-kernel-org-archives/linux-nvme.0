From: keith.busch@intel.com (Keith Busch)
Date: Fri,  2 Oct 2015 10:37:29 -0600
Subject: [PATCHv2 2/2] NVMe: Simplify device resume on io queue failure
In-Reply-To: <1443803849-7268-1-git-send-email-keith.busch@intel.com>
References: <1443803849-7268-1-git-send-email-keith.busch@intel.com>
Message-ID: <1443803849-7268-2-git-send-email-keith.busch@intel.com>

Releasing IO queues and disks was done in a work queue outside the
controller resume context to delete namespaces if the controller failed
after a resume from suspend. This is unnecessary since we can resume
a device asynchronously.

This patch makes resume use probe_work so it can directly remove
namespaces if the device is manageable but not IO capable. Since the
deleting disks was the only reason we had the convoluted "reset_workfn",
this patch removes that unnecessary indirection.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1->v2:

  Removed unrelated nvme work_queue changes.

  Merge conflict from the previous commit.

  I'll also point out the new print here should satisfy Jon's case he
  brought up here:

    http://lists.infradead.org/pipermail/linux-nvme/2015-September/002401.html

 drivers/block/nvme-core.c |   34 ++++++----------------------------
 include/linux/nvme.h      |    1 -
 2 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 904b54f..bf35846 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1285,7 +1285,6 @@ static void nvme_abort_req(struct request *req)
 		list_del_init(&dev->node);
 		dev_warn(dev->dev, "I/O %d QID %d timeout, reset controller\n",
 							req->tag, nvmeq->qid);
-		dev->reset_workfn = nvme_reset_failed_dev;
 		queue_work(nvme_workq, &dev->reset_work);
  out:
 		spin_unlock_irqrestore(&dev_list_lock, flags);
@@ -2089,7 +2088,6 @@ static int nvme_kthread(void *data)
 				dev_warn(dev->dev,
 					"Failed status: %x, reset controller\n",
 					readl(&dev->bar->csts));
-				dev->reset_workfn = nvme_reset_failed_dev;
 				queue_work(nvme_workq, &dev->reset_work);
 				continue;
 			}
@@ -3025,14 +3023,6 @@ static int nvme_remove_dead_ctrl(void *arg)
 	return 0;
 }
 
-static void nvme_remove_disks(struct work_struct *ws)
-{
-	struct nvme_dev *dev = container_of(ws, struct nvme_dev, reset_work);
-
-	nvme_free_queues(dev, 1);
-	nvme_dev_remove(dev);
-}
-
 static int nvme_dev_resume(struct nvme_dev *dev)
 {
 	int ret;
@@ -3041,10 +3031,9 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 	if (ret)
 		return ret;
 	if (dev->online_queues < 2) {
-		spin_lock(&dev_list_lock);
-		dev->reset_workfn = nvme_remove_disks;
-		queue_work(nvme_workq, &dev->reset_work);
-		spin_unlock(&dev_list_lock);
+		dev_warn(dev->dev, "IO queues not created\n");
+		nvme_free_queues(dev, 1);
+		nvme_dev_remove(dev);
 	} else {
 		nvme_unfreeze_queues(dev);
 		nvme_dev_add(dev);
@@ -3091,12 +3080,6 @@ static void nvme_reset_failed_dev(struct work_struct *ws)
 	nvme_dev_reset(dev);
 }
 
-static void nvme_reset_workfn(struct work_struct *work)
-{
-	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
-	dev->reset_workfn(work);
-}
-
 static int nvme_reset(struct nvme_dev *dev)
 {
 	int ret = -EBUSY;
@@ -3106,7 +3089,6 @@ static int nvme_reset(struct nvme_dev *dev)
 
 	spin_lock(&dev_list_lock);
 	if (!work_pending(&dev->reset_work)) {
-		dev->reset_workfn = nvme_reset_failed_dev;
 		queue_work(nvme_workq, &dev->reset_work);
 		ret = 0;
 	}
@@ -3159,8 +3141,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto free;
 
 	INIT_LIST_HEAD(&dev->namespaces);
-	dev->reset_workfn = nvme_reset_failed_dev;
-	INIT_WORK(&dev->reset_work, nvme_reset_workfn);
+	INIT_WORK(&dev->reset_work, nvme_reset_failed_dev);
 	dev->dev = get_device(&pdev->dev);
 	pci_set_drvdata(pdev, dev);
 	result = nvme_set_instance(dev);
@@ -3223,7 +3204,7 @@ static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
 	if (prepare)
 		nvme_dev_shutdown(dev);
 	else
-		nvme_dev_resume(dev);
+		schedule_work(&dev->probe_work);
 }
 
 static void nvme_shutdown(struct pci_dev *pdev)
@@ -3277,10 +3258,7 @@ static int nvme_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
-	if (nvme_dev_resume(ndev) && !work_busy(&ndev->reset_work)) {
-		ndev->reset_workfn = nvme_reset_failed_dev;
-		queue_work(nvme_workq, &ndev->reset_work);
-	}
+	schedule_work(&ndev->probe_work);
 	return 0;
 }
 #endif
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 992b9c1..7725b4c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -104,7 +104,6 @@ struct nvme_dev {
 	struct list_head namespaces;
 	struct kref kref;
 	struct device *device;
-	work_func_t reset_workfn;
 	struct work_struct reset_work;
 	struct work_struct probe_work;
 	struct work_struct scan_work;
-- 
1.7.10.4
