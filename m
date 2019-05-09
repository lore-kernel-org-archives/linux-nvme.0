From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu,  9 May 2019 20:42:22 +0200
Subject: [PATCH 5.0 65/95] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
Message-ID: <20190509181314.017487714@linuxfoundation.org>

[ Upstream commit 1b8f21b74c3c9c82fce5a751d7aefb7cc0b8d33d ]

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

Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Bart Van Assche <bvanassche at acm.org>
Cc: James Smart <james.smart at broadcom.com>
Cc: linux-nvme at lists.infradead.org
Reviewed-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
Signed-off-by: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 block/blk-mq.c         | 7 +++++++
 include/linux/blk-mq.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5a2585d69c817..6930c82ab75fc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -657,6 +657,13 @@ bool blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
+void blk_mq_complete_request_sync(struct request *rq)
+{
+	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+	rq->q->mq_ops->complete(rq);
+}
+EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
+
 int blk_mq_request_started(struct request *rq)
 {
 	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0e030f5f76b66..7e092bdac27f6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -306,6 +306,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 bool blk_mq_complete_request(struct request *rq);
+void blk_mq_complete_request_sync(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio);
 bool blk_mq_queue_stopped(struct request_queue *q);
-- 
2.20.1
