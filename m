From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 19 Nov 2015 12:11:52 -0700
Subject: [PATCH] nvme: allow queues the chance to quiesce after freezing them
Message-ID: <1447960312-2245-1-git-send-email-jonathan.derrick@intel.com>

A panic was discovered while doing io and hitting the sysfs reset.
Because io was completing successfully, the nvme_dev_shutdown code
detected this non-idle state as a stuck state and started to tear down
the queues. This resulted in a paging error when nvme_process_cq wrote
the doorbell of a deleted queue.

This patch allows some time after starting the queue freeze for queues
to quiesce on their own. It also sets a new nvme_queue member, frozen,
to prevent writing of the cq doorbell. If the queues successfully
quiesce, nvme_process_cq will run upon resuming. If the queues don't
quiesce, existing code considers it a dead controller and is torn down.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 block/blk-mq.c            |  8 ++++++++
 drivers/block/nvme-core.c | 33 ++++++++++++++++++++++++++++++++-
 include/linux/blk-mq.h    |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85f0143..b7fa323 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -128,6 +128,14 @@ static void blk_mq_freeze_queue_wait(struct request_queue *q)
 	wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->mq_usage_counter));
 }
 
+long blk_mq_freeze_queue_wait_timeout(struct request_queue *q, long timeout)
+{
+	return wait_event_timeout(q->mq_freeze_wq,
+			percpu_ref_is_zero(&q->mq_usage_counter),
+			timeout);
+}
+EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
+
 /*
  * Guarantee no request is in use, so we can change any data structure of
  * the queue afterward.
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ccc0c1f..183a868 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -122,6 +122,7 @@ struct nvme_queue {
 	u8 cq_phase;
 	u8 cqe_seen;
 	struct async_cmd_info cmdinfo;
+	bool frozen;
 };
 
 /*
@@ -977,7 +978,8 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
 		return 0;
 
-	writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+	if (unlikely(!nvmeq->frozen))
+		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;
 
@@ -2774,6 +2776,8 @@ static void nvme_dev_list_remove(struct nvme_dev *dev)
 static void nvme_freeze_queues(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns;
+	unsigned long start, timeout;
+	int i;
 
 	list_for_each_entry(ns, &dev->namespaces, list) {
 		blk_mq_freeze_queue_start(ns->queue);
@@ -2785,11 +2789,28 @@ static void nvme_freeze_queues(struct nvme_dev *dev)
 		blk_mq_cancel_requeue_work(ns->queue);
 		blk_mq_stop_hw_queues(ns->queue);
 	}
+
+	for (i = 1; i < dev->queue_count; i++) {
+		struct nvme_queue *nvmeq = dev->queues[i];
+		if (!nvmeq)
+			continue;
+		nvmeq->frozen = true;
+	}
+
+	start = jiffies;
+	list_for_each_entry(ns, &dev->namespaces, list) {
+		timeout = ns->queue->tag_set->timeout;
+		if (time_after_eq(jiffies, start + timeout))
+			timeout = 0;
+		blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
+	}
 }
 
 static void nvme_unfreeze_queues(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns;
+	unsigned long flags;
+	int i;
 
 	list_for_each_entry(ns, &dev->namespaces, list) {
 		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
@@ -2797,6 +2818,16 @@ static void nvme_unfreeze_queues(struct nvme_dev *dev)
 		blk_mq_start_stopped_hw_queues(ns->queue, true);
 		blk_mq_kick_requeue_list(ns->queue);
 	}
+
+	for (i = 1; i < dev->queue_count; i++) {
+		struct nvme_queue *nvmeq = dev->queues[i];
+		if (!nvmeq)
+			continue;
+		nvmeq->frozen = false;
+		spin_lock_irqsave(&nvmeq->q_lock, flags);
+		nvme_process_cq(nvmeq);
+		spin_unlock_irqrestore(&nvmeq->q_lock, flags);
+	}
 }
 
 static void nvme_dev_shutdown(struct nvme_dev *dev)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 5e7d43a..3741e59 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -228,6 +228,7 @@ void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_mq_freeze_queue_start(struct request_queue *q);
+long blk_mq_freeze_queue_wait_timeout(struct request_queue *q, long timeout);
 
 /*
  * Driver command data is immediately after the request. So subtract request
-- 
2.5.0
