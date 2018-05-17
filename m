From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 16 May 2018 21:23:21 -0600
Subject: [PATCH] nvme: handle completions outside of the queue lock
Message-ID: <da619fe4-a9ea-57e9-a731-e59a9043970e@kernel.dk>

Split the completion of events into a two part process:

1) Reap the events inside the queue lock
2) Complete the events outside the queue lock

Since we never wrap the queue, we can access the it locklessly
after we've updated the completion queue head. This patch started
off with batching events on the stack, but with this trick we
don't have to. Keith Busch <keith.busch at intel.com> come up with
that idea.

Note that this kills the ->cqe_seen as well. I haven't been able
to trigger any ill effects of this. If we do race with polling
every so often, it should be rare enough NOT to trigger any issues.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 drivers/nvme/host/pci.c | 87 ++++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 79bbfadcb7b9..845fb398e728 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -160,7 +160,6 @@ struct nvme_queue {
 	u16 cq_head;
 	u16 qid;
 	u8 cq_phase;
-	u8 cqe_seen;
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
@@ -930,7 +929,7 @@ static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
 }
 
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
-		struct nvme_completion *cqe)
+				   volatile struct nvme_completion *cqe)
 {
 	struct request *req;
 
@@ -950,21 +949,17 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 	if (unlikely(nvmeq->qid == 0 &&
 			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH)) {
 		nvme_complete_async_event(&nvmeq->dev->ctrl,
-				cqe->status, &cqe->result);
+				cqe->status, (union nvme_result *) &cqe->result);
 		return;
 	}
 
-	nvmeq->cqe_seen = 1;
 	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
 	nvme_end_request(req, cqe->status, cqe->result);
 }
 
-static inline bool nvme_read_cqe(struct nvme_queue *nvmeq,
-		struct nvme_completion *cqe)
+static inline bool nvme_read_cqe(struct nvme_queue *nvmeq)
 {
 	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
-		*cqe = nvmeq->cqes[nvmeq->cq_head];
-
 		if (++nvmeq->cq_head == nvmeq->q_depth) {
 			nvmeq->cq_head = 0;
 			nvmeq->cq_phase = !nvmeq->cq_phase;
@@ -974,30 +969,54 @@ static inline bool nvme_read_cqe(struct nvme_queue *nvmeq,
 	return false;
 }
 
-static void nvme_process_cq(struct nvme_queue *nvmeq)
+static inline void nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
+				   u16 *end)
+{
+	*start = nvmeq->cq_head;
+	while (nvme_read_cqe(nvmeq))
+		;
+	*end = nvmeq->cq_head;
+
+	if (*start != *end)
+		nvme_ring_cq_doorbell(nvmeq);
+}
+
+static bool nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end,
+			       unsigned int tag)
 {
-	struct nvme_completion cqe;
-	int consumed = 0;
+	bool found = false;
 
-	while (nvme_read_cqe(nvmeq, &cqe)) {
-		nvme_handle_cqe(nvmeq, &cqe);
-		consumed++;
+	if (start == end)
+		return false;
+
+	while (start != end) {
+		volatile struct nvme_completion *cqe = &nvmeq->cqes[start];
+
+		if (!found && tag == cqe->command_id)
+			found = true;
+		nvme_handle_cqe(nvmeq, cqe);
+		if (++start == nvmeq->q_depth)
+			start = 0;
 	}
 
-	if (consumed)
-		nvme_ring_cq_doorbell(nvmeq);
+	return found;
 }
 
 static irqreturn_t nvme_irq(int irq, void *data)
 {
-	irqreturn_t result;
 	struct nvme_queue *nvmeq = data;
+	u16 start, end;
+
 	spin_lock(&nvmeq->q_lock);
-	nvme_process_cq(nvmeq);
-	result = nvmeq->cqe_seen ? IRQ_HANDLED : IRQ_NONE;
-	nvmeq->cqe_seen = 0;
+	nvme_process_cq(nvmeq, &start, &end);
 	spin_unlock(&nvmeq->q_lock);
-	return result;
+
+	if (start != end) {
+		nvme_complete_cqes(nvmeq, start, end, -1);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
 }
 
 static irqreturn_t nvme_irq_check(int irq, void *data)
@@ -1010,28 +1029,16 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 
 static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 {
-	struct nvme_completion cqe;
-	int found = 0, consumed = 0;
+	u16 start, end;
 
 	if (!nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase))
 		return 0;
 
 	spin_lock_irq(&nvmeq->q_lock);
-	while (nvme_read_cqe(nvmeq, &cqe)) {
-		nvme_handle_cqe(nvmeq, &cqe);
-		consumed++;
-
-		if (tag == cqe.command_id) {
-			found = 1;
-			break;
-		}
-       }
-
-	if (consumed)
-		nvme_ring_cq_doorbell(nvmeq);
+	nvme_process_cq(nvmeq, &start, &end);
 	spin_unlock_irq(&nvmeq->q_lock);
 
-	return found;
+	return nvme_complete_cqes(nvmeq, start, end, tag);
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
@@ -1340,6 +1347,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 {
 	struct nvme_queue *nvmeq = &dev->queues[0];
+	u16 start, end;
 
 	if (shutdown)
 		nvme_shutdown_ctrl(&dev->ctrl);
@@ -1347,8 +1355,9 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 		nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
 
 	spin_lock_irq(&nvmeq->q_lock);
-	nvme_process_cq(nvmeq);
+	nvme_process_cq(nvmeq, &start, &end);
 	spin_unlock_irq(&nvmeq->q_lock);
+	nvme_complete_cqes(nvmeq, start, end, -1U);
 }
 
 static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
@@ -1995,6 +2004,7 @@ static void nvme_del_queue_end(struct request *req, blk_status_t error)
 static void nvme_del_cq_end(struct request *req, blk_status_t error)
 {
 	struct nvme_queue *nvmeq = req->end_io_data;
+	u16 start, end;
 
 	if (!error) {
 		unsigned long flags;
@@ -2006,8 +2016,9 @@ static void nvme_del_cq_end(struct request *req, blk_status_t error)
 		 */
 		spin_lock_irqsave_nested(&nvmeq->q_lock, flags,
 					SINGLE_DEPTH_NESTING);
-		nvme_process_cq(nvmeq);
+		nvme_process_cq(nvmeq, &start, &end);
 		spin_unlock_irqrestore(&nvmeq->q_lock, flags);
+		nvme_complete_cqes(nvmeq, start, end, -1U);
 	}
 
 	nvme_del_queue_end(req, error);
-- 
2.7.4

-- 
Jens Axboe
