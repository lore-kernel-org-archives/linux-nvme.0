From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Jan 2018 14:56:29 -0700
Subject: [PATCH 4/5] nvme/pci: Remove cq_vector checks in io path
In-Reply-To: <20180122215630.13697-1-keith.busch@intel.com>
References: <20180122215630.13697-1-keith.busch@intel.com>
Message-ID: <20180122215630.13697-4-keith.busch@intel.com>

We don't need to check for if the queue is suspended in the submission or
completion path. Requests to suspended queues are no longer submitted, and
we don't unmap the doorbell while requests are active.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9e9e3a59bfb3..99ac0de43206 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -889,11 +889,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_mq_start_request(req);
 
 	spin_lock_irq(&nvmeq->q_lock);
-	if (unlikely(nvmeq->cq_vector < 0)) {
-		ret = BLK_STS_IOERR;
-		spin_unlock_irq(&nvmeq->q_lock);
-		goto out_cleanup_iod;
-	}
 	__nvme_submit_cmd(nvmeq, &cmnd);
 	nvme_process_cq(nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -924,11 +919,9 @@ static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
 {
 	u16 head = nvmeq->cq_head;
 
-	if (likely(nvmeq->cq_vector >= 0)) {
-		if (nvme_dbbuf_update_and_check_event(head, nvmeq->dbbuf_cq_db,
-						      nvmeq->dbbuf_cq_ei))
-			writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
-	}
+	if (nvme_dbbuf_update_and_check_event(head, nvmeq->dbbuf_cq_db,
+					      nvmeq->dbbuf_cq_ei))
+		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
 }
 
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
-- 
2.14.3
