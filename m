From: keith.busch@intel.com (Keith Busch)
Date: Mon,  7 May 2018 10:43:22 -0600
Subject: [PATCH nvme-4.18] nvme/pci: Hold controller reference during async
 probe
Message-ID: <20180507164322.28571-1-keith.busch@intel.com>

It is possible the driver's remove may have freed the controller if
the remove callback is invoked prior to the async_schedule starting
the reset_work. This patch fixes that by holding a reference on the
controller.

Reported-by: Mikulas Patocka <mpatocka at redhat.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index dcd1be005eef..7acecdf25621 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2492,8 +2492,10 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 static void nvme_async_probe(void *data, async_cookie_t cookie)
 {
 	struct nvme_dev *dev = data;
+
 	nvme_reset_ctrl_sync(&dev->ctrl);
 	flush_work(&dev->ctrl.scan_work);
+	nvme_put_ctrl(&dev->ctrl);
 }
 
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -2540,6 +2542,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
+	nvme_get_ctrl(&dev->ctrl);
 	async_schedule(nvme_async_probe, dev);
 
 	return 0;
-- 
2.14.3
