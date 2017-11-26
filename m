From: israelr@mellanox.com (Israel Rukshin)
Date: Sun, 26 Nov 2017 10:40:55 +0000
Subject: [PATCH v3] nvme-rdma: Use mr pool
Message-ID: <1511692855-10535-1-git-send-email-israelr@mellanox.com>

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

Changes from v2:
 - rebase the patch over Sagi patch series "Fix request completion holes" v6
 - use WARN_ON_ONCE() for ib_mr_pool_get()
 - calc max_fr_pages at helper function
 - get rid of using need_inval flag

---
 drivers/nvme/host/rdma.c | 95 +++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 58 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f5c1a87..7f63ee9 100644
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
@@ -260,32 +261,6 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
 	return ret;
 }
 
-static int nvme_rdma_reinit_request(void *data, struct request *rq)
-{
-	struct nvme_rdma_ctrl *ctrl = data;
-	struct nvme_rdma_device *dev = ctrl->device;
-	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
-	int ret = 0;
-
-	if (WARN_ON_ONCE(!req->mr))
-		return 0;
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
@@ -295,9 +270,6 @@ static void nvme_rdma_exit_request(struct blk_mq_tag_set *set,
 	struct nvme_rdma_queue *queue = &ctrl->queues[queue_idx];
 	struct nvme_rdma_device *dev = queue->device;
 
-	if (req->mr)
-		ib_dereg_mr(req->mr);
-
 	nvme_rdma_free_qe(dev->dev, &req->sqe, sizeof(struct nvme_command),
 			DMA_TO_DEVICE);
 }
@@ -319,21 +291,9 @@ static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
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
@@ -433,6 +393,8 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
 
+	ib_mr_pool_destroy(queue->qp, &queue->qp->rdma_mrs);
+
 	rdma_destroy_qp(queue->cm_id);
 	ib_free_cq(queue->ib_cq);
 
@@ -442,6 +404,12 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 	nvme_rdma_dev_put(dev);
 }
 
+static int nvme_rdma_get_max_fr_pages(struct ib_device *ibdev)
+{
+	return min_t(u32, NVME_RDMA_MAX_SEGMENTS,
+		     ibdev->attrs.max_fast_reg_page_list_len);
+}
+
 static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 {
 	struct ib_device *ibdev;
@@ -484,8 +452,22 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 		goto out_destroy_qp;
 	}
 
+	ret = ib_mr_pool_init(queue->qp, &queue->qp->rdma_mrs,
+			      queue->queue_size,
+			      IB_MR_TYPE_MEM_REG,
+			      nvme_rdma_get_max_fr_pages(ibdev));
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
 	rdma_destroy_qp(queue->cm_id);
 out_destroy_ib_cq:
@@ -757,8 +739,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	ctrl->device = ctrl->queues[0].device;
 
-	ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
-		ctrl->device->dev->attrs.max_fast_reg_page_list_len);
+	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev);
 
 	if (new) {
 		ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
@@ -772,10 +753,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 			error = PTR_ERR(ctrl->ctrl.admin_q);
 			goto out_free_tagset;
 		}
-	} else {
-		error = nvme_reinit_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
-		if (error)
-			goto out_free_queue;
 	}
 
 	error = nvme_rdma_start_queue(ctrl, 0);
@@ -855,10 +832,6 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			goto out_free_tag_set;
 		}
 	} else {
-		ret = nvme_reinit_tagset(&ctrl->ctrl, ctrl->ctrl.tagset);
-		if (ret)
-			goto out_free_io_queues;
-
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set,
 			ctrl->ctrl.queue_count - 1);
 	}
@@ -1061,6 +1034,11 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 	if (!blk_rq_bytes(rq))
 		return;
 
+	if (req->mr) {
+		ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
+		req->mr = NULL;
+	}
+
 	ib_dma_unmap_sg(ibdev, req->sg_table.sgl,
 			req->nents, rq_data_dir(rq) ==
 				    WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
@@ -1117,12 +1095,18 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
 	int nr;
 
+	req->mr = ib_mr_pool_get(queue->qp, &queue->qp->rdma_mrs);
+	if (WARN_ON_ONCE(!req->mr))
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
@@ -1141,8 +1125,6 @@ static int nvme_rdma_map_sg_fr(struct nvme_rdma_queue *queue,
 			     IB_ACCESS_REMOTE_READ |
 			     IB_ACCESS_REMOTE_WRITE;
 
-	req->mr->need_inval = true;
-
 	sg->addr = cpu_to_le64(req->mr->iova);
 	put_unaligned_le24(req->mr->length, sg->length);
 	put_unaligned_le32(req->mr->rkey, sg->key);
@@ -1162,7 +1144,6 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 
 	req->num_sge = 1;
 	req->inline_data = false;
-	req->mr->need_inval = false;
 	refcount_set(&req->ref, 2); /* send and recv completions */
 
 	c->common.flags |= NVME_CMD_SGL_METABUF;
@@ -1341,8 +1322,7 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 				req->mr->rkey);
 			nvme_rdma_error_recovery(queue->ctrl);
 		}
-		req->mr->need_inval = false;
-	} else if (req->mr->need_inval) {
+	} else if (req->mr) {
 		ret = nvme_rdma_inv_rkey(queue, req);
 		if (unlikely(ret < 0)) {
 			dev_err(queue->ctrl->ctrl.device,
@@ -1670,7 +1650,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
-			req->mr->need_inval ? &req->reg_wr.wr : NULL);
+			req->mr ? &req->reg_wr.wr : NULL);
 	if (unlikely(err)) {
 		nvme_rdma_unmap_data(queue, rq);
 		goto err;
@@ -1818,7 +1798,6 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	.submit_async_event	= nvme_rdma_submit_async_event,
 	.delete_ctrl		= nvme_rdma_delete_ctrl,
 	.get_address		= nvmf_get_address,
-	.reinit_request		= nvme_rdma_reinit_request,
 };
 
 static inline bool
-- 
1.8.3.1
