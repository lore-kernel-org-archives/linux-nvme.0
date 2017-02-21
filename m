From: keith.busch@intel.com (Keith Busch)
Date: Tue, 21 Feb 2017 14:07:41 -0500
Subject: [PATCH] Revert "nvme/pci: Cancel work after watchdog disabled"
Message-ID: <1487704061-16852-1-git-send-email-keith.busch@intel.com>

This reverts commit f666775720c2b1ddcd7e1bc24262265af03ab194.

The patch was trying to fix a condition where a reset is queued during
disabling, but it breaks a standard reset since the reset_work can't sync
with itself. The original patch testing isolated an unlikely condition,
but neglected the more common use.

The condition this was trying to fix doesn't happen anyway with the most
recent patches included, so just reverting the broken part and not trying
to correct with a different patch.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3b6fc3e..f4ce192 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1677,7 +1677,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	u32 csts = -1;
 
 	del_timer_sync(&dev->watchdog_timer);
-	cancel_work_sync(&dev->reset_work);
 
 	mutex_lock(&dev->shutdown_lock);
 	if (pci_is_enabled(to_pci_dev(dev->dev))) {
@@ -2003,6 +2002,7 @@ static void nvme_remove(struct pci_dev *pdev)
 		nvme_dev_disable(dev, false);
 	}
 
+	flush_work(&dev->reset_work);
 	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, true);
 	nvme_dev_remove_admin(dev);
-- 
2.7.2
