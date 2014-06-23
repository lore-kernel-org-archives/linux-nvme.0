From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Jun 2014 15:24:53 -0600
Subject: [PATCH] NVMe: Use pci_stop_and_remove_bus_device_locked()
Message-ID: <1403558693-18209-1-git-send-email-keith.busch@intel.com>

Race conditions are theoretically possible between the NVMe PCI device
removal and the generic PCI bus rescan and device removal that can be
triggered via sysfs.

To avoid those race conditions make the NVMe code use
pci_stop_and_remove_bus_device_locked().

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 522a746..69bad18 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2692,7 +2692,7 @@ static int nvme_remove_dead_ctrl(void *arg)
 	struct pci_dev *pdev = dev->pci_dev;
 
 	if (pci_get_drvdata(pdev))
-		pci_stop_and_remove_bus_device(pdev);
+		pci_stop_and_remove_bus_device_locked(pdev);
 	kref_put(&dev->kref, nvme_free_dev);
 	return 0;
 }
-- 
1.7.10.4
