From: hch@lst.de (Christoph Hellwig)
Date: Mon, 30 Nov 2015 09:40:15 +0100
Subject: [PATCH 2/9] nvme: add explicit quirk handling
In-Reply-To: <1448872822-4789-1-git-send-email-hch@lst.de>
References: <1448872822-4789-1-git-send-email-hch@lst.de>
Message-ID: <1448872822-4789-3-git-send-email-hch@lst.de>

Add an enum for all workarounds not in the spec and identify the affected
controllers at probe time.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/nvme.h | 13 +++++++++++++
 drivers/nvme/host/pci.c  |  8 +++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3b3f855..f7f16e3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -32,6 +32,18 @@ enum {
 	NVME_NS_LIGHTNVM	= 1,
 };
 
+/*
+ * List of workarounds for devices that required behavior not specified in
+ * the standard.
+ */
+enum nvme_quirks {
+	/*
+	 * Prefers I/O aligned to a stripe size specified in a vendor
+	 * specific Identify field.
+	 */
+	NVME_QUIRK_STRIPE_SIZE			= (1 << 0),
+};
+
 struct nvme_ctrl {
 	const struct nvme_ctrl_ops *ops;
 	struct request_queue *admin_q;
@@ -47,6 +59,7 @@ struct nvme_ctrl {
 	u16 abort_limit;
 	u8 event_limit;
 	u8 vwc;
+	unsigned long quirks;
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e0f40af..27d7449 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2026,7 +2026,6 @@ static void nvme_dev_scan(struct work_struct *work)
  */
 static int nvme_dev_add(struct nvme_dev *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int res;
 	struct nvme_id_ctrl *ctrl;
 	int shift = NVME_CAP_MPSMIN(lo_hi_readq(dev->bar + NVME_REG_CAP)) + 12;
@@ -2047,8 +2046,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
 	else
 		dev->max_hw_sectors = UINT_MAX;
-	if ((pdev->vendor == PCI_VENDOR_ID_INTEL) &&
-			(pdev->device == 0x0953) && ctrl->vs[3]) {
+
+	if ((dev->ctrl.quirks & NVME_QUIRK_STRIPE_SIZE) && ctrl->vs[3]) {
 		unsigned int max_hw_sectors;
 
 		dev->stripe_size = 1 << (ctrl->vs[3] + shift);
@@ -2719,6 +2718,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev->ctrl.ops = &nvme_pci_ctrl_ops;
 	dev->ctrl.dev = dev->dev;
+	dev->ctrl.quirks = id->driver_data;
 
 	result = nvme_set_instance(dev);
 	if (result)
@@ -2846,6 +2846,8 @@ static const struct pci_error_handlers nvme_err_handler = {
 #define PCI_CLASS_STORAGE_EXPRESS	0x010802
 
 static const struct pci_device_id nvme_id_table[] = {
+	{ PCI_VDEVICE(INTEL, 0x0953),
+		.driver_data = NVME_QUIRK_STRIPE_SIZE, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ 0, }
-- 
1.9.1
