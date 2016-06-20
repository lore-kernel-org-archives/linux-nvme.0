From: keith.busch@intel.com (Keith Busch)
Date: Mon, 20 Jun 2016 09:41:06 -0600
Subject: [PATCHv3] nvme/pci: Provide SR-IOV support
Message-ID: <1466437266-25749-1-git-send-email-keith.busch@intel.com>

This registers an sr-iov callback for nvme.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v2 -> v3:
  Removed the pci dependency part, instead checking pci_vfs_assigned
  in nvme.

 drivers/nvme/host/pci.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index dc39924..6d33f77 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2008,6 +2008,24 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
+static int nvme_pci_sriov_configure(struct pci_dev *pdev, int numvfs)
+{
+	int ret = 0;
+
+	if (numvfs == 0) {
+		if (pci_vfs_assigned(pdev)) {
+			dev_warn(&pdev->dev,
+				"Cannot disable SR-IOV VFs while assigned\n");
+			return -EPERM;
+		}
+		pci_disable_sriov(pdev);
+		return 0;
+	}
+
+	ret = pci_enable_sriov(pdev, numvfs);
+	return ret ? ret : numvfs;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
 {
@@ -2108,6 +2126,7 @@ static struct pci_driver nvme_driver = {
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
 	},
+	.sriov_configure = nvme_pci_sriov_configure,
 	.err_handler	= &nvme_err_handler,
 };
 
-- 
2.7.2
