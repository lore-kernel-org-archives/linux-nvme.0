From: yuyufen@huawei.com (Yufen Yu)
Date: Wed, 10 Apr 2019 16:00:33 +0800
Subject: [PATCH RFC 4/6] nvme-tcp: use flag NVME_ADMIN_QID for admin queue
In-Reply-To: <20190410080035.82529-1-yuyufen@huawei.com>
References: <20190410080035.82529-1-yuyufen@huawei.com>
Message-ID: <20190410080035.82529-5-yuyufen@huawei.com>

Signed-off-by: Yufen Yu <yuyufen at huawei.com>
---
 drivers/nvme/host/tcp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 68c49dd67210..0ac59198792f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -391,7 +391,7 @@ static int nvme_tcp_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned int hctx_idx)
 {
 	struct nvme_tcp_ctrl *ctrl = data;
-	struct nvme_tcp_queue *queue = &ctrl->queues[0];
+	struct nvme_tcp_queue *queue = &ctrl->queues[NVME_ADMIN_QID];
 
 	hctx->driver_data = queue;
 	return 0;
@@ -1107,7 +1107,7 @@ static void nvme_tcp_free_async_req(struct nvme_tcp_ctrl *ctrl)
 
 static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 {
-	struct nvme_tcp_queue *queue = &ctrl->queues[0];
+	struct nvme_tcp_queue *queue = &ctrl->queues[NVME_ADMIN_QID];
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
@@ -1117,7 +1117,7 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	if (!async->pdu)
 		return -ENOMEM;
 
-	async->queue = &ctrl->queues[0];
+	async->queue = &ctrl->queues[NVME_ADMIN_QID];
 	return 0;
 }
 
@@ -1479,7 +1479,7 @@ static void nvme_tcp_free_admin_queue(struct nvme_ctrl *ctrl)
 		to_tcp_ctrl(ctrl)->async_req.pdu = NULL;
 	}
 
-	nvme_tcp_free_queue(ctrl, 0);
+	nvme_tcp_free_queue(ctrl, NVME_ADMIN_QID);
 }
 
 static void nvme_tcp_free_io_queues(struct nvme_ctrl *ctrl)
@@ -1520,7 +1520,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 {
 	int ret;
 
-	ret = nvme_tcp_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
+	ret = nvme_tcp_alloc_queue(ctrl, NVME_ADMIN_QID, NVME_AQ_DEPTH);
 	if (ret)
 		return ret;
 
@@ -1531,7 +1531,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	return 0;
 
 out_free_queue:
-	nvme_tcp_free_queue(ctrl, 0);
+	nvme_tcp_free_queue(ctrl, NVME_ADMIN_QID);
 	return ret;
 }
 
@@ -1639,7 +1639,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 {
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_queue(ctrl, NVME_ADMIN_QID);
 	if (remove) {
 		blk_cleanup_queue(ctrl->admin_q);
 		blk_mq_free_tag_set(ctrl->admin_tagset);
@@ -1669,7 +1669,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 		}
 	}
 
-	error = nvme_tcp_start_queue(ctrl, 0);
+	error = nvme_tcp_start_queue(ctrl, NVME_ADMIN_QID);
 	if (error)
 		goto out_cleanup_queue;
 
@@ -1693,7 +1693,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	return 0;
 
 out_stop_queue:
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_queue(ctrl, NVME_ADMIN_QID);
 out_cleanup_queue:
 	if (new)
 		blk_cleanup_queue(ctrl->admin_q);
@@ -1709,7 +1709,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 		bool remove)
 {
 	blk_mq_quiesce_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_queue(ctrl, NVME_ADMIN_QID);
 	blk_mq_tagset_busy_iter(ctrl->admin_tagset, nvme_cancel_request, ctrl);
 	blk_mq_unquiesce_queue(ctrl->admin_q);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
@@ -1794,7 +1794,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	if (ctrl->queue_count > 1)
 		nvme_tcp_destroy_io_queues(ctrl, new);
 destroy_admin:
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_queue(ctrl, NVME_ADMIN_QID);
 	nvme_tcp_destroy_admin_queue(ctrl, new);
 	return ret;
 }
@@ -1937,7 +1937,7 @@ static void nvme_tcp_set_sg_host_data(struct nvme_command *c,
 static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(arg);
-	struct nvme_tcp_queue *queue = &ctrl->queues[0];
+	struct nvme_tcp_queue *queue = &ctrl->queues[NVME_ADMIN_QID];
 	struct nvme_tcp_cmd_pdu *pdu = ctrl->async_req.pdu;
 	struct nvme_command *cmd = &pdu->cmd;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
-- 
2.16.2.dirty
