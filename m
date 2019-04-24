From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 24 Apr 2019 19:02:13 +0800
Subject: [PATCH V7 1/9] blk-mq: grab .q_usage_counter when queuing request
 from plug code path
In-Reply-To: <20190424110221.17435-1-ming.lei@redhat.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
Message-ID: <20190424110221.17435-2-ming.lei@redhat.com>

Just like aio/io_uring, we need to grab 2 refcount for queuing one
request, one is for submission, another is for completion.

If the request isn't queued from plug code path, the refcount grabbed
in generic_make_request() serves for submission. In theroy, this
refcount should have been released after the sumission(async run queue)
is done. blk_freeze_queue() works with blk_sync_queue() together
for avoiding race between cleanup queue and IO submission, given async
run queue activities are canceled because hctx->run_work is scheduled with
the refcount held, so it is fine to not hold the refcount when
running the run queue work function for dispatch IO.

However, if request is staggered into plug list, and finally queued
from plug code path, the refcount in submission side is actually missed.
And we may start to run queue after queue is removed because the queue's
kobject refcount isn't guaranteed to be grabbed in flushing plug list
context, then kernel oops is triggered, see the following race:

blk_mq_flush_plug_list():
        blk_mq_sched_insert_requests()
                insert requests to sw queue or scheduler queue
                blk_mq_run_hw_queue

Because of concurrent run queue, all requests inserted above may be
completed before calling the above blk_mq_run_hw_queue. Then queue can
be freed during the above blk_mq_run_hw_queue().

Fixes the issue by grab .q_usage_counter before calling
blk_mq_sched_insert_requests() in blk_mq_flush_plug_list(). This way is
safe because the queue is absolutely alive before inserting request.

Cc: Dongli Zhang <dongli.zhang at oracle.com>
Cc: James Smart <james.smart at broadcom.com>
Cc: Bart Van Assche <bart.vanassche at wdc.com>
Cc: linux-scsi at vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen at oracle.com>,
Cc: Christoph Hellwig <hch at lst.de>,
Cc: James E . J . Bottomley <jejb at linux.vnet.ibm.com>,
Reviewed-by: Bart Van Assche <bvanassche at acm.org>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Tested-by: James Smart <james.smart at broadcom.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 block/blk-mq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fc60ed7e940e..9df43ef4b541 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1736,9 +1736,12 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx) {
 			if (this_hctx) {
 				trace_block_unplug(this_q, depth, !from_schedule);
+
+				percpu_ref_get(&this_q->q_usage_counter);
 				blk_mq_sched_insert_requests(this_hctx, this_ctx,
 								&rq_list,
 								from_schedule);
+				percpu_ref_put(&this_q->q_usage_counter);
 			}
 
 			this_q = rq->q;
@@ -1757,8 +1760,11 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	 */
 	if (this_hctx) {
 		trace_block_unplug(this_q, depth, !from_schedule);
+
+		percpu_ref_get(&this_q->q_usage_counter);
 		blk_mq_sched_insert_requests(this_hctx, this_ctx, &rq_list,
 						from_schedule);
+		percpu_ref_put(&this_q->q_usage_counter);
 	}
 }
 
-- 
2.9.5
