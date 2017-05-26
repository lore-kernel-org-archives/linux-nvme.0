From: ming.lei@redhat.com (Ming Lei)
Date: Fri, 26 May 2017 11:07:37 +0800
Subject: [PATCH 4/6] blk-mq: update comments on blk_mq_quiesce_queue()
In-Reply-To: <20170526030740.26959-1-ming.lei@redhat.com>
References: <20170526030740.26959-1-ming.lei@redhat.com>
Message-ID: <20170526030740.26959-5-ming.lei@redhat.com>

Actually what we want to get from blk_mq_quiesce_queue()
isn't only to wait for completion of all ongooing .queue_rq().

In the typical context of canceling requests, we need to
make sure that the following is done in the dispatch path
before starting to cancel requests:
	- failed dispatched request is freeed
	- busy dispatched request is requeued, and the STARTED
	flag is cleared

Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 864709453c90..e1fc9ab50c87 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -155,12 +155,12 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
 /**
- * blk_mq_quiesce_queue() - wait until all ongoing queue_rq calls have finished
+ * blk_mq_quiesce_queue() - wait until all ongoing dispatching have finished
  * @q: request queue.
  *
  * Note: this function does not prevent that the struct request end_io()
- * callback function is invoked. Additionally, it is not prevented that
- * new queue_rq() calls occur unless the queue has been stopped first.
+ * callback function is invoked. Once this function is returned, we make
+ * sure no dispatching can happen.
  */
 void blk_mq_quiesce_queue(struct request_queue *q)
 {
-- 
2.9.4
