From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri,  5 May 2017 14:52:06 -0600
Subject: [PATCH] nvme: Unmap CMB and remove sysfs file in reset path
Message-ID: <20170505205206.4262-1-jonathan.derrick@intel.com>

CMB doesn't get unmapped until removal while getting remapped on every
reset. Add the unmapping and sysfs file removal to the reset path in
nvme_pci_disable to match the mapping path in nvme_pci_enable.

Fixes: 202021c1a ("nvme : Add sysfs entry for NVMe CMBs when appropriate")

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
Acked-by: Keith Busch <keith.busch at intel.com>
Cc: <stable at vger.kernel.org> # 4.9+
---
 drivers/nvme/host/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c8541c3..ee821a0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1511,6 +1511,11 @@ static inline void nvme_release_cmb(struct nvme_dev *dev)
 	if (dev->cmb) {
 		iounmap(dev->cmb);
 		dev->cmb = NULL;
+		if (dev->cmbsz) {
+			sysfs_remove_file_from_group(&dev->ctrl.device->kobj,
+						     &dev_attr_cmb.attr, NULL);
+			dev->cmbsz = 0;
+		}
 	}
 }
 
@@ -1784,6 +1789,7 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
+	nvme_release_cmb(dev);
 	pci_free_irq_vectors(pdev);
 
 	if (pci_is_enabled(pdev)) {
@@ -2189,7 +2195,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_disable(dev, true);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
-	nvme_release_cmb(dev);
 	nvme_release_prp_pools(dev);
 	nvme_dev_unmap(dev);
 	nvme_put_ctrl(&dev->ctrl);
-- 
2.9.3
