From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 30 Jul 2017 01:45:08 +0300
Subject: [PATCH v2 1/1] nvme: fix CMB sysfs file removal in reset path
Message-ID: <1501368308-20750-1-git-send-email-maxg@mellanox.com>

Currently we create the sysfs entry even if we fail mapping
it. In that case, the unmapping will not remove the sysfs created
file. There is no good reason to create a sysfs entry for a non
working CMB and show his characteristics.

Fixes: f63572dff ("nvme: unmap CMB and remove sysfs file in reset path")

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---

Changes from v1:
 - create sysfs for working CMB - from Christoph
 - remove wrong comment about auto-removal - from Christoph

---
 drivers/nvme/host/pci.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8569ee7..a9229cb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1558,11 +1558,9 @@ static inline void nvme_release_cmb(struct nvme_dev *dev)
 	if (dev->cmb) {
 		iounmap(dev->cmb);
 		dev->cmb = NULL;
-		if (dev->cmbsz) {
-			sysfs_remove_file_from_group(&dev->ctrl.device->kobj,
-						     &dev_attr_cmb.attr, NULL);
-			dev->cmbsz = 0;
-		}
+		sysfs_remove_file_from_group(&dev->ctrl.device->kobj,
+					     &dev_attr_cmb.attr, NULL);
+		dev->cmbsz = 0;
 	}
 }
 
@@ -1953,16 +1951,14 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	/*
 	 * CMBs can currently only exist on >=1.2 PCIe devices. We only
-	 * populate sysfs if a CMB is implemented. Note that we add the
-	 * CMB attribute to the nvme_ctrl kobj which removes the need to remove
-	 * it on exit. Since nvme_dev_attrs_group has no name we can pass
-	 * NULL as final argument to sysfs_add_file_to_group.
+	 * populate sysfs if a CMB is implemented. Since nvme_dev_attrs_group
+	 * has no name we can pass NULL as final argument to
+	 * sysfs_add_file_to_group.
 	 */
 
 	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2, 0)) {
 		dev->cmb = nvme_map_cmb(dev);
-
-		if (dev->cmbsz) {
+		if (dev->cmb) {
 			if (sysfs_add_file_to_group(&dev->ctrl.device->kobj,
 						    &dev_attr_cmb.attr, NULL))
 				dev_warn(dev->ctrl.device,
-- 
1.7.1
