From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 May 2018 16:03:26 -0600
Subject: [PATCHv2 2/8] nvme-pci: Fix queue freeze criteria on reset
In-Reply-To: <20180522220332.9244-1-keith.busch@intel.com>
References: <20180522220332.9244-1-keith.busch@intel.com>
Message-ID: <20180522220332.9244-3-keith.busch@intel.com>

The driver had been relying on the pci_dev to maintain the state of
the pci device to know when starting a freeze would be appropriate. The
blktests block/011 however shows us that users may alter the state of
pci_dev out from under drivers and break the criteria we had been using.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index deb44c27cdaf..8949ea3609d8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2196,24 +2196,22 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	mutex_lock(&dev->shutdown_lock);
-	if (pci_is_enabled(pdev)) {
+	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE &&
+	    (dev->ctrl.state == NVME_CTRL_LIVE ||
+	     dev->ctrl.state == NVME_CTRL_RESETTING)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
-		if (dev->ctrl.state == NVME_CTRL_LIVE ||
-		    dev->ctrl.state == NVME_CTRL_RESETTING)
-			nvme_start_freeze(&dev->ctrl);
+		nvme_start_freeze(&dev->ctrl);
 		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
-			pdev->error_state  != pci_channel_io_normal);
+			pci_channel_offline(pdev) || !pci_is_enabled(pdev));
 	}
 
 	/*
 	 * Give the controller a chance to complete all entered requests if
 	 * doing a safe shutdown.
 	 */
-	if (!dead) {
-		if (shutdown)
-			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
-	}
+	if (!dead && shutdown)
+		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 
 	nvme_stop_queues(&dev->ctrl);
 
-- 
2.14.3
