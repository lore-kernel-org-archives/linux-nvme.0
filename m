From: keith.busch@intel.com (Keith Busch)
Date: Fri, 30 Nov 2018 13:26:34 -0700
Subject: [PATCH 1/2] blk-mq: Export iterating all tagged requests
Message-ID: <20181130202635.11145-1-keith.busch@intel.com>

A driver may wish to iterate every tagged request, not just ones that
satisfy blk_mq_request_started(). The intended use is so a driver may
terminate entered requests on quiesced queues.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq-tag.c     | 41 +++++++++++++++++++++++++++++++++++------
 block/blk-mq-tag.h     |  2 --
 include/linux/blk-mq.h |  4 ++++
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 87bc5df72d48..c5fd2e0a4074 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -272,6 +272,7 @@ struct bt_tags_iter_data {
 	busy_tag_iter_fn *fn;
 	void *data;
 	bool reserved;
+	bool all;
 };
 
 static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
@@ -289,7 +290,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * test and set the bit before assining ->rqs[].
 	 */
 	rq = tags->rqs[bitnr];
-	if (rq && blk_mq_request_started(rq))
+	if (rq && (iter_data->all || blk_mq_request_started(rq)))
 		return iter_data->fn(rq, iter_data->data, reserved);
 
 	return true;
@@ -309,13 +310,15 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		bitmap_tags member of struct blk_mq_tags.
  */
 static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
-			     busy_tag_iter_fn *fn, void *data, bool reserved)
+			     busy_tag_iter_fn *fn, void *data, bool reserved,
+			     bool all)
 {
 	struct bt_tags_iter_data iter_data = {
 		.tags = tags,
 		.fn = fn,
 		.data = data,
 		.reserved = reserved,
+		.all = all,
 	};
 
 	if (tags->rqs)
@@ -333,11 +336,12 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
  * @priv:	Will be passed as second argument to @fn.
  */
 static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
-		busy_tag_iter_fn *fn, void *priv)
+		busy_tag_iter_fn *fn, void *priv, bool all)
 {
 	if (tags->nr_reserved_tags)
-		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
-	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
+		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true,
+				 all);
+	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false, all);
 }
 
 /**
@@ -357,11 +361,35 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 
 	for (i = 0; i < tagset->nr_hw_queues; i++) {
 		if (tagset->tags && tagset->tags[i])
-			blk_mq_all_tag_busy_iter(tagset->tags[i], fn, priv);
+			blk_mq_all_tag_busy_iter(tagset->tags[i], fn, priv,
+						 false);
 	}
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
+/**
+ * blk_mq_tagset_all_iter - iterate over all requests in a tag set
+ * @tagset:	Tag set to iterate over.
+ * @fn:		Pointer to the function that will be called for each started
+ *		request. @fn will be called as follows: @fn(rq, @priv,
+ *		reserved) where rq is a pointer to a request. 'reserved'
+ *		indicates whether or not @rq is a reserved request. Return
+ *		true to continue iterating tags, false to stop.
+ * @priv:	Will be passed as second argument to @fn.
+ */
+void blk_mq_tagset_all_iter(struct blk_mq_tag_set *tagset,
+		busy_tag_iter_fn *fn, void *priv)
+{
+	int i;
+
+	for (i = 0; i < tagset->nr_hw_queues; i++) {
+		if (tagset->tags && tagset->tags[i])
+			blk_mq_all_tag_busy_iter(tagset->tags[i], fn, priv,
+						 true);
+	}
+}
+EXPORT_SYMBOL(blk_mq_tagset_all_iter);
+
 /**
  * blk_mq_queue_tag_busy_iter - iterate over all requests with a driver tag
  * @q:		Request queue to examine.
@@ -408,6 +436,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
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
index 57eda7b20243..246aa128fd1f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -322,6 +322,10 @@ bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
+void blk_mq_tagset_all_iter(struct blk_mq_tag_set *tagset,
+		busy_tag_iter_fn *fn, void *priv);
+void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+		void *priv);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_freeze_queue_start(struct request_queue *q);
-- 
2.14.4
