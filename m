From: hch@lst.de (Christoph Hellwig)
Date: Tue,  1 Nov 2016 07:44:50 -0600
Subject: [PATCH,
 resend2] nvme-rdma: reject non-connect commands before the queue is
 live
Message-ID: <1478007890-18934-1-git-send-email-hch@lst.de>

If we reconncect we might have command queue up that get resent as soon
as the queue is restarted.  But until the connect command succeeded we
can't send other command.  Add a new flag that marks a queue as live when
connect finishes, and delay any non-connect command until the queue is
live based on it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reported-by: Steve Wise <swise at opengridcomputing.com>
Tested-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/host/rdma.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

[and now really to the right nvme list, sigh..]

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5a83881..9f552b6 100644
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
@@ -1394,10 +1398,18 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	WARN_ON_ONCE(rq->tag < 0);
 
+	c = (struct nvme_command *)rq->cmd;
+	if (!test_bit(NVME_RDMA_Q_LIVE, &queue->flags) &&
+	    rq->cmd_type != REQ_TYPE_DRV_PRIV &&
+	    (c->common.opcode != nvme_fabrics_command ||
+	     c->fabrics.fctype != nvme_fabrics_type_connect))
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
