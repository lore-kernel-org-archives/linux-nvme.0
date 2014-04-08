From: keith.busch@intel.com (Keith Busch)
Date: Tue,  8 Apr 2014 17:42:21 -0600
Subject: [PATCH 2/2] NVMe: Implement PCI-e reset notification callback
In-Reply-To: <1397000541-1085-1-git-send-email-keith.busch@intel.com>
References: <1397000541-1085-1-git-send-email-keith.busch@intel.com>
Message-ID: <1397000541-1085-2-git-send-email-keith.busch@intel.com>

Disable and shutdown the device prior to reset, and restart the device
after.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 625259d..273ff12 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2605,6 +2605,16 @@ static void nvme_reset_failed_dev(struct work_struct *ws)
 	nvme_dev_reset(dev);
 }
 
+static void nvme_reset_notify(struct pci_dev *pdev, int prepare)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	if (prepare)
+		nvme_dev_shutdown(dev);
+	else
+		nvme_dev_resume(dev);
+}
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int result = -ENOMEM;
@@ -2744,6 +2754,7 @@ static const struct pci_error_handlers nvme_err_handler = {
 	.link_reset	= nvme_link_reset,
 	.slot_reset	= nvme_slot_reset,
 	.resume		= nvme_error_resume,
+	.reset_notify	= nvme_reset_notify,
 };
 
 /* Move to pci_ids.h later */
-- 
1.7.10.4
