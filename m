From: keith.busch@intel.com (Keith Busch)
Date: Tue, 27 Jun 2017 19:43:38 -0400
Subject: [PATCH for-4.12] nvme/pci: Fix stuck nvme reset
Message-ID: <1498607018-1277-1-git-send-email-keith.busch@intel.com>

The controller state is set to resetting prior to disabling the
controller, so this patch accounts for that state when deciding if it
needs to freeze the queues. Without this, an 'nvme reset /dev/nvme0'
blocks forever because the queues were never frozen.

Fixes: 82b057caefaf ("nvme-pci: fix multiple ctrl removal scheduling")

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 951042a..0bfda30 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1805,7 +1805,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	if (pci_is_enabled(pdev)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
-		if (dev->ctrl.state == NVME_CTRL_LIVE)
+		if (dev->ctrl.state == NVME_CTRL_LIVE ||
+				dev->ctrl.state == NVME_CTRL_RESETTING)
 			nvme_start_freeze(&dev->ctrl);
 		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
 			pdev->error_state  != pci_channel_io_normal);
-- 
2.5.5
