From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  5 Oct 2016 12:42:10 +0300
Subject: [PATCH rfc 2/6] nvme-pci: Add budget to __nvme_process_cq
In-Reply-To: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
Message-ID: <1475660534-16681-3-git-send-email-sagi@grimberg.me>

Prepare for irq-poll logic where we budget the completion queue
processing context.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1d8b35a319d0..85bfd76fbee9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -705,7 +705,7 @@ static inline int nvme_read_cqe(struct nvme_queue *nvmeq,
 	return 0;
 }
 
-static int __nvme_process_cq(struct nvme_queue *nvmeq, int *tag)
+static int __nvme_process_cq(struct nvme_queue *nvmeq, int budget, int *tag)
 {
 	struct nvme_completion cqe;
 	int consumed = 0;
@@ -713,6 +713,9 @@ static int __nvme_process_cq(struct nvme_queue *nvmeq, int *tag)
 	while (nvme_read_cqe(nvmeq, &cqe)) {
 		nvme_handle_cqe(nvmeq, &cqe);
 
+		if (++consumed == budget)
+			break;
+
 		if (tag && *tag == cqe.command_id) {
 			*tag = -1;
 			break;
@@ -727,7 +730,7 @@ static int __nvme_process_cq(struct nvme_queue *nvmeq, int *tag)
 
 static int nvme_process_cq(struct nvme_queue *nvmeq)
 {
-	return __nvme_process_cq(nvmeq, NULL);
+	return __nvme_process_cq(nvmeq, INT_MAX, NULL);
 }
 
 static irqreturn_t nvme_irq(int irq, void *data)
@@ -755,7 +758,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 
 	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
 		spin_lock_irq(&nvmeq->q_lock);
-		__nvme_process_cq(nvmeq, &tag);
+		__nvme_process_cq(nvmeq, INT_MAX, &tag);
 		spin_unlock_irq(&nvmeq->q_lock);
 
 		if (tag == -1)
-- 
2.7.4
