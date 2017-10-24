From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 24 Oct 2017 15:25:20 +0300
Subject: [PATCH 1/3] nvme-fabrics: Introduce init command check for a queue
 that is not alive
In-Reply-To: <1508847922-26699-1-git-send-email-sagi@grimberg.me>
References: <1508847922-26699-1-git-send-email-sagi@grimberg.me>
Message-ID: <1508847922-26699-2-git-send-email-sagi@grimberg.me>

When the fabrics queue is not alive and fully functional, no
commands should be allowed to pass but connect (which moves
the queue to a fully functional state). Any other command
should be failed, with either temporary status BLK_STS_RESOUCE
or permanent status BLK_STS_IOERR.

This is shared across all fabrics, hence move the check to
fabrics helper.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.h | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/host/rdma.c    | 29 ++++++-----------------------
 2 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index bf33663218cd..d464cc03cd23 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -142,4 +142,34 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 
+static inline blk_status_t nvmf_check_init_req(struct nvme_ctrl *ctrl,
+		struct request *rq)
+{
+	struct nvme_command *cmd = nvme_req(rq)->cmd;
+
+	/*
+	 * We cannot accept any other command until the connect
+	 * command has completed, so only allow connect to pass.
+	 */
+	if (!blk_rq_is_passthrough(rq) ||
+	    cmd->common.opcode != nvme_fabrics_command ||
+	    cmd->fabrics.fctype != nvme_fabrics_type_connect) {
+		/*
+		 * reconnecting state means transport disruption, which
+		 * can take a long time and even might fail permanently,
+		 * fail fast to give upper layers a chance to failover.
+		 * deleting state means that the ctrl will never accept
+		 * commands again, fail it permanently.
+		 */
+		if (ctrl->state == NVME_CTRL_RECONNECTING ||
+		    ctrl->state == NVME_CTRL_DELETING) {
+			nvme_req(rq)->status = NVME_SC_ABORT_REQ;
+			return BLK_STS_IOERR;
+		}
+		return BLK_STS_RESOURCE; /* try again later */
+	}
+
+	return BLK_STS_OK;
+}
+
 #endif /* _NVME_FABRICS_H */
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a5577e06a620..3e6ece0005e4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1591,28 +1591,11 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
  * We cannot accept any other command until the Connect command has completed.
  */
 static inline blk_status_t
-nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue, struct request *rq)
-{
-	if (unlikely(!test_bit(NVME_RDMA_Q_LIVE, &queue->flags))) {
-		struct nvme_command *cmd = nvme_req(rq)->cmd;
-
-		if (!blk_rq_is_passthrough(rq) ||
-		    cmd->common.opcode != nvme_fabrics_command ||
-		    cmd->fabrics.fctype != nvme_fabrics_type_connect) {
-			/*
-			 * reconnecting state means transport disruption, which
-			 * can take a long time and even might fail permanently,
-			 * so we can't let incoming I/O be requeued forever.
-			 * fail it fast to allow upper layers a chance to
-			 * failover.
-			 */
-			if (queue->ctrl->ctrl.state == NVME_CTRL_RECONNECTING)
-				return BLK_STS_IOERR;
-			return BLK_STS_RESOURCE; /* try again later */
-		}
-	}
-
-	return 0;
+nvme_rdma_is_ready(struct nvme_rdma_queue *queue, struct request *rq)
+{
+	if (unlikely(!test_bit(NVME_RDMA_Q_LIVE, &queue->flags)))
+		return nvmf_check_init_req(&queue->ctrl->ctrl, rq);
+	return BLK_STS_OK;
 }
 
 static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -1631,7 +1614,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	WARN_ON_ONCE(rq->tag < 0);
 
-	ret = nvme_rdma_queue_is_ready(queue, rq);
+	ret = nvme_rdma_is_ready(queue, rq);
 	if (unlikely(ret))
 		return ret;
 
-- 
2.7.4
