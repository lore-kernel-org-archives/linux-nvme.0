From: keith.busch@intel.com (Keith Busch)
Date: Fri, 10 Feb 2017 18:15:50 -0500
Subject: [PATCH 2/5] nvme/pci: Cancel work after watchdog disabled
In-Reply-To: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
Message-ID: <1486768553-13738-3-git-send-email-keith.busch@intel.com>

The driver had been flushing the work prior to uninitializing the
controller, hoping the work would not get restarted. If controller
failure or IO time occurs when tearing down the request queues, the
watchdog timer may queue another reset.

We want to make sure that reset work is not running to prevent use after
free errors accessing the device being torn down, so this patch cancels
the reset work only after we know it can never be started again.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9126637..52cca9f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1677,6 +1677,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	u32 csts = -1;
 
 	del_timer_sync(&dev->watchdog_timer);
+	cancel_work_sync(&dev->reset_work);
 
 	mutex_lock(&dev->shutdown_lock);
 	if (pci_is_enabled(to_pci_dev(dev->dev))) {
@@ -2002,7 +2003,6 @@ static void nvme_remove(struct pci_dev *pdev)
 		nvme_dev_disable(dev, false);
 	}
 
-	flush_work(&dev->reset_work);
 	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, true);
 	nvme_dev_remove_admin(dev);
-- 
1.8.3.1
