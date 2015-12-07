From: keith.busch@intel.com (Keith Busch)
Date: Mon,  7 Dec 2015 15:30:31 -0700
Subject: [PATCHv2] NVMe: Add pci error handlers
Message-ID: <1449527431-23749-1-git-send-email-keith.busch@intel.com>

Requests enabling pcie aer support. Shuts down the controller on error
detected with io frozen state prior to requesting slot reset; resumes
controller after reset completes.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Changes from previous version:
  Merged up to Christoph's block repository.

  Removed the NULL function defines and the references to them.

  A comment that says what's happening in the error, with a description
  on how IO restarts through the other error callbacks.

 drivers/nvme/host/pci.c | 54 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b88708a..b82bbea 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -12,6 +12,7 @@
  * more details.
  */
 
+#include <linux/aer.h>
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
@@ -1670,6 +1671,8 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2))
 		dev->cmb = nvme_map_cmb(dev);
 
+	pci_enable_pcie_error_reporting(pdev);
+	pci_save_state(pdev);
 	return 0;
 
  unmap:
@@ -1697,8 +1700,10 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 		pci_release_regions(pdev);
 	}
 
-	if (pci_is_enabled(pdev))
+	if (pci_is_enabled(pdev)) {
+		pci_disable_pcie_error_reporting(pdev);
 		pci_disable_device(pdev);
+	}
 }
 
 struct nvme_delq_ctx {
@@ -2225,13 +2230,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-/* These functions are yet to be implemented */
-#define nvme_error_detected NULL
-#define nvme_dump_registers NULL
-#define nvme_link_reset NULL
-#define nvme_slot_reset NULL
-#define nvme_error_resume NULL
-
 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
 {
@@ -2254,10 +2252,46 @@ static int nvme_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
 
+static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
+						pci_channel_state_t state)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	/*
+	 * A frozen channel requires a reset. When detected, this method will
+	 * shutdown the controller to quiesce. The controller will be restarted
+	 * after the slot reset through driver's slot_reset callback.
+	 */
+	dev_warn(&pdev->dev, "error detected: state:%d\n", state);
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
+	dev_info(&pdev->dev, "restart after slot reset\n");
+	pci_restore_state(pdev);
+	queue_work(nvme_workq, &dev->reset_work);
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void nvme_error_resume(struct pci_dev *pdev)
+{
+	pci_cleanup_aer_uncorrect_error_status(pdev);
+}
+
 static const struct pci_error_handlers nvme_err_handler = {
 	.error_detected	= nvme_error_detected,
-	.mmio_enabled	= nvme_dump_registers,
-	.link_reset	= nvme_link_reset,
 	.slot_reset	= nvme_slot_reset,
 	.resume		= nvme_error_resume,
 	.reset_notify	= nvme_reset_notify,
-- 
2.6.2.307.g37023ba
