From: hch@lst.de (Christoph Hellwig)
Date: Wed,  2 Nov 2016 08:49:18 -0600
Subject: [PATCH v2] nvme-rdma: reject non-connect commands before the queue is
 live
Message-ID: <1478098158-18264-1-git-send-email-hch@lst.de>

If we reconncect we might have command queue up that get resent as soon
as the queue is restarted.  But until the connect command succeeded we
can't send other command.  Add a new flag that marks a queue as live when
connect finishes, and delay any non-connect command until the queue is
live based on it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reported-by: Steve Wise <swise at opengridcomputing.com>
Tested-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/host/rdma.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5a83881..5bd7a16 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -83,6 +83,7 @@ enum nvme_rdma_queue_flags {
 	NVME_RDMA_Q_CONNECTED = (1 << 0),
 	NVME_RDMA_IB_QUEUE_ALLOCATED = (1 << 1),
 	NVME_RDMA_Q_DELETING = (1 << 2),
+	NVME_RDMA_Q_LIVE = (1 << 3),
 };
 
 struct nvme_rdma_queue {
@@ -626,6 +627,7 @@ static int nvme_rdma_connect_io_queues(struct nvme_rdma_ctrl *ctrl)
 		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
 		if (ret)
 			break;
+		set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
 	}
 
 	return ret;
@@ -761,8 +763,10 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
 
-	for (i = 0; i < ctrl->queue_count; i++)
+	for (i = 0; i < ctrl->queue_count; i++) {
 		clear_bit(NVME_RDMA_Q_CONNECTED, &ctrl->queues[i].flags);
+		clear_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
+	}
 
 	if (ctrl->queue_count > 1)
 		nvme_stop_queues(&ctrl->ctrl);
@@ -1378,6 +1382,24 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
 	return BLK_EH_HANDLED;
 }
 
+/*
+ * We cannot accept any other command until the Connect command has completed.
+ */
+static inline bool nvme_rdma_queue_is_ready(struct nvme_rdma_queue *queue,
+		struct request *rq)
+{
+	if (unlikely(!test_bit(NVME_RDMA_Q_LIVE, &queue->flags))) {
+		struct nvme_command *cmd = (struct nvme_command *)rq->cmd;
+
+		if (rq->cmd_type != REQ_TYPE_DRV_PRIV ||
+		    cmd->common.opcode != nvme_fabrics_command ||
+		    cmd->fabrics.fctype != nvme_fabrics_type_connect)
+			return false;
+	}
+
+	return true;
+}
+
 static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
@@ -1394,10 +1416,14 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	WARN_ON_ONCE(rq->tag < 0);
 
+	if (!nvme_rdma_queue_is_ready(queue, rq))
+		return BLK_MQ_RQ_QUEUE_BUSY;
+
 	dev = queue->device->dev;
 	ib_dma_sync_single_for_cpu(dev, sqe->dma,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 
+	c = sqe->data;
 	ret = nvme_setup_cmd(ns, rq, c);
 	if (ret)
 		return ret;
-- 
2.1.4
