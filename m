From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Sun, 23 Apr 2017 08:30:06 -0700
Subject: [PATCH 1/3] nvme_fc: fix command id check
In-Reply-To: <20170423153008.22795-1-jsmart2021@gmail.com>
References: <20170423153008.22795-1-jsmart2021@gmail.com>
Message-ID: <20170423153008.22795-2-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

The code validates the command_id in the response to the original
sqe command. But prior code was using the rq->rqno as the sqe command
id. The core layer overwrites what the transport set there originally.

Use the actual sqe content.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 596b3a4..cccade5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1192,6 +1192,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	struct nvme_fc_ctrl *ctrl = op->ctrl;
 	struct nvme_fc_queue *queue = op->queue;
 	struct nvme_completion *cqe = &op->rsp_iu.cqe;
+	struct nvme_command *sqe = &op->cmd_iu.sqe;
 	__le16 status = cpu_to_le16(NVME_SC_SUCCESS << 1);
 	union nvme_result result;
 
@@ -1274,7 +1275,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 			     be32_to_cpu(op->rsp_iu.xfrd_len) !=
 					freq->transferred_length ||
 			     op->rsp_iu.status_code ||
-			     op->rqno != le16_to_cpu(cqe->command_id))) {
+			     sqe->common.command_id != cqe->command_id)) {
 			status = cpu_to_le16(NVME_SC_FC_TRANSPORT_ERROR << 1);
 			goto done;
 		}
-- 
2.9.3
