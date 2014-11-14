From: axboe@fb.com (Jens Axboe)
Date: Fri, 14 Nov 2014 09:47:32 -0700
Subject: [PATCH] NVMe: add ->exit_hctx() hook
Message-ID: <20141114164732.GA12860@kernel.dk>

If we do teardown and setup of the queue and block related parts
of the driver, then we should clear nvmeq->hctx once we kill the
hardware queue.

Signed-off-by: Jens Axboe <axboe at fb.com>
---
 drivers/block/nvme-core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 77dd3bb9ecf5..f2964dfcea6c 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -171,6 +171,13 @@ static int nvme_admin_init_request(void *data, struct request *req,
 	return 0;
 }
 
+static void nvme_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+{
+	struct nvme_queue *nvmeq = hctx->driver_data;
+
+	nvmeq->hctx = NULL;
+}
+
 static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 			  unsigned int hctx_idx)
 {
@@ -1335,6 +1342,7 @@ static struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_admin_queue_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_admin_init_hctx,
+	.exit_hctx	= nvme_exit_hctx,
 	.init_request	= nvme_admin_init_request,
 	.timeout	= nvme_timeout,
 };
@@ -1343,6 +1351,7 @@ static struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_init_hctx,
+	.exit_hctx	= nvme_exit_hctx,
 	.init_request	= nvme_init_request,
 	.timeout	= nvme_timeout,
 };
-- 
1.9.1

-- 
Jens Axboe
