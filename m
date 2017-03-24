From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 23 Mar 2017 20:44:33 -0700
Subject: [PATCH 3/5] nvme_fc: fix command id check
In-Reply-To: <20170324034435.8761-1-jsmart2021@gmail.com>
References: <20170324034435.8761-1-jsmart2021@gmail.com>
Message-ID: <20170324034435.8761-4-jsmart2021@gmail.com>

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
index 46594f1..d5fc2da 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1192,6 +1192,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	struct nvme_fc_ctrl *ctrl = op->ctrl;
 	struct nvme_fc_queue *queue = op->queue;
 	struct nvme_completion *cqe = &op->rsp_iu.cqe;
+	struct nvme_command *sqe = &op->cmd_iu.sqe;
 	u16 status = NVME_SC_SUCCESS;
 
 	/*
@@ -1273,7 +1274,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 			     be32_to_cpu(op->rsp_iu.xfrd_len) !=
 					freq->transferred_length ||
 			     op->rsp_iu.status_code ||
-			     op->rqno != le16_to_cpu(cqe->command_id))) {
+			     sqe->common.command_id != cqe->command_id)) {
 			status = NVME_SC_FC_TRANSPORT_ERROR;
 			goto done;
 		}
-- 
2.9.3
