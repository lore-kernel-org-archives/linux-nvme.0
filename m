From: keith.busch@intel.com (Keith Busch)
Date: Tue, 17 May 2016 15:39:59 -0600
Subject: [PATCH 2/2] nvme/pci: Enable SR-IOV capabilities
In-Reply-To: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
Message-ID: <1463521199-16604-2-git-send-email-keith.busch@intel.com>

Registers a standard boiler-plate SR-IOV configure callback for NVMe.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fbe8cc2..8379b9a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2033,6 +2033,18 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
+static int nvme_sriov_configure(struct pci_dev *pdev, int numvfs)
+{
+	int ret = 0;
+
+	if (numvfs == 0)
+		pci_disable_sriov(pdev);
+	else
+		ret = pci_enable_sriov(pdev, numvfs);
+
+	return ret ? ret : numvfs;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
 {
@@ -2127,6 +2139,7 @@ static struct pci_driver nvme_driver = {
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
 	},
+	.sriov_configure = nvme_sriov_configure,
 	.err_handler	= &nvme_err_handler,
 };
 
-- 
2.7.2
