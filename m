From: keith.busch@intel.com (Keith Busch)
Date: Tue, 18 Dec 2012 14:59:44 -0700
Subject: [PATCH] NVMe: disk io statistics
Message-ID: <1355867984-3307-1-git-send-email-keith.busch@intel.com>

Add io stats accounting for bio requests so nvme block devices show
useful disk stats.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 993c014..951ae99 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -118,6 +118,7 @@ struct nvme_queue {
 	u16 sq_tail;
 	u16 cq_head;
 	u16 cq_phase;
+	u16 qid;
 	unsigned long cmdid_data[];
 };
 
@@ -144,6 +145,7 @@ typedef void (*nvme_completion_fn)(struct nvme_dev *, void *,
 struct nvme_cmd_info {
 	nvme_completion_fn fn;
 	void *ctx;
+	unsigned long start_time;
 	unsigned long timeout;
 };
 
@@ -173,6 +175,7 @@ static int alloc_cmdid(struct nvme_queue *nvmeq, void *ctx,
 	int depth = nvmeq->q_depth - 1;
 	struct nvme_cmd_info *info = nvme_cmd_info(nvmeq);
 	int cmdid;
+	unsigned long start_time = jiffies;
 
 	do {
 		cmdid = find_first_zero_bit(nvmeq->cmdid_data, depth);
@@ -182,7 +185,8 @@ static int alloc_cmdid(struct nvme_queue *nvmeq, void *ctx,
 
 	info[cmdid].fn = handler;
 	info[cmdid].ctx = ctx;
-	info[cmdid].timeout = jiffies + timeout;
+	info[cmdid].start_time = start_time;
+	info[cmdid].timeout = start_time + timeout;
 	return cmdid;
 }
 
@@ -361,6 +365,30 @@ static void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
 	kfree(iod);
 }
 
+static void nvme_start_io_acct(struct bio *bio)
+{
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+	const int rw = bio_data_dir(bio);
+	int cpu = part_stat_lock();
+	part_round_stats(cpu, &disk->part0);
+	part_stat_inc(cpu, &disk->part0, ios[rw]);
+	part_stat_add(cpu, &disk->part0, sectors[rw], bio_sectors(bio));
+	part_inc_in_flight(&disk->part0, rw);
+	part_stat_unlock();
+}
+
+static void nvme_end_io_acct(struct bio *bio, unsigned long start_time)
+{
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+	int rw = bio_data_dir(bio);
+	unsigned long duration = jiffies - start_time;
+	int cpu = part_stat_lock();
+	part_stat_add(cpu, &disk->part0, ticks[rw], duration);
+	part_round_stats(cpu, &disk->part0);
+	part_dec_in_flight(&disk->part0, rw);
+	part_stat_unlock();
+}
+
 static void requeue_bio(struct nvme_dev *dev, struct bio *bio)
 {
 	struct nvme_queue *nvmeq = get_nvmeq(dev);
@@ -376,12 +404,15 @@ static void bio_completion(struct nvme_dev *dev, void *ctx,
 {
 	struct nvme_iod *iod = ctx;
 	struct bio *bio = iod->private;
+	struct nvme_queue *nvmeq = dev->queues[le16_to_cpup(&cqe->sq_id)];
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
 
 	if (iod->nents)
 		dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
 			bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	nvme_free_iod(dev, iod);
+
+	nvme_end_io_acct(bio, nvme_cmd_info(nvmeq)[cqe->command_id].start_time);
 	if (status) {
 		bio_endio(bio, -EIO);
 	} else if (bio->bi_vcnt > bio->bi_idx) {
@@ -607,6 +638,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 
 	bio->bi_sector += length >> 9;
 
+	nvme_start_io_acct(bio);
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
 	writel(nvmeq->sq_tail, nvmeq->q_db);
@@ -890,7 +922,10 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 
 		if (timeout && !time_after(now, info[cmdid].timeout))
 			continue;
-		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d\n", cmdid);
+		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d QID %d\n", cmdid,
+								nvmeq->qid);
+		cqe.command_id = cmdid;
+		cqe.sq_id = cpu_to_le16(nvmeq->qid);
 		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
 		fn(nvmeq->dev, ctx, &cqe);
 	}
@@ -962,6 +997,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->q_db = &dev->dbs[qid << (dev->db_stride + 1)];
 	nvmeq->q_depth = depth;
 	nvmeq->cq_vector = vector;
+	nvmeq->qid = qid;
 
 	return nvmeq;
 
-- 
This was requested by folks using iostat. They found it useful so maybe
others will find it useful too. I did't see this had an affect on
performance that I was able to measure.

The implementation requires the submission queue id and command id are
correctly set in the completion queue entry, otherwise the stats won't
come out correctly.

1.7.0.4
