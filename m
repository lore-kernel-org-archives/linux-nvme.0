From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 23 Mar 2017 20:41:27 -0700
Subject: [PATCH 6/6] nvme_fc: Clean up host fcpio done status handling
In-Reply-To: <20170324034127.8676-1-jsmart2021@gmail.com>
References: <20170324034127.8676-1-jsmart2021@gmail.com>
Message-ID: <20170324034127.8676-7-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

As Dan Carpenter pointed out: mixing 16-bit nvme status with 32-bit
error status from driver. Corrected comment on fcp request struct
status field, and converted done routine to explicitly set nvme status
codes for nvme status.

Signed-off-by: James Smart <james.smart at broadcom.com>
Reported-by: Dan Carpenter <dan.carpenter at oracle.com>
---
 drivers/nvme/host/fc.c         | 14 +++++++-------
 include/linux/nvme-fc-driver.h |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index aab2fe5..5aefccf 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1147,7 +1147,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	struct nvme_fc_ctrl *ctrl = op->ctrl;
 	struct nvme_fc_queue *queue = op->queue;
 	struct nvme_completion *cqe = &op->rsp_iu.cqe;
-	u16 status;
+	u16 status = NVME_SC_SUCCESS;
 
 	/*
 	 * WARNING:
@@ -1183,8 +1183,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 
 	if (atomic_read(&op->state) == FCPOP_STATE_ABORTED)
 		status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
-	else
-		status = freq->status;
+	else if (freq->status)
+		status = NVME_SC_FC_TRANSPORT_ERROR;
 
 	/*
 	 * For the linux implementation, if we have an unsuccesful
@@ -1212,7 +1212,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		 */
 		if (freq->transferred_length !=
 			be32_to_cpu(op->cmd_iu.data_len)) {
-			status = -EIO;
+			status = NVME_SC_FC_TRANSPORT_ERROR;
 			goto done;
 		}
 		op->nreq.result.u64 = 0;
@@ -1229,7 +1229,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 					freq->transferred_length ||
 			     op->rsp_iu.status_code ||
 			     op->rqno != le16_to_cpu(cqe->command_id))) {
-			status = -EIO;
+			status = NVME_SC_FC_TRANSPORT_ERROR;
 			goto done;
 		}
 		op->nreq.result = cqe->result;
@@ -1237,7 +1237,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		break;
 
 	default:
-		status = -EIO;
+		status = NVME_SC_FC_TRANSPORT_ERROR;
 		goto done;
 	}
 
@@ -1763,7 +1763,7 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	op->fcp_req.io_dir = io_dir;
 	op->fcp_req.transferred_length = 0;
 	op->fcp_req.rcv_rsplen = 0;
-	op->fcp_req.status = 0;
+	op->fcp_req.status = NVME_SC_SUCCESS;
 	op->fcp_req.sqid = cpu_to_le16(queue->qnum);
 
 	/*
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index f21471f..16eb264 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -137,9 +137,9 @@ enum nvmefc_fcp_datadir {
  *             transferred. Should equal payload_length on success.
  * @rcv_rsplen: length, in bytes, of the FCP RSP IU received.
  * @status:    Completion status of the FCP operation. must be 0 upon success,
- *             NVME_SC_FC_xxx value upon failure. Note: this is NOT a
- *             reflection of the NVME CQE completion status. Only the status
- *             of the FCP operation at the NVME-FC level.
+ *             negative errno value upon failure (ex: -EIO). Note: this is
+ *             NOT a reflection of the NVME CQE completion status. Only the
+ *             status of the FCP operation at the NVME-FC level.
  */
 struct nvmefc_fcp_req {
 	void			*cmdaddr;
-- 
2.9.3
