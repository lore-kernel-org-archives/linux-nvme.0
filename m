From: axboe@kernel.dk (Jens Axboe)
Date: Sat, 17 Nov 2018 14:43:51 -0700
Subject: [PATCH 4/7] blk-mq: when polling for IO, look for any completion
In-Reply-To: <20181117214354.822-1-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
Message-ID: <20181117214354.822-5-axboe@kernel.dk>

If we want to support async IO polling, then we have to allow
finding completions that aren't just for the one we are
looking for. Always pass in -1 to the mq_ops->poll() helper,
and have that return how many events were found in this poll
loop.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 block/blk-mq.c           | 69 +++++++++++++++++++++++-----------------
 drivers/nvme/host/pci.c  | 14 ++++----
 drivers/nvme/host/rdma.c | 36 ++++++++++-----------
 3 files changed, 62 insertions(+), 57 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 52b1c97cd7c6..3ca00d712158 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3266,9 +3266,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	 *  0:	use half of prev avg
 	 * >0:	use this specific value
 	 */
-	if (q->poll_nsec == -1)
-		return false;
-	else if (q->poll_nsec > 0)
+	if (q->poll_nsec > 0)
 		nsecs = q->poll_nsec;
 	else
 		nsecs = blk_mq_poll_nsecs(q, hctx, rq);
@@ -3305,21 +3303,36 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	return true;
 }
 
-static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
+static bool blk_mq_poll_hybrid(struct request_queue *q,
+			       struct blk_mq_hw_ctx *hctx, blk_qc_t cookie)
+{
+	struct request *rq;
+
+	if (q->poll_nsec == -1)
+		return false;
+
+	if (!blk_qc_t_is_internal(cookie))
+		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
+	else {
+		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
+		/*
+		 * With scheduling, if the request has completed, we'll
+		 * get a NULL return here, as we clear the sched tag when
+		 * that happens. The request still remains valid, like always,
+		 * so we should be safe with just the NULL check.
+		 */
+		if (!rq)
+			return false;
+	}
+
+	return blk_mq_poll_hybrid_sleep(q, hctx, rq);
+}
+
+static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	long state;
 
-	/*
-	 * If we sleep, have the caller restart the poll loop to reset
-	 * the state. Like for the other success return cases, the
-	 * caller is responsible for checking if the IO completed. If
-	 * the IO isn't complete, we'll get called again and will go
-	 * straight to the busy poll loop.
-	 */
-	if (blk_mq_poll_hybrid_sleep(q, hctx, rq))
-		return 1;
-
 	hctx->poll_considered++;
 
 	state = current->state;
@@ -3328,7 +3341,7 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 
 		hctx->poll_invoked++;
 
-		ret = q->mq_ops->poll(hctx, rq->tag);
+		ret = q->mq_ops->poll(hctx, -1U);
 		if (ret > 0) {
 			hctx->poll_success++;
 			__set_current_state(TASK_RUNNING);
@@ -3352,27 +3365,23 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 static int blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 {
 	struct blk_mq_hw_ctx *hctx;
-	struct request *rq;
 
 	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return 0;
 
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
-	if (!blk_qc_t_is_internal(cookie))
-		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
-	else {
-		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
-		/*
-		 * With scheduling, if the request has completed, we'll
-		 * get a NULL return here, as we clear the sched tag when
-		 * that happens. The request still remains valid, like always,
-		 * so we should be safe with just the NULL check.
-		 */
-		if (!rq)
-			return 0;
-	}
 
-	return __blk_mq_poll(hctx, rq);
+	/*
+	 * If we sleep, have the caller restart the poll loop to reset
+	 * the state. Like for the other success return cases, the
+	 * caller is responsible for checking if the IO completed. If
+	 * the IO isn't complete, we'll get called again and will go
+	 * straight to the busy poll loop.
+	 */
+	if (blk_mq_poll_hybrid(q, hctx, cookie))
+		return 1;
+
+	return __blk_mq_poll(hctx);
 }
 
 unsigned int blk_mq_rq_cpu(struct request *rq)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 89874e23e422..1742c8ab8196 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1012,15 +1012,15 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 	}
 }
 
