From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Mon, 12 Mar 2018 10:23:28 -0700
Subject: [pci PATCH v5 3/4] ena: Migrate over to unmanaged SR-IOV support
In-Reply-To: <20180312171813.3487.94803.stgit@localhost.localdomain>
References: <20180312171813.3487.94803.stgit@localhost.localdomain>
Message-ID: <20180312172309.3487.76690.stgit@localhost.localdomain>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Instead of implementing our own version of a SR-IOV configuration stub in
the ena driver we can just reuse the existing
pci_sriov_configure_simple function.

Signed-off-by: Alexander Duyck <alexander.h.duyck at intel.com>
---

v5: Replaced call to pci_sriov_configure_unmanaged with
        pci_sriov_configure_simple

 drivers/net/ethernet/amazon/ena/ena_netdev.c |   30 +++-----------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 6975150d144e..868069363bdd 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3385,32 +3385,6 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 }
 
 /*****************************************************************************/
-static int ena_sriov_configure(struct pci_dev *dev, int numvfs)
-{
-	int rc;
-
-	if (numvfs > 0) {
-		rc = pci_enable_sriov(dev, numvfs);
-		if (rc != 0) {
-			dev_err(&dev->dev,
-				"pci_enable_sriov failed to enable: %d vfs with the error: %d\n",
-				numvfs, rc);
-			return rc;
-		}
-
-		return numvfs;
-	}
-
-	if (numvfs == 0) {
-		pci_disable_sriov(dev);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-/*****************************************************************************/
-/*****************************************************************************/
 
 /* ena_remove - Device Removal Routine
  * @pdev: PCI device information struct
@@ -3525,7 +3499,9 @@ static int ena_resume(struct pci_dev *pdev)
 	.suspend    = ena_suspend,
 	.resume     = ena_resume,
 #endif
-	.sriov_configure = ena_sriov_configure,
+#ifdef CONFIG_PCI_IOV
+	.sriov_configure = pci_sriov_configure_simple,
+#endif
 };
 
 static int __init ena_init(void)
