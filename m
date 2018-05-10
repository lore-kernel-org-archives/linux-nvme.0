From: keith.busch@intel.com (Keith Busch)
Date: Thu, 10 May 2018 10:01:13 -0600
Subject: [PATCH] nvme/pci: Sync controller reset for AER slot_reset
Message-ID: <20180510160113.4432-1-keith.busch@intel.com>

AER handling expects a successful return from slot_reset means the
driver made the device functional again. The nvme driver had been using
an asynchronous reset to recover the device, so the device
may still be initializing after control is returned to the
AER handler. This creates problems for subsequent event handling,
causing the initializion to fail.

This patch fixes that by syncing the controller reset before returning
to the AER driver, and reporting the true state of the reset.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199657
Reported-by: Alex Gagniuc <mr.nuke.me at gmail.com>
Cc: Sinan Kaya <okaya at codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas at google.com>
Cc: <stable at vger.kernel.org>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b542dce45927..2e221796257a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2681,8 +2681,15 @@ static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
 
 	dev_info(dev->ctrl.device, "restart after slot reset\n");
 	pci_restore_state(pdev);
-	nvme_reset_ctrl(&dev->ctrl);
-	return PCI_ERS_RESULT_RECOVERED;
+	nvme_reset_ctrl_sync(&dev->ctrl);
+
+	switch (dev->ctrl.state) {
+	case NVME_CTRL_LIVE:
+	case NVME_CTRL_ADMIN_ONLY:
+		return PCI_ERS_RESULT_RECOVERED;
+	default:
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
 }
 
 static void nvme_error_resume(struct pci_dev *pdev)
-- 
2.14.3
