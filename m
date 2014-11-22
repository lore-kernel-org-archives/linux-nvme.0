From: sbradshaw@micron.com (Sam Bradshaw)
Date: Fri, 21 Nov 2014 16:24:02 -0800
Subject: [PATCH] NVMe: Re-introduce nvmeq->q_suspended
Message-ID: <546FD7A2.2070305@micron.com>

At some point in the blk-mq transition, q_suspended was removed.  This 
patch adds it back to address two failure modes, both illustrated in 
the attached snippet.  First, it protects the ioctl path from 
inadvertently dereferencing invalid nvme_queue data structures during 
device shutdown/reset.  Second, it protects against a double free_irq() 
if the shutdown/reset/resume sequence doesn't recover a flaky controller.

Patch is against Jens' for-3.19/drivers branch.

Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
---
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index c154165..64d6fc9 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -100,6 +100,7 @@ struct nvme_queue {
 	struct nvme_dev *dev;
 	char irqname[24];	/* nvme4294967295-65535\0 */
 	spinlock_t q_lock;
+	u8 q_suspended;
 	struct nvme_command *sq_cmds;
 	volatile struct nvme_completion *cqes;
 	dma_addr_t sq_dma_addr;
@@ -350,6 +351,10 @@ static int nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
 	unsigned long flags;
 	int ret;
 	spin_lock_irqsave(&nvmeq->q_lock, flags);
+	if (nvmeq->q_suspended) {
+		spin_unlock_irqrestore(&nvmeq->q_lock, flags);
+		return -EBUSY;
+	}
 	ret = __nvme_submit_cmd(nvmeq, cmd);
 	spin_unlock_irqrestore(&nvmeq->q_lock, flags);
 	return ret;
@@ -622,6 +627,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_iod *iod;
 	int psegs = req->nr_phys_segments;
 	int result = BLK_MQ_RQ_QUEUE_BUSY;
+	int do_prep = 1;
 	enum dma_data_direction dma_dir;
 	unsigned size = !(req->cmd_flags & REQ_DISCARD) ? blk_rq_bytes(req) :
 						sizeof(struct nvme_dsm_range);
@@ -630,8 +636,10 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * Requeued IO has already been prepped
 	 */
 	iod = req->special;
-	if (iod)
+	if (iod) {
+		do_prep = 0;
 		goto submit_iod;
+	}
 
 	iod = nvme_alloc_iod(psegs, size, ns->dev, GFP_ATOMIC);
 	if (!iod)
@@ -674,10 +682,14 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 			goto finish_cmd;
 	}
 
-	blk_mq_start_request(req);
-
  submit_iod:
 	spin_lock_irq(&nvmeq->q_lock);
+	if (nvmeq->q_suspended) {
+		spin_unlock_irq(&nvmeq->q_lock);
+		goto finish_cmd;
+	}
+	if (do_prep)
+		blk_mq_start_request(req);
 	if (req->cmd_flags & REQ_DISCARD)
 		nvme_submit_discard(nvmeq, ns, req, iod);
 	else if (req->cmd_flags & REQ_FLUSH)
@@ -1135,6 +1147,11 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	int vector = nvmeq->dev->entry[nvmeq->cq_vector].vector;
 
 	spin_lock_irq(&nvmeq->q_lock);
+	if (nvmeq->q_suspended) {
+		spin_unlock_irq(&nvmeq->q_lock);
+		return 1;
+	}
+	nvmeq->q_suspended = 1;
 	nvmeq->dev->online_queues--;
 	spin_unlock_irq(&nvmeq->q_lock);
 
@@ -1202,6 +1219,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->q_depth = depth;
 	nvmeq->cq_vector = vector;
 	nvmeq->qid = qid;
+	nvmeq->q_suspended = 1;
 	dev->queue_count++;
 	dev->queues[qid] = nvmeq;
 
@@ -1236,6 +1254,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
+	nvmeq->q_suspended = 0;
 	dev->online_queues++;
 	spin_unlock_irq(&nvmeq->q_lock);
 }
@@ -1852,6 +1871,8 @@ static int nvme_kthread(void *data)
 				if (!nvmeq)
 					continue;
 				spin_lock_irq(&nvmeq->q_lock);
+				if (nvmeq->q_suspended)
+					goto unlock;
 				nvme_process_cq(nvmeq);
 
 				while ((i == 0) && (dev->event_limit > 0)) {
@@ -1859,6 +1880,7 @@ static int nvme_kthread(void *data)
 						break;
 					dev->event_limit--;
 				}
+ unlock:
 				spin_unlock_irq(&nvmeq->q_lock);
 			}
 		}
@@ -2037,8 +2059,10 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	dev->max_qid = nr_io_queues;
 
 	result = queue_request_irq(dev, adminq, adminq->irqname);
-	if (result)
+	if (result) {
+		adminq->q_suspended = 1;
 		goto free_queues;
+	}
 
 	/* Free previously allocated queues that are no longer usable */
 	nvme_free_queues(dev, nr_io_queues + 1);




-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: q_suspended.issue
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20141121/50853a39/attachment.ksh>
