From: keith.busch@intel.com (Keith Busch)
Date: Wed, 20 Feb 2013 16:52:44 -0700
Subject: [PATCH 7/8] NVMe: Automatically reset failed controller
In-Reply-To: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
References: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
Message-ID: <1361404365-18982-7-git-send-email-keith.busch@intel.com>

An nvme controller may indicate it is failed and requires a reset by
setting its CSTS.CFS register to 1. This patch has the polling thread
check this value and automatically issue the reset when the controller
reports itself as failed.

Also, if the controller fails to return an IO, this will be considered
a failed controller and require a reset. Previously the polling thread
would timeout an IO and free up the resources. This is bad because if the
controller happens to service that command in the future, the resources
the driver allocated for that IO are no longer valid and could result in
the controller accessing memory that is associated with something else,
resulting in memory or data corruption.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |   42 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 0acccc1..120686c 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -58,6 +58,7 @@ module_param(use_threaded_interrupts, int, 0);
 static DEFINE_SPINLOCK(dev_list_lock);
 static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
+static struct workqueue_struct *nvme_workq;
 
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
@@ -82,6 +83,7 @@ struct nvme_dev {
 	u32 max_hw_sectors;
 	struct bio_list bio_list;
 	spinlock_t dev_lock;
+	struct work_struct ws;
 };
 
 /*
@@ -886,7 +888,7 @@ static int nvme_set_features(struct nvme_dev *dev, unsigned fid,
  * @queue: The queue to cancel I/Os on
  * @timeout: True to only cancel I/Os which have timed out
  */
-static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
+static int nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 {
 	int depth = nvmeq->q_depth - 1;
 	struct nvme_cmd_info *info = nvme_cmd_info(nvmeq);
@@ -902,10 +904,15 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 
 		if (timeout && !time_after(now, info[cmdid].timeout))
 			continue;
+		if (timeout)
+			return 1;
+
 		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d\n", cmdid);
 		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
 		fn(nvmeq->dev, ctx, &cqe);
 	}
+
+	return 0;
 }
 
 static void nvme_free_queue_mem(struct nvme_queue *nvmeq)
@@ -1341,6 +1348,12 @@ static int nvme_kthread(void *data)
 		spin_lock(&dev_list_lock);
 		list_for_each_entry(dev, &dev_list, node) {
 			int i;
+			if (readl(&dev->bar->csts) & NVME_CSTS_CFS) {
+				dev_warn(&dev->pci_dev->dev,
+					"failed status, reset controller\n");
+				queue_work(nvme_workq, &dev->ws);
+				continue;
+			}
 			for (i = 0; i < dev->queue_count; i++) {
 				struct nvme_queue *nvmeq = dev->queues[i];
 				if (!nvmeq)
@@ -1348,7 +1361,12 @@ static int nvme_kthread(void *data)
 				spin_lock_irq(&nvmeq->q_lock);
 				if (nvme_process_cq(nvmeq))
 					printk("process_cq did something\n");
-				nvme_cancel_ios(nvmeq, true);
+				if (nvme_cancel_ios(nvmeq, true)) {
+					dev_warn(&dev->pci_dev->dev,
+						"timed out I/O, reset controller\n");
+					queue_work(nvme_workq, &dev->ws);
+					break;
+				}
 				if (i)
 					nvme_resubmit_bios(nvmeq);
 				spin_unlock_irq(&nvmeq->q_lock);
@@ -1778,6 +1796,14 @@ static ssize_t reset_controller(struct device *dev,
 }
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, reset_controller);
 
+static void nvme_reset_failed_dev(struct work_struct *ws)
+{
+	struct nvme_dev *dev = container_of(ws, struct nvme_dev, ws);
+	if (nvme_reset_controller(dev))
+		dev_warn(&dev->pci_dev->dev,
+					"failed to reset failed controller\n");
+}
+
 static int __devinit nvme_probe(struct pci_dev *pdev,
 						const struct pci_device_id *id)
 {
@@ -1830,6 +1856,8 @@ static int __devinit nvme_probe(struct pci_dev *pdev,
 		goto unmap;
 	dev->queue_count++;
 
+	INIT_WORK(&dev->ws, nvme_reset_failed_dev);
+
 	spin_lock(&dev_list_lock);
 	list_add(&dev->node, &dev_list);
 	spin_unlock(&dev_list_lock);
@@ -1955,9 +1983,14 @@ static int __init nvme_init(void)
 	if (IS_ERR(nvme_thread))
 		return PTR_ERR(nvme_thread);
 
+	result = -ENOMEM;
+	nvme_workq = create_workqueue("nvme");
+	if (!nvme_workq)
+		goto kill_kthread;
+
 	result = register_blkdev(nvme_major, "nvme");
 	if (result < 0)
-		goto kill_kthread;
+		goto kill_workq;
 	else if (result > 0)
 		nvme_major = result;
 
@@ -1968,6 +2001,8 @@ static int __init nvme_init(void)
 
  unregister_blkdev:
 	unregister_blkdev(nvme_major, "nvme");
+ kill_workq:
+	destroy_workqueue(nvme_workq);
  kill_kthread:
 	kthread_stop(nvme_thread);
 	return result;
@@ -1977,6 +2012,7 @@ static void __exit nvme_exit(void)
 {
 	pci_unregister_driver(&nvme_driver);
 	unregister_blkdev(nvme_major, "nvme");
+	destroy_workqueue(nvme_workq);
 	kthread_stop(nvme_thread);
 }
 
-- 
1.7.0.4
