From: keith.busch@intel.com (Keith Busch)
Date: Thu, 31 Dec 2015 09:41:54 -0700
Subject: [PATCHv2 3/5] NVMe: Remove queue freezing on resets
In-Reply-To: <1451580116-12252-1-git-send-email-keith.busch@intel.com>
References: <1451580116-12252-1-git-send-email-keith.busch@intel.com>
Message-ID: <1451580116-12252-4-git-send-email-keith.busch@intel.com>

NVMe submits all commands through the block layer now. This means the
driver can let requests queue at the blk-mq hardware context since there
is no path that bypasses this anymore, so this patch removes freezing
the queues on reset. The driver simply stops the h/w queues from running
during a reset instead.

This also fixes a WARN in percpu_ref_reinit when the queue was unfrozen
with requeued requests.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 71f43ff..5e1e8cd 100644
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
@@ -1908,13 +1908,11 @@ static void nvme_dev_list_remove(struct nvme_dev *dev)
 		kthread_stop(tmp);
 }
 
-static void nvme_freeze_queues(struct nvme_dev *dev)
+static void nvme_stop_queues(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns;
 
 	list_for_each_entry(ns, &dev->ctrl.namespaces, list) {
-		blk_mq_freeze_queue_start(ns->queue);
-
 		spin_lock_irq(ns->queue->queue_lock);
 		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
 		spin_unlock_irq(ns->queue->queue_lock);
@@ -1924,13 +1922,12 @@ static void nvme_freeze_queues(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_unfreeze_queues(struct nvme_dev *dev)
+static void nvme_start_queues(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns;
 
 	list_for_each_entry(ns, &dev->ctrl.namespaces, list) {
 		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
-		blk_mq_unfreeze_queue(ns->queue);
 		blk_mq_start_stopped_hw_queues(ns->queue, true);
 		blk_mq_kick_requeue_list(ns->queue);
 	}
@@ -1945,7 +1942,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 
 	mutex_lock(&dev->shutdown_lock);
 	if (dev->bar) {
-		nvme_freeze_queues(dev);
+		nvme_stop_queues(dev);
 		csts = readl(dev->bar + NVME_REG_CSTS);
 	}
 	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
@@ -2054,7 +2051,7 @@ static void nvme_reset_work(struct work_struct *work)
 		dev_warn(dev->dev, "IO queues not created\n");
 		nvme_remove_namespaces(&dev->ctrl);
 	} else {
-		nvme_unfreeze_queues(dev);
+		nvme_start_queues(dev);
 		nvme_dev_add(dev);
 	}
 
-- 
2.6.2.307.g37023ba
