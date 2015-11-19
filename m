From: keith.busch@intel.com (Keith Busch)
Date: Thu, 19 Nov 2015 13:58:49 -0700
Subject: [RESEND PATCH] NVMe: Add pci error handlers
Message-ID: <1447966729-23141-1-git-send-email-keith.busch@intel.com>

Shutdown controller on error for impending reset, then resume after
slot reset.

Cc: Matthew Wilcox <willy at linux.intel.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
This is just a merge up from something I posted long ago:

  http://lists.infradead.org/pipermail/linux-nvme/2014-July/001073.html

And Kelly re-did this earlier this year as well:

  http://lists.infradead.org/pipermail/linux-nvme/2015-June/001949.html

We've heard from a few testers that this is successful and necessary to
recover from some errors, but this is getting more attention priority now,
otherwise I'd have made a fuss for its inclusion earlier.

 drivers/nvme/host/pci.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 394fd16..eb3adf4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -12,6 +12,7 @@
  * more details.
  */
 
+#include <linux/aer.h>
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
@@ -2704,6 +2705,8 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	if (readl(&dev->bar->vs) >= NVME_VS(1, 2))
 		dev->cmb = nvme_map_cmb(dev);
 
+	pci_enable_pcie_error_reporting(pdev);
+	pci_save_state(pdev);
 	return 0;
 
  unmap:
@@ -2731,8 +2734,10 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 		pci_release_regions(pdev);
 	}
 
-	if (pci_is_enabled(pdev))
+	if (pci_is_enabled(pdev)) {
+		pci_disable_pcie_error_reporting(pdev);
 		pci_disable_device(pdev);
+	}
 }
 
 struct nvme_delq_ctx {
@@ -3361,11 +3366,8 @@ static void nvme_remove(struct pci_dev *pdev)
 }
 
 /* These functions are yet to be implemented */
-#define nvme_error_detected NULL
 #define nvme_dump_registers NULL
 #define nvme_link_reset NULL
-#define nvme_slot_reset NULL
-#define nvme_error_resume NULL
 
 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
@@ -3389,6 +3391,40 @@ static int nvme_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
 
+static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
+						pci_channel_state_t state)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	dev_warn(&pdev->dev, "%s: state:%d\n", __func__, state);
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
+	dev_info(&pdev->dev, "%s\n", __func__);
+	pci_restore_state(pdev);
+	schedule_work(&dev->probe_work);
+	return PCI_ERS_RESULT_RECOVERED;
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
2.6.2.307.g37023ba
