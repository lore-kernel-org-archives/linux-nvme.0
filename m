From: jsmart2021@gmail.com (James Smart)
Date: Tue, 27 Mar 2018 15:25:19 -0700
Subject: [PATCH] nvme: expand nvmf_check_if_ready checks
Message-ID: <20180327222519.19488-1-jsmart2021@gmail.com>

The nvmf_check_if_ready() checks that were added are very simplistic.
As such, the routine allows a lot of cases to fail ios during windows
of reset or re-connection. In cases where there are not multi-path
options present, the error goes back to the callee - the filesystem
or application. Not good.

The common routine was rewritten and calling syntax slightly expanded
so that per-transport is_ready routines don't need to be present.
The transports can call the routine directly. The routine now looks
at controller state to decide the action to take. Some states mandate
io failure. Others define the condition where a command can be accepted.
When the decision is unclear, a generic queue-or-reject check is made
to look for failfast or multipath ios and only fails the io if it is
so marked. Otherwise, the io will be queued and wait for the controller
state to resolve.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fabrics.h | 84 +++++++++++++++++++++++++++++++++------------
 drivers/nvme/host/fc.c      | 12 ++-----
 drivers/nvme/host/rdma.c    | 14 ++------
 drivers/nvme/target/loop.c  | 11 ++----
 4 files changed, 69 insertions(+), 52 deletions(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a3145d90c1d2..7cb8a0f3dfa0 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -158,35 +158,75 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 
-static inline blk_status_t nvmf_check_init_req(struct nvme_ctrl *ctrl,
-		struct request *rq)
+static inline blk_status_t nvmf_check_if_ready(struct nvme_ctrl *ctrl,
+		struct request *rq, bool qlive, bool connectivity)
 {
 	struct nvme_command *cmd = nvme_req(rq)->cmd;
 
-	/*
-	 * We cannot accept any other command until the connect command has
-	 * completed, so only allow connect to pass.
-	 */
-	if (!blk_rq_is_passthrough(rq) ||
-	    cmd->common.opcode != nvme_fabrics_command ||
-	    cmd->fabrics.fctype != nvme_fabrics_type_connect) {
+	if (ctrl->state == NVME_CTRL_LIVE && connectivity)
+		return BLK_STS_OK;
+
+	switch (ctrl->state) {
+	case NVME_CTRL_DELETING:
+		return BLK_STS_IOERR;
+
+	case NVME_CTRL_NEW:
+	case NVME_CTRL_CONNECTING:
+		if (!connectivity)
+			/*
+			 * This is the case of starting a new
+			 * association but connectivity was lost
+			 * before it was fully created. We need to
+			 * error the commands used to initialize the
+			 * controller so the reconnect can go into a
+			 * retry attempt. The commands should all be
+			 * marked REQ_FAILFAST_DRIVER, which will hit
+			 * the reject path below. Anything else will
+			 * be queued while the state settles.
+			 */
+			goto reject_or_queue_io;
+
+		if (qlive ||
+		    (cmd->common.opcode == nvme_fabrics_command &&
+		     cmd->fabrics.fctype == nvme_fabrics_type_connect))
+			/*
+			 * let anything to a live queue through.
+			 * Typically this will be commands to the admin
+			 * queue which are either being used to initialize
+			 * the controller or are commands being issued
+			 * via the cli/ioctl path.
+			 *
+			 * if the q isn't live, allow only the connect
+			 * command through.
+			 */
+			return BLK_STS_OK;
+
 		/*
-		 * Connecting state means transport disruption or initial
-		 * establishment, which can take a long time and even might
-		 * fail permanently, fail fast to give upper layers a chance
-		 * to failover.
-		 * Deleting state means that the ctrl will never accept commands
-		 * again, fail it permanently.
+		 * q isn't live to accept the command.
+		 * fall-thru to the reject_or_queue_io clause
 		 */
-		if (ctrl->state == NVME_CTRL_CONNECTING ||
-		    ctrl->state == NVME_CTRL_DELETING) {
-			nvme_req(rq)->status = NVME_SC_ABORT_REQ;
-			return BLK_STS_IOERR;
-		}
-		return BLK_STS_RESOURCE; /* try again later */
+		break;
+
+	/* these cases fall-thru
+	 * case NVME_CTRL_LIVE:
+	 * case NVME_CTRL_RESETTING:
+	 */
+	default:
+		break;
 	}
 
-	return BLK_STS_OK;
+reject_or_queue_io:
+	/*
+	 * Any other new io is something we're not in a state to send
+	 * to the device. Default action is to Busy it and retry it
+	 * after the controller state is recovered. However, anything
+	 * marked for failfast or nvme multipath is immediately failed.
+	 * Note: nvme cli/ioctl commands are marked for failfast.
+	 */
+	if (blk_noretry_request(rq) || rq->cmd_flags & REQ_NVME_MPATH)
+		return BLK_STS_IOERR;
+
+	return BLK_STS_RESOURCE;
 }
 
 #endif /* _NVME_FABRICS_H */
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index c6e719b2f3ca..6cb26bcf6ec0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2277,14 +2277,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	return BLK_STS_OK;
 }
 
-static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
-		struct request *rq)
-{
-	if (unlikely(!test_bit(NVME_FC_Q_LIVE, &queue->flags)))
-		return nvmf_check_init_req(&queue->ctrl->ctrl, rq);
-	return BLK_STS_OK;
-}
-
 static blk_status_t
 nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 			const struct blk_mq_queue_data *bd)
