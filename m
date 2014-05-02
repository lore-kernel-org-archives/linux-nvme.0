From: keith.busch@intel.com (Keith Busch)
Date: Fri,  2 May 2014 10:40:43 -0600
Subject: [PATCHv2 2/2] NVMe: Implement PCI-e reset notification callback
In-Reply-To: <1399048843-9376-1-git-send-email-keith.busch@intel.com>
References: <1399048843-9376-1-git-send-email-keith.busch@intel.com>
Message-ID: <1399048843-9376-2-git-send-email-keith.busch@intel.com>

Quiesce and shutdown the device prior to reset, then restart the device
and resume IO after.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v2:

fixed compile warning for wrong data type in function (int -> bool).

 drivers/block/nvme-core.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7c64fa7..a842c71 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2775,6 +2775,16 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return result;
 }
 
+static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
+{
+       struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+       if (prepare)
+               nvme_dev_shutdown(dev);
+       else
+               nvme_dev_resume(dev);
+}
+
 static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
@@ -2839,6 +2849,7 @@ static const struct pci_error_handlers nvme_err_handler = {
 	.link_reset	= nvme_link_reset,
 	.slot_reset	= nvme_slot_reset,
 	.resume		= nvme_error_resume,
+	.reset_notify	= nvme_reset_notify,
 };
 
 /* Move to pci_ids.h later */
-- 
1.7.10.4
