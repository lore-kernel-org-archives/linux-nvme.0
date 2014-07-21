From: keith.busch@intel.com (Keith Busch)
Date: Mon, 21 Jul 2014 12:10:59 -0600
Subject: [PATCH] NVMe: PCI error handling code
Message-ID: <1405966259-26570-1-git-send-email-keith.busch@intel.com>

Implements the pci_error_handlers' .error_detected and .slot_reset. On
unrecovered error detected, the device is requested to be reset after
driver shuts it down and quieces IO, and resumes the device after the
slot reset.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Tested with aer_inject module. Here's an example of a spec file:

  AER
  BUS 9 DEV 0 FN 0
  UNCOR_STATUS MALF_TLP
  HEADER_LOG 0 1 2 3

Mentioned in comments in this patch, I had to add an odd hard delay to
make this work and I'm not sure why the heck it's necessary. Maybe the
device I'm testing with is broken, or there is something else I should
have the driver do. ?

 drivers/block/nvme-core.c |   53 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..985b9f0 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/nvme.h>
+#include <linux/aer.h>
 #include <linux/bio.h>
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
@@ -2377,6 +2378,10 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
 
+	/* Save PCI configuration state for recovery from PCI AER/EEH errors */
+	pci_enable_pcie_error_reporting(pdev);
+	pci_save_state(pdev);
+
 	return 0;
 
  unmap:
@@ -2402,8 +2407,10 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 		pci_release_regions(dev->pci_dev);
 	}
 
-	if (pci_is_enabled(dev->pci_dev))
+	if (pci_is_enabled(dev->pci_dev)) {
+		pci_disable_pcie_error_reporting(dev->pci_dev);
 		pci_disable_device(dev->pci_dev);
+	}
 }
 
 struct nvme_delq_ctx {
@@ -2930,11 +2937,8 @@ static void nvme_remove(struct pci_dev *pdev)
 }
 
 /* These functions are yet to be implemented */
-#define nvme_error_detected NULL
 #define nvme_dump_registers NULL
 #define nvme_link_reset NULL
-#define nvme_slot_reset NULL
-#define nvme_error_resume NULL
 
 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
@@ -2961,6 +2965,47 @@ static int nvme_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
 
+static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
+						pci_channel_state_t state)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	dev_warn(&pdev->dev, "%s\n", __func__);
+
+	switch (state) {
+	case pci_channel_io_normal:
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	case pci_channel_io_frozen:
+		nvme_dev_shutdown(dev);
+		return PCI_ERS_RESULT_NEED_RESET;
+	case pci_channel_io_perm_failure:
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	dev_warn(&pdev->dev, "%s\n", __func__);
+	pci_restore_state(pdev);
+
+	/* I've no idea why this is necessary, but device fails to initialize
+	 * if delay is removed or any lower.
+	 */
+	msleep(100);
+
+	if (!nvme_dev_resume(dev))
+		return PCI_ERS_RESULT_RECOVERED;
+	return PCI_ERS_RESULT_DISCONNECT;
+}
+
+static void nvme_error_resume(struct pci_dev *pdev)
+{
+	dev_info(&pdev->dev, "%s\n", __func__);
+	pci_cleanup_aer_uncorrect_error_status(pdev);
+}
+
 static const struct pci_error_handlers nvme_err_handler = {
 	.error_detected	= nvme_error_detected,
 	.mmio_enabled	= nvme_dump_registers,
-- 
1.7.10.4
