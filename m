From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Thu, 15 Mar 2018 11:43:49 -0700
Subject: [pci PATCH v7 4/5] nvme: Migrate over to unmanaged SR-IOV support
In-Reply-To: <20180315183449.3102.64791.stgit@localhost.localdomain>
References: <20180315183449.3102.64791.stgit@localhost.localdomain>
Message-ID: <20180315184328.3102.42818.stgit@localhost.localdomain>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Instead of implementing our own version of a SR-IOV configuration stub in
the nvme driver we can just reuse the existing
pci_sriov_configure_simple function.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Alexander Duyck <alexander.h.duyck at intel.com>
---

v5: Replaced call to pci_sriov_configure_unmanaged with
        pci_sriov_configure_simple
v6: Dropped "#ifdef" checks for IOV wrapping sriov_configure definition
v7: No code change, added Reviewed-by

 drivers/nvme/host/pci.c |   20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5933a5c732e8..5e963058882a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2580,24 +2580,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-static int nvme_pci_sriov_configure(struct pci_dev *pdev, int numvfs)
-{
-	int ret = 0;
-
-	if (numvfs == 0) {
-		if (pci_vfs_assigned(pdev)) {
-			dev_warn(&pdev->dev,
-				"Cannot disable SR-IOV VFs while assigned\n");
-			return -EPERM;
-		}
-		pci_disable_sriov(pdev);
-		return 0;
-	}
-
-	ret = pci_enable_sriov(pdev, numvfs);
-	return ret ? ret : numvfs;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
 {
@@ -2716,7 +2698,7 @@ static void nvme_error_resume(struct pci_dev *pdev)
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
 	},
-	.sriov_configure = nvme_pci_sriov_configure,
+	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
 };
 
