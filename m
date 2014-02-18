From: keith.busch@intel.com (Keith Busch)
Date: Tue, 18 Feb 2014 13:29:12 -0700
Subject: [PATCH 2/2] NVMe: Support for flush with data
In-Reply-To: <1392755352-19445-1-git-send-email-keith.busch@intel.com>
References: <1392755352-19445-1-git-send-email-keith.busch@intel.com>
Message-ID: <1392755352-19445-2-git-send-email-keith.busch@intel.com>

It is possible a filesystem may send a flush command with write
data. There is no such composite NVMe command, so the driver needs to
send the flush and write separately. The device is allowed to execute
these commands in any order, so it was possible the driver ends the
bio after the write completion, but while the flush command is still
active. We don't want to let the filesystem think the flush completed
before it really has to prevent a data corruption on a power loss between
these events, so this splits the flush and write in two child bios and
completes the original only once both commands have completed.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
The gfs2 filesystem provides a simple way to generate a flush with write
to test this:

\# mkfs.gfs2 -p lock_nolock /dev/nvme0n1
\# mount /dev/nvme0n1 /mnt
\# touch /mnt/foobar
\# sync

The above will create a flush with write data bio via log_write_header.

 drivers/block/nvme-core.c |   35 +++++++++++++++++++----------------
 include/linux/nvme.h      |    1 -
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index f8d6a9e..1656b00 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -187,16 +187,13 @@ static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
 #define CMD_CTX_CANCELLED	(0x30C + CMD_CTX_BASE)
 #define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
 #define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
-#define CMD_CTX_FLUSH		(0x318 + CMD_CTX_BASE)
-#define CMD_CTX_ABORT		(0x31C + CMD_CTX_BASE)
+#define CMD_CTX_ABORT		(0x318 + CMD_CTX_BASE)
 
 static void special_completion(struct nvme_dev *dev, void *ctx,
 						struct nvme_completion *cqe)
 {
 	if (ctx == CMD_CTX_CANCELLED)
 		return;
-	if (ctx == CMD_CTX_FLUSH)
-		return;
 	if (ctx == CMD_CTX_ABORT) {
 		++dev->abort_limit;
 		return;
@@ -673,14 +670,23 @@ static int nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	return 0;
 }
 
-int nvme_submit_flush_data(struct nvme_queue *nvmeq, struct nvme_ns *ns)
+static int nvme_split_flush_data(struct nvme_queue *nvmeq, struct bio *bio)
 {
-	int cmdid = alloc_cmdid(nvmeq, (void *)CMD_CTX_FLUSH,
-					special_completion, NVME_IO_TIMEOUT);
-	if (unlikely(cmdid < 0))
-		return cmdid;
+	struct nvme_bio_pair *bp = nvme_bio_split(bio, 0, 0, 0);
+
+	if (!bp)
+		return -ENOMEM;
 
-	return nvme_submit_flush(nvmeq, ns, cmdid);
+	bp->b1.bi_phys_segments = 0;
+	bp->b2.bi_rw &= ~REQ_FLUSH;
+
+	if (bio_list_empty(&nvmeq->sq_cong))
+		add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
+	bio_list_add(&nvmeq->sq_cong, &bp->b1);
+	bio_list_add(&nvmeq->sq_cong, &bp->b2);
+	wake_up_process(nvme_thread);
+
+	return 0;
 }
 
 /*
@@ -697,11 +703,8 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	u32 dsmgmt;
 	int psegs = bio_phys_segments(ns->queue, bio);
 
-	if ((bio->bi_rw & REQ_FLUSH) && psegs) {
-		result = nvme_submit_flush_data(nvmeq, ns);
-		if (result)
-			return result;
-	}
+	if ((bio->bi_rw & REQ_FLUSH) && psegs)
+		return nvme_split_flush_data(nvmeq, bio);
 
 	result = -ENOMEM;
 	iod = nvme_alloc_iod(psegs, bio->bi_size, GFP_ATOMIC);
@@ -720,7 +723,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 			goto free_cmdid;
 		return result;
 	}
-	if ((bio->bi_rw & REQ_FLUSH) && !psegs)
+	if (bio->bi_rw & REQ_FLUSH)
 		return nvme_submit_flush(nvmeq, ns, cmdid);
 
 	control = 0;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 69ae03f..5d909dc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -155,7 +155,6 @@ struct nvme_queue *get_nvmeq(struct nvme_dev *dev);
 void put_nvmeq(struct nvme_queue *nvmeq);
 int nvme_submit_sync_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 						u32 *result, unsigned timeout);
-int nvme_submit_flush_data(struct nvme_queue *nvmeq, struct nvme_ns *ns);
 int nvme_submit_admin_cmd(struct nvme_dev *, struct nvme_command *,
 							u32 *result);
 int nvme_identify(struct nvme_dev *, unsigned nsid, unsigned cns,
-- 
1.7.10.4
