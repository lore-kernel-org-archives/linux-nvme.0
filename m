From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 14 Dec 2017 10:31:02 +0800
Subject: [PATCH V2 5/6] blk-mq: fix race between updating nr_hw_queues and
 switching io sched
In-Reply-To: <20171214023103.18272-1-ming.lei@redhat.com>
References: <20171214023103.18272-1-ming.lei@redhat.com>
Message-ID: <20171214023103.18272-6-ming.lei@redhat.com>

In both elevator_switch_mq() and blk_mq_update_nr_hw_queues(), sched tags
can be allocated, and q->nr_hw_queue is used, and race is inevitable, for
example: blk_mq_init_sched() may trigger use-after-free on hctx, which is
freed in blk_mq_realloc_hw_ctxs() when nr_hw_queues is decreased.

This patch fixes the race be holding q->sysfs_lock.

Reported-by: Yi Zhang <yi.zhang at redhat.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6dae8f631253..d6c75daec41b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2418,6 +2418,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
 	blk_mq_sysfs_unregister(q);
+
+	/* protect against switching io scheduler  */
+	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int node;
 
@@ -2462,6 +2465,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		}
 	}
 	q->nr_hw_queues = i;
+	mutex_unlock(&q->sysfs_lock);
 	blk_mq_sysfs_register(q);
 }
 
-- 
2.9.5
