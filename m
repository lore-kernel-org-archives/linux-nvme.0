From: keith.busch@intel.com (Keith Busch)
Date: Thu, 23 Feb 2017 19:36:00 -0500
Subject: [PATCHv2 1/2] blk-mq: Export blk_mq_freeze_queue_wait
Message-ID: <1487896561-10454-1-git-send-email-keith.busch@intel.com>

Drivers can start a freeze, so this provides a way to wait for frozen.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c         | 3 ++-
 include/linux/blk-mq.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9e6b064..d5b9a15 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -75,10 +75,11 @@ void blk_mq_freeze_queue_start(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_start);
 
-static void blk_mq_freeze_queue_wait(struct request_queue *q)
+void blk_mq_freeze_queue_wait(struct request_queue *q)
 {
 	wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter));
 }
+EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait);
 
 /*
  * Guarantee no request is in use, so we can change any data structure of
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 001d30d..8dacf68 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -245,6 +245,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_mq_freeze_queue_start(struct request_queue *q);
+void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_reinit_tagset(struct blk_mq_tag_set *set);
 
 int blk_mq_map_queues(struct blk_mq_tag_set *set);
-- 
2.5.5
