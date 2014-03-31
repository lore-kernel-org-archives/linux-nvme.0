From: daniel.mcleran@intel.com (Dan McLeran)
Date: Mon, 31 Mar 2014 14:52:11 -0600
Subject: [PATCH] NVMe: Start-stop thread during device add-remove.
Message-ID: <1396299131-17979-1-git-send-email-daniel.mcleran@intel.com>

Move starting/stopping the nvme polling kthread from the module_init/exit
path to device add/remove so we don't have a kthread running when no
devices are being polled.

Signed-off-by: Dan McLeran <daniel.mcleran at intel.com>
---
 drivers/block/nvme-core.c |   57 +++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 51824d1..1d6f80a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -58,6 +58,7 @@ static DEFINE_SPINLOCK(dev_list_lock);
 static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
 static struct workqueue_struct *nvme_workq;
+static wait_queue_head_t nvme_kthread_wait;
 
 static void nvme_reset_failed_dev(struct work_struct *ws);
 
@@ -2193,15 +2194,33 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 	kthread_stop(kworker_task);
 }
 
+/*
+* Remove the node from the device list and check
+* for whether or not we need to stop the nvme_thread.
+*/
+static void nvme_dev_list_remove(struct nvme_dev *dev)
+{
+	struct task_struct *tmp = NULL;
+
+	spin_lock(&dev_list_lock);
+	list_del_init(&dev->node);
+	if (list_empty(&dev_list) && !IS_ERR_OR_NULL(nvme_thread)) {
+		tmp = nvme_thread;
+		nvme_thread = NULL;
+	}
+	spin_unlock(&dev_list_lock);
+
+	if (tmp)
+		kthread_stop(tmp);
+}
+
 static void nvme_dev_shutdown(struct nvme_dev *dev)
 {
 	int i;
 
 	dev->initialized = 0;
 
-	spin_lock(&dev_list_lock);
-	list_del_init(&dev->node);
-	spin_unlock(&dev_list_lock);
+	nvme_dev_list_remove(dev);
 
 	if (!dev->bar || (dev->bar && readl(&dev->bar->csts) == -1)) {
 		for (i = dev->queue_count - 1; i >= 0; i--) {
@@ -2341,6 +2360,7 @@ static const struct file_operations nvme_dev_fops = {
 static int nvme_dev_start(struct nvme_dev *dev)
 {
 	int result;
+	bool start_thread = false;
 
 	result = nvme_dev_map(dev);
 	if (result)
@@ -2351,9 +2371,24 @@ static int nvme_dev_start(struct nvme_dev *dev)
 		goto unmap;
 
 	spin_lock(&dev_list_lock);
+	if (list_empty(&dev_list) && IS_ERR_OR_NULL(nvme_thread)) {
+		start_thread = true;
+		nvme_thread = NULL;
+	}
 	list_add(&dev->node, &dev_list);
 	spin_unlock(&dev_list_lock);
 
+	if (start_thread) {
+		nvme_thread = kthread_run(nvme_kthread, NULL, "nvme");
+		wake_up(&nvme_kthread_wait);
+	} else
+		wait_event_killable(nvme_kthread_wait, nvme_thread);
+
+	if (IS_ERR_OR_NULL(nvme_thread)) {
+		result = nvme_thread ? PTR_ERR(nvme_thread) : -EINTR;
+		goto disable;
+	}
+
 	result = nvme_setup_io_queues(dev);
 	if (result && result != -EBUSY)
 		goto disable;
@@ -2362,9 +2397,7 @@ static int nvme_dev_start(struct nvme_dev *dev)
 
  disable:
 	nvme_disable_queue(dev, 0);
-	spin_lock(&dev_list_lock);
-	list_del_init(&dev->node);
-	spin_unlock(&dev_list_lock);
+	nvme_dev_list_remove(dev);
  unmap:
 	nvme_dev_unmap(dev);
 	return result;
@@ -2594,14 +2627,10 @@ static int __init nvme_init(void)
 {
 	int result;
 
-	nvme_thread = kthread_run(nvme_kthread, NULL, "nvme");
-	if (IS_ERR(nvme_thread))
-		return PTR_ERR(nvme_thread);
-
-	result = -ENOMEM;
+	init_waitqueue_head(&nvme_kthread_wait);
 	nvme_workq = create_singlethread_workqueue("nvme");
 	if (!nvme_workq)
-		goto kill_kthread;
+		return -ENOMEM;
 
 	result = register_blkdev(nvme_major, "nvme");
 	if (result < 0)
@@ -2618,8 +2647,6 @@ static int __init nvme_init(void)
 	unregister_blkdev(nvme_major, "nvme");
  kill_workq:
 	destroy_workqueue(nvme_workq);
- kill_kthread:
-	kthread_stop(nvme_thread);
 	return result;
 }
 
@@ -2628,7 +2655,7 @@ static void __exit nvme_exit(void)
 	pci_unregister_driver(&nvme_driver);
 	unregister_blkdev(nvme_major, "nvme");
 	destroy_workqueue(nvme_workq);
-	kthread_stop(nvme_thread);
+	BUG_ON(nvme_thread && !IS_ERR(nvme_thread));
 }
 
 MODULE_AUTHOR("Matthew Wilcox <willy at linux.intel.com>");
-- 
1.7.10.4
