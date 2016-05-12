From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 May 2016 08:13:30 -0600
Subject: [PATCH] nvme/pci: Provide SR-IOV support
Message-ID: <1463062410-10009-1-git-send-email-keith.busch@intel.com>

This registers a standard boiler-plate sr-iov callback for nvme.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9c57a10..9bc0c19 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2033,6 +2033,26 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
+static int nvme_pci_sriov_configure(struct pci_dev *pdev, int numvfs)
+{
+	int ret = 0;
+
+	if (!pdev->is_physfn)
+		return -EPERM;
+
+	if (numvfs == 0) {
+		if (pci_vfs_assigned(pdev)) {
+			dev_warn(&pdev->dev,
+				"Cannot disable SR-IOV VFs while assigned\n");
+			return -EPERM;
+		}
+		pci_disable_sriov(pdev);
+	} else
+		ret = pci_enable_sriov(pdev, numvfs);
+
+	return ret ? ret : numvfs;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
 {
@@ -2127,6 +2147,7 @@ static struct pci_driver nvme_driver = {
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
 	},
+	.sriov_configure = nvme_pci_sriov_configure,
 	.err_handler	= &nvme_err_handler,
 };
 
-- 
2.7.2
