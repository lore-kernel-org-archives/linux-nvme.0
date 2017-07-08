From: jsmart2021@gmail.com (James Smart)
Date: Fri,  7 Jul 2017 18:08:25 -0700
Subject: [PATCH 1/2] nvme_fc/nvmet_fc: revise Create Association descriptor
 length
In-Reply-To: <20170708010826.12448-1-jsmart2021@gmail.com>
References: <20170708010826.12448-1-jsmart2021@gmail.com>
Message-ID: <20170708010826.12448-2-jsmart2021@gmail.com>

Revises the Create Association LS for the amount of pad expected in 1.16.

Add defines for the minimum lengths that a target can accept (e.g. variable
pad lengths)

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 include/linux/nvme-fc.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme-fc.h b/include/linux/nvme-fc.h
index bc711a10be05..21c37e39e41a 100644
--- a/include/linux/nvme-fc.h
+++ b/include/linux/nvme-fc.h
@@ -17,6 +17,7 @@
 
 /*
  * This file contains definitions relative to FC-NVME r1.14 (16-020vB).
+ * The fcnvme_lsdesc_cr_assoc_cmd struct reflects expected r1.16 content.
  */
 
 #ifndef _NVME_FC_H
@@ -193,9 +194,21 @@ struct fcnvme_lsdesc_cr_assoc_cmd {
 	uuid_t	hostid;
 	u8	hostnqn[FCNVME_ASSOC_HOSTNQN_LEN];
 	u8	subnqn[FCNVME_ASSOC_SUBNQN_LEN];
-	u8	rsvd632[384];
+	__be32	rsvd584[108];		/* pad to 1016 bytes,
+					 * which makes overall LS rqst
+					 * payload 1024 bytes
+					 */
 };
 
+#define FCNVME_LSDESC_CRA_CMD_DESC_MINLEN	\
+		offsetof(struct fcnvme_lsdesc_cr_assoc_cmd, rsvd584)
+
+#define FCNVME_LSDESC_CRA_CMD_DESC_MIN_DESCLEN	\
+		(FCNVME_LSDESC_CRA_CMD_DESC_MINLEN - \
+		 offsetof(struct fcnvme_lsdesc_cr_assoc_cmd, ersp_ratio))
+
+
+
 /* FCNVME_LSDESC_CREATE_CONN_CMD */
 struct fcnvme_lsdesc_cr_conn_cmd {
 	__be32	desc_tag;		/* FCNVME_LSDESC_xxx */
@@ -273,6 +286,14 @@ struct fcnvme_ls_cr_assoc_rqst {
 	struct fcnvme_lsdesc_cr_assoc_cmd	assoc_cmd;
 };
 
+#define FCNVME_LSDESC_CRA_RQST_MINLEN	\
+		(offsetof(struct fcnvme_ls_cr_assoc_rqst, assoc_cmd) + \
+			FCNVME_LSDESC_CRA_CMD_DESC_MINLEN)
+
+#define FCNVME_LSDESC_CRA_RQST_MIN_LISTLEN	\
+		FCNVME_LSDESC_CRA_CMD_DESC_MINLEN
+
+
 struct fcnvme_ls_cr_assoc_acc {
 	struct fcnvme_ls_acc_hdr		hdr;
 	struct fcnvme_lsdesc_assoc_id		associd;
-- 
2.11.0
