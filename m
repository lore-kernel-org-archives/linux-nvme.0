From: hare@suse.de (Hannes Reinecke)
Date: Fri,  4 May 2018 13:28:42 +0200
Subject: [PATCH 2/5] nvme: Add ANA base definitions
In-Reply-To: <20180504112845.38820-1-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
Message-ID: <20180504112845.38820-3-hare@suse.de>

Add definitions from the ANA TP errata.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 include/linux/nvme.h | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 4112e2bd747f..40c2d08ee761 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -242,7 +242,11 @@ struct nvme_id_ctrl {
 	__le32			sanicap;
 	__le32			hmminds;
 	__le16			hmmaxd;
-	__u8			rsvd338[174];
+	__u8			anatt;
+	__u8			anacap;
+	__le32			anagrpmax;
+	__le32			nanagrpid;
+	__u8			rsvd338[164];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
@@ -258,7 +262,8 @@ struct nvme_id_ctrl {
 	__le16			acwu;
 	__u8			rsvd534[2];
 	__le32			sgls;
-	__u8			rsvd540[228];
+	__le32			mnn;
+	__u8			rsvd540[224];
 	char			subnqn[256];
 	__u8			rsvd1024[768];
 	__le32			ioccsz;
@@ -312,7 +317,8 @@ struct nvme_id_ns {
 	__le16			nabspf;
 	__le16			noiob;
 	__u8			nvmcap[16];
-	__u8			rsvd64[40];
+	__u8			rsvd64[36];
+	__le32			anagrpid;
 	__u8			nguid[16];
 	__u8			eui64[8];
 	struct nvme_lbaf	lbaf[16];
@@ -440,6 +446,7 @@ enum {
 	NVME_AER_VS			= 7,
 	NVME_AER_NOTICE_NS_CHANGED	= 0x0002,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x0102,
+	NVME_AER_NOTICE_ANA_CHANGE	= 0x0302,
 };
 
 struct nvme_lba_range_type {
@@ -748,11 +755,17 @@ enum {
 	NVME_LOG_SMART		= 0x02,
 	NVME_LOG_FW_SLOT	= 0x03,
 	NVME_LOG_CMD_EFFECTS	= 0x05,
+	NVME_LOG_ANA		= 0x0c,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
 	NVME_FWACT_REPL		= (0 << 3),
 	NVME_FWACT_REPL_ACTV	= (1 << 3),
 	NVME_FWACT_ACTV		= (2 << 3),
+	NVME_ANA_STATE_OPTIMIZED = 0x01,
+	NVME_ANA_STATE_NONOPTIMIZED = 0x02,
+	NVME_ANA_STATE_INACCESSIBLE = 0x03,
+	NVME_ANA_STATE_PERSISTENT_LOSS = 0x04,
+	NVME_ANA_STATE_CHANGE_STATE = 0x05,
 };
 
 struct nvme_identify {
@@ -917,6 +930,23 @@ struct nvmf_common_command {
 	__u8	ts[24];
 };
 
+/* Asymmetric Namespace Access log page entry */
+struct nvmf_ana_group_descriptor {
+	__le32 groupid;
+	__le32 nsid_num;
+	__le64 chgcnt;
+	__u8 ana_state;
+	__u8 resv1[7];
+	__le32 nsid[0];
+};
+
+struct nvmf_ana_rsp_page_header {
+	__le64 chgcnt;
+	__le16 grpid_num;
+	__le16 resv[3];
+	struct nvmf_ana_group_descriptor desc[0];
+};
+
 /*
  * The legal cntlid range a NVMe Target will provide.
  * Note that cntlid of value 0 is considered illegal in the fabrics world.
@@ -1135,6 +1165,8 @@ enum {
 	NVME_SC_NS_NOT_ATTACHED		= 0x11a,
 	NVME_SC_THIN_PROV_NOT_SUPP	= 0x11b,
 	NVME_SC_CTRL_LIST_INVALID	= 0x11c,
+	NVME_SC_GRP_ID_INVALID		= 0x123,
+	NVME_SC_ANA_ATTACH_FAILED	= 0x124,
 
 	/*
 	 * I/O Command Set Specific - NVM commands:
@@ -1168,6 +1200,15 @@ enum {
 	NVME_SC_ACCESS_DENIED		= 0x286,
 	NVME_SC_UNWRITTEN_BLOCK		= 0x287,
 
+	/* Path-related Errors */
+	NVME_SC_INTERNAL_PATH_ERROR	= 0x300,
+	NVME_SC_ANA_PERSISTENT_LOSS	= 0x301,
+	NVME_SC_ANA_INACCESSIBLE	= 0x302,
+	NVME_SC_ANA_TRANSITION		= 0x303,
+	NVME_SC_CTRL_PATHING_ERROR	= 0x360,
+	NVME_SC_HOST_PATHING_ERROR	= 0x370,
+	NVME_SC_HOST_ABORTED		= 0x371,
+
 	NVME_SC_DNR			= 0x4000,
 };
 
-- 
2.12.3
