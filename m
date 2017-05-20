From: hch@lst.de (Christoph Hellwig)
Date: Sat, 20 May 2017 15:14:43 +0200
Subject: [PATCH 1/3] nvme-pci: consistencly use ctrl->device for logging
Message-ID: <20170520131445.16078-1-hch@lst.de>

This is what most of the code already does and gives much more useful
prefixes than the device embedded in the pci_dev.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fed803232edc..a150b2dd7851 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -263,7 +263,7 @@ static void nvme_dbbuf_set(struct nvme_dev *dev)
 	c.dbbuf.prp2 = cpu_to_le64(dev->dbbuf_eis_dma_addr);
 
 	if (nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0)) {
-		dev_warn(dev->dev, "unable to set dbbuf\n");
+		dev_warn(dev->ctrl.device, "unable to set dbbuf\n");
 		/* Free memory and continue on */
 		nvme_dbbuf_dma_free(dev);
 	}
@@ -1394,11 +1394,11 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 	result = pci_read_config_word(to_pci_dev(dev->dev), PCI_STATUS,
 				      &pci_status);
 	if (result == PCIBIOS_SUCCESSFUL)
-		dev_warn(dev->dev,
+		dev_warn(dev->ctrl.device,
 			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
 			 csts, pci_status);
 	else
-		dev_warn(dev->dev,
+		dev_warn(dev->ctrl.device,
 			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS read failed (%d)\n",
 			 csts, result);
 }
@@ -1735,8 +1735,8 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	 */
 	if (pdev->vendor == PCI_VENDOR_ID_APPLE && pdev->device == 0x2001) {
 		dev->q_depth = 2;
-		dev_warn(dev->dev, "detected Apple NVMe controller, set "
-			"queue depth=%u to work around controller resets\n",
+		dev_warn(dev->ctrl.device, "detected Apple NVMe controller, "
+			"set queue depth=%u to work around controller resets\n",
 			dev->q_depth);
 	}
 
@@ -1754,7 +1754,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 		if (dev->cmbsz) {
 			if (sysfs_add_file_to_group(&dev->ctrl.device->kobj,
 						    &dev_attr_cmb.attr, NULL))
-				dev_warn(dev->dev,
+				dev_warn(dev->ctrl.device,
 					 "failed to add sysfs attribute for CMB\n");
 		}
 	}
-- 
2.11.0
