From: nitzanc@mellanox.com (Nitzan Carmi)
Date: Fri, 20 Oct 2017 08:24:22 +0000
Subject: [PATCH] nvme-rdma: Add debug message when reaches timeout
Message-ID: <20171020082422.4888-1-nitzanc@mellanox.com>

Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 92a03ff..8d2bbd7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1581,6 +1581,12 @@ static enum blk_eh_timer_return
 nvme_rdma_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_command *cmd = req->sqe.data;
+
+	dev_dbg_ratelimited(req->queue->ctrl->ctrl.device,
+			    "Reached timeout: command id %d opcode %d qid %d",
+			    cmd->common.command_id, cmd->common.opcode,
+			    nvme_rdma_queue_idx(req->queue));
 
 	/* queue error recovery */
 	nvme_rdma_error_recovery(req->queue->ctrl);
-- 
2.9.4
