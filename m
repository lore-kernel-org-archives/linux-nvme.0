From: keith.busch@intel.com (Keith Busch)
Date: Wed, 29 May 2013 15:59:39 -0600
Subject: [PATCH v2] NVMe: Disk IO statistics
Message-ID: <1369864779-28190-1-git-send-email-keith.busch@intel.com>

Add io stats accounting for bio requests so nvme block devices show
useful disk stats.

Signed-off-by: Keith Busch <keith.busch at intel.com>

---
v1->v2: moved the start time into the iod.

 drivers/block/nvme-core.c |   27 +++++++++++++++++++++++++++
 include/linux/nvme.h      |    1 +
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 42abf72..bef6521 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -285,6 +285,7 @@ nvme_alloc_iod(unsigned nseg, unsigned nbytes, gfp_t gfp)
 		iod->npages = -1;
 		iod->length = nbytes;
 		iod->nents = 0;
+		iod->start_time = jiffies;
 	}
 
 	return iod;
@@ -307,6 +308,29 @@ void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
 	}
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
+	const int rw = bio_data_dir(bio);
+	unsigned long duration = jiffies - start_time;
+	int cpu = part_stat_lock();
+	part_stat_add(cpu, &disk->part0, ticks[rw], duration);
+	part_round_stats(cpu, &disk->part0);
+	part_dec_in_flight(&disk->part0, rw);
+	part_stat_unlock();
+}
 
 static void bio_completion(struct nvme_dev *dev, void *ctx,
 						struct nvme_completion *cqe)
@@ -318,6 +342,8 @@ static void bio_completion(struct nvme_dev *dev, void *ctx,
 	if (iod->nents)
 		dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
 			bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+	nvme_end_io_acct(bio, iod->start_time);
 	nvme_free_iod(dev, iod);
 	if (status)
 		bio_endio(bio, -EIO);
@@ -695,6 +721,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
 
+	nvme_start_io_acct(bio);
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
 	writel(nvmeq->sq_tail, nvmeq->q_db);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index f451c8d..5d7c079 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -572,6 +572,7 @@ struct nvme_iod {
 	int offset;		/* Of PRP list */
 	int nents;		/* Used in scatterlist */
 	int length;		/* Of data, in bytes */
+	unsigned long start_time;
 	dma_addr_t first_dma;
 	struct scatterlist sg[0];
 };
-- 
1.7.0.4
