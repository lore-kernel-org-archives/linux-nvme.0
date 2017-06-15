From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Jun 2017 20:41:47 +0300
Subject: [PATCH 2/3] nvme-pci: Add budget to __nvme_process_cq
In-Reply-To: <1497548508-29447-1-git-send-email-sagi@grimberg.me>
References: <1497548508-29447-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497548508-29447-3-git-send-email-sagi@grimberg.me>

Prepare for irq-poll logic

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a99a483a8bb5..6733446c1535 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -784,14 +784,15 @@ static inline bool nvme_read_cqe(struct nvme_queue *nvmeq,
 	return false;
 }
 
-static int __nvme_process_cq(struct nvme_queue *nvmeq, int *tag)
+static int __nvme_process_cq(struct nvme_queue *nvmeq, int budget, int *tag)
 {
 	struct nvme_completion cqe;
 	int consumed = 0;
 
 	while (nvme_read_cqe(nvmeq, &cqe)) {
 		nvme_handle_cqe(nvmeq, &cqe);
-		consumed++;
+		if (++consumed == budget)
+			break;
 
 		if (tag && *tag == cqe.command_id) {
 			*tag = -1;
@@ -809,7 +810,7 @@ static int __nvme_process_cq(struct nvme_queue *nvmeq, int *tag)
 
 static int nvme_process_cq(struct nvme_queue *nvmeq)
 {
-	return __nvme_process_cq(nvmeq, NULL);
+	return __nvme_process_cq(nvmeq, INT_MAX, NULL);
 }
 
 static irqreturn_t nvme_irq(int irq, void *data)
@@ -838,7 +839,7 @@ static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 {
 	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
 		spin_lock_irq(&nvmeq->q_lock);
-		__nvme_process_cq(nvmeq, &tag);
+		__nvme_process_cq(nvmeq, INT_MAX, &tag);
 		spin_unlock_irq(&nvmeq->q_lock);
 
 		if (tag == -1)
-- 
2.7.4
