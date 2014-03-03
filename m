From: keith.busch@intel.com (Keith Busch)
Date: Mon,  3 Mar 2014 11:09:47 -0700
Subject: [PATCH] NVMe: Initialize device reference count earlier
Message-ID: <1393870187-4880-1-git-send-email-keith.busch@intel.com>

If an NVMe device becomes ready but fails to create IO queues, the driver
creates a character device handle so the device can be managed. The
device reference count needs to be initialized before creating the
character device.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cd39390..53f0c5e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2546,6 +2546,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release;
 
+	kref_init(&dev->kref);
 	result = nvme_dev_start(dev);
 	if (result) {
 		if (result == -EBUSY)
@@ -2553,7 +2554,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto release_pools;
 	}
 
-	kref_init(&dev->kref);
 	result = nvme_dev_add(dev);
 	if (result)
 		goto shutdown;
-- 
1.7.10.4
