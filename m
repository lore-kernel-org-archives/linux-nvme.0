From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  5 Jun 2017 20:35:56 +0300
Subject: [PATCH for-4.12-rc] nvme-rdma: fast fail incoming requests while we
 reconnect
Message-ID: <1496684156-32335-1-git-send-email-sagi@grimberg.me>

When we encounter an transport/controller errors, error recovery
kicks in which performs:
1. stops io/admin queues
2. moves transport queues out of LIVE state
3. fast fail pending io
4. schedule periodic reconnects.

But we also need to fast fail incoming IO taht enters after we
already scheduled. Given that our queue is not LIVE anymore, simply
restart the request queues to fail in .queue_rq

Reported-by: Alex Turin <alex at vastdata.com>
Reported-by: shahar.salzman <shahar.salzman at gmail.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
This is stable 4.11+ material.

 drivers/nvme/host/rdma.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 28bd255c144d..d6cac9cc6711 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -753,28 +753,26 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	if (ret)
 		goto requeue;
 
-	blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
-
 	ret = nvmf_connect_admin_queue(&ctrl->ctrl);
 	if (ret)
-		goto stop_admin_q;
+		goto requeue;
 
 	set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);
 
 	ret = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
 	if (ret)
-		goto stop_admin_q;
+		goto requeue;
 
 	nvme_start_keep_alive(&ctrl->ctrl);
 
 	if (ctrl->queue_count > 1) {
 		ret = nvme_rdma_init_io_queues(ctrl);
 		if (ret)
-			goto stop_admin_q;
+			goto requeue;
 
 		ret = nvme_rdma_connect_io_queues(ctrl);
 		if (ret)
-			goto stop_admin_q;
+			goto requeue;
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
@@ -782,7 +780,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	ctrl->ctrl.opts->nr_reconnects = 0;
 
 	if (ctrl->queue_count > 1) {
-		nvme_start_queues(&ctrl->ctrl);
 		nvme_queue_scan(&ctrl->ctrl);
 		nvme_queue_async_events(&ctrl->ctrl);
 	}
@@ -791,8 +788,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 
 	return;
 
-stop_admin_q:
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
 requeue:
 	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
 			ctrl->ctrl.opts->nr_reconnects);
@@ -823,6 +818,13 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
 
+	/*
+	 * queues are not a live anymore, so restart the queues to fail fast
+	 * new IO
+	 */
+	blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
+	nvme_start_queues(&ctrl->ctrl);
+
 	nvme_rdma_reconnect_or_remove(ctrl);
 }
 
@@ -1433,7 +1435,7 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
 /*
  * We cannot accept any other command until the Connect command has completed.
  */
-static inline bool nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue,
+static inline int nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue,
 		struct request *rq)
 {
 	if (unlikely(!test_bit(NVME_RDMA_Q_LIVE, &queue->flags))) {
@@ -1441,11 +1443,22 @@ static inline bool nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue,
 
 		if (!blk_rq_is_passthrough(rq) ||
 		    cmd->common.opcode != nvme_fabrics_command ||
-		    cmd->fabrics.fctype != nvme_fabrics_type_connect)
-			return false;
+		    cmd->fabrics.fctype != nvme_fabrics_type_connect) {
+			/*
+			 * reconnecting state means transport disruption, which
+			 * can take a long time and even might fail permanently,
+			 * so we can't let incoming I/O be requeued forever.
+			 * fail it fast to allow upper layers a chance to
+			 * failover.
+			 */
+			if (queue->ctrl->ctrl->state == NVME_CTRL_RECONNECTING)
+				return -EIO;
+			else
+				return -EAGAIN;
+		}
 	}
 
-	return true;
+	return 0;
 }
 
 static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -1463,8 +1476,9 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	WARN_ON_ONCE(rq->tag < 0);
 
-	if (!nvme_rdma_queue_is_ready(queue, rq))
-		return BLK_MQ_RQ_QUEUE_BUSY;
+	ret = nvme_rdma_queue_is_ready(queue, rq);
+	if (unlikely(ret))
+		goto err;
 
 	dev = queue->device->dev;
 	ib_dma_sync_single_for_cpu(dev, sqe->dma,
-- 
2.7.4
