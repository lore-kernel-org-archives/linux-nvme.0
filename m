From: hch@lst.de (Christoph Hellwig)
Date: Mon, 30 Nov 2015 09:36:16 +0100
Subject: [PATCH 06/23] nvme: use vendor it from identify
In-Reply-To: <1448872593-4096-1-git-send-email-hch@lst.de>
References: <1448872593-4096-1-git-send-email-hch@lst.de>
Message-ID: <1448872593-4096-7-git-send-email-hch@lst.de>

Use the vendor ID from the identify data instead of the PCI device to
make the SCSI translation layer independent from the PCI driver.  The NVMe
spec defines them as having the same value for current PCIe devices.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/scsi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index b42cf44..0bf90b6 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -649,6 +649,8 @@ static int nvme_fill_device_id_scsi_string(struct nvme_ns *ns,
 		struct sg_io_hdr *hdr, u8 *inq_response, int alloc_len)
 {
 	struct nvme_dev *dev = ns->dev;
+	struct nvme_id_ctrl *id_ctrl;
+	int nvme_sc, res;
 
 	if (alloc_len < 72) {
 		return nvme_trans_completion(hdr,
@@ -657,6 +659,11 @@ static int nvme_fill_device_id_scsi_string(struct nvme_ns *ns,
 				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
 	}
 
+	nvme_sc = nvme_identify_ctrl(dev, &id_ctrl);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (res)
+		return res;
+
 	memset(inq_response, 0, alloc_len);
 	inq_response[1] = INQ_DEVICE_IDENTIFICATION_PAGE;
 	inq_response[3] = 0x48;	/* Page Length */
@@ -667,12 +674,14 @@ static int nvme_fill_device_id_scsi_string(struct nvme_ns *ns,
 	inq_response[6] = 0x00;	/* Rsvd */
 	inq_response[7] = 0x44;	/* Designator Length */
 
-	sprintf(&inq_response[8], "%04x", to_pci_dev(dev->dev)->vendor);
+	sprintf(&inq_response[8], "%04x", le16_to_cpu(id_ctrl->vid));
 	memcpy(&inq_response[12], dev->model, sizeof(dev->model));
 	sprintf(&inq_response[52], "%04x", cpu_to_be32(ns->ns_id));
 	memcpy(&inq_response[56], dev->serial, sizeof(dev->serial));
 
-	return nvme_trans_copy_to_user(hdr, inq_response, alloc_len);
+	res = nvme_trans_copy_to_user(hdr, inq_response, alloc_len);
+	kfree(id_ctrl);
+	return res;
 }
 
 static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
-- 
1.9.1
