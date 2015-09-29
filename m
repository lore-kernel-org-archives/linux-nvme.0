From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 29 Sep 2015 11:20:55 +0800
Subject: [PATCH 1/3] blk-mq: introduce .map_changed to blk_mq_ops
In-Reply-To: <1443496857-26887-1-git-send-email-tom.leiming@gmail.com>
References: <1443496857-26887-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <1443496857-26887-2-git-send-email-tom.leiming@gmail.com>

This patch introduces .map_changed callback to blk_mq_ops
so that driver can get notified when the mapping between
sw queue and hw queue is changed. One use case is for
setting irq affinity hint of hardware queue.

Signed-off-by: Ming Lei <tom.leiming at gmail.com>
---
 block/blk-mq.c         | 5 +++++
 include/linux/blk-mq.h | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f2d67b4..181e438 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1829,6 +1829,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 				set->tags[i] = NULL;
 			}
 			hctx->tags = NULL;
+			if (q->mq_ops->map_changed)
+				q->mq_ops->map_changed(hctx, i, false);
 			continue;
 		}
 
@@ -1850,6 +1852,9 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		 */
 		hctx->next_cpu = cpumask_first(hctx->cpumask);
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
+
+		if (q->mq_ops->map_changed)
+			q->mq_ops->map_changed(hctx, i, true);
 	}
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 37d1602..a4a7433 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -89,6 +89,7 @@ typedef struct blk_mq_hw_ctx *(map_queue_fn)(struct request_queue *, const int);
 typedef enum blk_eh_timer_return (timeout_fn)(struct request *, bool);
 typedef int (init_hctx_fn)(struct blk_mq_hw_ctx *, void *, unsigned int);
 typedef void (exit_hctx_fn)(struct blk_mq_hw_ctx *, unsigned int);
+typedef void (map_changed_fn)(struct blk_mq_hw_ctx *, unsigned int, bool);
 typedef int (init_request_fn)(void *, struct request *, unsigned int,
 		unsigned int, unsigned int);
 typedef void (exit_request_fn)(void *, struct request *, unsigned int,
@@ -125,6 +126,12 @@ struct blk_mq_ops {
 	exit_hctx_fn		*exit_hctx;
 
 	/*
+	 * Called when the mapping between sw queue and hw queue
+	 * is setup or changed because of CPU topo changed
+	 */
+	map_changed_fn		*map_changed;
+
+	/*
 	 * Called for every command allocated by the block layer to allow
 	 * the driver to set up driver specific data.
 	 *
-- 
1.9.1
