From: kenneth.heitke@intel.com (Kenneth Heitke)
Date: Thu, 23 May 2019 17:14:29 -0600
Subject: [PATCH] nvme: Ignore timeouts while PCI config access is blocked
Message-ID: <20190523231429.21235-1-kenneth.heitke@intel.com>

If an admin command timeout occurs while a PCIe reset (FLR) is
pending, the CSTS bits may not be valid which could result in
the controller being removed.

Signed-off-by: Kenneth Heitke <kenneth.heitke at intel.com>
---
 drivers/nvme/host/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a8708c9ac18..7cd7e6287d5f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1258,13 +1258,14 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct request *abort_req;
 	struct nvme_command cmd;
 	bool shutdown = false;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
 	/* If PCI error recovery process is happening, we cannot reset or
 	 * the recovery mechanism will surely fail.
 	 */
 	mb();
-	if (pci_channel_offline(to_pci_dev(dev->dev)))
+	if (pci_channel_offline(to_pci_dev(dev->dev)) || pdev->block_cfg_access)
 		return BLK_EH_RESET_TIMER;
 
 	/*
@@ -2786,7 +2787,7 @@ static void nvme_reset_prepare(struct pci_dev *pdev)
 static void nvme_reset_done(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_reset_ctrl_sync(&dev->ctrl);
+	nvme_reset_ctrl(&dev->ctrl);
 }
 
 static void nvme_shutdown(struct pci_dev *pdev)
-- 
2.17.1
