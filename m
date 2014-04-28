From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Apr 2014 12:30:52 -0600
Subject: [PATCH] NVMe: Add tracepoints
Message-ID: <1398709852-19104-1-git-send-email-keith.busch@intel.com>

Adding tracepoints for bio_complete and block_split into nvme to help
with gathering IO info using blktrace and blkparse.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-core.c          |    1 +
 drivers/block/nvme-core.c |   14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 853f927..d635261 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -43,6 +43,7 @@
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_complete);
+EXPORT_TRACEPOINT_SYMBOL_GPL(block_split);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_unplug);
 
 DEFINE_IDA(blk_queue_ida);
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index efa9c8f..57ad2c6 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -46,6 +46,8 @@
 #include <scsi/sg.h>
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
 
+#include <trace/events/block.h>
+
 #define NVME_Q_DEPTH 1024
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
@@ -413,7 +415,9 @@ static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
 {
 	struct nvme_iod *iod = ctx;
 	struct bio *bio = iod->private;
+	struct nvme_ns *ns = bio->bi_bdev->bd_disk->private_data;
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
+	int error = 0;
 
 	if (unlikely(status)) {
 		if (!(status & NVME_SC_DNR ||
@@ -426,6 +430,7 @@ static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
 			wake_up(&nvmeq->sq_full);
 			return;
 		}
+		error = -EIO;
 	}
 	if (iod->nents) {
 		dma_unmap_sg(nvmeq->q_dmadev, iod->sg, iod->nents,
@@ -433,10 +438,9 @@ static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
 		nvme_end_io_acct(bio, iod->start_time);
 	}
 	nvme_free_iod(nvmeq->dev, iod);
-	if (status)
-		bio_endio(bio, -EIO);
-	else
-		bio_endio(bio, 0);
+
+	trace_block_bio_complete(ns->queue , bio, error);
+	bio_endio(bio, error);
 }
 
 /* length is in bytes.  gfp flags indicates whether we may sleep. */
@@ -522,9 +526,11 @@ static int nvme_split_and_submit(struct bio *bio, struct nvme_queue *nvmeq,
 				 int len)
 {
 	struct bio *split = bio_split(bio, len >> 9, GFP_ATOMIC, NULL);
+	struct nvme_ns *ns = bio->bi_bdev->bd_disk->private_data;
 	if (!split)
 		return -ENOMEM;
 
+	trace_block_split(ns->queue, bio, split->bi_iter.bi_sector);
 	bio_chain(split, bio);
 
 	if (!waitqueue_active(&nvmeq->sq_full))
-- 
1.7.10.4
