From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 Oct 2013 11:53:52 -0600
Subject: [PATCHv2 1/2] NVMe: Reset failed controller
In-Reply-To: <1382637233-26017-1-git-send-email-keith.busch@intel.com>
References: <1382637233-26017-1-git-send-email-keith.busch@intel.com>
Message-ID: <1382637233-26017-2-git-send-email-keith.busch@intel.com>

Polls on the controller fatal status bit and resets the controller per
the nvme spec if controller is failed. The controller reset is done only
if the device has completed initialization.

If the controller fails to start after attempting to reset it, the pci
driver will be removed since the controller is not usuable.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   75 ++++++++++++++++++++++++++++++++++++++-------
 include/linux/nvme.h      |    2 ++
 2 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index da52092..a278d19 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -58,6 +58,7 @@ module_param(use_threaded_interrupts, int, 0);
 static DEFINE_SPINLOCK(dev_list_lock);
 static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
+static struct workqueue_struct *nvme_workq;
 
 /*
  * An NVM Express queue.  Each device has at least two (one for admin
@@ -1596,13 +1597,22 @@ static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
 
 static int nvme_kthread(void *data)
 {
-	struct nvme_dev *dev;
+	struct nvme_dev *dev, *next;
 
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		spin_lock(&dev_list_lock);
-		list_for_each_entry(dev, &dev_list, node) {
+		list_for_each_entry_safe(dev, next, &dev_list, node) {
 			int i;
+			if (readl(&dev->bar->csts) & NVME_CSTS_CFS) {
+				if (dev->is_initialised) {
+					dev_warn(&dev->pci_dev->dev,
+						"failed status, reset controller\n");
+					list_del_init(&dev->node);
+					queue_work(nvme_workq, &dev->ws);
+					continue;
+				}
+			}
 			for (i = 0; i < dev->queue_count; i++) {
 				struct nvme_queue *nvmeq = dev->queues[i];
 				if (!nvmeq)
@@ -1983,9 +1993,8 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 	if (dev->bar) {
 		iounmap(dev->bar);
 		dev->bar = NULL;
+		pci_release_regions(dev->pci_dev);
 	}
-
-	pci_release_regions(dev->pci_dev);
 	if (pci_is_enabled(dev->pci_dev))
 		pci_disable_device(dev->pci_dev);
 }
@@ -1994,6 +2003,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 {
 	int i;
 
+	dev->is_initialised = 0;
 	for (i = dev->queue_count - 1; i >= 0; i--)
 		nvme_disable_queue(dev, i);
 
@@ -2149,6 +2159,44 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	return result;
 }
 
+static int nvme_dev_resume(struct nvme_dev *dev)
+{
+	int i, ret = nvme_dev_start(dev);
+
+	if (ret && ret != -EBUSY) {
+		dev_warn(&dev->pci_dev->dev, "controller failed to resume\n");
+		pci_stop_and_remove_bus_device(dev->pci_dev);
+		return ret;
+	}
+	if (ret == -EBUSY) {
+		/*
+		 * Device enabled but unable to perform IO; free IO queues and
+		 * block devices.
+		 */
+		for (i = dev->queue_count - 1; i > 0; i--) {
+			nvme_free_queue(dev->queues[i]);
+			dev->queue_count--;
+			dev->queues[i] = NULL;
+		}
+		nvme_dev_remove(dev);
+	}
+
+	dev->is_initialised = 1;
+	return 0;
+}
+
+static void nvme_dev_reset(struct nvme_dev *dev)
+{
+	nvme_dev_shutdown(dev);
+	nvme_dev_resume(dev);
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
@@ -2176,6 +2224,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release;
 
+	INIT_WORK(&dev->ws, nvme_reset_failed_dev);
 	result = nvme_dev_start(dev);
 	if (result) {
 		if (result == -EBUSY)
@@ -2198,6 +2247,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto remove;
 
 	kref_init(&dev->kref);
+	dev->is_initialised = 1;
 	return 0;
 
  remove:
@@ -2243,13 +2293,8 @@ static int nvme_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
-	int ret;
 
-	ret = nvme_dev_start(ndev);
-	/* XXX: should remove gendisks if resume fails */
-	if (ret)
-		nvme_free_queues(ndev);
-	return ret;
+	return nvme_dev_resume(ndev);
 }
 
 static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
@@ -2290,9 +2335,14 @@ static int __init nvme_init(void)
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
 
@@ -2303,6 +2353,8 @@ static int __init nvme_init(void)
 
  unregister_blkdev:
 	unregister_blkdev(nvme_major, "nvme");
+ kill_workq:
+	destroy_workqueue(nvme_workq);
  kill_kthread:
 	kthread_stop(nvme_thread);
 	return result;
@@ -2312,6 +2364,7 @@ static void __exit nvme_exit(void)
 {
 	pci_unregister_driver(&nvme_driver);
 	unregister_blkdev(nvme_major, "nvme");
+	destroy_workqueue(nvme_workq);
 	kthread_stop(nvme_thread);
 }
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 26ebcf4..fe5421b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -79,6 +79,7 @@ struct nvme_dev {
 	struct dma_pool *prp_page_pool;
 	struct dma_pool *prp_small_pool;
 	int instance;
+	int is_initialised;
 	int queue_count;
 	int db_stride;
 	u32 ctrl_config;
@@ -87,6 +88,7 @@ struct nvme_dev {
 	struct list_head namespaces;
 	struct kref kref;
 	struct miscdevice miscdev;
+	struct work_struct ws;
 	char name[12];
 	char serial[20];
 	char model[40];
-- 
1.7.10.4
