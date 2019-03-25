From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Mon, 25 Mar 2019 13:28:09 +0800
Subject: [PATCH V2 8/8] blk-mq: remove blk_mq_tagset_busy_iter
In-Reply-To: <1553491689-1730-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1553491689-1730-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1553491689-1730-9-git-send-email-jianchao.w.wang@oracle.com>

As nobody uses blk_mq_tagset_busy_iter, remove it.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 block/blk-mq-tag.c     | 95 --------------------------------------------------
 include/linux/blk-mq.h |  2 --
 2 files changed, 97 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index bf7b235..a6a28dd 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -279,101 +279,6 @@ static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
 	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
 }
 
-struct bt_tags_iter_data {
-	struct blk_mq_tags *tags;
-	busy_tag_iter_fn *fn;
-	void *data;
-	bool reserved;
-};
-
-static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
-{
-	struct bt_tags_iter_data *iter_data = data;
-	struct blk_mq_tags *tags = iter_data->tags;
-	bool reserved = iter_data->reserved;
-	struct request *rq;
-
-	if (!reserved)
-		bitnr += tags->nr_reserved_tags;
-
-	/*
-	 * We can hit rq == NULL here, because the tagging functions
-	 * test and set the bit before assining ->rqs[].
-	 */
-	rq = tags->rqs[bitnr];
-	if (rq && blk_mq_request_started(rq))
-		return iter_data->fn(rq, iter_data->data, reserved);
-
-	return true;
-}
-
-/**
- * bt_tags_for_each - iterate over the requests in a tag map
- * @tags:	Tag map to iterate over.
- * @bt:		sbitmap to examine. This is either the breserved_tags member
- *		or the bitmap_tags member of struct blk_mq_tags.
- * @fn:		Pointer to the function that will be called for each started
- *		request. @fn will be called as follows: @fn(rq, @data,
- *		@reserved) where rq is a pointer to a request. Return true
- *		to continue iterating tags, false to stop.
- * @data:	Will be passed as second argument to @fn.
- * @reserved:	Indicates whether @bt is the breserved_tags member or the
- *		bitmap_tags member of struct blk_mq_tags.
- */
-static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
-			     busy_tag_iter_fn *fn, void *data, bool reserved)
-{
-	struct bt_tags_iter_data iter_data = {
-		.tags = tags,
-		.fn = fn,
-		.data = data,
-		.reserved = reserved,
-	};
-
-	if (tags->rqs)
-		sbitmap_for_each_set(&bt->sb, bt_tags_iter, &iter_data);
-}
-
-/**
- * blk_mq_all_tag_busy_iter - iterate over all started requests in a tag map
- * @tags:	Tag map to iterate over.
- * @fn:		Pointer to the function that will be called for each started
- *		request. @fn will be called as follows: @fn(rq, @priv,
- *		reserved) where rq is a pointer to a request. 'reserved'
- *		indicates whether or not @rq is a reserved request. Return
- *		true to continue iterating tags, false to stop.
- * @priv:	Will be passed as second argument to @fn.
- */
-static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
-		busy_tag_iter_fn *fn, void *priv)
-{
-	if (tags->nr_reserved_tags)
-		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
-	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
-}
-
-/**
- * blk_mq_tagset_busy_iter - iterate over all started requests in a tag set
- * @tagset:	Tag set to iterate over.
- * @fn:		Pointer to the function that will be called for each started
- *		request. @fn will be called as follows: @fn(rq, @priv,
- *		reserved) where rq is a pointer to a request. 'reserved'
- *		indicates whether or not @rq is a reserved request. Return
- *		true to continue iterating tags, false to stop.
- * @priv:	Will be passed as second argument to @fn.
- */
-void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
-		busy_tag_iter_fn *fn, void *priv)
-{
-	int i;
-
-	for (i = 0; i < tagset->nr_hw_queues; i++) {
-		if (tagset->tags && tagset->tags[i])
-			blk_mq_all_tag_busy_iter(tagset->tags[i], fn, priv);
-	}
-}
-EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
-
 /**
  * __blk_mq_queue_tag_busy_iter - iterate over all busy or inflight tags
  * @q:		Request queue to examine.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index dff9bb6..3ba8001 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -318,8 +318,6 @@ void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
-void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
-		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_queue_tag_inflight_iter(struct request_queue *q,
 		busy_iter_fn *fn, void *priv);
 void blk_mq_freeze_queue(struct request_queue *q);
-- 
2.7.4
