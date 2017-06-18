From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 17:28:10 +0300
Subject: [PATCH v2 4/4] nvme-pci: open-code polling logic in nvme_poll
In-Reply-To: <1497796090-14808-1-git-send-email-sagi@grimberg.me>
References: <1497796090-14808-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497796090-14808-5-git-send-email-sagi@grimberg.me>

Given that the code is simple enough it seems better
then passing a tag by reference for each call site, also
we can now get rid of __nvme_process_cq.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d309b6c90511..2a9ee769ce9e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -785,7 +785,7 @@ static inline bool nvme_read_cqe(struct nvme_queue *nvmeq,
 	return false;
 }
 
-static void __nvme_process_cq(struct nvme_queue *nvmeq, int *tag)
+static void nvme_process_cq(struct nvme_queue *nvmeq)
 {
 	struct nvme_completion cqe;
 	int consumed = 0;
@@ -793,11 +793,6 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, int *tag)
 	while (nvme_read_cqe(nvmeq, &cqe)) {
 		nvme_handle_cqe(nvmeq, &cqe);
 		consumed++;
-
-		if (tag && *tag == cqe.command_id) {
-			*tag = -1;
-			break;
-		}
 	}
 
 	if (consumed) {
@@ -806,11 +801,6 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, int *tag)
 	}
 }
 
-static void nvme_process_cq(struct nvme_queue *nvmeq)
-{
-	__nvme_process_cq(nvmeq, NULL);
-}
-
 static irqreturn_t nvme_irq(int irq, void *data)
 {
 	irqreturn_t result;
@@ -833,16 +823,28 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 
 static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 {
-	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
-		spin_lock_irq(&nvmeq->q_lock);
-		__nvme_process_cq(nvmeq, &tag);
-		spin_unlock_irq(&nvmeq->q_lock);
+	struct nvme_completion cqe;
+	int found = 0, consumed = 0;
 
-		if (tag == -1)
-			return 1;
-	}
+	if (!nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase))
+		return 0;
 
-	return 0;
+	spin_lock_irq(&nvmeq->q_lock);
+	while (nvme_read_cqe(nvmeq, &cqe)) {
+		nvme_handle_cqe(nvmeq, &cqe);
+		consumed++;
+
+		if (tag == cqe.command_id) {
+			found = 1;
+			break;
+		}
+       }
+
+	if (consumed)
+		nvme_ring_cq_doorbell(nvmeq);
+	spin_unlock_irq(&nvmeq->q_lock);
+
+	return found;
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
-- 
2.7.4
