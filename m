From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Wed,  5 Apr 2017 16:40:37 -0300
Subject: [PATCH] nvme: avoid NULL pointer dereference in error recovery path
Message-ID: <20170405194037.1019-1-gpiccoli@linux.vnet.ibm.com>

It's possible that driver fails to recover from a PCI error and the
PCI core (or arch PCI specifics, like EEH in PowerPC) starts a process
of device removal. While this removal process is happening, if another
PCI error is triggered, we might have a NULL address for
"struct *nvme_dev", pointed by "pci_dev *driver_data" - for example this
happens if nvme_remove() already have set that pci_dev struct's field
to NULL.

In this case, the driver error handler functions will dereferece a NULL
pointer, causing a kernel oops. This patch checks for NULL pointer on
error handlers and in case "driver_data" points to NULL, it aborts the
error recovery path and return a fail error value to PCI core.

Also, the patch "standardize" the use of "pci_dev dev" as pointer to
"struct device", instead of "nvme_dev->nvme_ctrl.device".

Fixes: a0a3408ee614 ("NVMe: Add pci error handlers")
Cc: stable at vger.kernel.org # v4.5+
Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
---
 drivers/nvme/host/pci.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 26a5fd05fe88..283a930ab6ac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2089,6 +2089,12 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
+	if (!dev) {
+		dev_err(&pdev->dev,
+			"device already removed, aborting error recovery\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
 	/*
 	 * A frozen channel requires a reset. When detected, this method will
 	 * shutdown the controller to quiesce. The controller will be restarted
@@ -2098,12 +2104,12 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	case pci_channel_io_normal:
 		return PCI_ERS_RESULT_CAN_RECOVER;
 	case pci_channel_io_frozen:
-		dev_warn(dev->ctrl.device,
+		dev_warn(&pdev->dev,
 			"frozen state error detected, reset controller\n");
 		nvme_dev_disable(dev, false);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
-		dev_warn(dev->ctrl.device,
+		dev_warn(&pdev->dev,
 			"failure state error detected, request disconnect\n");
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
@@ -2114,7 +2120,13 @@ static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-	dev_info(dev->ctrl.device, "restart after slot reset\n");
+	if (!dev) {
+		dev_err(&pdev->dev,
+			"device already removed, aborting slot reset\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	dev_info(&pdev->dev, "restart after slot reset\n");
 	pci_restore_state(pdev);
 	nvme_reset(dev);
 	return PCI_ERS_RESULT_RECOVERED;
-- 
2.11.0
