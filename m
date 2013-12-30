From: santoshsy@gmail.com (Santosh Y)
Date: Mon, 30 Dec 2013 15:57:18 +0530
Subject: [PATCH RFC 3/5] NVMe: Asynchronous device scan support
In-Reply-To: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
Message-ID: <1388399240-13828-4-git-send-email-santoshsy@gmail.com>

This patch provides asynchronous device enumeration
capability. The 'probe' need not wait until the namespace scanning is
complete.

Signed-off-by: Ravi Kumar <ravi.android at gmail.com>
Signed-off-by: Santosh Y <santoshsy at gmail.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 8a02135..cd37335 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -17,6 +17,9 @@
  */
 
 #include <linux/nvme.h>
+#ifdef CONFIG_BLK_DEV_NVME_HP
+#include <linux/async.h>
+#endif
 #include <linux/bio.h>
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
@@ -2115,8 +2118,10 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		if (ns)
 			list_add_tail(&ns->list, &dev->namespaces);
 	}
+#ifndef CONFIG_BLK_DEV_NVME_HP
 	list_for_each_entry(ns, &dev->namespaces, list)
 		add_disk(ns->disk);
+#endif
 	res = 0;
 
  out:
@@ -2546,6 +2551,19 @@ static void nvme_reset_failed_dev(struct work_struct *ws)
 	nvme_dev_reset(dev);
 }
 
+#ifdef CONFIG_BLK_DEV_NVME_HP
+static void nvme_async_add(void *data, async_cookie_t cookie)
+{
+	struct nvme_dev *dev = (struct nvme_dev *)data;
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &dev->namespaces, list)
+		add_disk(ns->disk);
+	if (!test_bit(NVME_HOT_REM, &dev->hp_flag))
+		dev->initialized = 1;
+}
+#endif
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int result = -ENOMEM;
@@ -2595,14 +2613,16 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto remove;
 
-	dev->initialized = 1;
-	kref_init(&dev->kref);
-
 #ifdef CONFIG_BLK_DEV_NVME_HP
+	async_schedule(nvme_async_add, dev);
 	if (!pdev->is_added)
 		dev_info(&pdev->dev,
 			"Device 0x%x is on-line\n", pdev->device);
+#else
+	dev->initialized = 1;
 #endif
+	kref_init(&dev->kref);
+
 	return 0;
 
  remove:
-- 
1.8.3.2
