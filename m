From: keith.busch@intel.com (Keith Busch)
Date: Fri, 27 Apr 2018 15:17:08 -0600
Subject: [PATCH] nvme/pci: Use async_schedule for initial reset work
Message-ID: <20180427211708.5604-1-keith.busch@intel.com>

This patch schedules the initial controller reset in an async_domain so
that it can be synchronized from wait_for_device_probe(). This way the
kernel waits for the first nvme controller initialization to complete
for all devices before proceeding with the boot sequence, which may have
nvme dependencies.

Reported-by: Mikulas Patocka <mpatocka at redhat.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a2f3ad105620..9e04c7aba946 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/aer.h>
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-pci.h>
@@ -2489,6 +2490,12 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
+static void nvme_async_probe(void *data, async_cookie_t cookie)
+{
+	struct nvme_dev *dev = data;
+	nvme_reset_ctrl_sync(&dev->ctrl);
+}
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int node, result = -ENOMEM;
@@ -2533,7 +2540,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
-	nvme_reset_ctrl(&dev->ctrl);
+	async_schedule(nvme_async_probe, dev);
 
 	return 0;
 
-- 
2.14.3
