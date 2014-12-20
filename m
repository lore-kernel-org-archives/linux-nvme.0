From: keith.busch@intel.com (Keith Busch)
Date: Fri, 19 Dec 2014 17:54:14 -0700
Subject: [PATCH 2/4] blk-mq: Export freeze/unfreeze functions
In-Reply-To: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
Message-ID: <1419036856-16275-3-git-send-email-keith.busch@intel.com>

Let drivers prevent entering a queue that isn't available.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c         |    6 ++++--
 include/linux/blk-mq.h |    2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 68050ae..0b227fa 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -107,7 +107,7 @@ static void blk_mq_usage_counter_release(struct percpu_ref *ref)
 	wake_up_all(&q->mq_freeze_wq);
 }
 
-static void blk_mq_freeze_queue_start(struct request_queue *q)
+void blk_mq_freeze_queue_start(struct request_queue *q)
 {
 	bool freeze;
 
@@ -120,6 +120,7 @@ static void blk_mq_freeze_queue_start(struct request_queue *q)
 		blk_mq_run_queues(q, false);
 	}
 }
+EXPORT_SYMBOL(blk_mq_freeze_queue_start);
 
 static void blk_mq_freeze_queue_wait(struct request_queue *q)
 {
@@ -136,7 +137,7 @@ void blk_mq_freeze_queue(struct request_queue *q)
 	blk_mq_freeze_queue_wait(q);
 }
 
-static void blk_mq_unfreeze_queue(struct request_queue *q)
+void blk_mq_unfreeze_queue(struct request_queue *q)
 {
 	bool wake;
 
@@ -149,6 +150,7 @@ static void blk_mq_unfreeze_queue(struct request_queue *q)
 		wake_up_all(&q->mq_freeze_wq);
 	}
 }
+EXPORT_SYMBOL(blk_mq_unfreeze_queue);
 
 bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index fb0a4fb..87b22c2 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -195,6 +195,8 @@ void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_tag_busy_iter(struct blk_mq_hw_ctx *hctx, busy_iter_fn *fn,
 		void *priv);
+void blk_mq_unfreeze_queue(struct request_queue *q);
+void blk_mq_freeze_queue_start(struct request_queue *q);
 
 /*
  * Driver command data is immediately after the request. So subtract request
-- 
1.7.10.4
