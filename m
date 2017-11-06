From: israelr@mellanox.com (Israel Rukshin)
Date: Mon,  6 Nov 2017 15:29:41 +0000
Subject: [PATCH] nvme-rdma: Use mr pool
Message-ID: <1509982181-6340-1-git-send-email-israelr@mellanox.com>

Currently, blk_mq_tagset_iter() iterate over initial hctx tags only.
In case scheduler is used, it doesn't iterate the hctx scheduler tags
and the static request aren't been updated.
For example, while using NVMe over Fabrics RDMA host, this cause us not to
reinit the scheduler requests and thus not re-register all the memory regions
during the tagset re-initialization in the reconnect flow.

This may lead to a memory registration error:
"MEMREG for CQE 0xffff88044c14dce8 failed with status memory
management operation error (6)"

With this commit we don't need to reinit the requests.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---

The commit is based on Linux 4.14-rc8.

---
 drivers/nvme/host/rdma.c | 104 ++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 61 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0ebb539..432cccb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <rdma/mr_pool.h>
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/atomic.h>
@@ -267,29 +268,6 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
 	return ret;
 }
 
-static int nvme_rdma_reinit_request(void *data, struct request *rq)
-{
-	struct nvme_rdma_ctrl *ctrl = data;
-	struct nvme_rdma_device *dev = ctrl->device;
-	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
-	int ret = 0;
-
-	ib_dereg_mr(req->mr);
-
-	req->mr = ib_alloc_mr(dev->pd, IB_MR_TYPE_MEM_REG,
-			ctrl->max_fr_pages);
-	if (IS_ERR(req->mr)) {
-		ret = PTR_ERR(req->mr);
-		req->mr = NULL;
-		goto out;
-	}
-
-	req->mr->need_inval = false;
-
-out:
-	return ret;
-}
-
 static void nvme_rdma_exit_request(struct blk_mq_tag_set *set,
 		struct request *rq, unsigned int hctx_idx)
 {
@@ -299,9 +277,6 @@ static void nvme_rdma_exit_request(struct blk_mq_tag_set *set,
 	struct nvme_rdma_queue *queue = &ctrl->queues[queue_idx];
 	struct nvme_rdma_device *dev = queue->device;
 
-	if (req->mr)
-		ib_dereg_mr(req->mr);
-
 	nvme_rdma_free_qe(dev->dev, &req->sqe, sizeof(struct nvme_command),
 			DMA_TO_DEVICE);
 }
@@ -323,21 +298,9 @@ static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
 	if (ret)
 		return ret;
 
-	req->mr = ib_alloc_mr(dev->pd, IB_MR_TYPE_MEM_REG,
-			ctrl->max_fr_pages);
-	if (IS_ERR(req->mr)) {
-		ret = PTR_ERR(req->mr);
-		goto out_free_qe;
-	}
-
 	req->queue = queue;
 
 	return 0;
-
-out_free_qe:
-	nvme_rdma_free_qe(dev->dev, &req->sqe, sizeof(struct nvme_command),
-			DMA_TO_DEVICE);
-	return -ENOMEM;
 }
 
 static int nvme_rdma_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
@@ -439,6 +402,9 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 
 	dev = queue->device;
 	ibdev = dev->dev;
+
+	ib_mr_pool_destroy(queue->qp, &queue->qp->rdma_mrs);
+
 	rdma_destroy_qp(queue->cm_id);
 	ib_free_cq(queue->ib_cq);
 
@@ -490,8 +456,27 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 		goto out_destroy_qp;
 	}
 
+	if (idx == 0)
+		queue->ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
+				ibdev->attrs.max_fast_reg_page_list_len);
+
+	ret = ib_mr_pool_init(queue->qp, &queue->qp->rdma_mrs,
+			      queue->queue_size,
+			      IB_MR_TYPE_MEM_REG,
+			      queue->ctrl->max_fr_pages);
+
+	if (ret) {
+		dev_err(queue->ctrl->ctrl.device,
+			"failed to initialize MR pool sized %d for QID %d\n",
+			queue->queue_size, idx);
+		goto out_destroy_ring;
+	}
+
 	return 0;
 
