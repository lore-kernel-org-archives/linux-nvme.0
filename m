From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 16 May 2018 16:35:38 -0600
Subject: nvme: batch completions and do them outside of the queue lock
In-Reply-To: <20180516212757.GD20223@localhost.localdomain>
References: <528cf765-16ae-5499-8843-9a62b4fd8326@kernel.dk>
 <20180516212757.GD20223@localhost.localdomain>
Message-ID: <20180516223538.GE20223@localhost.localdomain>

On Wed, May 16, 2018@03:27:57PM -0600, Keith Busch wrote:
> On Wed, May 16, 2018@02:37:40PM -0600, Jens Axboe wrote:
> > This patch splits up the reaping of completion entries, and the
> > block side completion. The advantage of this is two-fold:
> > 
> > 1) We can batch completions, this patch pulls them off in units
> >    of 8, but that number is fairly arbitrary. I wanted it to be
> >    big enough to hold most use cases, but not big enough to be
> >    a stack burden.
> > 
> > 2) We complete the block side of things outside of the queue lock.
> 
> Interesting idea. Since you bring this up, I think there may be more
> optimizations on top of this concept. I'll stare at this a bit before
> applying, or may have a follow-up proposal later.

While I'm not seeing a difference, I assume you are. I tried adding on
to this proposal by batching *all* completions without using the stack,
exploiting the fact we never wrap the queue so it can be accessed
lockless after moving the cq_head.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 170642ad43fd..ac23314c94f5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -161,7 +161,6 @@ struct nvme_queue {
 	u16 cq_head;
 	u16 qid;
 	u8 cq_phase;
-	u8 cqe_seen;
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
@@ -955,17 +954,13 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
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
@@ -975,30 +970,41 @@ static inline bool nvme_read_cqe(struct nvme_queue *nvmeq,
 	return false;
 }
 
-static void nvme_process_cq(struct nvme_queue *nvmeq)
+static inline void nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
+				   u16 *end)
 {
-	struct nvme_completion cqe;
-	int consumed = 0;
-
-	while (nvme_read_cqe(nvmeq, &cqe)) {
-		nvme_handle_cqe(nvmeq, &cqe);
-		consumed++;
-	}
+	*start = nvmeq->cq_head;
+	while (nvme_read_cqe(nvmeq));
+	*end = nvmeq->cq_head;
 
-	if (consumed)
+	if (*start != *end)
 		nvme_ring_cq_doorbell(nvmeq);
 }
 
+static inline irqreturn_t nvme_complete_cqes(struct nvme_queue *nvmeq,
+					     u16 start, u16 end)
+{
+	if (start == end)
+		return IRQ_NONE;
+
+	while (start != end) {
+		nvme_handle_cqe(nvmeq, &nvmeq->cqes[start]);
+		if (++start == nvmeq->q_depth)
+			start = 0;
+	}
+	return IRQ_HANDLED;
+}
+
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
+	return nvme_complete_cqes(nvmeq, start, end);
 }
 
 static irqreturn_t nvme_irq_check(int irq, void *data)
@@ -1011,27 +1017,26 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 
 static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 {
-	struct nvme_completion cqe;
-	int found = 0, consumed = 0;
+	u16 start, end;
+	int found = 0;
 
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
+	nvme_process_cq(nvmeq, &start, &end);
+	spin_unlock(&nvmeq->q_lock);
 
-	if (consumed)
-		nvme_ring_cq_doorbell(nvmeq);
-	spin_unlock_irq(&nvmeq->q_lock);
+	if (start == end)
+		return 0;
 
+	while (start != end) {
+		nvme_handle_cqe(nvmeq, &nvmeq->cqes[start]);
+		if (++start == nvmeq->q_depth)
+			start = 0;
+		if (tag == cqe.command_id)
+			found = 1;
+	}
 	return found;
 }
 
@@ -1332,6 +1337,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 {
 	struct nvme_queue *nvmeq = &dev->queues[0];
+	u16 start, end;
 
 	if (shutdown)
 		nvme_shutdown_ctrl(&dev->ctrl);
@@ -1339,8 +1345,9 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 		nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
 
 	spin_lock_irq(&nvmeq->q_lock);
-	nvme_process_cq(nvmeq);
+	nvme_process_cq(nvmeq, &start, &end);
 	spin_unlock_irq(&nvmeq->q_lock);
+	nvme_complete_cqes(nvmeq, start, end);
 }
 
 static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
@@ -1987,6 +1994,7 @@ static void nvme_del_queue_end(struct request *req, blk_status_t error)
 static void nvme_del_cq_end(struct request *req, blk_status_t error)
 {
 	struct nvme_queue *nvmeq = req->end_io_data;
+	u16 start, end;
 
 	if (!error) {
 		unsigned long flags;
@@ -1998,8 +2006,9 @@ static void nvme_del_cq_end(struct request *req, blk_status_t error)
 		 */
 		spin_lock_irqsave_nested(&nvmeq->q_lock, flags,
 					SINGLE_DEPTH_NESTING);
-		nvme_process_cq(nvmeq);
+		nvme_process_cq(nvmeq, &start, &end);
 		spin_unlock_irqrestore(&nvmeq->q_lock, flags);
+		nvme_complete_cqes(nvmeq, start, end);
 	}
 
 	nvme_del_queue_end(req, error);
--
