From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Thu,  2 May 2019 14:47:54 +0300
Subject: [PATCH v2 03/10] nvme/core: add some more values from the spec
In-Reply-To: <20190502114801.23116-1-mlevitsk@redhat.com>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
Message-ID: <20190502114801.23116-4-mlevitsk@redhat.com>

This adds few defines from the spec,
that will be used in the nvme-mdev driver

Signed-off-by: Maxim Levitsky <mlevitsk at redhat.com>
---
 include/linux/nvme.h | 88 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 20 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c40720cb59ac..653c22baedb1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -144,32 +144,42 @@ enum {
 #define NVME_NVM_IOCQES		4
 
 enum {
-	NVME_CC_ENABLE		= 1 << 0,
-	NVME_CC_CSS_NVM		= 0 << 4,
 	NVME_CC_EN_SHIFT	= 0,
+	NVME_CC_ENABLE		= 1 << NVME_CC_EN_SHIFT,
+
 	NVME_CC_CSS_SHIFT	= 4,
+	NVME_CC_CSS_NVM		= 0 << NVME_CC_CSS_SHIFT,
+
 	NVME_CC_MPS_SHIFT	= 7,
+	NVME_CC_MPS_MASK	= 0xF << NVME_CC_MPS_SHIFT,
+
 	NVME_CC_AMS_SHIFT	= 11,
-	NVME_CC_SHN_SHIFT	= 14,
-	NVME_CC_IOSQES_SHIFT	= 16,
-	NVME_CC_IOCQES_SHIFT	= 20,
 	NVME_CC_AMS_RR		= 0 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_WRRU	= 1 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_VS		= 7 << NVME_CC_AMS_SHIFT,
+	NVME_CC_AMS_MASK	= 0x7 << NVME_CC_AMS_SHIFT,
+
+	NVME_CC_SHN_SHIFT	= 14,
 	NVME_CC_SHN_NONE	= 0 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_NORMAL	= 1 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_ABRUPT	= 2 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
+
+	NVME_CC_IOSQES_SHIFT	= 16,
+	NVME_CC_IOCQES_SHIFT	= 20,
 	NVME_CC_IOSQES		= NVME_NVM_IOSQES << NVME_CC_IOSQES_SHIFT,
 	NVME_CC_IOCQES		= NVME_NVM_IOCQES << NVME_CC_IOCQES_SHIFT,
+
 	NVME_CSTS_RDY		= 1 << 0,
 	NVME_CSTS_CFS		= 1 << 1,
 	NVME_CSTS_NSSRO		= 1 << 4,
 	NVME_CSTS_PP		= 1 << 5,
-	NVME_CSTS_SHST_NORMAL	= 0 << 2,
-	NVME_CSTS_SHST_OCCUR	= 1 << 2,
-	NVME_CSTS_SHST_CMPLT	= 2 << 2,
-	NVME_CSTS_SHST_MASK	= 3 << 2,
+
+	NVME_CSTS_SHST_SHIFT	= 2,
+	NVME_CSTS_SHST_NORMAL	= 0 << NVME_CSTS_SHST_SHIFT,
+	NVME_CSTS_SHST_OCCUR	= 1 << NVME_CSTS_SHST_SHIFT,
+	NVME_CSTS_SHST_CMPLT	= 2 << NVME_CSTS_SHST_SHIFT,
+	NVME_CSTS_SHST_MASK	= 3 << NVME_CSTS_SHST_SHIFT,
 };
 
 struct nvme_id_power_state {
@@ -396,6 +406,20 @@ enum {
 	NVME_NIDT_UUID		= 0x03,
 };
 
+struct nvme_err_log_entry {
+	__u8			err_count[8];
+	__le16			sqid;
+	__le16			cid;
+	__le16			status;
+	__le16			location;
+	__u8			lba[8];
+	__le32			ns;
+	__u8			vnd;
+	__u8			rsvd1[3];
+	__u8			cmd_specific[8];
+	__u8			rsvd2[24];
+};
+
 struct nvme_smart_log {
 	__u8			critical_warning;
 	__u8			temperature[2];
@@ -483,13 +507,30 @@ enum {
 	NVME_AER_VS			= 7,
 };
 
-enum {
-	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
-	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
-	NVME_AER_NOTICE_ANA		= 0x03,
-	NVME_AER_NOTICE_DISC_CHANGED	= 0xf0,
+enum nvme_async_event_type {
+	NVME_AER_TYPE_ERROR	= 0,
+	NVME_AER_TYPE_SMART	= 1,
+	NVME_AER_TYPE_NOTICE	= 2,
+	NVME_AER_TYPE_MAX	= 7,
 };
 
+enum nvme_async_event {
+	NVME_AER_ERROR_INVALID_DB_REG = 0,
+	NVME_AER_ERROR_INVALID_DB_VALUE = 1,
+	NVME_AER_ERROR_DIAG_FAILURE = 2,
+	NVME_AER_ERROR_PERSISTENT_INT_ERR = 3,
+	NVME_AER_ERROR_TRANSIENT_INT_ERR = 4,
+	NVME_AER_ERROR_FW_IMAGE_LOAD_ERR = 5,
+
+	NVME_AER_SMART_SUBSYS_RELIABILITY = 0,
+	NVME_AER_SMART_TEMP_THRESH = 1,
+	NVME_AER_SMART_SPARE_BELOW_THRESH = 2,
+
+	NVME_AER_NOTICE_NS_CHANGED	= 0,
+	NVME_AER_NOTICE_FW_ACT_STARTING = 1,
+	NVME_AER_NOTICE_ANA		= 3,
+	NVME_AER_NOTICE_DISC_CHANGED	= 0xf0,
+};
 enum {
 	NVME_AEN_BIT_NS_ATTR		= 8,
 	NVME_AEN_BIT_FW_ACT		= 9,
@@ -540,12 +581,6 @@ struct nvme_reservation_status {
 	} regctl_ds[];
 };
 
-enum nvme_async_event_type {
-	NVME_AER_TYPE_ERROR	= 0,
-	NVME_AER_TYPE_SMART	= 1,
-	NVME_AER_TYPE_NOTICE	= 2,
-};
-
 /* I/O commands */
 
 enum nvme_opcode {
@@ -697,10 +732,19 @@ enum {
 	NVME_RW_DSM_LATENCY_LOW		= 3 << 4,
 	NVME_RW_DSM_SEQ_REQ		= 1 << 6,
 	NVME_RW_DSM_COMPRESSED		= 1 << 7,
+
+	NVME_WZ_DEAC			= 1 << 9,
 	NVME_RW_PRINFO_PRCHK_REF	= 1 << 10,
 	NVME_RW_PRINFO_PRCHK_APP	= 1 << 11,
 	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
 	NVME_RW_PRINFO_PRACT		= 1 << 13,
+
+	NVME_RW_PRINFO			=
+			NVME_RW_PRINFO_PRCHK_REF |
+			NVME_RW_PRINFO_PRCHK_APP |
+			NVME_RW_PRINFO_PRCHK_GUARD |
+			NVME_RW_PRINFO_PRACT,
+
 	NVME_RW_DTYPE_STREAMS		= 1 << 4,
 };
 
@@ -801,6 +845,7 @@ enum {
 	NVME_SQ_PRIO_HIGH	= (1 << 1),
 	NVME_SQ_PRIO_MEDIUM	= (2 << 1),
 	NVME_SQ_PRIO_LOW	= (3 << 1),
+	NVME_SQ_PRIO_MASK	= (3 << 1),
 	NVME_FEAT_ARBITRATION	= 0x01,
 	NVME_FEAT_POWER_MGMT	= 0x02,
 	NVME_FEAT_LBA_RANGE	= 0x03,
@@ -1143,6 +1188,7 @@ struct streams_directive_params {
 
 struct nvme_command {
 	union {
+		__le32 dwords[16];
 		struct nvme_common_command common;
 		struct nvme_rw_command rw;
 		struct nvme_identify identify;
@@ -1214,6 +1260,8 @@ enum {
 	NVME_SC_SGL_INVALID_METADATA	= 0x10,
 	NVME_SC_SGL_INVALID_TYPE	= 0x11,
 
+	NVME_SC_PRP_OFFSET_INVALID	= 0x13,
+
 	NVME_SC_SGL_INVALID_OFFSET	= 0x16,
 	NVME_SC_SGL_INVALID_SUBTYPE	= 0x17,
 
-- 
2.17.2
