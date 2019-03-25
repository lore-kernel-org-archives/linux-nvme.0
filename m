From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Mon, 25 Mar 2019 13:38:31 +0800
Subject: [PATCH V2 1/8] blk-mq: get rid of the synchronize_rcu in
 __blk_mq_update_nr_hw_queues
In-Reply-To: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1553492318-1810-2-git-send-email-jianchao.w.wang@oracle.com>

In commit 530ca2c (blk-mq: Allow blocking queue tag iter callbacks),
we try to get a non-zero q_usage_counter to avoid access hctxs that
being modified. So the synchronize_rcu is useless and should be
removed.

Reviewed-by: Ming Lei <ming.lei at redhat.com>
Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 block/blk-mq-tag.c | 4 +---
 block/blk-mq.c     | 4 ----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a4931fc..5f28002 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -384,9 +384,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 	/*
 	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and queue_hw_ctx
 	 * while the queue is frozen. So we can use q_usage_counter to avoid
-	 * racing with it. __blk_mq_update_nr_hw_queues() uses
-	 * synchronize_rcu() to ensure this function left the critical section
-	 * below.
+	 * racing with it.
 	 */
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9c1816..2102d91 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3211,10 +3211,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue(q);
 	/*
-	 * Sync with blk_mq_queue_tag_busy_iter.
-	 */
-	synchronize_rcu();
-	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
 	 * with the previous scheduler. We will switch back once we are done
 	 * updating the new sw to hw queue mappings.
-- 
2.7.4
