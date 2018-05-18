From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 18 May 2018 08:52:30 -0600
Subject: [PATCH 2/7] nvme-pci: simplify nvme_cqe_valid
In-Reply-To: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
References: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
Message-ID: <1526655155-4006-3-git-send-email-axboe@kernel.dk>

From: Christoph Hellwig <hch@lst.de>

We always look at the current CQ head and phase, so don't pass these
as separate arguments, and rename the function to nvme_cqe_pending.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 drivers/nvme/host/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17a0190bd88f..9e2510249fa2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -914,10 +914,10 @@ static void nvme_pci_complete_rq(struct request *req)
 }
 
 /* We read the CQE phase first to check if the rest of the entry is valid */
-static inline bool nvme_cqe_valid(struct nvme_queue *nvmeq, u16 head,
-		u16 phase)
+static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
 {
-	return (le16_to_cpu(nvmeq->cqes[head].status) & 1) == phase;
+	return (le16_to_cpu(nvmeq->cqes[nvmeq->cq_head].status) & 1) ==
+			nvmeq->cq_phase;
 }
 
 static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
@@ -964,7 +964,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 static inline bool nvme_read_cqe(struct nvme_queue *nvmeq,
 		struct nvme_completion *cqe)
 {
-	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
+	if (nvme_cqe_pending(nvmeq)) {
 		*cqe = nvmeq->cqes[nvmeq->cq_head];
 
 		if (++nvmeq->cq_head == nvmeq->q_depth) {
@@ -1005,7 +1005,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 static irqreturn_t nvme_irq_check(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
-	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase))
+	if (nvme_cqe_pending(nvmeq))
 		return IRQ_WAKE_THREAD;
 	return IRQ_NONE;
 }
@@ -1015,7 +1015,7 @@ static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 	struct nvme_completion cqe;
 	int found = 0, consumed = 0;
 
-	if (!nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase))
+	if (!nvme_cqe_pending(nvmeq))
 		return 0;
 
 	spin_lock_irq(&nvmeq->q_lock);
-- 
2.7.4
