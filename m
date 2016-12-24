From: jsmart2021@gmail.com (James Smart)
Date: Sat, 24 Dec 2016 09:46:41 -0800
Subject: [PATCH] nvme_fc: correct LS validation
Message-ID: <585eb481.Z9kloEOnhgH+OCC7%jsmart2021@gmail.com>


LS validations shouldn't have been independent checks.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 03bb599..d30ef8c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -848,11 +848,12 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
 	/* validate the ACC response */
 	if (assoc_acc->hdr.w0.ls_cmd != FCNVME_LS_ACC)
 		fcret = VERR_LSACC;
-	if (assoc_acc->hdr.desc_list_len !=
+	else if (assoc_acc->hdr.desc_list_len !=
 			fcnvme_lsdesc_len(
 				sizeof(struct fcnvme_ls_cr_assoc_acc)))
 		fcret = VERR_CR_ASSOC_ACC_LEN;
-	if (assoc_acc->hdr.rqst.desc_tag != cpu_to_be32(FCNVME_LSDESC_RQST))
+	else if (assoc_acc->hdr.rqst.desc_tag !=
+			cpu_to_be32(FCNVME_LSDESC_RQST))
 		fcret = VERR_LSDESC_RQST;
 	else if (assoc_acc->hdr.rqst.desc_len !=
 			fcnvme_lsdesc_len(sizeof(struct fcnvme_lsdesc_rqst)))
@@ -955,10 +956,10 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	/* validate the ACC response */
 	if (conn_acc->hdr.w0.ls_cmd != FCNVME_LS_ACC)
 		fcret = VERR_LSACC;
-	if (conn_acc->hdr.desc_list_len !=
+	else if (conn_acc->hdr.desc_list_len !=
 			fcnvme_lsdesc_len(sizeof(struct fcnvme_ls_cr_conn_acc)))
 		fcret = VERR_CR_CONN_ACC_LEN;
-	if (conn_acc->hdr.rqst.desc_tag != cpu_to_be32(FCNVME_LSDESC_RQST))
+	else if (conn_acc->hdr.rqst.desc_tag != cpu_to_be32(FCNVME_LSDESC_RQST))
 		fcret = VERR_LSDESC_RQST;
 	else if (conn_acc->hdr.rqst.desc_len !=
 			fcnvme_lsdesc_len(sizeof(struct fcnvme_lsdesc_rqst)))
-- 
2.5.0
