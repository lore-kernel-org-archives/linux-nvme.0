From: keith.busch@intel.com (Keith Busch)
Date: Thu,  5 Sep 2013 14:45:10 -0600
Subject: [PATCH 4/9] NVMe: Reset failed controller
In-Reply-To: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
References: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
Message-ID: <1378413915-16667-5-git-send-email-keith.busch@intel.com>

Polls on the controller fatal status bit and resets the controller per
the nvme spec on this condition. If the device probe has not completed,
commands may be timed out in the previous way as resetting the controller
would cause the probe to fail, which will conflict with the the work
task that is resetting the controller.

If the controller fails to start after attempting to reset it, the pci
driver will be removed since the device would appear to be dead. I think
that would work on a surprise removal where the driver's remove function
isn't automatically called.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   67 +++++++++++++++++++++++++++++++++++++++------
 include/linux/nvme.h      |    2 +
 2 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index db15c3d..18bb04e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -58,6 +58,7 @@ module_param(use_threaded_interrupts, int, 0);
 static DEFINE_SPINLOCK(dev_list_lock);
 static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
+static struct workqueue_struct *nvme_workq;
 
 /*
  * An NVM Express queue.  Each device has at least two (one for admin
@@ -1604,6 +1605,14 @@ static int nvme_kthread(void *data)
 		spin_lock(&dev_list_lock);
 		list_for_each_entry(dev, &dev_list, node) {
 			int i;
+			if (readl(&dev->bar->csts) & NVME_CSTS_CFS) {
+				if (dev->is_initialised) {
+					dev_warn(&dev->pci_dev->dev,
+						"failed status, reset controller\n");
+					queue_work(nvme_workq, &dev->ws);
+					continue;
+				}
+			}
 			for (i = 0; i < dev->queue_count; i++) {
 				struct nvme_queue *nvmeq = dev->queues[i];
 				if (!nvmeq)
@@ -1996,9 +2005,8 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
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
@@ -2162,6 +2170,41 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	return result;
 }
 
+static int nvme_remove_dead_ctrl(void *arg)
+{
+	struct nvme_dev *dev = (struct nvme_dev *)arg;
+	struct pci_dev *pdev;
+
+	if ((dev == NULL))
+		return -1;
+
+	pdev = dev->pci_dev;
+	if ((pdev == NULL))
+		return -1;
+	pci_stop_and_remove_bus_device(pdev);
+	return 0;
+}
+
+static void nvme_dev_resume(struct nvme_dev *dev)
+{
+	int ret = nvme_dev_start(dev);
+	if (ret)
+		kthread_run(nvme_remove_dead_ctrl, dev,
+					"nvme%d", dev->instance);
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
@@ -2189,6 +2232,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release;
 
+	INIT_WORK(&dev->ws, nvme_reset_failed_dev);
 	result = nvme_dev_start(dev);
 	if (result) {
 		if (result == -EBUSY)
@@ -2211,6 +2255,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto remove;
 
 	kref_init(&dev->kref);
+	dev->is_initialised = 1;
 	return 0;
 
  remove:
@@ -2256,13 +2301,9 @@ static int nvme_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
-	int ret;
 
-	ret = nvme_dev_start(ndev);
-	/* XXX: should remove gendisks if resume fails */
-	if (ret)
-		nvme_free_queues(ndev);
-	return ret;
+	nvme_dev_resume(ndev);
+	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
@@ -2303,9 +2344,14 @@ static int __init nvme_init(void)
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
 
@@ -2316,6 +2362,8 @@ static int __init nvme_init(void)
 
  unregister_blkdev:
 	unregister_blkdev(nvme_major, "nvme");
+ kill_workq:
+	destroy_workqueue(nvme_workq);
  kill_kthread:
 	kthread_stop(nvme_thread);
 	return result;
@@ -2325,6 +2373,7 @@ static void __exit nvme_exit(void)
 {
 	pci_unregister_driver(&nvme_driver);
 	unregister_blkdev(nvme_major, "nvme");
+	destroy_workqueue(nvme_workq);
 	kthread_stop(nvme_thread);
 }
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 26ebcf4..a25bba2 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -81,12 +81,14 @@ struct nvme_dev {
 	int instance;
 	int queue_count;
 	int db_stride;
+	int is_initialised;
 	u32 ctrl_config;
 	struct msix_entry *entry;
 	struct nvme_bar __iomem *bar;
 	struct list_head namespaces;
 	struct kref kref;
 	struct miscdevice miscdev;
+	struct work_struct ws;
 	char name[12];
 	char serial[20];
 	char model[40];
-- 
1.7.0.4
