From: jsmart2021@gmail.com (James Smart)
Date: Thu,  1 Jun 2017 22:54:21 -0700
Subject: [PATCH] nvme_fc: on lldd/transport io error, terminate association
Message-ID: <20170602055421.2837-1-jsmart2021@gmail.com>

Per FC-NVME, when lldd or transport detects an i/o error, the
connection must be terminated, which in turn requires the association
to be termianted.  Currently the transport simply creates a nvme
completion status of transport error and returns the io. The FC-NVME
spec makes the mandate as initiator and host, depending on the error,
can get out of sync on outstanding io counts (sqhd/sqtail).

Implement the association teardown on lldd or transport detected
errors.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5b14cbefb724..2edae54688e8 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1139,6 +1139,7 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
 /* *********************** NVME Ctrl Routines **************************** */
 
 static void __nvme_fc_final_op_cleanup(struct request *rq);
+static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
 
 static int
 nvme_fc_reinit_request(void *data, struct request *rq)
@@ -1265,7 +1266,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	struct nvme_command *sqe = &op->cmd_iu.sqe;
 	__le16 status = cpu_to_le16(NVME_SC_SUCCESS << 1);
 	union nvme_result result;
-	bool complete_rq;
+	bool complete_rq, terminate_assoc = true;
 
 	/*
 	 * WARNING:
@@ -1294,6 +1295,14 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	 * fabricate a CQE, the following fields will not be set as they
 	 * are not referenced:
 	 *      cqe.sqid,  cqe.sqhd,  cqe.command_id
+	 *
+	 * Failure or error of an individual i/o, in a transport
+	 * detected fashion unrelated to the nvme completion status,
+	 * potentially cause the initiator and target sides to get out
+	 * of sync on SQ head/tail (aka outstanding io count allowed).
+	 * Per FC-NVME spec, failure of an individual command requires
+	 * the connection to be terminated, which in turn requires the
+	 * association to be terminated.
 	 */
 
 	fc_dma_sync_single_for_cpu(ctrl->lport->dev, op->fcp_req.rspdma,
@@ -1359,6 +1368,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		goto done;
 	}
 
+	terminate_assoc = false;
+
 done:
 	if (op->flags & FCOP_FLAGS_AEN) {
 		nvme_complete_async_event(&queue->ctrl->ctrl, status, &result);
@@ -1366,7 +1377,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		atomic_set(&op->state, FCPOP_STATE_IDLE);
 		op->flags = FCOP_FLAGS_AEN;	/* clear other flags */
 		nvme_fc_ctrl_put(ctrl);
-		return;
+		goto check_error;
 	}
 
 	complete_rq = __nvme_fc_fcpop_chk_teardowns(ctrl, op);
@@ -1379,6 +1390,10 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		nvme_end_request(rq, status, result);
 	} else
 		__nvme_fc_final_op_cleanup(rq);
+
+check_error:
+	if (terminate_assoc)
+		nvme_fc_error_recovery(ctrl, "transport detected io error");
 }
 
 static int
-- 
2.11.0
