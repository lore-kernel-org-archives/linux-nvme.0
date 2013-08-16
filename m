From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Aug 2013 16:00:28 -0600
Subject: [PATCHv2 1/5] NVMe: Reset failed controller
In-Reply-To: <1376690432-9775-1-git-send-email-keith.busch@intel.com>
References: <1376690432-9775-1-git-send-email-keith.busch@intel.com>
Message-ID: <1376690432-9775-2-git-send-email-keith.busch@intel.com>

Polls on the controller fatal status bit and resets the controller per
the nvme spec on this condition.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1->v2:

Fixed clean-up on module unload to delete the work queue.

I have a question on this: should we use the predefined kernel work
queue instead of making our own? The shutdown sequence can block for a
while on which is why I have a workqueue_struct for the module.

 drivers/block/nvme-core.c |   31 ++++++++++++++++++++++++++++++-
 include/linux/nvme.h      |    1 +
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 608b0a7..5713dd2 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -58,6 +58,7 @@ module_param(use_threaded_interrupts, int, 0);
 static DEFINE_SPINLOCK(dev_list_lock);
 static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
+static struct workqueue_struct *nvme_workq;
 
 /*
  * An NVM Express queue.  Each device has at least two (one for admin
@@ -1605,6 +1606,12 @@ static int nvme_kthread(void *data)
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
@@ -2151,6 +2158,19 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	return result;
 }
 
+static void nvme_dev_reset(struct nvme_dev *dev)
+{
+	nvme_dev_shutdown(dev);
+	if (nvme_dev_start(dev))
+		nvme_free_queues(dev);
+}
+
+static void nvme_reset_failed_dev(struct work_struct *ws)
+{
+	struct nvme_dev *dev = container_of(ws, struct nvme_dev, ws);
+	nvme_dev_reset(dev);
+}
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int result = -ENOMEM;
@@ -2178,6 +2198,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release;
 
+	INIT_WORK(&dev->ws, nvme_reset_failed_dev);
 	result = nvme_dev_start(dev);
 	if (result)
 		goto release_pools;
@@ -2288,9 +2309,14 @@ static int __init nvme_init(void)
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
 
@@ -2301,6 +2327,8 @@ static int __init nvme_init(void)
 
  unregister_blkdev:
 	unregister_blkdev(nvme_major, "nvme");
+ kill_workq:
+	destroy_workqueue(nvme_workq);
  kill_kthread:
 	kthread_stop(nvme_thread);
 	return result;
@@ -2310,6 +2338,7 @@ static void __exit nvme_exit(void)
 {
 	pci_unregister_driver(&nvme_driver);
 	unregister_blkdev(nvme_major, "nvme");
+	destroy_workqueue(nvme_workq);
 	kthread_stop(nvme_thread);
 }
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 26ebcf4..612e640 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -87,6 +87,7 @@ struct nvme_dev {
 	struct list_head namespaces;
 	struct kref kref;
 	struct miscdevice miscdev;
+	struct work_struct ws;
 	char name[12];
 	char serial[20];
 	char model[40];
-- 
1.7.10.4
