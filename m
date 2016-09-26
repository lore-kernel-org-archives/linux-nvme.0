From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Mon, 26 Sep 2016 11:28:59 -0700
Subject: [PATCH 9/9] [RFC] nvme: Fix a race condition
In-Reply-To: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
Message-ID: <9c372b04-a194-58c4-a64f-b155b52a5244@sandisk.com>

Avoid that nvme_queue_rq() is still running when nvme_stop_queues()
returns. Untested.

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 057f1fa..6e2bf6a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -201,13 +201,9 @@ fail:
 
 void nvme_requeue_req(struct request *req)
 {
-	unsigned long flags;
-
 	blk_mq_requeue_request(req);
-	spin_lock_irqsave(req->q->queue_lock, flags);
-	if (!blk_mq_queue_stopped(req->q))
-		blk_mq_kick_requeue_list(req->q);
-	spin_unlock_irqrestore(req->q->queue_lock, flags);
+	WARN_ON_ONCE(blk_mq_queue_stopped(req->q));
+	blk_mq_kick_requeue_list(req->q);
 }
 EXPORT_SYMBOL_GPL(nvme_requeue_req);
 
@@ -2079,11 +2075,15 @@ EXPORT_SYMBOL_GPL(nvme_kill_queues);
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
+	struct request_queue *q;
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		blk_mq_cancel_requeue_work(ns->queue);
-		blk_mq_stop_hw_queues(ns->queue);
+		q = ns->queue;
+		blk_quiesce_queue(q);
+		blk_mq_cancel_requeue_work(q);
+		blk_mq_stop_hw_queues(q);
+		blk_resume_queue(q);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
-- 
2.10.0