-static inline bool nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
-		u16 *end, int tag)
+static inline int nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
+				  u16 *end, unsigned int tag)
 {
-	bool found = false;
+	int found = 0;
 
 	*start = nvmeq->cq_head;
-	while (!found && nvme_cqe_pending(nvmeq)) {
-		if (nvmeq->cqes[nvmeq->cq_head].command_id == tag)
-			found = true;
+	while (nvme_cqe_pending(nvmeq)) {
+		if (tag == -1U || nvmeq->cqes[nvmeq->cq_head].command_id == tag)
+			found++;
 		nvme_update_cq_head(nvmeq);
 	}
 	*end = nvmeq->cq_head;
@@ -1062,7 +1062,7 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 {
 	u16 start, end;
-	bool found;
+	int found;
 
 	if (!nvme_cqe_pending(nvmeq))
 		return 0;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d181cafedc58..53e44efc6d32 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1409,12 +1409,11 @@ static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg)
 	WARN_ON_ONCE(ret);
 }
 
-static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
-		struct nvme_completion *cqe, struct ib_wc *wc, int tag)
+static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
+		struct nvme_completion *cqe, struct ib_wc *wc)
 {
 	struct request *rq;
 	struct nvme_rdma_request *req;
-	int ret = 0;
 
 	rq = blk_mq_tag_to_rq(nvme_rdma_tagset(queue), cqe->command_id);
 	if (!rq) {
@@ -1422,7 +1421,7 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 			"tag 0x%x on QP %#x not found\n",
 			cqe->command_id, queue->qp->qp_num);
 		nvme_rdma_error_recovery(queue->ctrl);
-		return ret;
+		return;
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
@@ -1437,6 +1436,8 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 			nvme_rdma_error_recovery(queue->ctrl);
 		}
 	} else if (req->mr) {
+		int ret;
+
 		ret = nvme_rdma_inv_rkey(queue, req);
 		if (unlikely(ret < 0)) {
 			dev_err(queue->ctrl->ctrl.device,
@@ -1445,19 +1446,14 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 			nvme_rdma_error_recovery(queue->ctrl);
 		}
 		/* the local invalidation completion will end the request */
-		return 0;
+		return;
 	}
 
-	if (refcount_dec_and_test(&req->ref)) {
-		if (rq->tag == tag)
-			ret = 1;
+	if (refcount_dec_and_test(&req->ref))
 		nvme_end_request(rq, req->status, req->result);
-	}
-
-	return ret;
 }
 
-static int __nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc, int tag)
+static void __nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvme_rdma_qe *qe =
 		container_of(wc->wr_cqe, struct nvme_rdma_qe, cqe);
@@ -1465,11 +1461,10 @@ static int __nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc, int tag)
 	struct ib_device *ibdev = queue->device->dev;
 	struct nvme_completion *cqe = qe->data;
 	const size_t len = sizeof(struct nvme_completion);
-	int ret = 0;
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
 		nvme_rdma_wr_error(cq, wc, "RECV");
-		return 0;
+		return;
 	}
 
 	ib_dma_sync_single_for_cpu(ibdev, qe->dma, len, DMA_FROM_DEVICE);
@@ -1484,16 +1479,15 @@ static int __nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc, int tag)
 		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
 	else
-		ret = nvme_rdma_process_nvme_rsp(queue, cqe, wc, tag);
+		nvme_rdma_process_nvme_rsp(queue, cqe, wc);
 	ib_dma_sync_single_for_device(ibdev, qe->dma, len, DMA_FROM_DEVICE);
 
 	nvme_rdma_post_recv(queue, qe);
-	return ret;
 }
 
 static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	__nvme_rdma_recv_done(cq, wc, -1);
+	__nvme_rdma_recv_done(cq, wc);
 }
 
 static int nvme_rdma_conn_established(struct nvme_rdma_queue *queue)
@@ -1758,10 +1752,12 @@ static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 		struct ib_cqe *cqe = wc.wr_cqe;
 
 		if (cqe) {
-			if (cqe->done == nvme_rdma_recv_done)
-				found |= __nvme_rdma_recv_done(cq, &wc, tag);
-			else
+			if (cqe->done == nvme_rdma_recv_done) {
+				__nvme_rdma_recv_done(cq, &wc);
+				found++;
+			} else {
 				cqe->done(cq, &wc);
+			}
 		}
 	}
 
-- 
2.17.1
