From: jsmart2021@gmail.com (James Smart)
Date: Fri,  7 Jul 2017 18:08:26 -0700
Subject: [PATCH 2/2] nvmet_fc: Accept variable pad lengths on Create
 Association LS
In-Reply-To: <20170708010826.12448-1-jsmart2021@gmail.com>
References: <20170708010826.12448-1-jsmart2021@gmail.com>
Message-ID: <20170708010826.12448-3-jsmart2021@gmail.com>

Target validation of the Create Association LS revised to accept any
LS as long as all non-pad data has been received. This allows a (newer)
target to accept the LS from older initiators with varying pad lengths.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 7692a96c9065..1e6dcc241b3c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1164,18 +1164,24 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 
 	memset(acc, 0, sizeof(*acc));
 
-	if (iod->rqstdatalen < sizeof(struct fcnvme_ls_cr_assoc_rqst))
+	/*
+	 * FC-NVME spec changes. There are initiators sending different
+	 * lengths as padding sizes for Create Association Cmd descriptor
+	 * was incorrect.
+	 * Accept anything of "minimum" length. Assume format per 1.15
+	 * spec (with HOSTID reduced to 16 bytes), ignore how long the
+	 * trailing pad length is.
+	 */
+	if (iod->rqstdatalen < FCNVME_LSDESC_CRA_RQST_MINLEN)
 		ret = VERR_CR_ASSOC_LEN;
-	else if (rqst->desc_list_len !=
-			fcnvme_lsdesc_len(
-				sizeof(struct fcnvme_ls_cr_assoc_rqst)))
+	else if (rqst->desc_list_len <
+			cpu_to_be32(FCNVME_LSDESC_CRA_RQST_MIN_LISTLEN))
 		ret = VERR_CR_ASSOC_RQST_LEN;
 	else if (rqst->assoc_cmd.desc_tag !=
 			cpu_to_be32(FCNVME_LSDESC_CREATE_ASSOC_CMD))
 		ret = VERR_CR_ASSOC_CMD;
-	else if (rqst->assoc_cmd.desc_len !=
-			fcnvme_lsdesc_len(
-				sizeof(struct fcnvme_lsdesc_cr_assoc_cmd)))
+	else if (rqst->assoc_cmd.desc_len <
+			cpu_to_be32(FCNVME_LSDESC_CRA_CMD_DESC_MIN_DESCLEN))
 		ret = VERR_CR_ASSOC_CMD_LEN;
 	else if (!rqst->assoc_cmd.ersp_ratio ||
 		 (be16_to_cpu(rqst->assoc_cmd.ersp_ratio) >=
-- 
2.11.0
