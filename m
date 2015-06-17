From: kelly.n.kaoudis@intel.com (Kelly Nicole Kaoudis)
Date: Wed, 17 Jun 2015 09:58:16 -0600
Subject: [PATCH v2] handlers for driver recovery after fatal PCIe errs
Message-ID: <1434556696-19991-1-git-send-email-kelly.n.kaoudis@intel.com>

Add functionality to allow for advanced PCIe error reporting, as
well as graceful recovery from correctable, uncorrectable nonfatal,
and uncorrectable fatal PCIe errors. Device IO resumes properly on recovery.

Signed-off-by: Kelly Nicole Kaoudis <kelly.n.kaoudis at intel.com>
---

Obsoletes the original "handlers for driver based recovery after fatal errs"
version of this patch (this is v2). Differences include
	- removing un-necessary PCI state save from nvme_error_resume
	- moving the PCI state restore into slot_reset so that
		- AER uncorrectable error status register is cleared after
		state restore and
		- IO resumes properly (checked afterward with custom fio
		workload of reads and writes on the nvme device tested with
		this version of the driver)
	- simply returning that the device has recovered from slot_reset since
	we were not doing anything in the case of a disconnect in slot_reset
	anyhow
	- fixing a curly brace issue caused by the -w option to format-patch

Requires series of three: "Initialization error fixups"
(http://lists.infradead.org/pipermail/linux-nvme/2015-June/001915.html)
which allows us to schedule a probe in the same fashion as a resume.

Also requires the aer_inject module and userspace utility if you'd like to
test this out via error injection. aer_inject sets bits in the uncorrectable
error status register, which means I/O stops with writes failing and reads
returning -1 until the device recovers and the PCI state is restored. The
uncorrectable error status register is cleared by calling
pci_cleanup_aer_uncorrect_error_status upon resume.

 drivers/block/nvme-core.c |   44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 326abff..3f6fc30 100644
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
@@ -2451,8 +2455,10 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 		pci_release_regions(pdev);
 	}

-	if (pci_is_enabled(pdev))
+	if (pci_is_enabled(pdev)) {
+		pci_disable_pcie_error_reporting(pdev);
 		pci_disable_device(pdev);
+	}
 }

 struct nvme_delq_ctx {
@@ -3136,11 +3142,41 @@ static void nvme_remove(struct pci_dev *pdev)
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
+static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	pci_restore_state(pdev);
+
+	schedule_work(&dev->probe_work);
+	flush_work(&dev->probe_work);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}

 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
--
1.7.10.4
