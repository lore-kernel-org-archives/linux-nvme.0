From: sunad.s@samsung.com (Sunad Bhandary S)
Date: Mon, 23 Mar 2015 19:18:13 +0530
Subject: [PATCHv3] NVMe: write_long SCSI to NVMe translation implementation
Message-ID: <1427118493-29227-1-git-send-email-sunad.s@samsung.com>

From: Sunad Bhandary S <sunad.s@samsung.com>

This patch implements the SCSI to NVMe translation for write_long.
write_long is translated to the NVMe command write_uncorrectable as
defined by the translation specification version 1.4.

This patch also indicates the device support for write_uncorrectable
method in the response of extended inquiry as defined in the translation
spec.

This patch is based on for-linus branch.

Changes:
v1 -> v2 : __le32 nlb field changed to __le16 nlb followed by __u16
rsvd.
v2 -> v3 : Check for SAO16 value for write_long_16.

Signed-off-by: Sunad Bhandary S <sunad.s at samsung.com>
---
 drivers/block/nvme-scsi.c | 78 +++++++++++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/nvme.h | 13 ++++++++
 2 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index e10196e..3b778e4 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -245,6 +245,17 @@ static int sg_version_num = 30534;	/* 2 digits for each component */
 /* Report LUNs defines */
 #define REPORT_LUNS_FIRST_LUN_OFFSET			8
 
+/*Write Long defines */
+#define WRITE_LONG_CDB_COR_DIS_OFFSET			1
+#define WRITE_LONG_CDB_COR_DIS_MASK			0x80
+#define WRITE_LONG_CDB_WR_UNCOR_OFFSET			1
+#define WRITE_LONG_CDB_WR_UNCOR_MASK			0x40
+#define WRITE_LONG_CDB_PBLOCK_OFFSET			1
+#define WRITE_LONG_CDB_PBLOCK_MASK			0x20
+#define WRITE_LONG_CDB_LBA_OFFSET			2
+#define WRITE_LONG_SAO_MASK				0x1F
+#define SAO_WRITE_LONG_16				0x11
+
 /* SCSI ADDITIONAL SENSE Codes */
 
 #define SCSI_ASC_NO_SENSE				0x00
@@ -331,6 +342,10 @@ INQUIRY_EVPD_BIT_MASK) ? 1 : 0)
 #define IS_READ_CAP_16(cdb)					\
 ((cdb[0] == SERVICE_ACTION_IN_16 && cdb[1] == SAI_READ_CAPACITY_16) ? 1 : 0)
 
+#define IS_WRITE_LONG_16(cdb)					\
+((cdb[0] == SERVICE_ACTION_OUT_16 &&				\
+(cdb[1] & WRITE_LONG_SAO_MASK) == SAO_WRITE_LONG_16) ? 1 : 0)
+
 /* Request Sense Helper Macros */
 #define GET_REQUEST_SENSE_ALLOC_LENGTH(cdb)			\
 (GET_U8_FROM_CDB(cdb, REQUEST_SENSE_CDB_ALLOC_LENGTH_OFFSET))
@@ -871,7 +886,7 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	u8 spt_lut[8] = {0, 0, 2, 1, 4, 6, 5, 7};
 	u8 grd_chk, app_chk, ref_chk, protect;
 	u8 uask_sup = 0x20;
-	u8 v_sup;
+	u8 v_sup, wrt_uncor, wu_sup, cd_sup;
 	u8 luiclr = 0x01;
 
 	inq_response = kmalloc(EXTENDED_INQUIRY_DATA_PAGE_LENGTH, GFP_KERNEL);
@@ -914,6 +929,10 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	}
 	id_ctrl = mem;
 	v_sup = id_ctrl->vwc;
