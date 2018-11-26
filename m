From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 26 Nov 2018 09:35:54 -0700
Subject: [PATCH 6/8] ataflop: implement mq_ops->commit_rqs() hook
In-Reply-To: <20181126163556.5181-1-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
Message-ID: <20181126163556.5181-7-axboe@kernel.dk>

We need this for blk-mq to kick things into gear, if we told it that
we had more IO coming, but then failed to deliver on that promise.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 drivers/block/ataflop.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index f88b4c26d422..475cb972f324 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1471,6 +1471,13 @@ static void setup_req_params( int drive )
 			ReqTrack, ReqSector, (unsigned long)ReqData ));
 }
 
+static void ataflop_commit_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	spin_lock_irq(&ataflop_lock);
+	finish_fdc();
+	spin_unlock_irq(&ataflop_lock);
+}
+
 static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 				     const struct blk_mq_queue_data *bd)
 {
@@ -1947,6 +1954,7 @@ static const struct block_device_operations floppy_fops = {
 
 static const struct blk_mq_ops ataflop_mq_ops = {
 	.queue_rq = ataflop_queue_rq,
+	.commit_rqs = ataflop_commit_rqs,
 };
 
 static struct kobject *floppy_find(dev_t dev, int *part, void *data)
-- 
2.17.1
