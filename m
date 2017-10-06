From: keith.busch@intel.com (Keith Busch)
Date: Fri,  6 Oct 2017 09:05:57 -0600
Subject: [PATCH-stable] nvme: protect against simultaneous shutdown invocations
Message-ID: <20171006150557.17492-1-keith.busch@intel.com>

commit 77bf25ea70200cddf083f74b7f617e5f07fac8bd upstream

Back-ported to 4.4. The only difference is the file location of the
struct definition that's adding the mutex.

This fixes reported reported kernel panics in 4.4-stable from simultaneous
controller resets that never supposed to be allowed to happen.

Cc: <stable at vger.kernel.org> # 4.4
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/nvme.h | 2 ++
 drivers/nvme/host/pci.c  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b8a5a8e8f57d..88cf4f5025b0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -14,6 +14,7 @@
 #ifndef _NVME_H
 #define _NVME_H
 
+#include <linux/mutex.h>
 #include <linux/nvme.h>
 #include <linux/pci.h>
 #include <linux/kref.h>
@@ -62,6 +63,7 @@ struct nvme_dev {
 	struct work_struct reset_work;
 	struct work_struct probe_work;
 	struct work_struct scan_work;
+	struct mutex shutdown_lock;
 	char name[12];
 	char serial[20];
 	char model[40];
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4c673d45f1bd..a36072b926f8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2954,6 +2954,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 
 	nvme_dev_list_remove(dev);
 
+	mutex_lock(&dev->shutdown_lock);
 	if (pci_is_enabled(to_pci_dev(dev->dev))) {
 		nvme_freeze_queues(dev);
 		csts = readl(&dev->bar->csts);
@@ -2972,6 +2973,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 
 	for (i = dev->queue_count - 1; i >= 0; i--)
 		nvme_clear_queue(dev->queues[i]);
+	mutex_init(&dev->shutdown_lock);
 }
 
 static void nvme_dev_remove(struct nvme_dev *dev)
@@ -3328,6 +3330,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	INIT_LIST_HEAD(&dev->namespaces);
 	INIT_WORK(&dev->reset_work, nvme_reset_work);
+	mutex_init(&dev->shutdown_lock);
 	dev->dev = get_device(&pdev->dev);
 	pci_set_drvdata(pdev, dev);
 
-- 
2.13.6
