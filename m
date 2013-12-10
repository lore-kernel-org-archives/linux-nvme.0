From: keith.busch@intel.com (Keith Busch)
Date: Tue, 10 Dec 2013 13:10:36 -0700
Subject: [PATCH 1/5] NVMe: Device resume error handling
In-Reply-To: <1386706240-2300-1-git-send-email-keith.busch@intel.com>
References: <1386706240-2300-1-git-send-email-keith.busch@intel.com>
Message-ID: <1386706240-2300-2-git-send-email-keith.busch@intel.com>

Adds controller error handling on resume power management. If the device
fails to initialize, the device is queued for a reset. If the reset fails,
a thread is spawned to remove the pci device.

If the device resumes as "busy", the device is responding to admin
commands but will not create IO queues. In this case, we need to remove
the gendisks and free the IO queues since they can't be used and may be
holding bios in their lists.

>From testing, the dma pools require a pci device so this had to change
the pci driver 'remove' to release the dma resources in line with that
call instead of after all references to the device are released.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |  107 +++++++++++++++++++++++++++++++++++++++------
 include/linux/nvme.h      |    1 +
 2 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index da52092..f3c2065 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -58,6 +58,7 @@ module_param(use_threaded_interrupts, int, 0);
 static DEFINE_SPINLOCK(dev_list_lock);
 static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
+static struct workqueue_struct *nvme_workq;
 
 /*
  * An NVM Express queue.  Each device has at least two (one for admin
@@ -1956,7 +1957,6 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	else
 		goto disable_pci;
 
-	pci_set_drvdata(pdev, dev);
 	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
 	if (!dev->bar)
 		goto disable;
@@ -1983,9 +1983,9 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 	if (dev->bar) {
 		iounmap(dev->bar);
 		dev->bar = NULL;
+		pci_release_regions(dev->pci_dev);
 	}
 
-	pci_release_regions(dev->pci_dev);
 	if (pci_is_enabled(dev->pci_dev))
 		pci_disable_device(dev->pci_dev);
 }
@@ -2073,11 +2073,6 @@ static void nvme_release_instance(struct nvme_dev *dev)
 static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
-	nvme_dev_remove(dev);
-	nvme_dev_shutdown(dev);
-	nvme_free_queues(dev);
-	nvme_release_instance(dev);
-	nvme_release_prp_pools(dev);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
@@ -2149,6 +2144,70 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	return result;
 }
 
+static int nvme_remove_dead_ctrl(void *arg)
+{
+	struct nvme_dev *dev = (struct nvme_dev *)arg;
+	struct pci_dev *pdev = dev->pci_dev;
+
+	if (pci_get_drvdata(pdev))
+		pci_stop_and_remove_bus_device(pdev);
+	kref_put(&dev->kref, nvme_free_dev);
+	return 0;
+}
+
+static void nvme_remove_disks(struct work_struct *ws)
+{
+	int i;
+	struct nvme_dev *dev = container_of(ws, struct nvme_dev, reset_work);
+
+	nvme_dev_remove(dev);
+	spin_lock(&dev_list_lock);
+	for (i = dev->queue_count - 1; i > 0; i--) {
+		BUG_ON(!dev->queues[i] || !dev->queues[i]->q_suspended);
+		nvme_free_queue(dev->queues[i]);
+		dev->queue_count--;
+		dev->queues[i] = NULL;
+	}
+	spin_unlock(&dev_list_lock);
+}
+
+static int nvme_dev_resume(struct nvme_dev *dev)
+{
+	int ret;
+
+	ret = nvme_dev_start(dev);
+	if (ret && ret != -EBUSY)
+		return ret;
+	if (ret == -EBUSY) {
+		spin_lock(&dev_list_lock);
+		INIT_WORK(&dev->reset_work, nvme_remove_disks);
+		queue_work(nvme_workq, &dev->reset_work);
+		spin_unlock(&dev_list_lock);
+	}
+	return 0;
+}
+
+static void nvme_dev_reset(struct nvme_dev *dev)
+{
+	nvme_dev_shutdown(dev);
+	if (nvme_dev_resume(dev)) {
+		dev_err(&dev->pci_dev->dev, "Device failed to resume\n");
+		kref_get(&dev->kref);
+		if (IS_ERR(kthread_run(nvme_remove_dead_ctrl, dev, "nvme%d",
+							dev->instance))) {
+			dev_err(&dev->pci_dev->dev,
+				"Failed to start controller remove task\n");
+			kref_put(&dev->kref, nvme_free_dev);
+		}
+	}
+}
+
+static void nvme_reset_failed_dev(struct work_struct *ws)
+{
+	struct nvme_dev *dev = container_of(ws, struct nvme_dev, reset_work);
+	nvme_dev_reset(dev);
+}
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int result = -ENOMEM;
@@ -2168,6 +2227,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	INIT_LIST_HEAD(&dev->namespaces);
 	dev->pci_dev = pdev;
+	pci_set_drvdata(pdev, dev);
 	result = nvme_set_instance(dev);
 	if (result)
 		goto free;
@@ -2219,7 +2279,19 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	spin_lock(&dev_list_lock);
+	list_del_init(&dev->node);
+	spin_unlock(&dev_list_lock);
+
+	pci_set_drvdata(pdev, NULL);
+	flush_work(&dev->reset_work);
 	misc_deregister(&dev->miscdev);
+	nvme_dev_remove(dev);
+	nvme_dev_shutdown(dev);
+	nvme_free_queues(dev);
+	nvme_release_instance(dev);
+	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
 }
 
@@ -2243,13 +2315,12 @@ static int nvme_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
-	int ret;
 
-	ret = nvme_dev_start(ndev);
-	/* XXX: should remove gendisks if resume fails */
-	if (ret)
-		nvme_free_queues(ndev);
-	return ret;
+	if (nvme_dev_resume(ndev) && !work_busy(&ndev->reset_work)) {
+		INIT_WORK(&ndev->reset_work, nvme_reset_failed_dev);
+		queue_work(nvme_workq, &ndev->reset_work);
+	}
+	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
@@ -2290,9 +2361,14 @@ static int __init nvme_init(void)
 	if (IS_ERR(nvme_thread))
 		return PTR_ERR(nvme_thread);
 
+	result = -ENOMEM;
+	nvme_workq = create_singlethread_workqueue("nvme");
+	if (!nvme_workq)
+		goto kill_kthread;
+
 	result = register_blkdev(nvme_major, "nvme");
 	if (result < 0)
-		goto kill_kthread;
+		goto kill_workq;
 	else if (result > 0)
 		nvme_major = result;
 
@@ -2303,6 +2379,8 @@ static int __init nvme_init(void)
 
  unregister_blkdev:
 	unregister_blkdev(nvme_major, "nvme");
+ kill_workq:
+	destroy_workqueue(nvme_workq);
  kill_kthread:
 	kthread_stop(nvme_thread);
 	return result;
@@ -2312,6 +2390,7 @@ static void __exit nvme_exit(void)
 {
 	pci_unregister_driver(&nvme_driver);
 	unregister_blkdev(nvme_major, "nvme");
+	destroy_workqueue(nvme_workq);
 	kthread_stop(nvme_thread);
 }
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 26ebcf4..cdd37fc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -87,6 +87,7 @@ struct nvme_dev {
 	struct list_head namespaces;
 	struct kref kref;
 	struct miscdevice miscdev;
+	struct work_struct reset_work;
 	char name[12];
 	char serial[20];
 	char model[40];
-- 
1.7.10.4
