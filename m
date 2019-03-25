From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Mon, 25 Mar 2019 13:28:03 +0800
Subject: [PATCH V2 2/8] blk-mq: use static_rqs instead of rqs to iterate tags
In-Reply-To: <1553491689-1730-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1553491689-1730-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1553491689-1730-3-git-send-email-jianchao.w.wang@oracle.com>

tags->rqs[] will not been cleaned when free driver tag to avoid
an extra store on a shared area in the per io path. But there
is a window between get driver tag and write tags->rqs[], so we
may see stale rq in tags->rqs[] which may have been freed, as
following case,
blk_mq_get_request         blk_mq_queue_tag_busy_iter
  -> blk_mq_get_tag
                             -> bt_for_each
                               -> bt_iter
                                 -> rq = taags->rqs[]
                                 -> rq->q
  -> blk_mq_rq_ctx_init
    -> data->hctx->tags->rqs[rq->tag] = rq;

In additiion, tags->rqs[] only contains the requests that get
driver tag. It is not accurate for io-scheduler case when account
busy tags in part_in_flight.

To fix both of them, the blk_mq_queue_tag_busy_iter is changed
in this patch to use tags->static_rqs[] instead of tags->rqs[].
We have to identify whether there is a io scheduler attached to
decide to use hctx->tags or hctx->sched_tags. And we will try to
get a non-zero q_usage_counter before that, then could avoid race
with update nr_hw_queues, switch io-scheduler and even queue cleanup.

Add 'inflight' parameter to determine to iterate in-flight
requests or just busy tags and add a new helper interface
blk_mq_queue_tag_inflight_iter to iterate all of the in-flight
tags and export this interface for drivers.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 block/blk-mq-tag.c     | 96 ++++++++++++++++++++++++++++++++++++--------------
 block/blk-mq-tag.h     |  4 +--
 block/blk-mq.c         | 27 +++++---------
 include/linux/blk-mq.h |  5 +--
 4 files changed, 83 insertions(+), 49 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 5f28002..bf7b235 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -216,26 +216,38 @@ struct bt_iter_data {
 	busy_iter_fn *fn;
 	void *data;
 	bool reserved;
+	bool inflight;
 };
 
 static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
 	struct bt_iter_data *iter_data = data;
 	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
-	struct blk_mq_tags *tags = hctx->tags;
 	bool reserved = iter_data->reserved;
+	struct blk_mq_tags *tags;
 	struct request *rq;
 
+	tags =  hctx->sched_tags ? hctx->sched_tags : hctx->tags;
+
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
-	rq = tags->rqs[bitnr];
+	/*
+	 * Because tags->rqs[] will not been cleaned when free driver tag
+	 * and there is a window between get driver tag and write tags->rqs[],
+	 * so we may see stale rq in tags->rqs[] which may have been freed.
+	 * Using static_rqs[] is safer.
+	 */
+	rq = tags->static_rqs[bitnr];
 
 	/*
-	 * We can hit rq == NULL here, because the tagging functions
-	 * test and set the bit before assigning ->rqs[].
+	 * There is a small window between get tag and blk_mq_rq_ctx_init,
+	 * so rq->q and rq->mq_hctx maybe different.
 	 */
-	if (rq && rq->q == hctx->queue)
-		return iter_data->fn(hctx, rq, iter_data->data, reserved);
+	if (rq && rq->q == hctx->queue &&
+	    rq->mq_hctx == hctx &&
+	    (!iter_data->inflight ||
+	     blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT))
+		return iter_data->fn(rq, iter_data->data, reserved);
 	return true;
 }
 
@@ -246,7 +258,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		or the bitmap_tags member of struct blk_mq_tags.
  * @fn:		Pointer to the function that will be called for each request
  *		associated with @hctx that has been assigned a driver tag.
- *		@fn will be called as follows: @fn(@hctx, rq, @data, @reserved)
+ *		@fn will be called as follows: @fn(rq, @data, @reserved)
  *		where rq is a pointer to a request. Return true to continue
  *		iterating tags, false to stop.
  * @data:	Will be passed as third argument to @fn.
@@ -254,13 +266,14 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		bitmap_tags member of struct blk_mq_tags.
  */
 static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct sbitmap_queue *bt,
