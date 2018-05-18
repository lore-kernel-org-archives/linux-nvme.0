From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 18 May 2018 08:52:34 -0600
Subject: [PATCH 6/7] nvme-pci: split the nvme queue lock into submission and
 completion locks
In-Reply-To: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
References: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
Message-ID: <1526655155-4006-7-git-send-email-axboe@kernel.dk>

This is now feasible. We protect the submission queue ring with
->sq_lock, and the completion side with ->cq_lock.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fd4f348c8f54..1d64761e66f8 100644
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
@@ -893,9 +894,9 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(req);
 
-	spin_lock_irq(&nvmeq->q_lock);
+	spin_lock_irq(&nvmeq->sq_lock);
 	__nvme_submit_cmd(nvmeq, &cmnd);
-	spin_unlock_irq(&nvmeq->q_lock);
+	spin_unlock_irq(&nvmeq->sq_lock);
 	return BLK_STS_OK;
 out_cleanup_iod:
 	nvme_free_iod(dev, req);
@@ -999,9 +1000,9 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	struct nvme_queue *nvmeq = data;
 	u16 start, end;
 
-	spin_lock(&nvmeq->q_lock);
+	spin_lock(&nvmeq->cq_lock);
 	nvme_process_cq(nvmeq, &start, &end, -1);
-	spin_unlock(&nvmeq->q_lock);
+	spin_unlock(&nvmeq->cq_lock);
 
 	if (start == end)
 		return IRQ_NONE;
@@ -1025,9 +1026,9 @@ static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 	if (!nvme_cqe_pending(nvmeq))
 		return 0;
 
-	spin_lock_irq(&nvmeq->q_lock);
+	spin_lock_irq(&nvmeq->cq_lock);
 	found = nvme_process_cq(nvmeq, &start, &end, tag);
-	spin_unlock_irq(&nvmeq->q_lock);
+	spin_unlock_irq(&nvmeq->cq_lock);
 
 	nvme_complete_cqes(nvmeq, start, end);
 	return found;
@@ -1050,9 +1051,9 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
 
-	spin_lock_irq(&nvmeq->q_lock);
+	spin_lock_irq(&nvmeq->sq_lock);
 	__nvme_submit_cmd(nvmeq, &c);
-	spin_unlock_irq(&nvmeq->q_lock);
+	spin_unlock_irq(&nvmeq->sq_lock);
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
@@ -1318,15 +1319,15 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
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
 
 	/*
 	 * Ensure that nvme_queue_rq() sees it ->cq_vector == -1 without
@@ -1352,9 +1353,9 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 	else
 		nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
 
-	spin_lock_irq(&nvmeq->q_lock);
+	spin_lock_irq(&nvmeq->cq_lock);
 	nvme_process_cq(nvmeq, &start, &end, -1);
-	spin_unlock_irq(&nvmeq->q_lock);
+	spin_unlock_irq(&nvmeq->cq_lock);
 
 	nvme_complete_cqes(nvmeq, start, end);
 }
@@ -1414,7 +1415,8 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 
 	nvmeq->q_dmadev = dev->dev;
 	nvmeq->dev = dev;
-	spin_lock_init(&nvmeq->q_lock);
+	spin_lock_init(&nvmeq->sq_lock);
+	spin_lock_init(&nvmeq->cq_lock);
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
@@ -1450,7 +1452,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 
-	spin_lock_irq(&nvmeq->q_lock);
+	spin_lock_irq(&nvmeq->cq_lock);
 	nvmeq->sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
@@ -1458,7 +1460,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	nvme_dbbuf_init(dev, nvmeq, qid);
 	dev->online_queues++;
-	spin_unlock_irq(&nvmeq->q_lock);
+	spin_unlock_irq(&nvmeq->cq_lock);
 }
 
 static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
@@ -2009,14 +2011,14 @@ static void nvme_del_cq_end(struct request *req, blk_status_t error)
 		unsigned long flags;
 
 		/*
-		 * We might be called with the AQ q_lock held
-		 * and the I/O queue q_lock should always
+		 * We might be called with the AQ cq_lock held
+		 * and the I/O queue cq_lock should always
 		 * nest inside the AQ one.
 		 */
-		spin_lock_irqsave_nested(&nvmeq->q_lock, flags,
+		spin_lock_irqsave_nested(&nvmeq->cq_lock, flags,
 					SINGLE_DEPTH_NESTING);
 		nvme_process_cq(nvmeq, &start, &end, -1);
-		spin_unlock_irqrestore(&nvmeq->q_lock, flags);
+		spin_unlock_irqrestore(&nvmeq->cq_lock, flags);
 
 		nvme_complete_cqes(nvmeq, start, end);
 	}
-- 
2.7.4
