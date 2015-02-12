From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 Feb 2015 12:07:58 -0700
Subject: [PATCHv3] NVMe: Asynchronous controller probe
Message-ID: <1423768078-17389-1-git-send-email-keith.busch@intel.com>

This performs the longest parts of nvme device probe in scheduled work.
This speeds up probe significantly when multiple devices are in use.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v3:

Using a work queue instead of a asynchronous schedule so it can be
synchronized correctly on removal.

Initialize device kref and character device prior to scheduling the
asynchronous device start. This makes it possible to see the character
device before the controller admin queue is initialized, so this also
prevents opening the device prior to that.

 drivers/block/nvme-core.c |   52 ++++++++++++++++++++++++++-------------------
 include/linux/nvme.h      |    1 +
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b3cb67d..55485cc 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2624,6 +2624,8 @@ static int nvme_dev_open(struct inode *inode, struct file *f)
 {
 	struct nvme_dev *dev = container_of(f->private_data, struct nvme_dev,
 								miscdev);
+	if (!dev->admin_q)
+		return -EWOULDBLOCK;
 	kref_get(&dev->kref);
 	f->private_data = dev;
 	return 0;
@@ -2799,6 +2801,7 @@ static void nvme_reset_workfn(struct work_struct *work)
 	dev->reset_workfn(work);
 }
 
+static void nvme_async_probe(struct work_struct *work);
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int node, result = -ENOMEM;
@@ -2834,15 +2837,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto release;
 
 	kref_init(&dev->kref);
-	result = nvme_dev_start(dev);
-	if (result)
-		goto release_pools;
-
-	if (dev->online_queues > 1)
-		result = nvme_dev_add(dev);
-	if (result)
-		goto shutdown;
-
 	scnprintf(dev->name, sizeof(dev->name), "nvme%d", dev->instance);
 	dev->miscdev.minor = MISC_DYNAMIC_MINOR;
 	dev->miscdev.parent = &pdev->dev;
@@ -2850,21 +2844,12 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->miscdev.fops = &nvme_dev_fops;
 	result = misc_register(&dev->miscdev);
 	if (result)
-		goto remove;
-
-	nvme_set_irq_hints(dev);
-
-	dev->initialized = 1;
-	return 0;
+		goto release_pools;
 
- remove:
-	nvme_dev_remove(dev);
-	nvme_dev_remove_admin(dev);
-	nvme_free_namespaces(dev);
- shutdown:
-	nvme_dev_shutdown(dev);
+	INIT_WORK(&dev->probe_work, nvme_async_probe);
+	schedule_work(&dev->probe_work);
+	return result;
  release_pools:
-	nvme_free_queues(dev, 0);
 	nvme_release_prp_pools(dev);
  release:
 	nvme_release_instance(dev);
@@ -2877,6 +2862,28 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return result;
 }
 
+static void nvme_async_probe(struct work_struct *work)
+{
+	struct nvme_dev *dev = container_of(work, struct nvme_dev, probe_work);
+	int result;
+
+	result = nvme_dev_start(dev);
+	if (result)
+		goto reset;
+
+	if (dev->online_queues > 1)
+		result = nvme_dev_add(dev);
+	if (result)
+		goto reset;
+
+	nvme_set_irq_hints(dev);
+	dev->initialized = 1;
+	return;
+ reset:
+	dev->reset_workfn = nvme_reset_failed_dev;
+	queue_work(nvme_workq, &dev->reset_work);
+}
+
 static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
@@ -2902,6 +2909,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	spin_unlock(&dev_list_lock);
 
 	pci_set_drvdata(pdev, NULL);
+	flush_work(&dev->probe_work);
 	flush_work(&dev->reset_work);
 	misc_deregister(&dev->miscdev);
 	nvme_dev_shutdown(dev);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 19a5d4b..0969b08 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -94,6 +94,7 @@ struct nvme_dev {
 	struct miscdevice miscdev;
 	work_func_t reset_workfn;
 	struct work_struct reset_work;
+	struct work_struct probe_work;
 	char name[12];
 	char serial[20];
 	char model[40];
-- 
1.7.10.4
