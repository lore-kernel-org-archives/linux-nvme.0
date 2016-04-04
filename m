From: keith.busch@intel.com (Keith Busch)
Date: Mon,  4 Apr 2016 14:30:14 -0600
Subject: [PATCH] NVMe: Reduce driver log spamming
Message-ID: <1459801814-4473-1-git-send-email-keith.busch@intel.com>

Reduce error logging when no corrective action is required.

Suggessted-by: Chris Petersen <cpetersen at fb.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5acd6e4..29f31bc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2130,14 +2130,17 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	 * shutdown the controller to quiesce. The controller will be restarted
 	 * after the slot reset through driver's slot_reset callback.
 	 */
-	dev_warn(dev->ctrl.device, "error detected: state:%d\n", state);
 	switch (state) {
 	case pci_channel_io_normal:
 		return PCI_ERS_RESULT_CAN_RECOVER;
 	case pci_channel_io_frozen:
+		dev_warn(dev->ctrl.device,
+			"frozen state error detected, reset controller\n");
 		nvme_dev_disable(dev, false);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
+		dev_warn(dev->ctrl.device,
+			"failure state error detected, request disconnect\n");
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 	return PCI_ERS_RESULT_NEED_RESET;
-- 
2.7.2
