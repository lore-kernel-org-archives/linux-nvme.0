From: sagig@mellanox.com (Sagi Grimberg)
Date: Sun, 13 Dec 2015 18:27:18 +0200
Subject: [PATCH] nvme: Move nvme_freeze/unfreeze_queues to nvme core
Message-ID: <1450024038-1694-1-git-send-email-sagig@mellanox.com>

Nothing pci specific about them and We'll need them exported
in other transports too.

Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
---
 drivers/nvme/host/core.c |   28 ++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |    3 +++
 drivers/nvme/host/pci.c  |   32 ++------------------------------
 3 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 64891eb..b7eb59e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1207,6 +1207,34 @@ out:
 	return ret;
 }
 
+void nvme_freeze_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		blk_mq_freeze_queue_start(ns->queue);
+
+		spin_lock_irq(ns->queue->queue_lock);
+		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
+		spin_unlock_irq(ns->queue->queue_lock);
+
+		blk_mq_cancel_requeue_work(ns->queue);
+		blk_mq_stop_hw_queues(ns->queue);
+	}
+}
+
+void nvme_unfreeze_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
+		blk_mq_unfreeze_queue(ns->queue);
+		blk_mq_start_stopped_hw_queues(ns->queue, true);
+		blk_mq_kick_requeue_list(ns->queue);
+	}
+}
+
 int __init nvme_core_init(void)
 {
 	int result;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b75d41e..93cc840 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -211,6 +211,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl);
 void nvme_scan_namespaces(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
+void nvme_freeze_queues(struct nvme_ctrl *ctrl);
+void nvme_unfreeze_queues(struct nvme_ctrl *ctrl);
+
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, unsigned int flags);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a64d0ba..293b889 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2009,34 +2009,6 @@ static void nvme_dev_list_remove(struct nvme_dev *dev)
 		kthread_stop(tmp);
 }
 
-static void nvme_freeze_queues(struct nvme_dev *dev)
-{
-	struct nvme_ns *ns;
-
-	list_for_each_entry(ns, &dev->ctrl.namespaces, list) {
-		blk_mq_freeze_queue_start(ns->queue);
-
-		spin_lock_irq(ns->queue->queue_lock);
-		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
-		spin_unlock_irq(ns->queue->queue_lock);
-
-		blk_mq_cancel_requeue_work(ns->queue);
-		blk_mq_stop_hw_queues(ns->queue);
-	}
-}
-
-static void nvme_unfreeze_queues(struct nvme_dev *dev)
-{
-	struct nvme_ns *ns;
-
-	list_for_each_entry(ns, &dev->ctrl.namespaces, list) {
-		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
-		blk_mq_unfreeze_queue(ns->queue);
-		blk_mq_start_stopped_hw_queues(ns->queue, true);
-		blk_mq_kick_requeue_list(ns->queue);
-	}
-}
-
 static void nvme_dev_shutdown(struct nvme_dev *dev)
 {
 	int i;
@@ -2045,7 +2017,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	nvme_dev_list_remove(dev);
 
 	if (dev->bar) {
-		nvme_freeze_queues(dev);
+		nvme_freeze_queues(&dev->ctrl);
 		csts = readl(dev->bar + NVME_REG_CSTS);
 	}
 	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
@@ -2157,7 +2129,7 @@ static void nvme_probe_work(struct work_struct *work)
 		dev_warn(dev->dev, "IO queues not created\n");
 		nvme_remove_namespaces(&dev->ctrl);
 	} else {
-		nvme_unfreeze_queues(dev);
+		nvme_unfreeze_queues(&dev->ctrl);
 		nvme_dev_add(dev);
 	}
 
-- 
1.7.1
