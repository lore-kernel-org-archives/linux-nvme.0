From: Max Gurtovoy <maxg@mellanox.com>
Date: Tue, 4 Jun 2019 11:24:47 +0000
Subject: [PATCH 1/1] FIX kernel crash
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190604112447.e33GuKFu7eSg1kXyAXe6qBe6osrfAY_RuPG7goQkmjk@z>

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 128 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 92 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f383146..92616b3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -167,28 +167,63 @@ static inline size_t nvme_rdma_inline_data_size(struct nvme_rdma_queue *queue)
 	return queue->cmnd_capsule_len - sizeof(struct nvme_command);
 }
 
-static void nvme_rdma_free_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
-		size_t capsule_size, enum dma_data_direction dir)
+static void nvme_rdma_unmap_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
+			       size_t capsule_size, enum dma_data_direction dir)
 {
 	ib_dma_unmap_single(ibdev, qe->dma, capsule_size, dir);
+}
+
+static int nvme_rdma_map_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
+			    size_t capsule_size, enum dma_data_direction dir)
+{
+	qe->dma = ib_dma_map_single(ibdev, qe->data, capsule_size, dir);
+	return ib_dma_mapping_error(ibdev, qe->dma);
+}
+
+static void nvme_rdma_free_qe(struct nvme_rdma_qe *qe)
+{
 	kfree(qe->data);
 }
 
-static int nvme_rdma_alloc_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
-		size_t capsule_size, enum dma_data_direction dir)
+static int nvme_rdma_alloc_qe(struct nvme_rdma_qe *qe, size_t capsule_size)
 {
 	qe->data = kzalloc(capsule_size, GFP_KERNEL);
 	if (!qe->data)
 		return -ENOMEM;
 
-	qe->dma = ib_dma_map_single(ibdev, qe->data, capsule_size, dir);
-	if (ib_dma_mapping_error(ibdev, qe->dma)) {
-		kfree(qe->data);
-		qe->data = NULL;
-		return -ENOMEM;
-	}
+	return 0;
+}
+
+static void nvme_rdma_free_mapped_qe(struct ib_device *ibdev,
+				     struct nvme_rdma_qe *qe,
+				     size_t capsule_size,
+				     enum dma_data_direction dir)
+{
+	nvme_rdma_unmap_qe(ibdev, qe, capsule_size, dir);
+	nvme_rdma_free_qe(qe);
+}
+
+static int nvme_rdma_alloc_mapped_qe(struct ib_device *ibdev,
+				     struct nvme_rdma_qe *qe,
+				     size_t capsule_size,
+				     enum dma_data_direction dir)
+{
+	int ret;
+
+	ret = nvme_rdma_alloc_qe(qe, capsule_size);
+	if (ret)
+		return ret;
+
+	ret = nvme_rdma_map_qe(ibdev, qe, capsule_size, dir);
+	if (ret)
+		goto free_qe;
 
 	return 0;
+
+free_qe:
+	nvme_rdma_free_qe(qe);
+
+	return ret;
 }
 
 static void nvme_rdma_free_ring(struct ib_device *ibdev,
@@ -198,7 +233,7 @@ static void nvme_rdma_free_ring(struct ib_device *ibdev,
 	int i;
 
 	for (i = 0; i < ib_queue_size; i++)
-		nvme_rdma_free_qe(ibdev, &ring[i], capsule_size, dir);
+		nvme_rdma_free_mapped_qe(ibdev, &ring[i], capsule_size, dir);
 	kfree(ring);
 }
 
@@ -214,7 +249,8 @@ static struct nvme_rdma_qe *nvme_rdma_alloc_ring(struct ib_device *ibdev,
 		return NULL;
 
 	for (i = 0; i < ib_queue_size; i++) {
-		if (nvme_rdma_alloc_qe(ibdev, &ring[i], capsule_size, dir))
+		if (nvme_rdma_alloc_mapped_qe(ibdev, &ring[i], capsule_size,
+					      dir))
 			goto out_free_ring;
 	}
 
@@ -274,14 +310,9 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
 static void nvme_rdma_exit_request(struct blk_mq_tag_set *set,
 		struct request *rq, unsigned int hctx_idx)
 {
-	struct nvme_rdma_ctrl *ctrl = set->driver_data;
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
-	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
-	struct nvme_rdma_queue *queue = &ctrl->queues[queue_idx];
-	struct nvme_rdma_device *dev = queue->device;
 
-	nvme_rdma_free_qe(dev->dev, &req->sqe, sizeof(struct nvme_command),
-			DMA_TO_DEVICE);
+	nvme_rdma_free_qe(&req->sqe);
 }
 
 static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
@@ -292,13 +323,10 @@ static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
 	struct nvme_rdma_queue *queue = &ctrl->queues[queue_idx];
-	struct nvme_rdma_device *dev = queue->device;
-	struct ib_device *ibdev = dev->dev;
 	int ret;
 
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
-	ret = nvme_rdma_alloc_qe(ibdev, &req->sqe, sizeof(struct nvme_command),
-			DMA_TO_DEVICE);
+	ret = nvme_rdma_alloc_qe(&req->sqe, sizeof(struct nvme_command));
 	if (ret)
 		return ret;
 
@@ -748,8 +776,10 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
 	}
 	if (ctrl->async_event_sqe.data) {
-		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
-				sizeof(struct nvme_command), DMA_TO_DEVICE);
+		nvme_rdma_free_mapped_qe(ctrl->queues[0].device->dev,
+					 &ctrl->async_event_sqe,
+					 sizeof(struct nvme_command),
+					 DMA_TO_DEVICE);
 		ctrl->async_event_sqe.data = NULL;
 	}
 	nvme_rdma_free_queue(&ctrl->queues[0]);
