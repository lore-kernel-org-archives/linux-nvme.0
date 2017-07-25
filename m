From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 25 Jul 2017 16:58:36 +0300
Subject: [PATCH 1/1] nvme: fix CMB sysfs file removal in reset path
Message-ID: <1500991116-8227-1-git-send-email-maxg@mellanox.com>

Currently we create the sysfs entry even if we fail mapping
it. In that case, the unmapping will not remove the sysfs created
file.

Fixes: f63572dff ("nvme: unmap CMB and remove sysfs file in reset path")

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/pci.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8569ee7..cbbfc68 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1558,12 +1558,13 @@ static inline void nvme_release_cmb(struct nvme_dev *dev)
 	if (dev->cmb) {
 		iounmap(dev->cmb);
 		dev->cmb = NULL;
-		if (dev->cmbsz) {
-			sysfs_remove_file_from_group(&dev->ctrl.device->kobj,
-						     &dev_attr_cmb.attr, NULL);
-			dev->cmbsz = 0;
-		}
 	}
+	if (NVME_CMB_SZ(dev->cmbsz)) {
+		sysfs_remove_file_from_group(&dev->ctrl.device->kobj,
+					     &dev_attr_cmb.attr, NULL);
+		dev->cmbsz = 0;
+	}
+
 }
 
 static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
@@ -1962,7 +1963,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2, 0)) {
 		dev->cmb = nvme_map_cmb(dev);
 
-		if (dev->cmbsz) {
+		if (NVME_CMB_SZ(dev->cmbsz)) {
 			if (sysfs_add_file_to_group(&dev->ctrl.device->kobj,
 						    &dev_attr_cmb.attr, NULL))
 				dev_warn(dev->ctrl.device,
-- 
1.7.1
