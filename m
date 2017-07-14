From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 12:43:09 +0200
Subject: [PATCH 2/2] nvmet-fc: fix byte swapping in
 nvmet_fc_ls_create_association
In-Reply-To: <20170714104309.10757-1-hch@lst.de>
References: <20170714104309.10757-1-hch@lst.de>
Message-ID: <20170714104309.10757-2-hch@lst.de>

We always need to do non-equal comparisms on the native endian versions
to get the correct result.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/fc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1e6dcc241b3c..d5801c150b1c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1174,14 +1174,14 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 	 */
 	if (iod->rqstdatalen < FCNVME_LSDESC_CRA_RQST_MINLEN)
 		ret = VERR_CR_ASSOC_LEN;
-	else if (rqst->desc_list_len <
-			cpu_to_be32(FCNVME_LSDESC_CRA_RQST_MIN_LISTLEN))
+	else if (be32_to_cpu(rqst->desc_list_len) <
+			FCNVME_LSDESC_CRA_RQST_MIN_LISTLEN)
 		ret = VERR_CR_ASSOC_RQST_LEN;
 	else if (rqst->assoc_cmd.desc_tag !=
 			cpu_to_be32(FCNVME_LSDESC_CREATE_ASSOC_CMD))
 		ret = VERR_CR_ASSOC_CMD;
-	else if (rqst->assoc_cmd.desc_len <
-			cpu_to_be32(FCNVME_LSDESC_CRA_CMD_DESC_MIN_DESCLEN))
+	else if (be32_to_cpu(rqst->assoc_cmd.desc_len) <
+			FCNVME_LSDESC_CRA_CMD_DESC_MIN_DESCLEN)
 		ret = VERR_CR_ASSOC_CMD_LEN;
 	else if (!rqst->assoc_cmd.ersp_ratio ||
 		 (be16_to_cpu(rqst->assoc_cmd.ersp_ratio) >=
-- 
2.11.0
