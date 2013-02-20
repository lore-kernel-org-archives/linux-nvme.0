From: keith.busch@intel.com (Keith Busch)
Date: Wed, 20 Feb 2013 16:52:38 -0700
Subject: [PATCH 1/8] NVMe: Queue bio requests on device
Message-ID: <1361404365-18982-1-git-send-email-keith.busch@intel.com>

A bio request is not tied to an NVMe IO submission queue, so bio requests
can be resubmitted on any available queue. Instead of adding bios on the
nvme_queue, this queues bios on the nvme_dev. This should help balance
the load across the submission queues.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |   57 +++++++++++++++++++++++--------------------------
 1 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 993c014..0a25765 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -80,6 +80,8 @@ struct nvme_dev {
 	char model[40];
 	char firmware_rev[8];
 	u32 max_hw_sectors;
+	struct bio_list bio_list;
+	spinlock_t dev_lock;
 };
 
 /*
@@ -109,8 +111,6 @@ struct nvme_queue {
 	dma_addr_t sq_dma_addr;
 	dma_addr_t cq_dma_addr;
 	wait_queue_head_t sq_full;
-	wait_queue_t sq_cong_wait;
-	struct bio_list sq_cong;
 	u32 __iomem *q_db;
 	u16 q_depth;
 	u16 cq_vector;
@@ -245,6 +245,8 @@ static void *free_cmdid(struct nvme_queue *nvmeq, int cmdid,
 	info[cmdid].ctx = CMD_CTX_COMPLETED;
 	clear_bit(cmdid, nvmeq->cmdid_data);
 	wake_up(&nvmeq->sq_full);
+	if (!bio_list_empty(&nvmeq->dev->bio_list))
+		wake_up_process(nvme_thread);
 	return ctx;
 }
 
@@ -363,11 +365,10 @@ static void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
 
 static void requeue_bio(struct nvme_dev *dev, struct bio *bio)
 {
-	struct nvme_queue *nvmeq = get_nvmeq(dev);
-	if (bio_list_empty(&nvmeq->sq_cong))
-		add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
-	bio_list_add(&nvmeq->sq_cong, bio);
-	put_nvmeq(nvmeq);
+	unsigned long flags;
+	spin_lock_irqsave(&dev->dev_lock, flags);
+	bio_list_add(&dev->bio_list, bio);
+	spin_unlock_irqrestore(&dev->dev_lock, flags);
 	wake_up_process(nvme_thread);
 }
 
@@ -624,19 +625,17 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 static void nvme_make_request(struct request_queue *q, struct bio *bio)
 {
 	struct nvme_ns *ns = q->queuedata;
-	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
-	int result = -EBUSY;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_queue *nvmeq = get_nvmeq(dev);
+	int result;
 
 	spin_lock_irq(&nvmeq->q_lock);
-	if (bio_list_empty(&nvmeq->sq_cong))
-		result = nvme_submit_bio_queue(nvmeq, ns, bio);
-	if (unlikely(result)) {
-		if (bio_list_empty(&nvmeq->sq_cong))
-			add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
-		bio_list_add(&nvmeq->sq_cong, bio);
-	}
-
+	result = nvme_submit_bio_queue(nvmeq, ns, bio);
 	spin_unlock_irq(&nvmeq->q_lock);
+
+	if (unlikely(result))
+		requeue_bio(dev, bio);
+
 	put_nvmeq(nvmeq);
 }
 
@@ -912,10 +911,6 @@ static void nvme_free_queue(struct nvme_dev *dev, int qid)
 
 	spin_lock_irq(&nvmeq->q_lock);
 	nvme_cancel_ios(nvmeq, false);
-	while (bio_list_peek(&nvmeq->sq_cong)) {
-		struct bio *bio = bio_list_pop(&nvmeq->sq_cong);
-		bio_endio(bio, -EIO);
-	}
 	spin_unlock_irq(&nvmeq->q_lock);
 
 	irq_set_affinity_hint(vector, NULL);
@@ -957,8 +952,6 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	init_waitqueue_head(&nvmeq->sq_full);
-	init_waitqueue_entry(&nvmeq->sq_cong_wait, nvme_thread);
-	bio_list_init(&nvmeq->sq_cong);
 	nvmeq->q_db = &dev->dbs[qid << (dev->db_stride + 1)];
 	nvmeq->q_depth = depth;
 	nvmeq->cq_vector = vector;
@@ -1279,17 +1272,19 @@ static const struct block_device_operations nvme_fops = {
 
 static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
 {
-	while (bio_list_peek(&nvmeq->sq_cong)) {
-		struct bio *bio = bio_list_pop(&nvmeq->sq_cong);
+	unsigned long flags;
+	struct bio_list *list = &nvmeq->dev->bio_list;
+
+	spin_lock_irqsave(&nvmeq->dev->dev_lock, flags);
+	while (bio_list_peek(list)) {
+		struct bio *bio = bio_list_pop(list);
 		struct nvme_ns *ns = bio->bi_bdev->bd_disk->private_data;
 		if (nvme_submit_bio_queue(nvmeq, ns, bio)) {
-			bio_list_add_head(&nvmeq->sq_cong, bio);
+			bio_list_add_head(list, bio);
 			break;
 		}
-		if (bio_list_empty(&nvmeq->sq_cong))
-			remove_wait_queue(&nvmeq->sq_full,
-							&nvmeq->sq_cong_wait);
 	}
+	spin_unlock_irqrestore(&nvmeq->dev->dev_lock, flags);
 }
 
 static int nvme_kthread(void *data)
@@ -1309,7 +1304,8 @@ static int nvme_kthread(void *data)
 				if (nvme_process_cq(nvmeq))
 					printk("process_cq did something\n");
 				nvme_cancel_ios(nvmeq, true);
-				nvme_resubmit_bios(nvmeq);
+				if (i)
+					nvme_resubmit_bios(nvmeq);
 				spin_unlock_irq(&nvmeq->q_lock);
 			}
 		}
@@ -1660,6 +1656,7 @@ static int __devinit nvme_probe(struct pci_dev *pdev,
 		goto disable;
 
 	INIT_LIST_HEAD(&dev->namespaces);
+	spin_lock_init(&dev->dev_lock);
 	dev->pci_dev = pdev;
 	pci_set_drvdata(pdev, dev);
 	dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
-- 
1.7.0.4
