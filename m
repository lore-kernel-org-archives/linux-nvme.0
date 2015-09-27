From: hch@lst.de (Christoph Hellwig)
Date: Sun, 27 Sep 2015 21:01:51 +0200
Subject: [PATCH 03/10] blk-mq: factor out a helper to iterate all tags for a
 request_queue
In-Reply-To: <1443380518-6829-1-git-send-email-hch@lst.de>
References: <1443380518-6829-1-git-send-email-hch@lst.de>
Message-ID: <1443380518-6829-4-git-send-email-hch@lst.de>

And replace the blk_mq_tag_busy_iter with it - the driver use has been
replaced with a new helper a while ago, and internal to the block we
only need the new version.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-mq-tag.c     | 27 ++++++++++++++++++++-------
 block/blk-mq-tag.h     |  2 ++
 block/blk-mq.c         | 14 +++-----------
 include/linux/blk-mq.h |  2 --
 4 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9115c6d..ed96474 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -471,17 +471,30 @@ void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 }
 EXPORT_SYMBOL(blk_mq_all_tag_busy_iter);
 
-void blk_mq_tag_busy_iter(struct blk_mq_hw_ctx *hctx, busy_iter_fn *fn,
+void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv)
 {
-	struct blk_mq_tags *tags = hctx->tags;
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		struct blk_mq_tags *tags = hctx->tags;
+
+		/*
+		 * If not software queues are currently mapped to this
+		 * hardware queue, there's nothing to check
+		 */
+		if (!blk_mq_hw_queue_mapped(hctx))
+			continue;
+
+		if (tags->nr_reserved_tags)
+			bt_for_each(hctx, &tags->breserved_tags, 0, fn, priv, true);
+		bt_for_each(hctx, &tags->bitmap_tags, tags->nr_reserved_tags, fn, priv,
+		      false);
+	}
 
-	if (tags->nr_reserved_tags)
-		bt_for_each(hctx, &tags->breserved_tags, 0, fn, priv, true);
-	bt_for_each(hctx, &tags->bitmap_tags, tags->nr_reserved_tags, fn, priv,
-			false);
 }
-EXPORT_SYMBOL(blk_mq_tag_busy_iter);
 
 static unsigned int bt_unused_tags(struct blk_mq_bitmap_tags *bt)
 {
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 9eb2cf4..d468a79 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -58,6 +58,8 @@ extern ssize_t blk_mq_tag_sysfs_show(struct blk_mq_tags *tags, char *page);
 extern void blk_mq_tag_init_last_tag(struct blk_mq_tags *tags, unsigned int *last_tag);
 extern int blk_mq_tag_update_depth(struct blk_mq_tags *tags, unsigned int depth);
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
+void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+		void *priv);
 
 enum {
 	BLK_MQ_TAG_CACHE_MIN	= 1,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 698b735..732f15c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -641,24 +641,16 @@ static void blk_mq_rq_timer(unsigned long priv)
 		.next		= 0,
 		.next_set	= 0,
 	};
-	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		/*
-		 * If not software queues are currently mapped to this
-		 * hardware queue, there's nothing to check
-		 */
-		if (!blk_mq_hw_queue_mapped(hctx))
-			continue;
-
-		blk_mq_tag_busy_iter(hctx, blk_mq_check_expired, &data);
-	}
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &data);
 
 	if (data.next_set) {
 		data.next = blk_rq_timeout(round_jiffies_up(data.next));
 		mod_timer(&q->timeout, data.next);
 	} else {
+		struct blk_mq_hw_ctx *hctx;
+
 		queue_for_each_hw_ctx(q, hctx, i) {
 			/* the hctx may be unmapped, so check it here */
 			if (blk_mq_hw_queue_mapped(hctx))
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4b4577a..15bb31d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -224,8 +224,6 @@ void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
-void blk_mq_tag_busy_iter(struct blk_mq_hw_ctx *hctx, busy_iter_fn *fn,
-		void *priv);
 void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv);
 void blk_mq_freeze_queue(struct request_queue *q);
-- 
1.9.1
