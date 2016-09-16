From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:14 +0200
Subject: [PATCH 03/21] block: Get rid of unused request_queue::nr_queues member
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <a4015e9acdae1095e84d8075a6386fa031f8ed80.1474014910.git.agordeev@redhat.com>

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-mq.c         | 2 --
 include/linux/blkdev.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1cacf83..b6a7dee 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2080,8 +2080,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
 	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
 
-	q->nr_queues = nr_cpu_ids;
-
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 
 	if (!(set->flags & BLK_MQ_F_SG_MERGE))
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e79055c..268f160 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -325,7 +325,6 @@ struct request_queue {
 
 	/* sw queues */
 	struct blk_mq_ctx __percpu	*queue_ctx;
-	unsigned int		nr_queues;
 
 	/* hw dispatch queues */
 	struct blk_mq_hw_ctx	**queue_hw_ctx;
-- 
1.8.3.1
