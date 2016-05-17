From: keith.busch@intel.com (Keith Busch)
Date: Tue, 17 May 2016 15:39:58 -0600
Subject: [PATCH 1/2] pci: Error disabling SR-IOV if in VFs assigned
Message-ID: <1463521199-16604-1-git-send-email-keith.busch@intel.com>

Every sriov capable driver has to check if any guest is using a virtual
function prior to disabling, so let's make it common code.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/pci/pci-sysfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 342b691..5011fa9 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -487,6 +487,11 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 
 	if (num_vfs == 0) {
 		/* disable VFs */
+		if (pci_vfs_assigned(pdev)) {
+			dev_warn(&pdev->dev,
+				"Cannot disable SR-IOV VFs while assigned\n");
+			return -EPERM;
+		}
 		ret = pdev->driver->sriov_configure(pdev, 0);
 		if (ret < 0)
 			return ret;
-- 
2.7.2
