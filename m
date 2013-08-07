From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Aug 2013 14:44:46 -0600
Subject: [PATCH 1/2] NVMe: Reset failed controller
In-Reply-To: <1375908287-18884-1-git-send-email-keith.busch@intel.com>
References: <1375908287-18884-1-git-send-email-keith.busch@intel.com>
Message-ID: <1375908287-18884-2-git-send-email-keith.busch@intel.com>

Polls on the controller fatal status bit and resets the controller per
the nvme spec on this condition.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   30 +++++++++++++++++++++++++++++-
 include/linux/nvme.h      |    1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 52cf479..f401e2b 100644
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
-		goto kill_thread;
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
