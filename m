From: yuyufen@huawei.com (Yufen Yu)
Date: Wed, 10 Apr 2019 16:00:32 +0800
Subject: [PATCH RFC 3/6] nvme-rdma: use flag NVME_ADMIN_QID for admin queue
In-Reply-To: <20190410080035.82529-1-yuyufen@huawei.com>
References: <20190410080035.82529-1-yuyufen@huawei.com>
Message-ID: <20190410080035.82529-4-yuyufen@huawei.com>

---
 drivers/nvme/host/rdma.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 11a5ecae78c8..c1249e7a1790 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -323,9 +323,9 @@ static int nvme_rdma_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned int hctx_idx)
 {
 	struct nvme_rdma_ctrl *ctrl = data;
-	struct nvme_rdma_queue *queue = &ctrl->queues[0];
+	struct nvme_rdma_queue *queue = &ctrl->queues[NVME_ADMIN_QID];
 
-	BUG_ON(hctx_idx != 0);
+	BUG_ON(hctx_idx != NVME_ADMIN_QID);
 
 	hctx->driver_data = queue;
 	return 0;
@@ -776,7 +776,7 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 				sizeof(struct nvme_command), DMA_TO_DEVICE);
 		ctrl->async_event_sqe.data = NULL;
 	}
-	nvme_rdma_free_queue(&ctrl->queues[0]);
+	nvme_rdma_free_queue(&ctrl->queues[NVME_ADMIN_QID]);
 }
 
 static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
@@ -784,11 +784,11 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 {
 	int error;
 
-	error = nvme_rdma_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
+	error = nvme_rdma_alloc_queue(ctrl, NVME_ADMIN_QID, NVME_AQ_DEPTH);
 	if (error)
 		return error;
 
-	ctrl->device = ctrl->queues[0].device;
+	ctrl->device = ctrl->queues[NVME_ADMIN_QID].device;
 	ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);
 
 	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev);
@@ -812,7 +812,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		}
 	}
 
-	error = nvme_rdma_start_queue(ctrl, 0);
+	error = nvme_rdma_start_queue(ctrl, NVME_ADMIN_QID);
 	if (error)
 		goto out_cleanup_queue;
 
@@ -841,7 +841,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	return 0;
 
 out_stop_queue:
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_rdma_stop_queue(&ctrl->queues[NVME_ADMIN_QID]);
 out_cleanup_queue:
 	if (new)
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
@@ -853,7 +853,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		sizeof(struct nvme_command), DMA_TO_DEVICE);
 	ctrl->async_event_sqe.data = NULL;
 out_free_queue:
-	nvme_rdma_free_queue(&ctrl->queues[0]);
+	nvme_rdma_free_queue(&ctrl->queues[NVME_ADMIN_QID]);
 	return error;
 }
 
@@ -913,7 +913,7 @@ static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_rdma_stop_queue(&ctrl->queues[NVME_ADMIN_QID]);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set, nvme_cancel_request,
 			&ctrl->ctrl);
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
@@ -1027,7 +1027,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 	if (ctrl->ctrl.queue_count > 1)
 		nvme_rdma_destroy_io_queues(ctrl, new);
 destroy_admin:
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_rdma_stop_queue(&ctrl->queues[NVME_ADMIN_QID]);
 	nvme_rdma_destroy_admin_queue(ctrl, new);
 	return ret;
 }
@@ -1406,7 +1406,7 @@ static void nvme_rdma_async_done(struct ib_cq *cq, struct ib_wc *wc)
 static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(arg);
-	struct nvme_rdma_queue *queue = &ctrl->queues[0];
+	struct nvme_rdma_queue *queue = &ctrl->queues[NVME_ADMIN_QID];
 	struct ib_device *dev = queue->device->dev;
 	struct nvme_rdma_qe *sqe = &ctrl->async_event_sqe;
 	struct nvme_command *cmd = sqe->data;
-- 
2.16.2.dirty
