From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Jun 2017 20:41:48 +0300
Subject: [PATCH 3/3] nvme-pci: open-code polling logic in nvme_poll
In-Reply-To: <1497548508-29447-1-git-send-email-sagi@grimberg.me>
References: <1497548508-29447-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497548508-29447-4-git-send-email-sagi@grimberg.me>

Given that the code is simple enough it seems better
then passing a tag by reference for each call site.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6733446c1535..f3503c45be57 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -784,7 +784,7 @@ static inline bool nvme_read_cqe(struct nvme_queue *nvmeq,
 	return false;
 }
 
-static int __nvme_process_cq(struct nvme_queue *nvmeq, int budget, int *tag)
+static int __nvme_process_cq(struct nvme_queue *nvmeq, int budget)
 {
 	struct nvme_completion cqe;
 	int consumed = 0;
@@ -793,11 +793,6 @@ static int __nvme_process_cq(struct nvme_queue *nvmeq, int budget, int *tag)
 		nvme_handle_cqe(nvmeq, &cqe);
 		if (++consumed == budget)
 			break;
-
-		if (tag && *tag == cqe.command_id) {
-			*tag = -1;
-			break;
-		}
 	}
 
 	if (consumed) {
@@ -810,7 +805,7 @@ static int __nvme_process_cq(struct nvme_queue *nvmeq, int budget, int *tag)
 
 static int nvme_process_cq(struct nvme_queue *nvmeq)
 {
-	return __nvme_process_cq(nvmeq, INT_MAX, NULL);
+	return __nvme_process_cq(nvmeq, INT_MAX);
 }
 
 static irqreturn_t nvme_irq(int irq, void *data)
@@ -837,16 +832,28 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 
 static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 {
-	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
-		spin_lock_irq(&nvmeq->q_lock);
-		__nvme_process_cq(nvmeq, INT_MAX, &tag);
-		spin_unlock_irq(&nvmeq->q_lock);
+	struct nvme_completion cqe;
+	int found = 0, consumed = 0;
+
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
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
-- 
2.7.4
