From: keith.busch@intel.com (Keith Busch)
Date: Mon,  4 Jan 2016 09:10:57 -0700
Subject: [PATCHv3 3/5] NVMe: Remove queue freezing on resets
In-Reply-To: <1451923859-14187-1-git-send-email-keith.busch@intel.com>
References: <1451923859-14187-1-git-send-email-keith.busch@intel.com>
Message-ID: <1451923859-14187-4-git-send-email-keith.busch@intel.com>

NVMe submits all commands through the block layer now. This means we
can let requests queue at the blk-mq hardware context since there is no
path that bypasses this anymore so we don't need to freeze the queues
anymore. The driver can simply stop the h/w queues from running during
a reset instead.

This also fixes a WARN in percpu_ref_reinit when the queue was unfrozen
with requeued requests.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 7 ++-----
 drivers/nvme/host/nvme.h | 4 ++--
 drivers/nvme/host/pci.c  | 8 ++++----
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8da4a8a..e31a256 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1372,14 +1372,12 @@ out:
 	return ret;
 }
 
-void nvme_freeze_queues(struct nvme_ctrl *ctrl)
+void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		blk_mq_freeze_queue_start(ns->queue);
-
 		spin_lock_irq(ns->queue->queue_lock);
 		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
 		spin_unlock_irq(ns->queue->queue_lock);
@@ -1390,14 +1388,13 @@ void nvme_freeze_queues(struct nvme_ctrl *ctrl)
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
 
-void nvme_unfreeze_queues(struct nvme_ctrl *ctrl)
+void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
-		blk_mq_unfreeze_queue(ns->queue);
 		blk_mq_start_stopped_hw_queues(ns->queue, true);
 		blk_mq_kick_requeue_list(ns->queue);
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4437592..4722fad 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -238,8 +238,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl);
 void nvme_scan_namespaces(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
-void nvme_freeze_queues(struct nvme_ctrl *ctrl);
-void nvme_unfreeze_queues(struct nvme_ctrl *ctrl);
+void nvme_stop_queues(struct nvme_ctrl *ctrl);
+void nvme_start_queues(struct nvme_ctrl *ctrl);
 
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, unsigned int flags);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ac6c7af..953fe48 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1064,7 +1064,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	spin_unlock_irq(&nvmeq->q_lock);
 
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
-		blk_mq_freeze_queue_start(nvmeq->dev->ctrl.admin_q);
+		blk_mq_stop_hw_queues(nvmeq->dev->ctrl.admin_q);
 
 	irq_set_affinity_hint(vector, NULL);
 	free_irq(vector, nvmeq);
@@ -1296,7 +1296,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 			return -ENODEV;
 		}
 	} else
-		blk_mq_unfreeze_queue(dev->ctrl.admin_q);
+		blk_mq_start_stopped_hw_queues(dev->ctrl.admin_q, true);
 
 	return 0;
 }
@@ -1917,7 +1917,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 
 	mutex_lock(&dev->shutdown_lock);
 	if (dev->bar) {
-		nvme_freeze_queues(&dev->ctrl);
+		nvme_stop_queues(&dev->ctrl);
 		csts = readl(dev->bar + NVME_REG_CSTS);
 	}
 	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
@@ -2026,7 +2026,7 @@ static void nvme_reset_work(struct work_struct *work)
 		dev_warn(dev->dev, "IO queues not created\n");
 		nvme_remove_namespaces(&dev->ctrl);
 	} else {
-		nvme_unfreeze_queues(&dev->ctrl);
+		nvme_start_queues(&dev->ctrl);
 		nvme_dev_add(dev);
 	}
 
-- 
2.6.2.307.g37023ba
