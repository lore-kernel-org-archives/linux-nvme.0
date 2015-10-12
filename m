From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Oct 2015 09:10:07 +0200
Subject: [PATCH 4/8] nvme: add explicit quirk handling
In-Reply-To: <1444633811-28319-1-git-send-email-hch@lst.de>
References: <1444633811-28319-1-git-send-email-hch@lst.de>
Message-ID: <1444633811-28319-5-git-send-email-hch@lst.de>

Add an enum for all workarounds not in the spec and identify the affected
controllers at probe time.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/nvme.h | 13 +++++++++++++
 drivers/nvme/host/pci.c  |  8 +++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2efdeaa..3e2e819 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -27,6 +27,18 @@ extern unsigned char nvme_io_timeout;
 extern unsigned char admin_timeout;
 #define ADMIN_TIMEOUT	(admin_timeout * HZ)
 
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
@@ -43,6 +55,7 @@ struct nvme_ctrl {
 	u8 event_limit;
 	u8 vwc;
 	u16 vendor;
+	unsigned long quirks;
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5ad7bab..afe0b69 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2050,7 +2050,6 @@ static void nvme_dev_scan(struct work_struct *work)
  */
 static int nvme_dev_add(struct nvme_dev *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int res;
 	struct nvme_id_ctrl *ctrl;
 	int shift = NVME_CAP_MPSMIN(readq(dev->bar + NVME_REG_CAP)) + 12;
@@ -2069,8 +2068,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	memcpy(dev->ctrl.firmware_rev, ctrl->fr, sizeof(ctrl->fr));
 	if (ctrl->mdts)
 		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
-	if ((pdev->vendor == PCI_VENDOR_ID_INTEL) &&
-			(pdev->device == 0x0953) && ctrl->vs[3]) {
+
+	if ((dev->ctrl.quirks & NVME_QUIRK_STRIPE_SIZE) && ctrl->vs[3]) {
 		unsigned int max_hw_sectors;
 
 		dev->stripe_size = 1 << (ctrl->vs[3] + shift);
@@ -2736,6 +2735,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->ctrl.vendor = pdev->vendor;
 	dev->ctrl.ops = &nvme_pci_ctrl_ops;
 	dev->ctrl.dev = dev->dev;
+	dev->ctrl.quirks = id->driver_data;
 
 	result = nvme_set_instance(dev);
 	if (result)
@@ -2863,6 +2863,8 @@ static const struct pci_error_handlers nvme_err_handler = {
 #define PCI_CLASS_STORAGE_EXPRESS	0x010802
 
 static const struct pci_device_id nvme_id_table[] = {
+	{ PCI_VDEVICE(INTEL, 0x0953),
+		.driver_data = NVME_QUIRK_STRIPE_SIZE, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
 };
-- 
1.9.1
