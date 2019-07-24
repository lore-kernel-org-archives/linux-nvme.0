From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 24 Jul 2019 11:48:43 +0800
Subject: [PATCH V2 5/5] blk-mq: remove blk_mq_complete_request_sync
In-Reply-To: <20190724034843.10879-1-ming.lei@redhat.com>
References: <20190724034843.10879-1-ming.lei@redhat.com>
Message-ID: <20190724034843.10879-6-ming.lei@redhat.com>

blk_mq_tagset_wait_completed_request() has been applied for waiting
for completed request's fn, so not necessary to use
blk_mq_complete_request_sync() any more.

Cc: Max Gurtovoy <maxg at mellanox.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 block/blk-mq.c           | 7 -------
 drivers/nvme/host/core.c | 2 +-
 include/linux/blk-mq.h   | 1 -
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e1d0b4567388..9836a00d8c07 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -652,13 +652,6 @@ bool blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
-void blk_mq_complete_request_sync(struct request *rq)
-{
-	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
-	rq->q->mq_ops->complete(rq);
-}
-EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
-
 int blk_mq_request_started(struct request *rq)
 {
 	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e98490b98cbd..b3c1e063261e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -293,7 +293,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 		return true;
 
 	nvme_req(req)->status = NVME_SC_ABORT_REQ;
-	blk_mq_complete_request_sync(req);
+	blk_mq_complete_request(req);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f9f722aeb535..21cebe901ac0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -312,7 +312,6 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 bool blk_mq_complete_request(struct request *rq);
-void blk_mq_complete_request_sync(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio, unsigned int nr_segs);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.20.1
