From: keith.busch@intel.com (Keith Busch)
Date: Thu,  1 Oct 2015 17:14:11 -0600
Subject: [PATCH 2/2] NVMe: Simplify device resume on io queue failure
In-Reply-To: <1443741251-13274-1-git-send-email-keith.busch@intel.com>
References: <1443741251-13274-1-git-send-email-keith.busch@intel.com>
Message-ID: <1443741251-13274-3-git-send-email-keith.busch@intel.com>

Releasing io queues and disks was done in a work queue separate from
the controller resumption task to handle failed drives after a resume
from suspend. This is not necesssary since we can resume a device
asynchronously the same as probe.

This patch makes resume use the probe work, and this lets the task delete
gendisks directly if the device is managable but not io capable. Since
deleting disks was the only reason we had the convoluted "reset_workfn",
this patch removes the unnecessary indirection, and places all work
tasks onto the global work queue.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   51 ++++++++++-----------------------------------
 include/linux/nvme.h      |    1 -
 2 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b02ae3d..81b42078 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -79,7 +79,6 @@ MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 static DEFINE_SPINLOCK(dev_list_lock);
 static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
-static struct workqueue_struct *nvme_workq;
 static wait_queue_head_t nvme_kthread_wait;
 
 static struct class *nvme_class;
@@ -1285,8 +1284,7 @@ static void nvme_abort_req(struct request *req)
 		list_del_init(&dev->node);
 		dev_warn(dev->dev, "I/O %d QID %d timeout, reset controller\n",
 							req->tag, nvmeq->qid);
-		dev->reset_workfn = nvme_reset_failed_dev;
-		queue_work(nvme_workq, &dev->reset_work);
+		schedule_work(&dev->reset_work);
  out:
 		spin_unlock_irqrestore(&dev_list_lock, flags);
 		return;
@@ -2095,8 +2093,7 @@ static int nvme_kthread(void *data)
 				dev_warn(dev->dev,
 					"Failed status: %x, reset controller\n",
 					readl(&dev->bar->csts));
-				dev->reset_workfn = nvme_reset_failed_dev;
-				queue_work(nvme_workq, &dev->reset_work);
+				schedule_work(&dev->reset_work);
 				continue;
 			}
 			for (i = 0; i < dev->queue_count; i++) {
@@ -3047,14 +3044,6 @@ static int nvme_remove_dead_ctrl(void *arg)
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
@@ -3063,10 +3052,10 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 	if (ret)
 		return ret;
 	if (dev->online_queues < 2) {
-		spin_lock(&dev_list_lock);
-		dev->reset_workfn = nvme_remove_disks;
-		queue_work(nvme_workq, &dev->reset_work);
-		spin_unlock(&dev_list_lock);
+		dev_warn(dev->dev, "no io queues created\n");
+		nvme_free_queues(dev, 1);
+		nvme_dev_remove(dev);
+		nvme_free_namespaces(dev);
 	} else {
 		nvme_unfreeze_queues(dev);
 		nvme_dev_add(dev);
@@ -3113,12 +3102,6 @@ static void nvme_reset_failed_dev(struct work_struct *ws)
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
@@ -3128,8 +3111,7 @@ static int nvme_reset(struct nvme_dev *dev)
 
 	spin_lock(&dev_list_lock);
 	if (!work_pending(&dev->reset_work)) {
-		dev->reset_workfn = nvme_reset_failed_dev;
-		queue_work(nvme_workq, &dev->reset_work);
+		schedule_work(&dev->reset_work);
 		ret = 0;
 	}
 	spin_unlock(&dev_list_lock);
@@ -3181,8 +3163,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto free;
 
 	INIT_LIST_HEAD(&dev->namespaces);
-	dev->reset_workfn = nvme_reset_failed_dev;
-	INIT_WORK(&dev->reset_work, nvme_reset_workfn);
+	INIT_WORK(&dev->reset_work, nvme_reset_failed_dev);
 	dev->dev = get_device(&pdev->dev);
 	pci_set_drvdata(pdev, dev);
 	result = nvme_set_instance(dev);
@@ -3245,7 +3226,7 @@ static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
 	if (prepare)
 		nvme_dev_shutdown(dev);
 	else
-		nvme_dev_resume(dev);
+		schedule_work(&dev->probe_work);
 }
 
 static void nvme_shutdown(struct pci_dev *pdev)
@@ -3299,10 +3280,7 @@ static int nvme_resume(struct device *dev)
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
@@ -3345,13 +3323,9 @@ static int __init nvme_init(void)
 
 	init_waitqueue_head(&nvme_kthread_wait);
 
-	nvme_workq = create_singlethread_workqueue("nvme");
-	if (!nvme_workq)
-		return -ENOMEM;
-
 	result = register_blkdev(nvme_major, "nvme");
 	if (result < 0)
-		goto kill_workq;
+		return result;
 	else if (result > 0)
 		nvme_major = result;
 
@@ -3379,8 +3353,6 @@ static int __init nvme_init(void)
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
  unregister_blkdev:
 	unregister_blkdev(nvme_major, "nvme");
- kill_workq:
-	destroy_workqueue(nvme_workq);
 	return result;
 }
 
@@ -3388,7 +3360,6 @@ static void __exit nvme_exit(void)
 {
 	pci_unregister_driver(&nvme_driver);
 	unregister_blkdev(nvme_major, "nvme");
-	destroy_workqueue(nvme_workq);
 	class_destroy(nvme_class);
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
 	BUG_ON(nvme_thread && !IS_ERR(nvme_thread));
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