+	wrt_uncor = (id_ctrl->oncs &
+				NVME_CTRL_ONCS_WRITE_UNCORRECTABLE) ? 1 : 0;
+	wu_sup = wrt_uncor << 3;
+	cd_sup = wrt_uncor << 2;
 
 	memset(inq_response, 0, EXTENDED_INQUIRY_DATA_PAGE_LENGTH);
 	inq_response[1] = INQ_EXTENDED_INQUIRY_DATA_PAGE;    /* Page Code */
@@ -921,7 +940,7 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	inq_response[3] = 0x3C;    /* Page Length LSB */
 	inq_response[4] = microcode | spt | grd_chk | app_chk | ref_chk;
 	inq_response[5] = uask_sup;
-	inq_response[6] = v_sup;
+	inq_response[6] = wu_sup | cd_sup | v_sup;
 	inq_response[7] = luiclr;
 	inq_response[8] = 0;
 	inq_response[9] = 0;
@@ -2916,6 +2935,52 @@ static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	return res;
 }
 
+static int nvme_trans_write_long(struct nvme_ns *ns, struct sg_io_hdr *hdr,
+				u8 *cmd)
+{
+	int res = SNTI_TRANSLATION_SUCCESS;
+	int nvme_sc;
+	struct nvme_command c;
+	u64 slba;
+	u8 cor_dis, wr_uncor, pblock;
+
+	cor_dis = GET_U8_FROM_CDB(cmd, WRITE_LONG_CDB_COR_DIS_OFFSET) &
+					WRITE_LONG_CDB_COR_DIS_MASK;
+	wr_uncor = GET_U8_FROM_CDB(cmd, WRITE_LONG_CDB_WR_UNCOR_OFFSET) &
+					WRITE_LONG_CDB_WR_UNCOR_MASK;
+	pblock = GET_U8_FROM_CDB(cmd, WRITE_LONG_CDB_PBLOCK_OFFSET) &
+					WRITE_LONG_CDB_PBLOCK_MASK;
+
+	if (!cor_dis || !wr_uncor || pblock) {
+		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
+					SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+		goto out;
+	}
+
+	if (cmd[0] == WRITE_LONG)
+		slba = GET_U32_FROM_CDB(cmd, WRITE_LONG_CDB_LBA_OFFSET);
+	else
+		slba = GET_U64_FROM_CDB(cmd, WRITE_LONG_CDB_LBA_OFFSET);
+
+	memset(&c, 0, sizeof(c));
+	c.wu.opcode = nvme_cmd_write_uncor;
+	c.wu.nsid = cpu_to_le32(ns->ns_id);
+	c.wu.slba = cpu_to_le64(slba);
+	c.wu.nlb = 0;
+
+	nvme_sc = nvme_submit_io_cmd(ns->dev, ns, &c, NULL);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (res)
+		goto out;
+	if (nvme_sc)
+		res = nvme_sc;
+
+out:
+	return res;
+}
+
 static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr *hdr)
 {
 	u8 cmd[BLK_MAX_CDB];
@@ -3001,6 +3066,15 @@ static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr *hdr)
 	case UNMAP:
 		retcode = nvme_trans_unmap(ns, hdr, cmd);
 		break;
+	case WRITE_LONG:
+		retcode = nvme_trans_write_long(ns, hdr, cmd);
+		break;
+	case SERVICE_ACTION_OUT_16:
+		if (IS_WRITE_LONG_16(cmd))
+			retcode = nvme_trans_write_long(ns, hdr, cmd);
+		else
+			goto out;
+		break;
 	default:
  out:
 		retcode = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index aef9a81..068db6d 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -310,6 +310,18 @@ struct nvme_dsm_range {
 	__le64			slba;
 };
 
+struct nvme_write_uncor_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u32			rsvd2[8];
+	__le64			slba;
+	__le16			nlb;
+	__u16			rsvd;
+	__u32			rsvd13[3];
+};
+
 /* Admin commands */
 
 enum nvme_admin_opcode {
@@ -469,6 +481,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_write_uncor_cmd wu;
 		struct nvme_abort_cmd abort;
 	};
 };
-- 
1.8.3.2
