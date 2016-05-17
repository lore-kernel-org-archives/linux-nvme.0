From: keith.busch@intel.com (Keith Busch)
Date: Tue, 17 May 2016 15:37:42 -0600
Subject: [PATCH] NVMe: Fix possible scheduling while atomic error
Message-ID: <1463521062-16488-1-git-send-email-keith.busch@intel.com>

Stopping a h/w queue could have scheduled the task to wait on cancelling
work. This patch removes stopping the the delayed work so we can safely
hold rcu_read_lock() while stopping h/w queues.

Since blk-mq requeue work may restart the h/w queues during a reset,
the nvme driver's queue_rq will stop them again if the driver receives
a command during the reset window.

Reported-by: Ming Lin <mlin at kernel.org>
[fixes 0bf77e9 nvme: switch to RCU freeing the namespace]
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 6 ++++--
 drivers/nvme/host/pci.c  | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a51584..1e05abf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1823,7 +1823,6 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
 		spin_unlock_irq(ns->queue->queue_lock);
 
-		blk_mq_cancel_requeue_work(ns->queue);
 		blk_mq_stop_hw_queues(ns->queue);
 	}
 	rcu_read_unlock();
@@ -1836,7 +1835,10 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
-		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
+		spin_lock_irq(ns->queue->queue_lock);
+		queue_flag_clear(QUEUE_FLAG_STOPPED, ns->queue);
+		spin_unlock_irq(ns->queue->queue_lock);
+
 		blk_mq_start_stopped_hw_queues(ns->queue, true);
 		blk_mq_kick_requeue_list(ns->queue);
 	}
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8356813..9693629 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -609,6 +609,12 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	spin_unlock_irq(&nvmeq->q_lock);
 	return BLK_MQ_RQ_QUEUE_OK;
 out:
+	if (ret == BLK_MQ_RQ_QUEUE_BUSY) {
+		spin_lock_irq(ns->queue->queue_lock);
+		if (blk_queue_stopped(req->q))
+			blk_mq_stop_hw_queues(ns->queue);
+		spin_unlock_irq(ns->queue->queue_lock);
+	}
 	nvme_free_iod(dev, req);
 	return ret;
 }
-- 
2.7.2
