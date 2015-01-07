From: keith.busch@intel.com (Keith Busch)
Date: Tue,  6 Jan 2015 19:57:57 -0700
Subject: [PATCHv2 03/10] blk-mq: Let drivers cancel requeue_work
In-Reply-To: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
References: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420599484-21582-4-git-send-email-keith.busch@intel.com>

Requeueing requests run h/w queues in a work_queue, which may alter the
driver's requested state to temporarily stop them. This patch exports
a method to cancel the q->requeue_work so a driver can be assured it's
stopped h/w queues won't be started up when it is not ready.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c         |    6 ++++++
 include/linux/blk-mq.h |    1 +
 2 files changed, 7 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 82930c0..a976db4 100644
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
index 8bbd082..b509ef5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -202,6 +202,7 @@ void __blk_mq_end_request(struct request *rq, int error);
 
 void blk_mq_requeue_request(struct request *rq);
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head);
+void blk_mq_cancel_requeue_work(struct request_queue *q);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_complete_request(struct request *rq);
 
-- 
1.7.10.4