-			busy_iter_fn *fn, void *data, bool reserved)
+			busy_iter_fn *fn, void *data, bool reserved, bool inflight)
 {
 	struct bt_iter_data iter_data = {
 		.hctx = hctx,
 		.fn = fn,
 		.data = data,
 		.reserved = reserved,
+		.inflight = inflight,
 	};
 
 	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
@@ -362,36 +375,33 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
 /**
- * blk_mq_queue_tag_busy_iter - iterate over all requests with a driver tag
+ * __blk_mq_queue_tag_busy_iter - iterate over all busy or inflight tags
  * @q:		Request queue to examine.
- * @fn:		Pointer to the function that will be called for each request
- *		on @q. @fn will be called as follows: @fn(hctx, rq, @priv,
- *		reserved) where rq is a pointer to a request and hctx points
- *		to the hardware queue associated with the request. 'reserved'
- *		indicates whether or not @rq is a reserved request.
+ * @fn:		Pointer to the function that will be called for each
+ * 		in-flight request issued by @q. @fn will be called as
+ * 		follows:
+ * 		@fn(rq, @priv, reserved)
+ * 		rq is a pointer to a request.'reserved' indicates whether or
+ * 		not @rq is a reserved request.
  * @priv:	Will be passed as third argument to @fn.
- *
- * Note: if @q->tag_set is shared with other request queues then @fn will be
- * called for all requests on all queues that share that tag set and not only
- * for requests associated with @q.
  */
-void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
-		void *priv)
+static void __blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+		void *priv, bool inflight)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
 	/*
-	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
-	 * while the queue is frozen. So we can use q_usage_counter to avoid
-	 * racing with it.
+	 * Get a reference of the queue unless it has been zero. We use this
+	 * to avoid the race with the code that would modify the hctxs after
+	 * freeze and drain the queue, including updating nr_hw_queues, io
+	 * scheduler switching and queue clean up.
 	 */
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		struct blk_mq_tags *tags = hctx->tags;
-
+		struct blk_mq_tags *tags;
 		/*
 		 * If no software queues are currently mapped to this
 		 * hardware queue, there's nothing to check
@@ -399,13 +409,45 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		if (!blk_mq_hw_queue_mapped(hctx))
 			continue;
 
+		tags =  hctx->sched_tags ? hctx->sched_tags : hctx->tags;
+
 		if (tags->nr_reserved_tags)
-			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
-		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
+			bt_for_each(hctx, &tags->breserved_tags,
+				    fn, priv, true, inflight);
+		bt_for_each(hctx, &tags->bitmap_tags,
+			    fn, priv, false, inflight);
+		/*
+		 * flush_rq represents the rq with REQ_PREFLUSH and REQ_FUA
+		 * (if FUA is not supported by device) to be issued to
+		 * device. So we need to consider it when iterate inflight
+		 * rqs, but needn't to count it when iterate busy tags.
+		 */
+		if (inflight &&
+		    blk_mq_rq_state(hctx->fq->flush_rq) == MQ_RQ_IN_FLIGHT)
+			fn(hctx->fq->flush_rq, priv, false);
 	}
 	blk_queue_exit(q);
 }
 
+/*
+ * Iterate all the busy tags including pending and in-flight ones.
+ */
+void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+				void *priv)
+{
+	__blk_mq_queue_tag_busy_iter(q, fn, priv, false);
+}
+
+/*
+ * Iterate all the inflight tags.
+ */
+void blk_mq_queue_tag_inflight_iter(struct request_queue *q,
+				    busy_iter_fn *fn, void *priv)
+{
+	__blk_mq_queue_tag_busy_iter(q, fn, priv, true);
+}
+EXPORT_SYMBOL(blk_mq_queue_tag_inflight_iter);
+
 static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
 		    bool round_robin, int node)
 {
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0..bcbb699 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -32,9 +32,9 @@ extern bool blk_mq_has_free_tags(struct blk_mq_tags *tags);
 extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
-extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
-void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+extern void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
+extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 						 struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2102d91..531522e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -93,8 +93,7 @@ struct mq_inflight {
 	unsigned int *inflight;
 };
 
-static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
-				  struct request *rq, void *priv,
+static bool blk_mq_check_inflight(struct request *rq, void *priv,
 				  bool reserved)
 {
 	struct mq_inflight *mi = priv;
@@ -119,8 +118,7 @@ unsigned int blk_mq_in_flight(struct request_queue *q, struct hd_struct *part)
 	return inflight[0];
 }
 
-static bool blk_mq_check_inflight_rw(struct blk_mq_hw_ctx *hctx,
-				     struct request *rq, void *priv,
+static bool blk_mq_check_inflight_rw(struct request *rq, void *priv,
 				     bool reserved)
 {
 	struct mq_inflight *mi = priv;
@@ -809,28 +807,22 @@ struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 }
 EXPORT_SYMBOL(blk_mq_tag_to_rq);
 
-static bool blk_mq_rq_inflight(struct blk_mq_hw_ctx *hctx, struct request *rq,
-			       void *priv, bool reserved)
+static bool blk_mq_rq_inflight(struct request *rq, void *priv, bool reserved)
 {
+	bool *busy = priv;
 	/*
 	 * If we find a request that is inflight and the queue matches,
 	 * we know the queue is busy. Return false to stop the iteration.
 	 */
-	if (rq->state == MQ_RQ_IN_FLIGHT && rq->q == hctx->queue) {
-		bool *busy = priv;
-
-		*busy = true;
-		return false;
-	}
-
-	return true;
+	*busy = true;
+	return false;
 }
 
 bool blk_mq_queue_inflight(struct request_queue *q)
 {
 	bool busy = false;
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_rq_inflight, &busy);
+	blk_mq_queue_tag_inflight_iter(q, blk_mq_rq_inflight, &busy);
 	return busy;
 }
 EXPORT_SYMBOL_GPL(blk_mq_queue_inflight);
@@ -870,8 +862,7 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 	return false;
 }
 
-static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
-		struct request *rq, void *priv, bool reserved)
+static bool blk_mq_check_expired(struct request *rq, void *priv, bool reserved)
 {
 	unsigned long *next = priv;
 
@@ -932,7 +923,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
+	blk_mq_queue_tag_inflight_iter(q, blk_mq_check_expired, &next);
 
 	if (next != 0) {
 		mod_timer(&q->timeout, next);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b0c814b..dff9bb6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -132,8 +132,7 @@ typedef int (init_request_fn)(struct blk_mq_tag_set *set, struct request *,
 typedef void (exit_request_fn)(struct blk_mq_tag_set *set, struct request *,
 		unsigned int);
 
-typedef bool (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
-		bool);
+typedef bool (busy_iter_fn)(struct request *, void *, bool);
 typedef bool (busy_tag_iter_fn)(struct request *, void *, bool);
 typedef int (poll_fn)(struct blk_mq_hw_ctx *);
 typedef int (map_queues_fn)(struct blk_mq_tag_set *set);
@@ -321,6 +320,8 @@ bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
+void blk_mq_queue_tag_inflight_iter(struct request_queue *q,
+		busy_iter_fn *fn, void *priv);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_freeze_queue_start(struct request_queue *q);
-- 
2.7.4
