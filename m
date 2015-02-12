From: keith.busch@intel.com (Keith Busch)
Date: Wed, 11 Feb 2015 18:11:15 -0700
Subject: [PATCH] NVMe: Async probe
In-Reply-To: <1423703475-21794-1-git-send-email-keith.busch@intel.com>
References: <1423703475-21794-1-git-send-email-keith.busch@intel.com>
Message-ID: <1423703475-21794-2-git-send-email-keith.busch@intel.com>

This performs the longest parts of nvme device probe asynchronously. This
speeds up probe significantly when multiple devices are in use.

Just to drive how important this is for many distros, 'systemd' sends a
fatal signal to the modprobe routine during boot if you have a lot of
NVMe drives; it might take a while to initailize them and exceed some
arbitrary timeout that no one knows how to change. The result is only a
subset of your drives are discovered after boot since nvme probe bails
on devices when fatal_signal_pending is set.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   55 ++++++++++++++++++++++++---------------------
 include/linux/nvme.h      |    2 ++
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b3cb67d..89cb4c5 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2799,6 +2799,8 @@ static void nvme_reset_workfn(struct work_struct *work)
 	dev->reset_workfn(work);
 }
 
+static void nvme_async_probe(void *data, async_cookie_t cookie);
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int node, result = -ENOMEM;
@@ -2833,48 +2835,50 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release;
 
+	dev->probe_cookie = async_schedule(nvme_async_probe, dev);
+	return result;
+
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
+static void nvme_async_probe(void *data, async_cookie_t cookie)
+{
+	struct nvme_dev *dev = data;
+	int result;
+
 	kref_init(&dev->kref);
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
+	async_synchronize_cookie(dev->probe_cookie);
 	flush_work(&dev->reset_work);
 	misc_deregister(&dev->miscdev);
 	nvme_dev_shutdown(dev);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 19a5d4b..ebfbfa8 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -16,6 +16,7 @@
 #define _LINUX_NVME_H
 
 #include <uapi/linux/nvme.h>
+#include <linux/async.h>
 #include <linux/pci.h>
 #include <linux/miscdevice.h>
 #include <linux/kref.h>
@@ -94,6 +95,7 @@ struct nvme_dev {
 	struct miscdevice miscdev;
 	work_func_t reset_workfn;
 	struct work_struct reset_work;
+	async_cookie_t probe_cookie;
 	char name[12];
 	char serial[20];
 	char model[40];
-- 
1.7.10.4
