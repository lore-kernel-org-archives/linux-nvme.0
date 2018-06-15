From: revanth.rajashekar@intel.com (Revanth Rajashekar)
Date: Fri, 15 Jun 2018 15:36:06 -0600
Subject: [PATCH] nvme-cli: Included primary controller capability structure
 and secondary controller list
Message-ID: <20180615213606.16254-1-revanth.rajashekar@intel.com>

Signed-off-by: Revanth Rajashekar <revanth.rajashekar at intel.com>
---
 linux/nvme.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/linux/nvme.h b/linux/nvme.h
index 8df7255..97204f3 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -34,6 +34,8 @@
 
 #define NVME_NSID_ALL		0xffffffff
 
+#define NVME_SECONDARY_CONTROLLER_MAX	127
+
 enum nvme_subsys_type {
 	NVME_NQN_DISC	= 1,		/* Discovery type target subsystem */
 	NVME_NQN_NVME	= 2,		/* NVME type target subsystem */
@@ -270,6 +272,44 @@ struct nvme_id_ctrl {
 	__u8			vs[1024];
 };
 
+struct nvme_id_primary_cntrlr {
+	__le16	cntlid;
+	__le16	portid;
+	__u8	crt;
+	__u8	rsvd5[27];
+	__le32	vqfrt;
+	__le32	vqrfa;
+	__le16	vqrfap;
+	__le16 	vqprt;
+	__le16	vqfrsm;
+	__le16 	vqgran;
+	__u8	rsvd48[16];
+	__le32	vifrt;
+	__le32	virfa;
+	__le16 	virfap;
+	__le16	viprt;
+	__le16	vifrsm;
+	__le16	vigran;
+	__u8	rsvd80[4016];
+};
+
+struct nvme_secondary_cntrlr_entry {
+	__le16	scid;
+	__le16 	pcid;
+	__u8 	scs;
+	__u8 	rsvd5[3];
+	__le16 	vfn;
+	__le16 	nvq;
+	__le16 	nvi;
+	__u8 	rsvd14[18];
+};
+
+struct nvme_secondary_cntrlr_list {
+	__u8 	num_of_identifiers;
+	__u8	rsvd1[31];
+	struct  nvme_secondary_cntrlr_entry sc[NVME_SECONDARY_CONTROLLER_MAX];
+};
+
 enum {
 	NVME_CTRL_ONCS_COMPARE			= 1 << 0,
 	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
-- 
2.17.1
