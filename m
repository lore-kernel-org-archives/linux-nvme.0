From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Mar 2019 18:55:04 +0100
Subject: [PATCH 11/17] nvmet-fc: bring Disconnect into compliance with FC-NVME
 spec
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
Message-ID: <20190313175510.20725-12-hch@lst.de>

From: James Smart <jsmart2021@gmail.com>

The FC-NVME spec, when finally approved, modified the disconnect LS
such that the only scope available is the association.

Rework the Disconnect LS processing to be in accordance with the
change.

Signed-off-by: Nigel Kirkland <nigel.kirkland at broadcom.com>
Signed-off-by: James Smart <jsmart2021 at gmail.com>
Reviewed-by: Ewan D. Milne <emilne at redhat.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/fc.c | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 8d34aa573d5b..7f051f9dfa8f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1502,10 +1502,8 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 			(struct fcnvme_ls_disconnect_rqst *)iod->rqstbuf;
 	struct fcnvme_ls_disconnect_acc *acc =
 			(struct fcnvme_ls_disconnect_acc *)iod->rspbuf;
-	struct nvmet_fc_tgt_queue *queue = NULL;
 	struct nvmet_fc_tgt_assoc *assoc;
 	int ret = 0;
-	bool del_assoc = false;
 
 	memset(acc, 0, sizeof(*acc));
 
@@ -1536,18 +1534,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 		assoc = nvmet_fc_find_target_assoc(tgtport,
 				be64_to_cpu(rqst->associd.association_id));
 		iod->assoc = assoc;
-		if (assoc) {
-			if (rqst->discon_cmd.scope ==
-					FCNVME_DISCONN_CONNECTION) {
-				queue = nvmet_fc_find_target_queue(tgtport,
-						be64_to_cpu(
-							rqst->discon_cmd.id));
-				if (!queue) {
-					nvmet_fc_tgt_a_put(assoc);
-					ret = VERR_NO_CONN;
-				}
-			}
-		} else
+		if (!assoc)
 			ret = VERR_NO_ASSOC;
 	}
 
@@ -1575,26 +1562,10 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 				sizeof(struct fcnvme_ls_disconnect_acc)),
 			FCNVME_LS_DISCONNECT);
 
-
-	/* are we to delete a Connection ID (queue) */
-	if (queue) {
-		int qid = queue->qid;
-
-		nvmet_fc_delete_target_queue(queue);
-
-		/* release the get taken by find_target_queue */
-		nvmet_fc_tgt_q_put(queue);
-
-		/* tear association down if io queue terminated */
-		if (!qid)
-			del_assoc = true;
-	}
-
 	/* release get taken in nvmet_fc_find_target_assoc */
 	nvmet_fc_tgt_a_put(iod->assoc);
 
-	if (del_assoc)
-		nvmet_fc_delete_target_assoc(iod->assoc);
+	nvmet_fc_delete_target_assoc(iod->assoc);
 }
 
 
-- 
2.20.1
