From: jsmart2021@gmail.com (James Smart)
Date: Sat, 24 Dec 2016 09:46:43 -0800
Subject: [PATCH] nvmet_fc: correct logic in disconnect queue LS handling
Message-ID: <585eb483.hZUYI8T/2zVBl4Zm%jsmart2021@gmail.com>


Correct logic in disconnect queue LS handling.
Rework so that queue searching and error reporting is above the
section to send back a ls rjt

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fc.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index fe74fc6..90cd652 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1315,7 +1315,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 			(struct fcnvme_ls_disconnect_rqst *)iod->rqstbuf;
 	struct fcnvme_ls_disconnect_acc *acc =
 			(struct fcnvme_ls_disconnect_acc *)iod->rspbuf;
-	struct nvmet_fc_tgt_queue *queue;
+	struct nvmet_fc_tgt_queue *queue = NULL;
 	struct nvmet_fc_tgt_assoc *assoc;
 	int ret = 0;
 	bool del_assoc = false;
@@ -1349,7 +1349,18 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 		assoc = nvmet_fc_find_target_assoc(tgtport,
 				be64_to_cpu(rqst->associd.association_id));
 		iod->assoc = assoc;
-		if (!assoc)
+		if (assoc) {
+			if (rqst->discon_cmd.scope ==
+					FCNVME_DISCONN_CONNECTION) {
+				queue = nvmet_fc_find_target_queue(tgtport,
+						be64_to_cpu(
+							rqst->discon_cmd.id));
+				if (!queue) {
+					nvmet_fc_tgt_a_put(assoc);
+					ret = VERR_NO_CONN;
+				}
+			}
+		} else
 			ret = VERR_NO_ASSOC;
 	}
 
@@ -1378,21 +1389,18 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 			FCNVME_LS_DISCONNECT);
 
 
-	if (rqst->discon_cmd.scope == FCNVME_DISCONN_CONNECTION) {
-		queue = nvmet_fc_find_target_queue(tgtport,
-					be64_to_cpu(rqst->discon_cmd.id));
-		if (queue) {
-			int qid = queue->qid;
+	/* are we to delete a Connection ID (queue) */
+	if (queue) {
+		int qid = queue->qid;
 
-			nvmet_fc_delete_target_queue(queue);
+		nvmet_fc_delete_target_queue(queue);
 
-			/* release the get taken by find_target_queue */
-			nvmet_fc_tgt_q_put(queue);
+		/* release the get taken by find_target_queue */
+		nvmet_fc_tgt_q_put(queue);
 
-			/* tear association down if io queue terminated */
-			if (!qid)
-				del_assoc = true;
-		}
+		/* tear association down if io queue terminated */
+		if (!qid)
+			del_assoc = true;
 	}
 
 	/* release get taken in nvmet_fc_find_target_assoc */
-- 
2.5.0
