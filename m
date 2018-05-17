From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 May 2018 00:47:32 -0700
Subject: [PATCH] nvme: handle completions outside of the queue lock
In-Reply-To: <20180517071651.GC30079@infradead.org>
References: <da619fe4-a9ea-57e9-a731-e59a9043970e@kernel.dk>
 <20180517034750.GA22063@localhost.localdomain>
 <20180517071651.GC30079@infradead.org>
Message-ID: <20180517074732.GA24736@infradead.org>

On Thu, May 17, 2018@12:16:51AM -0700, Christoph Hellwig wrote:
> On Wed, May 16, 2018@09:47:50PM -0600, Keith Busch wrote:
> > Looks good to me. Queued up for 4.18 with just a minor changelog
> > update.
> 
> Folks, can we please at least wait a night to give other ins a
> different time zone to review?  In fact for things not entirely critical
> and non-trivial a few days would be good.

And here is the patch with my suggestions from the last round:

---
>From 816554a6bffe4266d33a60de042f4269597fad2c Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 17 May 2018 09:35:14 +0200
Subject: nvme-pci: streamling the CQ batch processing

Also fixes poll to return once we found the command we polled for and
propagates the volatile status for the result field properly,

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c |  2 +-
 drivers/nvme/host/nvme.h |  2 +-
 drivers/nvme/host/pci.c  | 75 +++++++++++++++++-----------------------
 3 files changed, 34 insertions(+), 45 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62262fac7a5d..b070c659391f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3344,7 +3344,7 @@ static void nvme_fw_act_work(struct work_struct *work)
 }
 
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
-		union nvme_result *res)
+		volatile union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 061fecfd44f5..7a872b0d53a7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -400,7 +400,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 		bool send);
 
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
-		union nvme_result *res);
+		volatile union nvme_result *res);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 43cba47076a3..4367f702f3de 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -929,16 +929,18 @@ static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
 	}
 }
 
-static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
-				   volatile struct nvme_completion *cqe)
+static inline bool nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx,
+		unsigned int poll_command_id)
 {
+	volatile struct nvme_completion *cqe = &nvmeq->cqes[idx];
 	struct request *req;
+	bool match = false;
 
 	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
 		dev_warn(nvmeq->dev->ctrl.device,
 			"invalid id %d completed on queue %d\n",
 			cqe->command_id, le16_to_cpu(cqe->sq_id));
-		return;
+		return false;
 	}
 
 	/*
@@ -950,57 +952,45 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 	if (unlikely(nvmeq->qid == 0 &&
 			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH)) {
 		nvme_complete_async_event(&nvmeq->dev->ctrl,
-				cqe->status, (union nvme_result *) &cqe->result);
-		return;
+				cqe->status, &cqe->result);
+		return false;
 	}
 
+	if (cqe->command_id == poll_command_id)
+		match = true;
 	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
 	nvme_end_request(req, cqe->status, cqe->result);
+	return match;
 }
 
-static inline bool nvme_read_cqe(struct nvme_queue *nvmeq)
+static inline void nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
+				   u16 *end)
 {
-	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
+	*start = nvmeq->cq_head;
+	while (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
 		if (++nvmeq->cq_head == nvmeq->q_depth) {
 			nvmeq->cq_head = 0;
 			nvmeq->cq_phase = !nvmeq->cq_phase;
 		}
-		return true;
 	}
-	return false;
-}
-
-static inline void nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
-				   u16 *end)
-{
-	*start = nvmeq->cq_head;
-	while (nvme_read_cqe(nvmeq))
-		;
 	*end = nvmeq->cq_head;
 
 	if (*start != *end)
 		nvme_ring_cq_doorbell(nvmeq);
 }
 
-static bool nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end,
-			       unsigned int tag)
+static irqreturn_t nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start,
+		u16 end)
 {
-	bool found = false;
-
-	if (start == end)
-		return false;
+	irqreturn_t ret = IRQ_NONE;
 
 	while (start != end) {
-		volatile struct nvme_completion *cqe = &nvmeq->cqes[start];
-
-		if (!found && tag == cqe->command_id)
-			found = true;
-		nvme_handle_cqe(nvmeq, cqe);
+		nvme_handle_cqe(nvmeq, start, -1);
 		if (++start == nvmeq->q_depth)
 			start = 0;
+		ret = IRQ_HANDLED;
 	}
-
-	return found;
+	return ret;
 }
 
 static irqreturn_t nvme_irq(int irq, void *data)
@@ -1012,12 +1002,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	nvme_process_cq(nvmeq, &start, &end);
 	spin_unlock(&nvmeq->q_lock);
 
-	if (start != end) {
-		nvme_complete_cqes(nvmeq, start, end, -1);
-		return IRQ_HANDLED;
-	}
-
-	return IRQ_NONE;
+	return nvme_complete_cqes(nvmeq, start, end);
 }
 
 static irqreturn_t nvme_irq_check(int irq, void *data)
@@ -1039,7 +1024,14 @@ static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 	nvme_process_cq(nvmeq, &start, &end);
 	spin_unlock_irq(&nvmeq->q_lock);
 
-	return nvme_complete_cqes(nvmeq, start, end, tag);
+	while (start != end) {
+		if (nvme_handle_cqe(nvmeq, start, tag))
+			return 1;
+		if (++start == nvmeq->q_depth)
+			start = 0;
+	}
+
+	return 0;
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
@@ -1339,17 +1331,13 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 {
 	struct nvme_queue *nvmeq = &dev->queues[0];
-	u16 start, end;
 
 	if (shutdown)
 		nvme_shutdown_ctrl(&dev->ctrl);
 	else
 		nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
 
-	spin_lock_irq(&nvmeq->q_lock);
-	nvme_process_cq(nvmeq, &start, &end);
-	spin_unlock_irq(&nvmeq->q_lock);
-	nvme_complete_cqes(nvmeq, start, end, -1U);
+	nvme_irq(-1, nvmeq);
 }
 
 static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
@@ -2010,7 +1998,8 @@ static void nvme_del_cq_end(struct request *req, blk_status_t error)
 					SINGLE_DEPTH_NESTING);
 		nvme_process_cq(nvmeq, &start, &end);
 		spin_unlock_irqrestore(&nvmeq->q_lock, flags);
-		nvme_complete_cqes(nvmeq, start, end, -1U);
+
+		nvme_complete_cqes(nvmeq, start, end);
 	}
 
 	nvme_del_queue_end(req, error);
-- 
2.17.0
