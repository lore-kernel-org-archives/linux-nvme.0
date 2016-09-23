From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:22:53 -0700
Subject: [PATCH 02/18] fix linux/nvme.h for use with nvme-cli
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-3-git-send-email-hch@lst.de>

Rename a few fields or constants to be closer to the standards and a few more.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 linux/nvme.h | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index 7676557..c3ed1df 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -182,7 +182,7 @@ struct nvme_id_ctrl {
 	char			fr[8];
 	__u8			rab;
 	__u8			ieee[3];
-	__u8			mic;
+	__u8			cmic;
 	__u8			mdts;
 	__le16			cntlid;
 	__le32			ver;
@@ -202,7 +202,13 @@ struct nvme_id_ctrl {
 	__u8			apsta;
 	__le16			wctemp;
 	__le16			cctemp;
-	__u8			rsvd270[50];
+	__le16			mtfa;
+	__le32			hmpre;
+	__le32			hmmin;
+	__u8			tnvmcap[16];
+	__u8			unvmcap[16];
+	__le32			rpmbs;
+	__u8			rsvd316[4];
 	__le16			kas;
 	__u8			rsvd322[190];
 	__u8			sqes;
@@ -267,7 +273,7 @@ struct nvme_id_ns {
 	__le16			nabo;
 	__le16			nabspf;
 	__u16			rsvd46;
-	__le64			nvmcap[2];
+	__u8			nvmcap[16];
 	__u8			rsvd64[40];
 	__u8			nguid[16];
 	__u8			eui64[8];
@@ -556,8 +562,10 @@ enum nvme_admin_opcode {
 	nvme_admin_set_features		= 0x09,
 	nvme_admin_get_features		= 0x0a,
 	nvme_admin_async_event		= 0x0c,
+	nvme_admin_ns_mgmt		= 0x0d,
 	nvme_admin_activate_fw		= 0x10,
 	nvme_admin_download_fw		= 0x11,
+	nvme_admin_ns_attach		= 0x15,
 	nvme_admin_keep_alive		= 0x18,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
@@ -583,6 +591,7 @@ enum {
 	NVME_FEAT_WRITE_ATOMIC	= 0x0a,
 	NVME_FEAT_ASYNC_EVENT	= 0x0b,
 	NVME_FEAT_AUTO_PST	= 0x0c,
+	NVME_FEAT_HOST_MEM_BUF	= 0x0d,
 	NVME_FEAT_KATO		= 0x0f,
 	NVME_FEAT_SW_PROGRESS	= 0x80,
 	NVME_FEAT_HOST_ID	= 0x81,
@@ -745,7 +754,7 @@ struct nvmf_common_command {
 struct nvmf_disc_rsp_page_entry {
 	__u8		trtype;
 	__u8		adrfam;
-	__u8		nqntype;
+	__u8		subtype;
 	__u8		treq;
 	__le16		portid;
 	__le16		cntlid;
@@ -905,12 +914,23 @@ enum {
 	NVME_SC_INVALID_VECTOR		= 0x108,
 	NVME_SC_INVALID_LOG_PAGE	= 0x109,
 	NVME_SC_INVALID_FORMAT		= 0x10a,
-	NVME_SC_FIRMWARE_NEEDS_RESET	= 0x10b,
+	NVME_SC_FW_NEEDS_CONV_RESET	= 0x10b,
 	NVME_SC_INVALID_QUEUE		= 0x10c,
 	NVME_SC_FEATURE_NOT_SAVEABLE	= 0x10d,
 	NVME_SC_FEATURE_NOT_CHANGEABLE	= 0x10e,
 	NVME_SC_FEATURE_NOT_PER_NS	= 0x10f,
-	NVME_SC_FW_NEEDS_RESET_SUBSYS	= 0x110,
+	NVME_SC_FW_NEEDS_SUBSYS_RESET	= 0x110,
+	NVME_SC_FW_NEEDS_RESET		= 0x111,
+	NVME_SC_FW_NEEDS_MAX_TIME	= 0x112,
+	NVME_SC_FW_ACIVATE_PROHIBITED	= 0x113,
+	NVME_SC_OVERLAPPING_RANGE	= 0x114,
+	NVME_SC_NS_INSUFFICENT_CAP	= 0x115,
+	NVME_SC_NS_ID_UNAVAILABLE	= 0x116,
+	NVME_SC_NS_ALREADY_ATTACHED	= 0x118,
+	NVME_SC_NS_IS_PRIVATE		= 0x119,
+	NVME_SC_NS_NOT_ATTACHED		= 0x11a,
+	NVME_SC_THIN_PROV_NOT_SUPP	= 0x11b,
+	NVME_SC_CTRL_LIST_INVALID	= 0x11c,
 
 	/*
 	 * I/O Command Set Specific - NVM commands:
@@ -941,6 +961,7 @@ enum {
 	NVME_SC_REFTAG_CHECK		= 0x284,
 	NVME_SC_COMPARE_FAILED		= 0x285,
 	NVME_SC_ACCESS_DENIED		= 0x286,
+	NVME_SC_UNWRITTEN_BLOCK		= 0x287,
 
 	NVME_SC_DNR			= 0x4000,
 };
-- 
2.1.4
