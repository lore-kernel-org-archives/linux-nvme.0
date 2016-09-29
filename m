From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Wed, 28 Sep 2016 17:02:23 -0700
Subject: [PATCH v2 2/7] dm: Use BLK_MQ_S_STOPPED instead of QUEUE_FLAG_STOPPED
 in blk-mq code
In-Reply-To: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
Message-ID: <43265806-b77f-b357-cbf1-1d05cf253f97@sandisk.com>

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Cc: Mike Snitzer <snitzer at redhat.com>
---
 drivers/md/dm-rq.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 182b679..f2c271a 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -75,12 +75,6 @@ static void dm_old_start_queue(struct request_queue *q)
 
 static void dm_mq_start_queue(struct request_queue *q)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	queue_flag_clear(QUEUE_FLAG_STOPPED, q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
-
 	blk_mq_start_stopped_hw_queues(q, true);
 	blk_mq_kick_requeue_list(q);
 }
@@ -105,16 +99,8 @@ static void dm_old_stop_queue(struct request_queue *q)
 
 static void dm_mq_stop_queue(struct request_queue *q)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-	if (blk_queue_stopped(q)) {
-		spin_unlock_irqrestore(q->queue_lock, flags);
+	if (blk_mq_queue_stopped(q))
 		return;
-	}
-
-	queue_flag_set(QUEUE_FLAG_STOPPED, q);
-	spin_unlock_irqrestore(q->queue_lock, flags);
 
 	/* Avoid that requeuing could restart the queue. */
 	blk_mq_cancel_requeue_work(q);
@@ -341,7 +327,7 @@ static void __dm_mq_kick_requeue_list(struct request_queue *q, unsigned long mse
 	unsigned long flags;
 
 	spin_lock_irqsave(q->queue_lock, flags);
-	if (!blk_queue_stopped(q))
+	if (!blk_mq_queue_stopped(q))
 		blk_mq_delay_kick_requeue_list(q, msecs);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
-- 
2.10.0
