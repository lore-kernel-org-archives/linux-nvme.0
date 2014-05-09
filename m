From: sbradshaw@micron.com (Sam Bradshaw)
Date: Fri, 9 May 2014 13:10:26 -0700
Subject: [PATCH] NVMe: Adhere to request queue block accounting enable/disable
Message-ID: <536D3632.3020009@micron.com>


Recently, a new sysfs control "iostats" was added to selectively 
enable or disable io statistics collection for request queues.  This 
patch hooks that control.  

IO statistics collection is rather expensive on large, multi-node 
machines with drives pushing millions of iops.  Having the ability to 
disable collection if not needed can improve throughput significantly.

As a data point, on a quad E5-4640, I see more than 50% throughput
improvement when io statistics accounting is disabled during heavily 
multi-threaded small block random read benchmarks where device 
performance is in the million iops+ range.

Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
---
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 3a25502..cd8a8bc 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -383,30 +383,25 @@ void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
 static void nvme_start_io_acct(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
-	if (blk_queue_io_stat(disk->queue)) {
-		const int rw = bio_data_dir(bio);
-		int cpu = part_stat_lock();
-		part_round_stats(cpu, &disk->part0);
-		part_stat_inc(cpu, &disk->part0, ios[rw]);
-		part_stat_add(cpu, &disk->part0, sectors[rw],
-							bio_sectors(bio));
-		part_inc_in_flight(&disk->part0, rw);
-		part_stat_unlock();
-	}
+	const int rw = bio_data_dir(bio);
+	int cpu = part_stat_lock();
+	part_round_stats(cpu, &disk->part0);
+	part_stat_inc(cpu, &disk->part0, ios[rw]);
+	part_stat_add(cpu, &disk->part0, sectors[rw], bio_sectors(bio));
+	part_inc_in_flight(&disk->part0, rw);
+	part_stat_unlock();
 }
 
 static void nvme_end_io_acct(struct bio *bio, unsigned long start_time)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
-	if (blk_queue_io_stat(disk->queue)) {
-		const int rw = bio_data_dir(bio);
-		unsigned long duration = jiffies - start_time;
-		int cpu = part_stat_lock();
-		part_stat_add(cpu, &disk->part0, ticks[rw], duration);
-		part_round_stats(cpu, &disk->part0);
-		part_dec_in_flight(&disk->part0, rw);
-		part_stat_unlock();
-	}
+	const int rw = bio_data_dir(bio);
+	unsigned long duration = jiffies - start_time;
+	int cpu = part_stat_lock();
+	part_stat_add(cpu, &disk->part0, ticks[rw], duration);
+	part_round_stats(cpu, &disk->part0);
+	part_dec_in_flight(&disk->part0, rw);
+	part_stat_unlock();
 }
 
 static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
