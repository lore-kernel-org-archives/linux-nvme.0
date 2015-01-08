From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Jan 2015 18:55:44 -0700
Subject: [PATCHv3 03/12] blk-mq: Let drivers cancel requeue_work
In-Reply-To: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
References: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420682153-3756-4-git-send-email-keith.busch@intel.com>

Kicking requeued requests will start h/w queues in a work_queue, which
may alter the driver's requested state to temporarily stop them. This
patch exports a method to cancel the q->requeue_work so a driver can be
assured stopped h/w queues won't be started up before it is ready.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c         |    6 ++++++
 include/linux/blk-mq.h |    1 +
 2 files changed, 7 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d7123f3..0812965 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -521,6 +521,12 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head)
 }
 EXPORT_SYMBOL(blk_mq_add_to_requeue_list);
 
+void blk_mq_cancel_requeue_work(struct request_queue *q)
+{
+	cancel_work_sync(&q->requeue_work);
+}
+EXPORT_SYMBOL_GPL(blk_mq_cancel_requeue_work);
+
 void blk_mq_kick_requeue_list(struct request_queue *q)
 {
 	kblockd_schedule_work(&q->requeue_work);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index addf8a1..18684e0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -201,6 +201,7 @@ void __blk_mq_end_request(struct request *rq, int error);
 
 void blk_mq_requeue_request(struct request *rq);
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head);
+void blk_mq_cancel_requeue_work(struct request_queue *q);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_complete_request(struct request *rq);
 
-- 
1.7.10.4
