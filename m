From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 Feb 2015 10:44:56 -0700
Subject: [PATCHv2] NVMe: Asynchronous controller probe
Message-ID: <1423763096-14628-1-git-send-email-keith.busch@intel.com>

This performs the longest parts of nvme device probe in scheduled
work. This speeds up probe significantly when multiple devices are in use.

Just to drive how important this is for many distros, 'systemd' sends a
fatal signal to the modprobe routine during boot if you have a lot of
NVMe drives; it might take a while to initailize them and exceed some
arbitrary timeout that no one knows how to change. The result is only a
subset of your drives are discovered after boot since nvme probe bails
on devices when fatal_signal_pending is set.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   55 ++++++++++++++++++++++++---------------------
 include/linux/nvme.h      |    1 +
 2 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b3cb67d..e68763e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2799,6 +2799,7 @@ static void nvme_reset_workfn(struct work_struct *work)
 	dev->reset_workfn(work);
 }
 
+static void nvme_async_probe(struct work_struct *work);
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int node, result = -ENOMEM;
@@ -2833,48 +2834,51 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release;
 
+	INIT_WORK(&dev->probe_work, nvme_async_probe);
+	schedule_work(&dev->probe_work);
+	return result;
+ release:
+	nvme_release_instance(dev);
+ put_pci:
+	pci_dev_put(dev->pci_dev);
+ free:
+	kfree(dev->queues);
+	kfree(dev->entry);
+	kfree(dev);
+	return result;
+}
+
+static void nvme_async_probe(struct work_struct *work)
+{
+	struct nvme_dev *dev = container_of(work, struct nvme_dev, probe_work);
+	int result;
+
 	kref_init(&dev->kref);
+
 	result = nvme_dev_start(dev);
 	if (result)
-		goto release_pools;
+		goto reset;
 
 	if (dev->online_queues > 1)
 		result = nvme_dev_add(dev);
 	if (result)
-		goto shutdown;
+		goto reset;
 
 	scnprintf(dev->name, sizeof(dev->name), "nvme%d", dev->instance);
 	dev->miscdev.minor = MISC_DYNAMIC_MINOR;
-	dev->miscdev.parent = &pdev->dev;
+	dev->miscdev.parent = &dev->pci_dev->dev;
 	dev->miscdev.name = dev->name;
 	dev->miscdev.fops = &nvme_dev_fops;
 	result = misc_register(&dev->miscdev);
 	if (result)
-		goto remove;
+		goto reset;
 
 	nvme_set_irq_hints(dev);
-
 	dev->initialized = 1;
-	return 0;
-
- remove:
-	nvme_dev_remove(dev);
-	nvme_dev_remove_admin(dev);
-	nvme_free_namespaces(dev);
- shutdown:
-	nvme_dev_shutdown(dev);
- release_pools:
-	nvme_free_queues(dev, 0);
-	nvme_release_prp_pools(dev);
- release:
-	nvme_release_instance(dev);
- put_pci:
-	pci_dev_put(dev->pci_dev);
- free:
-	kfree(dev->queues);
-	kfree(dev->entry);
-	kfree(dev);
-	return result;
+	return;
+ reset:
+	dev->reset_workfn = nvme_reset_failed_dev;
+	queue_work(nvme_workq, &dev->reset_work);
 }
 
 static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
@@ -2902,6 +2906,7 @@ static void nvme_remove(struct pci_dev *pdev)
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
