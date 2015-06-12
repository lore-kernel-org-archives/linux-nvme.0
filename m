From: kelly.n.kaoudis@intel.com (kelly.n.kaoudis@intel.com)
Date: Fri, 12 Jun 2015 11:51:01 -0600
Subject: [PATCH] handlers for driver based recovery after fatal errs
Message-ID: <1434131461-14724-1-git-send-email-kelly.n.kaoudis@intel.com>

From: Kelly Nicole Kaoudis <kelly.n.kaoudis@intel.com>

Add functionality to allow for advanced error reporting (such as reporting
of aborts and unsupported actions) as well as graceful recovery from
correctable, uncorrectable nonfatal, and uncorrectable fatal errors.
Device IO resumes upon error recovery.

Signed-off-by: Kelly Nicole Kaoudis <kelly.n.kaoudis at intel.com>
---
 drivers/block/nvme-core.c |   49 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 326abff..44ae031 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -13,6 +13,7 @@
  */

 #include <linux/nvme.h>
+#include <linux/aer.h>
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
@@ -2423,6 +2424,8 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
+	pci_enable_pcie_error_reporting(pdev);
+	pci_save_state(pdev);

 	return 0;

@@ -2432,6 +2435,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
  disable:
 	pci_release_regions(pdev);
  disable_pci:
+	pci_disable_pcie_error_reporting(pdev);
 	pci_disable_device(pdev);
 	return result;
 }
@@ -2451,9 +2455,11 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 		pci_release_regions(pdev);
 	}

-	if (pci_is_enabled(pdev))
+	if (pci_is_enabled(pdev)) {
+		pci_disable_pcie_error_reporting(pdev);
 		pci_disable_device(pdev);
 	}
+}

 struct nvme_delq_ctx {
 	struct task_struct *waiter;
@@ -3136,11 +3142,46 @@ static void nvme_remove(struct pci_dev *pdev)
 }

 /* These functions are yet to be implemented */
-#define nvme_error_detected NULL
 #define nvme_dump_registers NULL
 #define nvme_link_reset NULL
-#define nvme_slot_reset NULL
-#define nvme_error_resume NULL
+
+static void nvme_error_resume(struct pci_dev *pdev)
+{
+	pci_cleanup_aer_uncorrect_error_status(pdev);
+	pci_restore_state(pdev);
+
+	pci_save_state(pdev);
+}
+
+static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
+		enum pci_channel_state state)
+{
+	pci_ers_result_t ret = PCI_ERS_RESULT_NEED_RESET;
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	dev_warn(&pdev->dev, "%s: channel state is %d\n", __func__, state);
+
+	if (state == pci_channel_io_normal)
+		ret = PCI_ERS_RESULT_CAN_RECOVER;
+	else
+		nvme_dev_shutdown(dev);
+
+	return ret;
+}
+
+/* called by aerdrv if nvme_error_detected returns PCI_ERS_RESULT_NEED_RESET */
+static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
+{
+	pci_ers_result_t ret = PCI_ERS_RESULT_DISCONNECT;
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	queue_work(nvme_workq, &dev->probe_work);
+	flush_work(&dev->probe_work);
+
+	ret = PCI_ERS_RESULT_RECOVERED;
+
+	return ret;
+}

 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
--
1.7.10.4
