From: kenneth.heitke@intel.com (Kenneth Heitke)
Date: Tue, 21 May 2019 18:37:41 -0600
Subject: [RFC PATCH] nvme: Ignore timeouts while a PCIe reset is pending
Message-ID: <20190522003741.26755-1-kenneth.heitke@intel.com>

If an admin command timeout occurs while a PCIe reset (FLR) is
pending, the CSTS bits may not be valid which could result in
the controller being removed.

[372337.996566] nvme nvme0: I/O 0 QID 0 timeout, reset controller
[372339.984662] nvme 0000:1c:00.0: enabling device (0000 -> 0002)
[372339.984951] nvme nvme0: Removing after probe failure status: -19

Signed-off-by: Kenneth Heitke <kenneth.heitke at intel.com>
---
 drivers/nvme/host/pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a8708c9ac18..aa9ea64a8b53 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -118,6 +118,8 @@ struct nvme_dev {
 	struct nvme_ctrl ctrl;
 
 	mempool_t *iod_mempool;
+	unsigned long flags;
+#define NVME_CTRL_PCI_RESET_PENDING	0
 
 	/* shadow doorbell buffer support: */
 	u32 *dbbuf_dbs;
@@ -1250,6 +1252,11 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 			 csts, result);
 }
 
+static bool nvme_pci_reset_pending(const struct nvme_dev *dev)
+{
+	return !!test_bit(NVME_CTRL_PCI_RESET_PENDING, &dev->flags);
+}
+
 static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -1267,6 +1274,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	if (pci_channel_offline(to_pci_dev(dev->dev)))
 		return BLK_EH_RESET_TIMER;
 
+	/* If a PCIe reset (FLR) is pending, wait for it to complete */
+	if (nvme_pci_reset_pending(dev))
+		return BLK_EH_RESET_TIMER;
+
 	/*
 	 * Reset immediately if the controller is failed
 	 */
@@ -2780,12 +2791,14 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void nvme_reset_prepare(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	set_bit(NVME_CTRL_PCI_RESET_PENDING, &dev->flags);
 	nvme_dev_disable(dev, false);
 }
 
 static void nvme_reset_done(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	clear_bit(NVME_CTRL_PCI_RESET_PENDING, &dev->flags);
 	nvme_reset_ctrl_sync(&dev->ctrl);
 }
 
-- 
2.17.1
