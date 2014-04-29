From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Apr 2014 11:41:29 -0600
Subject: [PATCHv2 2/2] NVMe: Flush with data support
In-Reply-To: <1398793289-23150-1-git-send-email-keith.busch@intel.com>
References: <1398793289-23150-1-git-send-email-keith.busch@intel.com>
Message-ID: <1398793289-23150-2-git-send-email-keith.busch@intel.com>

It is possible a filesystem may send a flush flagged bio with write
data. There is no such composite NVMe command, so the driver sends flush
and write separately.

The device is allowed to execute these commands in any order, so it was
possible the driver ends the bio after the write completes, but while the
flush is still active. We don't want to let a filesystem believe flush
succeeded before it really has; this could cause data corruption on a
power loss between these events. To fix, this patch splits the flush
and write into chained bios.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v2:

Merge up and use the new bio_chain to track the split bios.

 drivers/block/nvme-core.c |   46 ++++++++++++++++++++++++---------------------
 include/linux/nvme.h      |    1 -
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 1d8b67d..478bbec 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -199,16 +199,13 @@ static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
 #define CMD_CTX_CANCELLED	(0x30C + CMD_CTX_BASE)
 #define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
 #define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
-#define CMD_CTX_FLUSH		(0x318 + CMD_CTX_BASE)
-#define CMD_CTX_ABORT		(0x31C + CMD_CTX_BASE)
+#define CMD_CTX_ABORT		(0x318 + CMD_CTX_BASE)
 
 static void special_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	if (ctx == CMD_CTX_CANCELLED)
 		return;
-	if (ctx == CMD_CTX_FLUSH)
-		return;
 	if (ctx == CMD_CTX_ABORT) {
 		++nvmeq->dev->abort_limit;
 		return;
@@ -627,16 +624,6 @@ static int nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	return 0;
 }
 
-int nvme_submit_flush_data(struct nvme_queue *nvmeq, struct nvme_ns *ns)
-{
-	int cmdid = alloc_cmdid(nvmeq, (void *)CMD_CTX_FLUSH,
-					special_completion, NVME_IO_TIMEOUT);
-	if (unlikely(cmdid < 0))
-		return cmdid;
-
-	return nvme_submit_flush(nvmeq, ns, cmdid);
-}
-
 static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod)
 {
 	struct bio *bio = iod->private;
@@ -652,7 +639,7 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod)
 
 	if (bio->bi_rw & REQ_DISCARD)
 		return nvme_submit_discard(nvmeq, ns, bio, iod, cmdid);
-	if ((bio->bi_rw & REQ_FLUSH) && !iod->nents)
+	if (bio->bi_rw & REQ_FLUSH)
 		return nvme_submit_flush(nvmeq, ns, cmdid);
 
 	control = 0;
@@ -686,6 +673,26 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod)
 	return 0;
 }
 
+static int nvme_split_flush_data(struct nvme_queue *nvmeq, struct bio *bio)
+{
+	struct bio *split = bio_clone(bio, GFP_ATOMIC);
+	if (!split)
+		return -ENOMEM;
+
+	split->bi_iter.bi_size = 0;
+	split->bi_phys_segments = 0;
+	bio->bi_rw &= ~REQ_FLUSH;
+	bio_chain(split, bio);
+
+	if (!waitqueue_active(&nvmeq->sq_full))
+		add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
+	bio_list_add(&nvmeq->sq_cong, split);
+	bio_list_add(&nvmeq->sq_cong, bio);
+	wake_up_process(nvme_thread);
+
+	return 0;
+}
+
 /*
  * Called with local interrupts disabled and the q_lock held.  May not sleep.
  */
@@ -696,11 +703,8 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	int psegs = bio_phys_segments(ns->queue, bio);
 	int result;
 
-	if ((bio->bi_rw & REQ_FLUSH) && psegs) {
-		result = nvme_submit_flush_data(nvmeq, ns);
-		if (result)
-			return result;
-	}
+	if ((bio->bi_rw & REQ_FLUSH) && psegs)
+		return nvme_split_flush_data(nvmeq, bio);
 
 	iod = nvme_alloc_iod(psegs, bio->bi_iter.bi_size, GFP_ATOMIC);
 	if (!iod)
@@ -1895,7 +1899,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	if (dev->max_hw_sectors)
 		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
-	if (dev->vwc & NVME_VWC_PRESENT)
+	if (dev->vwc & NVME_CTRL_VWC_PRESENT)
 		blk_queue_flush(ns->queue, REQ_FLUSH | REQ_FUA);
 
 	disk->major = nvme_major;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3eb8875..3b8f6b0 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -159,7 +159,6 @@ struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
 void nvme_unmap_user_pages(struct nvme_dev *dev, int write,
 			struct nvme_iod *iod);
 int nvme_submit_io_cmd(struct nvme_dev *, struct nvme_command *, u32 *);
-int nvme_submit_flush_data(struct nvme_queue *nvmeq, struct nvme_ns *ns);
 int nvme_submit_admin_cmd(struct nvme_dev *, struct nvme_command *,
 							u32 *result);
 int nvme_identify(struct nvme_dev *, unsigned nsid, unsigned cns,
-- 
1.7.10.4
