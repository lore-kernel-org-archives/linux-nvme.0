From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 17 May 2018 09:02:16 -0600
Subject: [PATCH 2/3] nvme: split the nvme queue lock into submission and
 completion locks
In-Reply-To: <1526569337-3489-1-git-send-email-axboe@kernel.dk>
References: <1526569337-3489-1-git-send-email-axboe@kernel.dk>
Message-ID: <1526569337-3489-3-git-send-email-axboe@kernel.dk>

This is now feasible. We protect the submission queue ring with
->sq_lock, and the completion side with ->cq_lock.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 drivers/nvme/host/pci.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4ed3583ad3bc..ae982edfa4f3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -146,9 +146,10 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
 struct nvme_queue {
 	struct device *q_dmadev;
 	struct nvme_dev *dev;
-	spinlock_t q_lock;
+	spinlock_t sq_lock;
 	struct nvme_command *sq_cmds;
 	struct nvme_command __iomem *sq_cmds_io;
+	spinlock_t cq_lock ____cacheline_aligned_in_smp;
 	volatile struct nvme_completion *cqes;
 	struct blk_mq_tags **tags;
 	dma_addr_t sq_dma_addr;
@@ -886,9 +887,9 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(req);
 
-	spin_lock_irq(&nvmeq->q_lock);
+	spin_lock_irq(&nvmeq->sq_lock);
 	__nvme_submit_cmd(nvmeq, &cmnd);
-	spin_unlock_irq(&nvmeq->q_lock);
+	spin_unlock_irq(&nvmeq->sq_lock);
 	return BLK_STS_OK;
 out_cleanup_iod:
 	nvme_free_iod(dev, req);
@@ -992,9 +993,9 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	struct nvme_queue *nvmeq = data;
 	u16 start, end;
 
-	spin_lock(&nvmeq->q_lock);
+	spin_lock(&nvmeq->cq_lock);
 	nvme_process_cq(nvmeq, &start, &end);
-	spin_unlock(&nvmeq->q_lock);
+	spin_unlock(&nvmeq->cq_lock);
 
 	return nvme_complete_cqes(nvmeq, start, end);
 }
@@ -1014,9 +1015,9 @@ static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 	if (!nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase))
 		return 0;
 
-	spin_lock_irq(&nvmeq->q_lock);
+	spin_lock_irq(&nvmeq->cq_lock);
 	nvme_process_cq(nvmeq, &start, &end);
-	spin_unlock_irq(&nvmeq->q_lock);
+	spin_unlock_irq(&nvmeq->cq_lock);
 
 	while (start != end) {
 		if (nvme_handle_cqe(nvmeq, start, tag))
@@ -1045,9 +1046,9 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
 
-	spin_lock_irq(&nvmeq->q_lock);
+	spin_lock_irq(&nvmeq->sq_lock);
 	__nvme_submit_cmd(nvmeq, &c);
-	spin_unlock_irq(&nvmeq->q_lock);
+	spin_unlock_irq(&nvmeq->sq_lock);
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
@@ -1313,15 +1314,15 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 {
 	int vector;
 
-	spin_lock_irq(&nvmeq->q_lock);
+	spin_lock_irq(&nvmeq->cq_lock);
 	if (nvmeq->cq_vector == -1) {
-		spin_unlock_irq(&nvmeq->q_lock);
+		spin_unlock_irq(&nvmeq->cq_lock);
 		return 1;
 	}
 	vector = nvmeq->cq_vector;
 	nvmeq->dev->online_queues--;
 	nvmeq->cq_vector = -1;
-	spin_unlock_irq(&nvmeq->q_lock);
+	spin_unlock_irq(&nvmeq->cq_lock);
 
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
@@ -1398,7 +1399,8 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 
 	nvmeq->q_dmadev = dev->dev;
 	nvmeq->dev = dev;
-	spin_lock_init(&nvmeq->q_lock);
+	spin_lock_init(&nvmeq->sq_lock);
+	spin_lock_init(&nvmeq->cq_lock);
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
@@ -1434,7 +1436,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 
-	spin_lock_irq(&nvmeq->q_lock);
+	spin_lock_irq(&nvmeq->cq_lock);
 	nvmeq->sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
@@ -1442,7 +1444,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	nvme_dbbuf_init(dev, nvmeq, qid);
 	dev->online_queues++;
-	spin_unlock_irq(&nvmeq->q_lock);
+	spin_unlock_irq(&nvmeq->cq_lock);
 }
 
 static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
@@ -1997,10 +1999,10 @@ static void nvme_del_cq_end(struct request *req, blk_status_t error)
 		 * and the I/O queue q_lock should always
 		 * nest inside the AQ one.
 		 */
-		spin_lock_irqsave_nested(&nvmeq->q_lock, flags,
+		spin_lock_irqsave_nested(&nvmeq->cq_lock, flags,
 					SINGLE_DEPTH_NESTING);
 		nvme_process_cq(nvmeq, &start, &end);
-		spin_unlock_irqrestore(&nvmeq->q_lock, flags);
+		spin_unlock_irqrestore(&nvmeq->cq_lock, flags);
 
 		nvme_complete_cqes(nvmeq, start, end);
 	}
-- 
2.7.4
