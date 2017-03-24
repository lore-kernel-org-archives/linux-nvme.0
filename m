From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 23 Mar 2017 20:41:25 -0700
Subject: [PATCH 4/6] nvme_fc: correct LS validation
In-Reply-To: <20170324034127.8676-1-jsmart2021@gmail.com>
References: <20170324034127.8676-1-jsmart2021@gmail.com>
Message-ID: <20170324034127.8676-5-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

LS validations shouldn't have been independent checks.

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/fc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 7b8989a..aab2fe5 100644
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
2.9.3
