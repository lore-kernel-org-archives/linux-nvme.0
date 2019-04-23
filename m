From: hare@suse.de (Hannes Reinecke)
Date: Tue, 23 Apr 2019 14:29:47 +0200
Subject: [PATCH 1/5] blk-mq: rename 'dead_hctx_XX' to 'unused_hctx_XX'
In-Reply-To: <20190423122951.134531-1-hare@suse.de>
References: <20190423122951.134531-1-hare@suse.de>
Message-ID: <20190423122951.134531-2-hare@suse.de>

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 block/blk-mq.c         | 22 +++++++++++-----------
 include/linux/blkdev.h |  6 +++---
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 93e30c14f1e8..6f016d0cc69b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2261,9 +2261,9 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 
 	blk_mq_remove_cpuhp(hctx);
 
-	spin_lock(&q->dead_hctx_lock);
-	list_add(&hctx->hctx_list, &q->dead_hctx_list);
-	spin_unlock(&q->dead_hctx_lock);
+	spin_lock(&q->unused_hctx_lock);
+	list_add(&hctx->hctx_list, &q->unused_hctx_list);
+	spin_unlock(&q->unused_hctx_lock);
 }
 
 static void blk_mq_exit_hw_queues(struct request_queue *q,
@@ -2669,8 +2669,8 @@ void blk_mq_release(struct request_queue *q)
 
 	cancel_delayed_work_sync(&q->requeue_work);
 
-	/* all hctx are in .dead_hctx_list now */
-	list_for_each_entry_safe(hctx, next, &q->dead_hctx_list, hctx_list) {
+	/* all hctx are in .unused_hctx_list now */
+	list_for_each_entry_safe(hctx, next, &q->unused_hctx_list, hctx_list) {
 		list_del_init(&hctx->hctx_list);
 		kobject_put(&hctx->kobj);
 	}
@@ -2740,9 +2740,9 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 {
 	struct blk_mq_hw_ctx *hctx = NULL, *tmp;
 
-	/* reuse dead hctx first */
-	spin_lock(&q->dead_hctx_lock);
-	list_for_each_entry(tmp, &q->dead_hctx_list, hctx_list) {
+	/* reuse hctx first */
+	spin_lock(&q->unused_hctx_lock);
+	list_for_each_entry(tmp, &q->unused_hctx_list, hctx_list) {
 		if (tmp->numa_node == node) {
 			hctx = tmp;
 			break;
@@ -2750,7 +2750,7 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 	}
 	if (hctx)
 		list_del_init(&hctx->hctx_list);
-	spin_unlock(&q->dead_hctx_lock);
+	spin_unlock(&q->unused_hctx_lock);
 
 	if (!hctx)
 		hctx = blk_mq_alloc_hctx(q, set, hctx_idx, node);
@@ -2866,8 +2866,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (!q->queue_hw_ctx)
 		goto err_sys_init;
 
-	INIT_LIST_HEAD(&q->dead_hctx_list);
-	spin_lock_init(&q->dead_hctx_lock);
+	INIT_LIST_HEAD(&q->unused_hctx_list);
+	spin_lock_init(&q->unused_hctx_lock);
 
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1325f941f0be..39e8cd1f0cd4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -536,11 +536,11 @@ struct request_queue {
 	struct mutex		sysfs_lock;
 
 	/*
-	 * for reusing dead hctx instance in case of updating
+	 * for reusing hctx instances in case of updating
 	 * nr_hw_queues
 	 */
-	struct list_head	dead_hctx_list;
-	spinlock_t		dead_hctx_lock;
+	struct list_head	unused_hctx_list;
+	spinlock_t		unused_hctx_lock;
 
 	atomic_t		mq_freeze_depth;
 
-- 
2.16.4
