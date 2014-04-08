From: keith.busch@intel.com (Keith Busch)
Date: Tue,  8 Apr 2014 16:24:20 -0600
Subject: [PATCH] NVMe: Complete shutdown & suspend asynchronously
Message-ID: <1396995860-31211-1-git-send-email-keith.busch@intel.com>

So devices may take time to complete a shutdown. The shutdown and suspend
driver paths can safely perform the actual device shutdown asynchronously,
so multiple devices may be done in parallel.

The async shutdown and suspend have to be handled a little differently. We
can't use MSI/MSI-x in the shutdown path after returning, so its
asynchronous callback will have to use and free INTx irq, where suspend
may continue using MSI[-x].

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 625259d..927a73e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/nvme.h>
+#include <linux/async.h>
 #include <linux/bio.h>
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
@@ -2680,10 +2681,24 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return result;
 }
 
+static void nvme_async_shutdown(void *data, async_cookie_t cookie)
+{
+	struct nvme_dev *dev = data;
+	nvme_dev_shutdown(dev);
+	free_irq(dev->pci_dev->irq, raw_nvmeq(dev, 0));
+}
+
 static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_shutdown(dev);
+	struct nvme_queue *adminq = raw_nvmeq(dev, 0);
+
+	/* MSI/MSI-x are disabled after returning from this function */	
+	if (request_irq(dev->pci_dev->irq, nvme_irq, IRQF_SHARED,
+					adminq->irqname, adminq))
+		nvme_dev_shutdown(dev);
+	else
+		async_schedule(nvme_async_shutdown, dev);
 }
 
 static void nvme_remove(struct pci_dev *pdev)
@@ -2714,12 +2729,18 @@ static void nvme_remove(struct pci_dev *pdev)
 #define nvme_error_resume NULL
 
 #ifdef CONFIG_PM_SLEEP
+static void nvme_async_suspend(void *data, async_cookie_t cookie)
+{
+	struct nvme_dev *dev = data;
+	nvme_dev_shutdown(dev);
+}
+
 static int nvme_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
-	nvme_dev_shutdown(ndev);
+	async_schedule(nvme_async_suspend, ndev);
 	return 0;
 }
 
-- 
1.7.10.4
