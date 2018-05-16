From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 16 May 2018 14:37:40 -0600
Subject: nvme: batch completions and do them outside of the queue lock
Message-ID: <528cf765-16ae-5499-8843-9a62b4fd8326@kernel.dk>

This patch splits up the reaping of completion entries, and the
block side completion. The advantage of this is two-fold:

1) We can batch completions, this patch pulls them off in units
   of 8, but that number is fairly arbitrary. I wanted it to be
   big enough to hold most use cases, but not big enough to be
   a stack burden.

2) We complete the block side of things outside of the queue lock.

Note that this kills the ->cqe_seen as well. I haven't been able
to trigger any ill effects of this. If we do race with polling
every so often, it should be rare enough NOT to trigger any issues.

Signed-off-by: Jens Axboe <axboe at kernel.dk>

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 79bbfadcb7b9..ed2bd7840939 100644
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
@@ -954,7 +953,6 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 		return;
 	}
 
-	nvmeq->cqe_seen = 1;
 	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
 	nvme_end_request(req, cqe->status, cqe->result);
 }
@@ -974,29 +972,67 @@ static inline bool nvme_read_cqe(struct nvme_queue *nvmeq,
 	return false;
 }
 
-static void nvme_process_cq(struct nvme_queue *nvmeq)
+static bool nvme_process_cq_end(struct nvme_queue *nvmeq,
+				struct nvme_completion *cqes, unsigned int nr,
+				int tag)
+{
+	bool ret = false;
+	unsigned int i;
+
+	for (i = 0; i < nr; i++) {
+		if (!ret && tag == cqes[i].command_id)
+			ret |= true;
+
+		nvme_handle_cqe(nvmeq, &cqes[i]);
+	}
+
+	return ret;
+}
+
+static int nvme_process_cq_start(struct nvme_queue *nvmeq,
+				 struct nvme_completion *cqes, unsigned int nr)
 {
-	struct nvme_completion cqe;
 	int consumed = 0;
 
-	while (nvme_read_cqe(nvmeq, &cqe)) {
-		nvme_handle_cqe(nvmeq, &cqe);
+	while (nvme_read_cqe(nvmeq, &cqes[consumed])) {
 		consumed++;
+		if (consumed == nr)
+			break;
 	}
 
 	if (consumed)
 		nvme_ring_cq_doorbell(nvmeq);
+
+	return consumed;
+}
+
+static void nvme_process_cq(struct nvme_queue *nvmeq)
+{
+	struct nvme_completion cqe;
+
+	while (nvme_process_cq_start(nvmeq, &cqe, 1))
+		nvme_process_cq_end(nvmeq, &cqe, 1, -1U);
 }
 
 static irqreturn_t nvme_irq(int irq, void *data)
 {
-	irqreturn_t result;
 	struct nvme_queue *nvmeq = data;
-	spin_lock(&nvmeq->q_lock);
-	nvme_process_cq(nvmeq);
-	result = nvmeq->cqe_seen ? IRQ_HANDLED : IRQ_NONE;
-	nvmeq->cqe_seen = 0;
-	spin_unlock(&nvmeq->q_lock);
+	struct nvme_completion cqes[8];
+	irqreturn_t result = IRQ_NONE;
+	int done;
+
+	do {
+		spin_lock(&nvmeq->q_lock);
+		done = nvme_process_cq_start(nvmeq, cqes, ARRAY_SIZE(cqes));
+		spin_unlock(&nvmeq->q_lock);
+
+		if (!done)
+			break;
+
+		result = IRQ_HANDLED;
+		nvme_process_cq_end(nvmeq, cqes, done, -1U);
+	} while (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase));
+
 	return result;
 }
 
@@ -1010,26 +1046,19 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 
 static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 {
-	struct nvme_completion cqe;
-	int found = 0, consumed = 0;
-
-	if (!nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase))
-		return 0;
+	struct nvme_completion cqes[8];
+	int done, found = 0;
 
-	spin_lock_irq(&nvmeq->q_lock);
-	while (nvme_read_cqe(nvmeq, &cqe)) {
-		nvme_handle_cqe(nvmeq, &cqe);
-		consumed++;
+	while (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
+		spin_lock_irq(&nvmeq->q_lock);
+		done = nvme_process_cq_start(nvmeq, cqes, ARRAY_SIZE(cqes));
+		spin_unlock_irq(&nvmeq->q_lock);
 
-		if (tag == cqe.command_id) {
-			found = 1;
+		if (!done)
 			break;
-		}
-       }
 
-	if (consumed)
-		nvme_ring_cq_doorbell(nvmeq);
-	spin_unlock_irq(&nvmeq->q_lock);
+		found |= nvme_process_cq_end(nvmeq, cqes, done, tag);
+	}
 
 	return found;
 }

-- 
Jens Axboe
