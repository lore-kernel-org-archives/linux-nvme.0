From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 28 Nov 2017 23:41:17 +0900
Subject: [PATCH] nvme-cli: resync nvme.h with the kernel's
Message-ID: <1511880077-30443-1-git-send-email-minwoo.im.dev@gmail.com>

Copy over nvme.h from for-4.15/block tree to a current one in nvme-cli
and fix a few build errors.
---
 linux/nvme.h | 172 +++++++++++++++++++++++++++++++++++++++--------------------
 nvme.c       |   2 +-
 2 files changed, 115 insertions(+), 59 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index 2d5be8f..e21610f 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -32,6 +32,8 @@
 
 #define NVME_RDMA_IP_PORT	4420
 
+#define NVME_NSID_ALL		0xffffffff
+
 enum nvme_subsys_type {
 	NVME_NQN_DISC	= 1,		/* Discovery type target subsystem */
 	NVME_NQN_NVME	= 2,		/* NVME type target subsystem */
@@ -87,7 +89,15 @@ enum {
 	NVMF_RDMA_CMS_RDMA_CM	= 1, /* Sockets based endpoint addressing */
 };
 
-#define NVMF_AQ_DEPTH		32
+#define NVME_AQ_DEPTH		32
+#define NVME_NR_AEN_COMMANDS	1
+#define NVME_AQ_BLK_MQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AEN_COMMANDS)
+
+/*
+ * Subtract one to leave an empty queue entry for 'Full Queue' condition. See
+ * NVM-Express 1.2 specification, section 4.1.2.
+ */
+#define NVME_AQ_MQ_TAG_DEPTH	(NVME_AQ_BLK_MQ_DEPTH - 1)
 
 enum {
 	NVME_REG_CAP	= 0x0000,	/* Controller Capabilities */
@@ -133,19 +143,26 @@ enum {
 enum {
 	NVME_CC_ENABLE		= 1 << 0,
 	NVME_CC_CSS_NVM		= 0 << 4,
+	NVME_CC_EN_SHIFT	= 0,
+	NVME_CC_CSS_SHIFT	= 4,
 	NVME_CC_MPS_SHIFT	= 7,
-	NVME_CC_ARB_RR		= 0 << 11,
-	NVME_CC_ARB_WRRU	= 1 << 11,
-	NVME_CC_ARB_VS		= 7 << 11,
-	NVME_CC_SHN_NONE	= 0 << 14,
-	NVME_CC_SHN_NORMAL	= 1 << 14,
-	NVME_CC_SHN_ABRUPT	= 2 << 14,
-	NVME_CC_SHN_MASK	= 3 << 14,
-	NVME_CC_IOSQES		= NVME_NVM_IOSQES << 16,
-	NVME_CC_IOCQES		= NVME_NVM_IOCQES << 20,
+	NVME_CC_AMS_SHIFT	= 11,
+	NVME_CC_SHN_SHIFT	= 14,
+	NVME_CC_IOSQES_SHIFT	= 16,
+	NVME_CC_IOCQES_SHIFT	= 20,
+	NVME_CC_AMS_RR		= 0 << NVME_CC_AMS_SHIFT,
+	NVME_CC_AMS_WRRU	= 1 << NVME_CC_AMS_SHIFT,
+	NVME_CC_AMS_VS		= 7 << NVME_CC_AMS_SHIFT,
+	NVME_CC_SHN_NONE	= 0 << NVME_CC_SHN_SHIFT,
+	NVME_CC_SHN_NORMAL	= 1 << NVME_CC_SHN_SHIFT,
+	NVME_CC_SHN_ABRUPT	= 2 << NVME_CC_SHN_SHIFT,
+	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
+	NVME_CC_IOSQES		= NVME_NVM_IOSQES << NVME_CC_IOSQES_SHIFT,
+	NVME_CC_IOCQES		= NVME_NVM_IOCQES << NVME_CC_IOCQES_SHIFT,
 	NVME_CSTS_RDY		= 1 << 0,
 	NVME_CSTS_CFS		= 1 << 1,
 	NVME_CSTS_NSSRO		= 1 << 4,
+	NVME_CSTS_PP		= 1 << 5,
 	NVME_CSTS_SHST_NORMAL	= 0 << 2,
 	NVME_CSTS_SHST_OCCUR	= 1 << 2,
 	NVME_CSTS_SHST_CMPLT	= 2 << 2,
@@ -217,7 +234,9 @@ struct nvme_id_ctrl {
 	__le16			mntmt;
 	__le16			mxtmt;
 	__le32			sanicap;
-	__u8			rsvd332[180];
+	__le32			hmminds;
+	__le16			hmmaxd;
+	__u8			rsvd338[174];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
@@ -251,10 +270,12 @@ enum {
 	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
 	NVME_CTRL_ONCS_DSM			= 1 << 2,
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
+	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
-	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 7,
+	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
+	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
 };
 
 struct nvme_lbaf {
@@ -380,6 +401,28 @@ struct nvme_smart_log {
 	__u8			rsvd232[280];
 };
 
+struct nvme_fw_slot_info_log {
+	__u8			afi;
+	__u8			rsvd1[7];
+	__le64			frs[7];
+	__u8			rsvd64[448];
+};
+
+enum {
+	NVME_CMD_EFFECTS_CSUPP		= 1 << 0,
+	NVME_CMD_EFFECTS_LBCC		= 1 << 1,
+	NVME_CMD_EFFECTS_NCC		= 1 << 2,
+	NVME_CMD_EFFECTS_NIC		= 1 << 3,
+	NVME_CMD_EFFECTS_CCC		= 1 << 4,
+	NVME_CMD_EFFECTS_CSE_MASK	= 3 << 16,
+};
+
+struct nvme_effects_log {
+	__le32 acs[256];
+	__le32 iocs[256];
+	__u8   resv[2048];
+};
+
 enum {
 	NVME_SMART_CRIT_SPARE		= 1 << 0,
 	NVME_SMART_CRIT_TEMPERATURE	= 1 << 1,
@@ -389,7 +432,12 @@ enum {
 };
 
 enum {
+	NVME_AER_ERROR			= 0,
+	NVME_AER_SMART			= 1,
+	NVME_AER_CSS			= 6,
+	NVME_AER_VS			= 7,
 	NVME_AER_NOTICE_NS_CHANGED	= 0x0002,
+	NVME_AER_NOTICE_FW_ACT_STARTING = 0x0102,
 };
 
 struct nvme_lba_range_type {
@@ -418,7 +466,7 @@ struct nvme_reservation_status {
 	__u8	regctl[2];
 	__u8	resv5[2];
 	__u8	ptpls;
-	__u8	resv10[14];
+	__u8	resv10[13];
 	struct {
 		__le16	cntlid;
 		__u8	rcsts;
@@ -473,12 +521,14 @@ enum nvme_opcode {
  *
  * @NVME_SGL_FMT_ADDRESS:     absolute address of the data block
  * @NVME_SGL_FMT_OFFSET:      relative offset of the in-capsule data block
+ * @NVME_SGL_FMT_TRANSPORT_A: transport defined format, value 0xA
  * @NVME_SGL_FMT_INVALIDATE:  RDMA transport specific remote invalidation
  *                            request subtype
  */
 enum {
 	NVME_SGL_FMT_ADDRESS		= 0x00,
 	NVME_SGL_FMT_OFFSET		= 0x01,
+	NVME_SGL_FMT_TRANSPORT_A	= 0x0A,
 	NVME_SGL_FMT_INVALIDATE		= 0x0f,
 };
 
@@ -492,12 +542,16 @@ enum {
  *
  * For struct nvme_keyed_sgl_desc:
  *   @NVME_KEY_SGL_FMT_DATA_DESC:	keyed data block descriptor
+ *
+ * Transport-specific SGL types:
+ *   @NVME_TRANSPORT_SGL_DATA_DESC:	Transport SGL data dlock descriptor
  */
 enum {
 	NVME_SGL_FMT_DATA_DESC		= 0x00,
 	NVME_SGL_FMT_SEG_DESC		= 0x02,
 	NVME_SGL_FMT_LAST_SEG_DESC	= 0x03,
 	NVME_KEY_SGL_FMT_DATA_DESC	= 0x04,
+	NVME_TRANSPORT_SGL_DATA_DESC	= 0x05,
 };
 
 struct nvme_sgl_desc {
@@ -672,13 +726,13 @@ enum nvme_admin_opcode {
 	nvme_admin_download_fw		= 0x11,
 	nvme_admin_ns_attach		= 0x15,
 	nvme_admin_keep_alive		= 0x18,
-	nvme_admin_directive_send       = 0x19,
-	nvme_admin_directive_recv       = 0x1a,
+	nvme_admin_directive_send	= 0x19,
+	nvme_admin_directive_recv	= 0x1a,
 	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
 	nvme_admin_security_recv	= 0x82,
-	nvme_admin_sanitize			= 0x84,
+	nvme_admin_sanitize_nvm		= 0x84,
 };
 
 enum {
@@ -701,6 +755,7 @@ enum {
 	NVME_FEAT_ASYNC_EVENT	= 0x0b,
 	NVME_FEAT_AUTO_PST	= 0x0c,
 	NVME_FEAT_HOST_MEM_BUF	= 0x0d,
+	NVME_FEAT_TIMESTAMP	= 0x0e,
 	NVME_FEAT_KATO		= 0x0f,
 	NVME_FEAT_SW_PROGRESS	= 0x80,
 	NVME_FEAT_HOST_ID	= 0x81,
@@ -709,6 +764,7 @@ enum {
 	NVME_LOG_ERROR		= 0x01,
 	NVME_LOG_SMART		= 0x02,
 	NVME_LOG_FW_SLOT	= 0x03,
+	NVME_LOG_CMD_EFFECTS	= 0x05,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
 	NVME_LOG_SANITIZE	= 0x81,
@@ -720,23 +776,23 @@ enum {
 /* Sanitize and Sanitize Monitor/Log */
 enum {
 	/* Sanitize */
-	NVME_SANITIZE_NO_DEALLOC		= 0x00000200,
-	NVME_SANITIZE_OIPBP				= 0x00000100,
-	NVME_SANITIZE_OWPASS_SHIFT		= 0x00000004,
-	NVME_SANITIZE_AUSE				= 0x00000008,
+	NVME_SANITIZE_NO_DEALLOC	= 0x00000200,
+	NVME_SANITIZE_OIPBP		= 0x00000100,
+	NVME_SANITIZE_OWPASS_SHIFT	= 0x00000004,
+	NVME_SANITIZE_AUSE		= 0x00000008,
 	NVME_SANITIZE_ACT_CRYPTO_ERASE	= 0x00000004,
-	NVME_SANITIZE_ACT_OVERWRITE		= 0x00000003,
+	NVME_SANITIZE_ACT_OVERWRITE	= 0x00000003,
 	NVME_SANITIZE_ACT_BLOCK_ERASE	= 0x00000002,
-	NVME_SANITIZE_ACT_EXIT			= 0x00000001,
+	NVME_SANITIZE_ACT_EXIT		= 0x00000001,
 
 	/* Sanitize Monitor/Log */
-	NVME_SANITIZE_LOG_DATA_LEN				= 0x0014,
+	NVME_SANITIZE_LOG_DATA_LEN		= 0x0014,
 	NVME_SANITIZE_LOG_GLOBAL_DATA_ERASED	= 0x0100,
-	NVME_SANITIZE_LOG_STATUS_MASK			= 0x0007,
-	NVME_SANITIZE_LOG_NEVER_SANITIZED		= 0x0000,
-	NVME_SANITIZE_LOG_COMPLETED_SUCCESS		= 0x0001,
-	NVME_SANITIZE_LOG_IN_PROGESS			= 0x0002,
-	NVME_SANITIZE_LOG_COMPLETED_FAILED		= 0x0003,
+	NVME_SANITIZE_LOG_STATUS_MASK		= 0x0007,
+	NVME_SANITIZE_LOG_NEVER_SANITIZED	= 0x0000,
+	NVME_SANITIZE_LOG_COMPLETED_SUCCESS	= 0x0001,
+	NVME_SANITIZE_LOG_IN_PROGESS		= 0x0002,
+	NVME_SANITIZE_LOG_COMPLETED_FAILED	= 0x0003,
 };
 
 struct nvme_identify {
@@ -861,6 +917,24 @@ struct nvme_get_log_page_command {
 	__u32			rsvd14[2];
 };
 
+struct nvme_directive_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__le32			numd;
+	__u8			doper;
+	__u8			dtype;
+	__le16			dspec;
+	__u8			endir;
+	__u8			tdtype;
+	__u16			rsvd15;
+
+	__u32			rsvd16[3];
+};
+
 /* Sanitize Log Page */
 struct nvme_sanitize_log_page {
 	__le16			progress;
@@ -1001,21 +1075,16 @@ struct nvme_dbbuf {
 	__u32			rsvd12[6];
 };
 
-struct nvme_directive_cmd {
-	__u8			opcode;
-	__u8			flags;
-	__u16			command_id;
-	__le32			nsid;
-	__u64			rsvd2[2];
-	union nvme_data_ptr	dptr;
-	__le32			numd;
-	__u8			doper;
-	__u8			dtype;
-	__le16			dspec;
-	__u8			endir;
-	__u8			tdtype;
-	__u16			rsvd15;
-	__u32			rsvd16[3];
+struct streams_directive_params {
+	__le16	msl;
+	__le16	nssa;
+	__le16	nsso;
+	__u8	rsvd[10];
+	__le32	sws;
+	__le16	sgs;
+	__le16	nsa;
+	__le16	nso;
+	__u8	rsvd2[6];
 };
 
 struct nvme_command {
@@ -1050,7 +1119,7 @@ static inline bool nvme_is_write(struct nvme_command *cmd)
 	 * Why can't we simply have a Fabrics In and Fabrics out command?
 	 */
 	if (unlikely(cmd->common.opcode == nvme_fabrics_command))
-		return cmd->fabrics.opcode & 1;
+		return cmd->fabrics.fctype & 1;
 	return cmd->common.opcode & 1;
 }
 
@@ -1080,7 +1149,7 @@ enum {
 	NVME_SC_SGL_INVALID_OFFSET	= 0x16,
 	NVME_SC_SGL_INVALID_SUBTYPE	= 0x17,
 
-	NVME_SC_SANITIZE_FAILED			= 0x1C,
+	NVME_SC_SANITIZE_FAILED		= 0x1C,
 	NVME_SC_SANITIZE_IN_PROGRESS	= 0x1D,
 
 	NVME_SC_LBA_RANGE		= 0x80,
@@ -1153,19 +1222,6 @@ enum {
 	NVME_SC_UNWRITTEN_BLOCK		= 0x287,
 
 	NVME_SC_DNR			= 0x4000,
-
-
-	/*
-	 * FC Transport-specific error status values for NVME commands
-	 *
-	 * Transport-specific status code values must be in the range 0xB0..0xBF
-	 */
-
-	/* Generic FC failure - catchall */
-	NVME_SC_FC_TRANSPORT_ERROR	= 0x00B0,
-
-	/* I/O failure due to FC ABTS'd */
-	NVME_SC_FC_TRANSPORT_ABORTED	= 0x00B1,
 };
 
 struct nvme_completion {
diff --git a/nvme.c b/nvme.c
index 6dae69f..35b10a7 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1647,7 +1647,7 @@ static int sanitize(int argc, char **argv, struct command *cmd, struct plugin *p
 		sanitize_cdw10 |= NVME_SANITIZE_NO_DEALLOC;
 
 	memset(&admin_cmd, 0, sizeof (admin_cmd));
-	admin_cmd.opcode = nvme_admin_sanitize;
+	admin_cmd.opcode = nvme_admin_sanitize_nvm;
 	admin_cmd.cdw10 = sanitize_cdw10;
 	admin_cmd.cdw11 = sanitize_cdw11;
 
-- 
2.7.4
