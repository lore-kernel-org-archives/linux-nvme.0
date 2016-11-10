From: hch@lst.de (Christoph Hellwig)
Date: Thu, 10 Nov 2016 07:32:34 -0800
Subject: [PATCH 2/2] nvme: don't pass the full CQE to nvme_complete_async_event
In-Reply-To: <1478791954-30152-1-git-send-email-hch@lst.de>
References: <1478791954-30152-1-git-send-email-hch@lst.de>
Message-ID: <1478791954-30152-3-git-send-email-hch@lst.de>

We only need the status and result fields, and passing them explicitly
makes life a lot easier for the Fibre Channel transport which doesn't
have a full CQE for the fast path case.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c   | 19 +++++++++++++------
 drivers/nvme/host/nvme.h   |  4 ++--
 drivers/nvme/host/pci.c    |  3 ++-
 drivers/nvme/host/rdma.c   |  3 ++-
 drivers/nvme/target/loop.c |  3 ++-
 5 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2fd632b..53584d2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1895,18 +1895,25 @@ static void nvme_async_event_work(struct work_struct *work)
 	spin_unlock_irq(&ctrl->lock);
 }
 
-void nvme_complete_async_event(struct nvme_ctrl *ctrl,
-		struct nvme_completion *cqe)
+void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
+		union nvme_result *res)
 {
-	u16 status = le16_to_cpu(cqe->status) >> 1;
-	u32 result = le32_to_cpu(cqe->result.u32);
+	u32 result = le32_to_cpu(res->u32);
+	bool done = true;
 
-	if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ) {
+	switch (le16_to_cpu(status) >> 1) {
+	case NVME_SC_SUCCESS:
+		done = false;
+		/*FALLTHRU*/
+	case NVME_SC_ABORT_REQ:
 		++ctrl->event_limit;
 		schedule_work(&ctrl->async_event_work);
+		break;
+	default:
+		break;
 	}
 
-	if (status != NVME_SC_SUCCESS)
+	if (done)
 		return;
 
 	switch (result & 0xff07) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5e64957a..468fc44 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -275,8 +275,8 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
 #define NVME_NR_AERS	1
-void nvme_complete_async_event(struct nvme_ctrl *ctrl,
-		struct nvme_completion *cqe);
+void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
+		union nvme_result *res);
 void nvme_queue_async_events(struct nvme_ctrl *ctrl);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index de8e050..51d13d5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -703,7 +703,8 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 		 */
 		if (unlikely(nvmeq->qid == 0 &&
 				cqe.command_id >= NVME_AQ_BLKMQ_DEPTH)) {
-			nvme_complete_async_event(&nvmeq->dev->ctrl, &cqe);
+			nvme_complete_async_event(&nvmeq->dev->ctrl,
+					cqe.status, &cqe.result);
 			continue;
 		}
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0b8a161..c4700ef 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1168,7 +1168,8 @@ static int __nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc, int tag)
 	 */
 	if (unlikely(nvme_rdma_queue_idx(queue) == 0 &&
 			cqe->command_id >= NVME_RDMA_AQ_BLKMQ_DEPTH))
-		nvme_complete_async_event(&queue->ctrl->ctrl, cqe);
+		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
+				&cqe->result);
 	else
 		ret = nvme_rdma_process_nvme_rsp(queue, cqe, wc, tag);
 	ib_dma_sync_single_for_device(ibdev, qe->dma, len, DMA_FROM_DEVICE);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 757e21a..26aa3a5 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -127,7 +127,8 @@ static void nvme_loop_queue_response(struct nvmet_req *req)
 	 */
 	if (unlikely(nvme_loop_queue_idx(iod->queue) == 0 &&
 			cqe->command_id >= NVME_LOOP_AQ_BLKMQ_DEPTH)) {
-		nvme_complete_async_event(&iod->queue->ctrl->ctrl, cqe);
+		nvme_complete_async_event(&iod->queue->ctrl->ctrl, cqe->status,
+				&cqe->result);
 	} else {
 		struct request *rq = blk_mq_rq_from_pdu(iod);
 
-- 
2.1.4
