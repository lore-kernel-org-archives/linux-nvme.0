From: ming.lei@redhat.com (Ming Lei)
Date: Mon,  8 Apr 2019 17:40:46 +0800
Subject: [PATCH V3 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <20190408094047.29150-1-ming.lei@redhat.com>
References: <20190408094047.29150-1-ming.lei@redhat.com>
Message-ID: <20190408094047.29150-2-ming.lei@redhat.com>

In NVMe's error handler, follows the typical steps of tearing down
hardware for recovering controller:

1) stop blk_mq hw queues
2) stop the real hw queues
3) cancel in-flight requests via
	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
cancel_request():
	mark the request as abort
	blk_mq_complete_request(req);
4) destroy real hw queues

However, there may be race between #3 and #4, because blk_mq_complete_request()
may run q->mq_ops->complete(rq) remotelly and asynchronously, and
->complete(rq) may be run after #4.

This patch introduces blk_mq_complete_request_sync() for fixing the
above race.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Bart Van Assche <bvanassche at acm.org>
Cc: James Smart <james.smart at broadcom.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: linux-nvme at lists.infradead.org
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 block/blk-mq.c         | 11 +++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9354835cf51..d8d89f3514ac 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -654,6 +654,17 @@ bool blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
+bool blk_mq_complete_request_sync(struct request *rq)
+{
+	if (unlikely(blk_should_fake_timeout(rq->q)))
+		return false;
+
+	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+	rq->q->mq_ops->complete(rq);
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
+
 int blk_mq_request_started(struct request *rq)
 {
 	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index cb2aa7ecafff..1412c983e7b8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -302,6 +302,7 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 bool blk_mq_complete_request(struct request *rq);
+bool blk_mq_complete_request_sync(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.9.5
