From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 24 Oct 2017 15:25:21 +0300
Subject: [PATCH 2/3] nvme-fc: Check if queue is ready in queue_rq
In-Reply-To: <1508847922-26699-1-git-send-email-sagi@grimberg.me>
References: <1508847922-26699-1-git-send-email-sagi@grimberg.me>
Message-ID: <1508847922-26699-3-git-send-email-sagi@grimberg.me>

In case the queue is not LIVE (fully functional
and connected in the nvmf level), we cannot
allow any commands other than connect to pass
through.

Add a new queue state flag NVME_FC_Q_LIVE which is
set after nvmf connect and cleared in queue teardown.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index c6c903f1b172..7ab131500387 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -41,6 +41,7 @@
 
 enum nvme_fc_queue_flags {
 	NVME_FC_Q_CONNECTED = (1 << 0),
+	NVME_FC_Q_LIVE = (1 << 1),
 };
 
 #define NVMEFC_QUEUE_DELAY	3		/* ms units */
@@ -1715,6 +1716,7 @@ nvme_fc_free_queue(struct nvme_fc_queue *queue)
 	if (!test_and_clear_bit(NVME_FC_Q_CONNECTED, &queue->flags))
 		return;
 
+	clear_bit(NVME_FC_Q_LIVE, &queue->flags);
 	/*
 	 * Current implementation never disconnects a single queue.
 	 * It always terminates a whole association. So there is never
@@ -1722,7 +1724,6 @@ nvme_fc_free_queue(struct nvme_fc_queue *queue)
 	 */
 
 	queue->connection_id = 0;
-	clear_bit(NVME_FC_Q_CONNECTED, &queue->flags);
 }
 
 static void
@@ -1801,6 +1802,8 @@ nvme_fc_connect_io_queues(struct nvme_fc_ctrl *ctrl, u16 qsize)
 		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
 		if (ret)
 			break;
+
+		set_bit(NVME_FC_Q_LIVE, &ctrl->queues[i].flags);
 	}
 
 	return ret;
@@ -2115,6 +2118,14 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	return BLK_STS_RESOURCE;
 }
 
+static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
+		struct request *rq)
+{
+	if (unlikely(!test_bit(NVME_FC_Q_LIVE, &queue->flags)))
+		return nvmf_check_init_req(&queue->ctrl->ctrl, rq);
+	return BLK_STS_OK;
+}
+
 static blk_status_t
 nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 			const struct blk_mq_queue_data *bd)
@@ -2130,6 +2141,10 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	u32 data_len;
 	blk_status_t ret;
 
+	ret = nvme_fc_is_ready(queue, rq);
+	if (unlikely(ret))
+		return ret;
+
 	ret = nvme_setup_cmd(ns, rq, sqe);
 	if (ret)
 		return ret;
@@ -2465,6 +2480,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (ret)
 		goto out_disconnect_admin_queue;
 
+	set_bit(NVME_FC_Q_LIVE, &ctrl->queues[0].flags);
+
 	/*
 	 * Check controller capabilities
 	 *
-- 
2.7.4