@@ -2300,7 +2292,9 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	u32 data_len;
 	blk_status_t ret;
 
-	ret = nvme_fc_is_ready(queue, rq);
+	ret = nvmf_check_if_ready(&queue->ctrl->ctrl, rq,
+		test_bit(NVME_FC_Q_LIVE, &queue->flags),
+		ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE);
 	if (unlikely(ret))
 		return ret;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f5f460b8045c..e65b762723a3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1593,17 +1593,6 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
 	return BLK_EH_HANDLED;
 }
 
-/*
- * We cannot accept any other command until the Connect command has completed.
- */
-static inline blk_status_t
-nvme_rdma_is_ready(struct nvme_rdma_queue *queue, struct request *rq)
-{
-	if (unlikely(!test_bit(NVME_RDMA_Q_LIVE, &queue->flags)))
-		return nvmf_check_init_req(&queue->ctrl->ctrl, rq);
-	return BLK_STS_OK;
-}
-
 static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
@@ -1619,7 +1608,8 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	WARN_ON_ONCE(rq->tag < 0);
 
-	ret = nvme_rdma_is_ready(queue, rq);
+	ret = nvmf_check_if_ready(&queue->ctrl->ctrl, rq,
+		test_bit(NVME_RDMA_Q_LIVE, &queue->flags), true);
 	if (unlikely(ret))
 		return ret;
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 861d1509b22b..e10987f87603 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -149,14 +149,6 @@ nvme_loop_timeout(struct request *rq, bool reserved)
 	return BLK_EH_HANDLED;
 }
 
-static inline blk_status_t nvme_loop_is_ready(struct nvme_loop_queue *queue,
-		struct request *rq)
-{
-	if (unlikely(!test_bit(NVME_LOOP_Q_LIVE, &queue->flags)))
-		return nvmf_check_init_req(&queue->ctrl->ctrl, rq);
-	return BLK_STS_OK;
-}
-
 static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
@@ -166,7 +158,8 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret;
 
-	ret = nvme_loop_is_ready(queue, req);
+	ret = nvmf_check_if_ready(&queue->ctrl->ctrl, req,
+		test_bit(NVME_LOOP_Q_LIVE, &queue->flags), true);
 	if (unlikely(ret))
 		return ret;
 
-- 
2.13.1
