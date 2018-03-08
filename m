From: keith.busch@intel.com (Keith Busch)
Date: Thu,  8 Mar 2018 14:56:55 -0700
Subject: [PATCH] nvme-pci: Add .get_address ctrl callback
Message-ID: <20180308215655.6670-1-keith.busch@intel.com>

The nvme-fabrics exports the controller address to sysfs, and we'd
like to have parity with this feature for PCIe. This patch provides
the appropiate callback and returns the controller address as the pci
domain:bus:device.function.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b6f43b738f03..9a3057a03499 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2416,6 +2416,13 @@ static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	return 0;
 }
 
+static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
+{
+	struct pci_dev *pdev = to_pci_dev(to_nvme_dev(ctrl)->dev);
+
+	return snprintf(buf, size, "%s", dev_name(&pdev->dev));
+}
+
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
@@ -2425,6 +2432,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.reg_read64		= nvme_pci_reg_read64,
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.submit_async_event	= nvme_pci_submit_async_event,
+	.get_address		= nvme_pci_get_address,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
-- 
2.14.3
