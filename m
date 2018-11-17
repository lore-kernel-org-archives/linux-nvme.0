From: axboe@kernel.dk (Jens Axboe)
Date: Sat, 17 Nov 2018 14:43:52 -0700
Subject: [PATCH 5/7] blk-mq: remove 'tag' parameter from mq_ops->poll()
In-Reply-To: <20181117214354.822-1-axboe@kernel.dk>
References: <20181117214354.822-1-axboe@kernel.dk>
Message-ID: <20181117214354.822-6-axboe@kernel.dk>

We always pass in -1 now and none of the callers use the tag value,
remove the parameter.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 block/blk-mq.c           | 2 +-
 drivers/nvme/host/pci.c  | 8 ++++----
 drivers/nvme/host/rdma.c | 2 +-
 include/linux/blk-mq.h   | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ca00d712158..10a14baa04ff 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3341,7 +3341,7 @@ static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx)
 
 		hctx->poll_invoked++;
 
-		ret = q->mq_ops->poll(hctx, -1U);
+		ret = q->mq_ops->poll(hctx);
 		if (ret > 0) {
 			hctx->poll_success++;
 			__set_current_state(TASK_RUNNING);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1742c8ab8196..1280cc327096 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1075,14 +1075,14 @@ static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 	return found;
 }
 
-static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
+static int nvme_poll(struct blk_mq_hw_ctx *hctx)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
 
-	return __nvme_poll(nvmeq, tag);
+	return __nvme_poll(nvmeq, -1);
 }
 
-static int nvme_poll_noirq(struct blk_mq_hw_ctx *hctx, unsigned int tag)
+static int nvme_poll_noirq(struct blk_mq_hw_ctx *hctx)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
 	u16 start, end;
@@ -1092,7 +1092,7 @@ static int nvme_poll_noirq(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 		return 0;
 
 	spin_lock(&nvmeq->cq_lock);
-	found = nvme_process_cq(nvmeq, &start, &end, tag);
+	found = nvme_process_cq(nvmeq, &start, &end, -1);
 	spin_unlock(&nvmeq->cq_lock);
 
 	nvme_complete_cqes(nvmeq, start, end);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 53e44efc6d32..4b2ba563acdb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1741,7 +1741,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_IOERR;
 }
 
-static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
+static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
 {
 	struct nvme_rdma_queue *queue = hctx->driver_data;
 	struct ib_cq *cq = queue->ib_cq;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 929e8abc5535..ca0520ca6437 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -132,7 +132,7 @@ typedef void (exit_request_fn)(struct blk_mq_tag_set *set, struct request *,
 typedef bool (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
 		bool);
 typedef bool (busy_tag_iter_fn)(struct request *, void *, bool);
-typedef int (poll_fn)(struct blk_mq_hw_ctx *, unsigned int);
+typedef int (poll_fn)(struct blk_mq_hw_ctx *);
 typedef int (map_queues_fn)(struct blk_mq_tag_set *set);
 typedef bool (busy_fn)(struct request_queue *);
 typedef void (complete_fn)(struct request *);
-- 
2.17.1