+out_destroy_ring:
+	nvme_rdma_free_ring(ibdev, queue->rsp_ring, queue->queue_size,
+			    sizeof(struct nvme_completion), DMA_FROM_DEVICE);
 out_destroy_qp:
 	ib_destroy_qp(queue->qp);
 out_destroy_ib_cq:
@@ -764,9 +749,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	ctrl->device = ctrl->queues[0].device;
 
-	ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
-		ctrl->device->dev->attrs.max_fast_reg_page_list_len);
-
 	if (new) {
 		ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
 		if (IS_ERR(ctrl->ctrl.admin_tagset)) {
@@ -779,11 +761,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 			error = PTR_ERR(ctrl->ctrl.admin_q);
 			goto out_free_tagset;
 		}
-	} else {
-		error = blk_mq_reinit_tagset(&ctrl->admin_tag_set,
-					     nvme_rdma_reinit_request);
-		if (error)
-			goto out_free_queue;
 	}
 
 	error = nvme_rdma_start_queue(ctrl, 0);
@@ -863,11 +840,6 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			goto out_free_tag_set;
 		}
 	} else {
-		ret = blk_mq_reinit_tagset(&ctrl->tag_set,
-					   nvme_rdma_reinit_request);
-		if (ret)
-			goto out_free_io_queues;
-
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set,
 			ctrl->ctrl.queue_count - 1);
 	}
@@ -1065,14 +1037,19 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 	if (!blk_rq_bytes(rq))
 		return;
 
-	if (req->mr->need_inval) {
-		res = nvme_rdma_inv_rkey(queue, req);
-		if (unlikely(res < 0)) {
-			dev_err(ctrl->ctrl.device,
-				"Queueing INV WR for rkey %#x failed (%d)\n",
-				req->mr->rkey, res);
-			nvme_rdma_error_recovery(queue->ctrl);
+	if (req->mr) {
+		if (req->mr->need_inval) {
+			res = nvme_rdma_inv_rkey(queue, req);
+			if (unlikely(res < 0)) {
+				dev_err(ctrl->ctrl.device,
+					"Queueing INV WR for rkey %#x failed (%d)\n",
+					req->mr->rkey, res);
+				nvme_rdma_error_recovery(queue->ctrl);
+			}
 		}
+
+		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
+		req->mr = NULL;
 	}
 
 	ib_dma_unmap_sg(ibdev, req->sg_table.sgl,
@@ -1131,12 +1108,18 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
 	int nr;
 
+	req->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
+	if (!req->mr)
+		return -EAGAIN;
+
 	/*
 	 * Align the MR to a 4K page size to match the ctrl page size and
 	 * the block virtual boundary.
 	 */
 	nr = ib_map_mr_sg(req->mr, req->sg_table.sgl, count, NULL, SZ_4K);
 	if (unlikely(nr < count)) {
+		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
+		req->mr = NULL;
 		if (nr < 0)
 			return nr;
 		return -EINVAL;
@@ -1176,7 +1159,6 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 
 	req->num_sge = 1;
 	req->inline_data = false;
-	req->mr->need_inval = false;
 
 	c->common.flags |= NVME_CMD_SGL_METABUF;
 
@@ -1362,7 +1344,7 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 	if (rq->tag == tag)
 		ret = 1;
 
-	if ((wc->wc_flags & IB_WC_WITH_INVALIDATE) &&
+	if (req->mr && (wc->wc_flags & IB_WC_WITH_INVALIDATE) &&
 	    wc->ex.invalidate_rkey == req->mr->rkey)
 		req->mr->need_inval = false;
 
@@ -1674,7 +1656,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (req_op(rq) == REQ_OP_FLUSH)
 		flush = true;
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
-			req->mr->need_inval ? &req->reg_wr.wr : NULL, flush);
+			req->mr ? &req->reg_wr.wr : NULL, flush);
 	if (unlikely(err)) {
 		nvme_rdma_unmap_data(queue, rq);
 		goto err;
-- 
1.8.3.1
