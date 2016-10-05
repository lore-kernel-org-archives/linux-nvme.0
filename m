From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  5 Oct 2016 12:42:13 +0300
Subject: [PATCH rfc 5/6] nvme-pci: open-code polling logic in nvme_poll
In-Reply-To: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
Message-ID: <1475660534-16681-6-git-send-email-sagi@grimberg.me>

Given that the code is simple enough it seems better
then passing a tag by reference for each call site.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba448fb755be..a1de66f13e80 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -706,7 +706,7 @@ static inline int nvme_read_cqe(struct nvme_queue *nvmeq,
 	return 0;
 }
 
-static int __nvme_process_cq(struct nvme_queue *nvmeq, int budget, int *tag)
+static int __nvme_process_cq(struct nvme_queue *nvmeq, int budget)
 {
 	struct nvme_completion cqe;
 	int consumed = 0;
@@ -716,11 +716,6 @@ static int __nvme_process_cq(struct nvme_queue *nvmeq, int budget, int *tag)
 
 		if (++consumed == budget)
 			break;
-
-		if (tag && *tag == cqe.command_id) {
-			*tag = -1;
-			break;
-		}
 	}
 
 	if (consumed)
@@ -731,7 +726,7 @@ static int __nvme_process_cq(struct nvme_queue *nvmeq, int budget, int *tag)
 
 static int nvme_process_cq(struct nvme_queue *nvmeq)
 {
-	return __nvme_process_cq(nvmeq, INT_MAX, NULL);
+	return __nvme_process_cq(nvmeq, INT_MAX);
 }
 
 static int nvme_irqpoll_handler(struct irq_poll *iop, int budget)
@@ -740,7 +735,7 @@ static int nvme_irqpoll_handler(struct irq_poll *iop, int budget)
 	int completed;
 
 	spin_lock_irq(&nvmeq->q_lock);
-	completed = __nvme_process_cq(nvmeq, budget, NULL);
+	completed = __nvme_process_cq(nvmeq, budget);
 	if (completed < budget) {
 		irq_poll_complete(&nvmeq->iop);
 		enable_irq(nvmeq->dev->entry[nvmeq->cq_vector].vector);
@@ -773,17 +768,28 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
+	struct nvme_completion cqe;
+	int found = 0, consumed = 0;
 
-	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
-		spin_lock_irq(&nvmeq->q_lock);
-		__nvme_process_cq(nvmeq, INT_MAX, &tag);
-		spin_unlock_irq(&nvmeq->q_lock);
+	if (!nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase))
+		return 0;
+
+	spin_lock_irq(&nvmeq->q_lock);
+	while (nvme_read_cqe(nvmeq, &cqe)) {
+		nvme_handle_cqe(nvmeq, &cqe);
+		consumed++;
 
-		if (tag == -1)
-			return 1;
+		if (tag == cqe.command_id) {
+			found = 1;
+			break;
+		}
 	}
 
-	return 0;
+	if (consumed)
+		nvme_ring_cq_doorbell(nvmeq);
+	spin_unlock_irq(&nvmeq->q_lock);
+
+	return found;
 }
 
 static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl, int aer_idx)
-- 
2.7.4
