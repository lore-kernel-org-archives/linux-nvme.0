From: keith.busch@intel.com (Keith Busch)
Date: Fri,  9 Jan 2015 09:54:07 -0700
Subject: [PATCHv4 for-3.20] NVMe: Update SCSI Inquiry VPD 83h translation
Message-ID: <1420822447-10486-1-git-send-email-keith.busch@intel.com>

The original translation reference created collisions on VPD 83 for
many existing devices. Later specifications provided other ways to
translate based on the device's version and can be used to create unique
identifiers.

The 1.1 spec provides an EUI64 field that uniquely identifies each
namespace, and 1.2 added the longer NGUID field for the same reason.
Both follow the IEEE EUI format and readily translate to the SCSI device
identification EUI designator type 2h. For devices implementing either,
the translation will use this type, defaulting to the EUI64 8-byte
type if implemented then NGUID's 16 byte version if not. If neither are
implemented, the 1.0 translation is used, and is updated to use the SCSI
String format to guarantee a unique identifier.

Since the Identify Namespace structure required an update for the NGUID
field, this patch adds the remaining new 1.2 fields to the structure.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v3->v4:

  Used the correct patch this time, using designator type 2h.

  Fixed the named reserved field offset in identify namespace.

 drivers/block/nvme-scsi.c |   94 +++++++++++++++++++++++++--------------------
 include/uapi/linux/nvme.h |   10 ++++-
 2 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 4fb9531..87fdd2b 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -782,10 +782,8 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	struct nvme_dev *dev = ns->dev;
 	dma_addr_t dma_addr;
 	void *mem;
-	struct nvme_id_ctrl *id_ctrl;
 	int res = SNTI_TRANSLATION_SUCCESS;
 	int nvme_sc;
-	u8 ieee[4];
 	int xfer_len;
 	__be32 tmp_id = cpu_to_be32(ns->ns_id);
 
@@ -796,46 +794,60 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		goto out_dma;
 	}
 
-	/* nvme controller identify */
-	nvme_sc = nvme_identify(dev, 0, 1, dma_addr);
-	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		goto out_free;
-	if (nvme_sc) {
-		res = nvme_sc;
-		goto out_free;
-	}
-	id_ctrl = mem;
-
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
+	if (readl(&dev->bar->vs) >= NVME_VERSION(1, 1)) {
+		struct nvme_id_ns *id_ns = mem;
+		void *eui = id_ns->eui64;
+		int len = sizeof(id_ns->eui64);
 
-	xfer_len = min(alloc_len, STANDARD_INQUIRY_LENGTH);
+		nvme_sc = nvme_identify(dev, ns->ns_id, 0, dma_addr);
+		res = nvme_trans_status_code(hdr, nvme_sc);
+		if (res)
+			goto out_free;
+		if (nvme_sc) {
+			res = nvme_sc;
+			goto out_free;
+		}
+
+		if (readl(&dev->bar->vs) >= NVME_VERSION(1, 2)) {
+			if (bitmap_empty(eui, len * 8)) {
+				eui = id_ns->nguid;
+				len = sizeof(id_ns->nguid);
+			}
+		}
+		if (bitmap_empty(eui, len * 8))
+			goto scsi_string;
+
+		inq_response[3] = 4 + len; /* Page Length */
+		/* Designation Descriptor start */
+		inq_response[4] = 0x01;    /* Proto ID=0h | Code set=1h */
+		inq_response[5] = 0x02;    /* PIV=0b | Asso=00b | Designator Type=2h */
+		inq_response[6] = 0x00;    /* Rsvd */
+		inq_response[7] = len;     /* Designator Length */
+		memcpy(&inq_response[8], eui, len);
+	} else {
+ scsi_string:
+		if (alloc_len < 72) {
+			res = nvme_trans_completion(hdr,
+					SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+			goto out_free;
+		}
+		inq_response[3] = 0x48;    /* Page Length */
+		/* Designation Descriptor start */
+		inq_response[4] = 0x03;    /* Proto ID=0h | Code set=3h */
+		inq_response[5] = 0x08;    /* PIV=0b | Asso=00b | Designator Type=8h */
+		inq_response[6] = 0x00;    /* Rsvd */
+		inq_response[7] = 0x44;    /* Designator Length */
+
+		sprintf(&inq_response[8], "%04x", dev->pci_dev->vendor);
+		memcpy(&inq_response[12], dev->model, sizeof(dev->model));
+		sprintf(&inq_response[52], "%04x", tmp_id);
+		memcpy(&inq_response[56], dev->serial, sizeof(dev->serial));
+	}
+	xfer_len = alloc_len;
 	res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
 
  out_free:
@@ -2244,7 +2256,7 @@ static int nvme_trans_inquiry(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	page_code = GET_INQ_PAGE_CODE(cmd);
 	alloc_len = GET_INQ_ALLOC_LENGTH(cmd);
 
-	inq_response = kmalloc(STANDARD_INQUIRY_LENGTH, GFP_KERNEL);
+	inq_response = kmalloc(alloc_len, GFP_KERNEL);
 	if (inq_response == NULL) {
 		res = -ENOMEM;
 		goto out_mem;
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 26386cf..9e102e4 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -115,7 +115,13 @@ struct nvme_id_ns {
 	__le16			nawun;
 	__le16			nawupf;
 	__le16			nacwu;
-	__u8			rsvd40[80];
+	__le16			nabsn;
+	__le16			nabo;
+	__le16			nabspf;
+	__u16			rsvd46;
+	__le64			nvmcap[2];
+	__u8			rsvd64[40];
+	__u8			nguid[16];
 	__u8			eui64[8];
 	struct nvme_lbaf	lbaf[16];
 	__u8			rsvd192[192];
@@ -556,4 +562,6 @@ struct nvme_passthru_cmd {
 #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
 #define NVME_IOCTL_IO_CMD	_IOWR('N', 0x43, struct nvme_passthru_cmd)
 
+#define NVME_VERSION(major, minor) (((major) << 16) | ((minor) << 8))
+
 #endif /* _UAPI_LINUX_NVME_H */
-- 
1.7.10.4
