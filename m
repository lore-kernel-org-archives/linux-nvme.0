From: keith.busch@intel.com (Keith Busch)
Date: Tue, 24 Nov 2015 11:35:27 -0700
Subject: [PATCHv2 1/2] blk-mq: allow timer to freeze its own queue
Message-ID: <1448390128-25758-1-git-send-email-keith.busch@intel.com>

This patch removes synchronizing the timeout work so that the timer can
start a freeze on its own queue. The timer enters the queue, so timer
context can only start a freeze, but not wait for frozen.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5142219..2714c9c2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -85,7 +85,6 @@ void blk_mq_freeze_queue_start(struct request_queue *q)
 	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
 	if (freeze_depth == 1) {
 		percpu_ref_kill(&q->q_usage_counter);
-		cancel_work_sync(&q->timeout_work);
 		blk_mq_run_hw_queues(q, false);
 	}
 }
@@ -628,6 +627,9 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	};
 	int i;
 
+	if (blk_queue_enter(q, true))
+		return;
+
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &data);
 
 	if (data.next_set) {
@@ -642,6 +644,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 				blk_mq_tag_idle(hctx);
 		}
 	}
+	blk_queue_exit(q);
 }
 
 /*
-- 
2.6.2.307.g37023ba
