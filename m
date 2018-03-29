From: jsmart2021@gmail.com (James Smart)
Date: Thu, 29 Mar 2018 14:56:17 -0700
Subject: [PATCH v4] nvme: expand nvmf_check_if_ready checks
Message-ID: <20180329215617.14592-1-jsmart2021@gmail.com>

The nvmf_check_if_ready() checks that were added are very simplistic.
As such, the routine allows a lot of cases to fail ios during windows
of reset or re-connection. In cases where there are not multi-path
options present, the error goes back to the callee - the filesystem
or application. Not good.

The common routine was rewritten and calling syntax slightly expanded
so that per-transport is_ready routines don't need to be present.
The transports now call the routine directly. The routine is now a
fabrics routine rather than an inline function.

The routine now looks at controller state to decide the action to
take. Some states mandate io failure. Others define the condition where
a command can be accepted.  When the decision is unclear, a generic
queue-or-reject check is made to look for failfast or multipath ios and
only fails the io if it is so marked. Otherwise, the io will be queued
and wait for the controller state to resolve.

Signed-off-by: James Smart <james.smart at broadcom.com>

---
v2:
  needed to set nvme status when rejecting io
v3:
  renamed qlive to queue_live and connectivity to is_connected
  converted from inline routine to fabrics exported routine.
v4:
  missing a check on blk_rq_is_passthrough() as not all requests
  have nvme_req(rq)->cmd set.
---
 drivers/nvme/host/fabrics.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h | 33 ++-----------------
 drivers/nvme/host/fc.c      | 12 ++-----
 drivers/nvme/host/rdma.c    | 14 ++-------
 drivers/nvme/target/loop.c  | 11 ++-----
 5 files changed, 86 insertions(+), 61 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index a1c58e35075e..cf42ddfb0527 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -536,6 +536,83 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
 	return NULL;
 }
 
+blk_status_t nvmf_check_if_ready(struct nvme_ctrl *ctrl, struct request *rq,
+		bool queue_live, bool is_connected)
+{
+	struct nvme_command *cmd = nvme_req(rq)->cmd;
+
+	if (ctrl->state == NVME_CTRL_LIVE && is_connected)
+		return BLK_STS_OK;
+
+	switch (ctrl->state) {
+	case NVME_CTRL_DELETING:
+		goto reject_io;
+
+	case NVME_CTRL_NEW:
+	case NVME_CTRL_CONNECTING:
+		if (!is_connected)
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
+		if (queue_live ||
+		    (blk_rq_is_passthrough(rq) &&
+		     cmd->common.opcode == nvme_fabrics_command &&
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
+		/*
+		 * q isn't live to accept the command.
+		 * fall-thru to the reject_or_queue_io clause
+		 */
+		break;
+
+	/* these cases fall-thru
+	 * case NVME_CTRL_LIVE:
+	 * case NVME_CTRL_RESETTING:
+	 */
+	default:
+		break;
+	}
+
+reject_or_queue_io:
+	/*
+	 * Any other new io is something we're not in a state to send
+	 * to the device. Default action is to busy it and retry it
+	 * after the controller state is recovered. However, anything
+	 * marked for failfast or nvme multipath is immediately failed.
+	 * Note: commands used to initialize the controller will be
+	 *  marked for failfast.
+	 * Note: nvme cli/ioctl commands are marked for failfast.
+	 */
+	if (!blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
+		return BLK_STS_RESOURCE;
+
+reject_io:
+	nvme_req(rq)->status = NVME_SC_ABORT_REQ;
+	return BLK_STS_IOERR;
+}
+EXPORT_SYMBOL_GPL(nvmf_check_if_ready);
+
 static const match_table_t opt_tokens = {
 	{ NVMF_OPT_TRANSPORT,		"transport=%s"		},
 	{ NVMF_OPT_TRADDR,		"traddr=%s"		},
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a3145d90c1d2..ef46c915b7b5 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -157,36 +157,7 @@ void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
 void nvmf_free_options(struct nvmf_ctrl_options *opts);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
-
-static inline blk_status_t nvmf_check_init_req(struct nvme_ctrl *ctrl,
-		struct request *rq)
-{
-	struct nvme_command *cmd = nvme_req(rq)->cmd;
-
-	/*
-	 * We cannot accept any other command until the connect command has
-	 * completed, so only allow connect to pass.
-	 */
-	if (!blk_rq_is_passthrough(rq) ||
-	    cmd->common.opcode != nvme_fabrics_command ||
-	    cmd->fabrics.fctype != nvme_fabrics_type_connect) {
-		/*
-		 * Connecting state means transport disruption or initial
-		 * establishment, which can take a long time and even might
-		 * fail permanently, fail fast to give upper layers a chance
-		 * to failover.
-		 * Deleting state means that the ctrl will never accept commands
-		 * again, fail it permanently.
-		 */
-		if (ctrl->state == NVME_CTRL_CONNECTING ||
-		    ctrl->state == NVME_CTRL_DELETING) {
-			nvme_req(rq)->status = NVME_SC_ABORT_REQ;
-			return BLK_STS_IOERR;
-		}
-		return BLK_STS_RESOURCE; /* try again later */
-	}
-
-	return BLK_STS_OK;
-}
+blk_status_t nvmf_check_if_ready(struct nvme_ctrl *ctrl,
+	struct request *rq, bool queue_live, bool is_connected);
 
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
