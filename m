From: keith.busch@intel.com (Keith Busch)
Date: Fri,  8 Mar 2019 10:40:03 -0700
Subject: [PATCH 2/5] blk-mq: Export iterating queue requests
In-Reply-To: <20190308174006.5032-1-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
Message-ID: <20190308174006.5032-2-keith.busch@intel.com>

A driver may need to iterate a particular queue's tagged request rather
than the whole tagset.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq-tag.c     | 1 +
 block/blk-mq-tag.h     | 2 --
 include/linux/blk-mq.h | 2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a4931fc7be8a..a4ba91b332b0 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -407,6 +407,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 	}
 	blk_queue_exit(q);
 }
+EXPORT_SYMBOL(blk_mq_queue_tag_busy_iter);
 
 static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
 		    bool round_robin, int node)
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..5af7ff94b400 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -33,8 +33,6 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
-void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
-		void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b0c814bcc7e3..a64b3fdce0b0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -321,6 +321,8 @@ bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
+void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+		void *priv);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_freeze_queue_start(struct request_queue *q);
-- 
2.14.4