@@ -769,8 +799,10 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev);
 
-	error = nvme_rdma_alloc_qe(ctrl->device->dev, &ctrl->async_event_sqe,
-			sizeof(struct nvme_command), DMA_TO_DEVICE);
+	error = nvme_rdma_alloc_mapped_qe(ctrl->device->dev,
+					  &ctrl->async_event_sqe,
+					  sizeof(struct nvme_command),
+					  DMA_TO_DEVICE);
 	if (error)
 		goto out_free_queue;
 
@@ -825,8 +857,10 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (new)
 		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
 out_free_async_qe:
-	nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
-		sizeof(struct nvme_command), DMA_TO_DEVICE);
+	nvme_rdma_free_mapped_qe(ctrl->queues[0].device->dev,
+				 &ctrl->async_event_sqe,
+				 sizeof(struct nvme_command),
+				 DMA_TO_DEVICE);
 	ctrl->async_event_sqe.data = NULL;
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->queues[0]);
@@ -1709,12 +1743,20 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return nvmf_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
 	dev = queue->device->dev;
+
+	err = nvme_rdma_map_qe(dev, &req->sqe, sizeof(struct nvme_command),
+			       DMA_TO_DEVICE);
+	if (unlikely(err)) {
+		ret = BLK_STS_RESOURCE;
+		goto out;
+	}
+
 	ib_dma_sync_single_for_cpu(dev, sqe->dma,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 
 	ret = nvme_setup_cmd(ns, rq, c);
 	if (ret)
-		return ret;
+		goto unmap_qe;
 
 	blk_mq_start_request(rq);
 
@@ -1723,7 +1765,11 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		dev_err(queue->ctrl->ctrl.device,
 			     "Failed to map data (%d)\n", err);
 		nvme_cleanup_cmd(rq);
-		goto err;
+		if (err == -ENOMEM || err == -EAGAIN)
+			ret = BLK_STS_RESOURCE;
+		else
+			ret = BLK_STS_IOERR;
+		goto unmap_qe;
 	}
 
 	sqe->cqe.done = nvme_rdma_send_done;
@@ -1735,14 +1781,20 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 			req->mr ? &req->reg_wr.wr : NULL);
 	if (unlikely(err)) {
 		nvme_rdma_unmap_data(queue, rq);
-		goto err;
+		if (err == -ENOMEM || err == -EAGAIN)
+			ret = BLK_STS_RESOURCE;
+		else
+			ret = BLK_STS_IOERR;
+		goto unmap_qe;
 	}
 
 	return BLK_STS_OK;
-err:
-	if (err == -ENOMEM || err == -EAGAIN)
-		return BLK_STS_RESOURCE;
-	return BLK_STS_IOERR;
+
+unmap_qe:
+	nvme_rdma_unmap_qe(dev, &req->sqe, sizeof(struct nvme_command),
+			   DMA_TO_DEVICE);
+out:
+	return ret;
 }
 
 static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
@@ -1755,8 +1807,12 @@ static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
 static void nvme_rdma_complete_rq(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_rdma_queue *queue = req->queue;
+	struct ib_device *ibdev = queue->device->dev;
 
-	nvme_rdma_unmap_data(req->queue, rq);
+	nvme_rdma_unmap_data(queue, rq);
+	nvme_rdma_unmap_qe(ibdev, &req->sqe, sizeof(struct nvme_command),
+			   DMA_TO_DEVICE);
 	nvme_complete_rq(rq);
 }
 
-- 
1.8.3.1
