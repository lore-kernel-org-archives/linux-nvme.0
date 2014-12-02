From: keith.busch@intel.com (Keith Busch)
Date: Tue,  2 Dec 2014 12:56:16 -0700
Subject: [PATCH] NVMe: Update SCSI Inquiry VPD 83 translation
Message-ID: <1417550176-14775-1-git-send-email-keith.busch@intel.com>

The original translation reference resulted in collisions on VPD 83 for
many devices today. Later specification revisions provided other ways
to translate based on the device's specification compliance that will
create different identifiers.

For 1.1 commplaint devices, this patch will use the EUI64 field to create
a unique NAA Registerd identifier. If 1.0, the SCSI Name String format
is required to generate unique bits.

This fixes reported problems with customer device managers, but this
is going to be even more important when multipath capable nvme devices
become more common.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-scsi.c |   94 ++++++++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 32 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 49f86d1..b33cff6 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -782,11 +782,10 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	struct nvme_id_ctrl *id_ctrl;
 	int res = SNTI_TRANSLATION_SUCCESS;
 	int nvme_sc;
-	u8 ieee[4];
 	int xfer_len;
 	__be32 tmp_id = cpu_to_be32(ns->ns_id);
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
+	mem = dma_alloc_coherent(&dev->pci_dev->dev, 4096,
 					&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -804,40 +803,71 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	}
 	id_ctrl = mem;
 
-	/* Since SCSI tried to save 4 bits... [SPC-4(r34) Table 591] */
-	ieee[0] = id_ctrl->ieee[0] << 4;
-	ieee[1] = id_ctrl->ieee[0] >> 4 | id_ctrl->ieee[1] << 4;
-	ieee[2] = id_ctrl->ieee[1] >> 4 | id_ctrl->ieee[2] << 4;
-	ieee[3] = id_ctrl->ieee[2] >> 4;
-
-	memset(inq_response, 0, STANDARD_INQUIRY_LENGTH);
+	memset(inq_response, 0, alloc_len);
 	inq_response[1] = INQ_DEVICE_IDENTIFICATION_PAGE;    /* Page Code */
-	inq_response[3] = 20;      /* Page Length */
-	/* Designation Descriptor start */
-	inq_response[4] = 0x01;    /* Proto ID=0h | Code set=1h */
-	inq_response[5] = 0x03;    /* PIV=0b | Asso=00b | Designator Type=3h */
-	inq_response[6] = 0x00;    /* Rsvd */
-	inq_response[7] = 16;      /* Designator Length */
-	/* Designator start */
-	inq_response[8] = 0x60 | ieee[3]; /* NAA=6h | IEEE ID MSB, High nibble*/
-	inq_response[9] = ieee[2];        /* IEEE ID */
-	inq_response[10] = ieee[1];       /* IEEE ID */
-	inq_response[11] = ieee[0];       /* IEEE ID| Vendor Specific ID... */
-	inq_response[12] = (dev->pci_dev->vendor & 0xFF00) >> 8;
-	inq_response[13] = (dev->pci_dev->vendor & 0x00FF);
-	inq_response[14] = dev->serial[0];
-	inq_response[15] = dev->serial[1];
-	inq_response[16] = dev->model[0];
-	inq_response[17] = dev->model[1];
-	memcpy(&inq_response[18], &tmp_id, sizeof(u32));
-	/* Last 2 bytes are zero */
 
-	xfer_len = min(alloc_len, STANDARD_INQUIRY_LENGTH);
+	if (readl(&dev->bar->vs) >= 0x10100) {
+		/* 1.1 requires EUI64 */
+		struct nvme_id_ns *id_ns = mem;
+		u8 ieee[4];
+
+		nvme_sc = nvme_identify(dev, ns->ns_id, 0, dma_addr);
+		res = nvme_trans_status_code(hdr, nvme_sc);
+		if (res)
+			goto out_free;
+		if (nvme_sc) {
+			res = nvme_sc;
+			goto out_free;
+		}
+
+		/* Since SCSI tried to save 4 bits... [SPC-4(r34) Table 591] */
+		ieee[0] = id_ctrl->ieee[0] << 4;
+		ieee[1] = id_ctrl->ieee[0] >> 4 | id_ctrl->ieee[1] << 4;
+		ieee[2] = id_ctrl->ieee[1] >> 4 | id_ctrl->ieee[2] << 4;
+		ieee[3] = id_ctrl->ieee[2] >> 4;
+
+		inq_response[3] = 0x14;    /* Page Length */
+		/* Designation Descriptor start */
+		inq_response[4] = 0x01;    /* Proto ID=0h | Code set=1h */
+		inq_response[5] = 0x03;    /* PIV=0b | Asso=00b | Designator Type=3h */
+		inq_response[6] = 0x03;    /* Rsvd */
+		inq_response[7] = 0x10;    /* Designator Length */
+
+		/* Designator start */
+		inq_response[8] = 0x60 | ieee[3]; /* NAA=6h | IEEE ID MSB, High nibble*/
+		inq_response[9] = ieee[2];        /* IEEE ID */
+		inq_response[10] = ieee[1];       /* IEEE ID */
+		inq_response[11] = ieee[0];       /* IEEE ID| Vendor Specific ID... */
+		memcpy(&inq_response[12], id_ns->eui64, sizeof(id_ns->eui64));
+	} else {
+		u16 vid = dev->pci_dev->vendor;
+
+		if (alloc_len < 72) {
+			res = nvme_trans_completion(hdr,
+					SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+			goto out_free;
+		}
+
+		inq_response[3] = 0x48;    /* Page Length */
+		/* Designation Descriptor start */
+		inq_response[4] = 0x03;    /* Proto ID=0h | Code set=3h */
+		inq_response[5] = 0x08;    /* PIV=0b | Asso=00b | Designator Type=8h */
+		inq_response[6] = 0x00;    /* Rsvd */
+		inq_response[7] = 0x44;    /* Designator Length */
+
+		sprintf(&inq_response[8], "%04x", vid);
+		memcpy(&inq_response[12], dev->model, sizeof(dev->model));
+		sprintf(&inq_response[52], "%04x", tmp_id);
+		memcpy(&inq_response[56], dev->serial, sizeof(dev->serial));
+	}
+
+	xfer_len = alloc_len;
 	res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
 
  out_free:
-	dma_free_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns), mem,
-			  dma_addr);
+	dma_free_coherent(&dev->pci_dev->dev, 4096, mem, dma_addr);
  out_dma:
 	return res;
 }
@@ -2222,7 +2252,7 @@ static int nvme_trans_inquiry(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	page_code = GET_INQ_PAGE_CODE(cmd);
 	alloc_len = GET_INQ_ALLOC_LENGTH(cmd);
 
-	inq_response = kmalloc(STANDARD_INQUIRY_LENGTH, GFP_KERNEL);
+	inq_response = kmalloc(alloc_len, GFP_KERNEL);
 	if (inq_response == NULL) {
 		res = -ENOMEM;
 		goto out_mem;
-- 
1.7.10.4
