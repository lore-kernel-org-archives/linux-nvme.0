From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Mar 2016 15:42:39 -0600
Subject: [PATCH] NVMe: Unbind driver on failure
Message-ID: <1459201359-25044-1-git-send-email-keith.busch@intel.com>

Instead of removing the PCI device from the kernel's topology on
controller failure, this patch simply requests unbinding the device
from the driver. This avoids concurrently running pci removal with the
hot plug event, which has been reported to be problematic when multiple
surprise events occur near simultaneously.

The other benefit is that we will have PCI config and memory space
available to poke around for debugging a failed controller, assuming
the device was not physically removed.

The down side occurs if the platform and/or kernel do not support any
type of surprise hot removal. The device will remain visible through
sysfs (and therefore lspci), and some manual work is necessary to get
the logical topology corrected. But if your platform and/or kernel don't
support surprise removal, you probably shouldn't be doing that anyway.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 660ec84..5acd6e4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1916,7 +1916,7 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 
 	nvme_kill_queues(&dev->ctrl);
 	if (pci_get_drvdata(pdev))
-		pci_stop_and_remove_bus_device_locked(pdev);
+		device_release_driver(&pdev->dev);
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-- 
2.7.2
