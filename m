From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Jan 2015 18:55:50 -0700
Subject: [PATCHv3 09/12] NVMe: Admin queue removal handling
In-Reply-To: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
References: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420682153-3756-10-git-send-email-keith.busch@intel.com>

This protects admin queue access on shutdown. When the controller is
disabled, the queue is frozen to prevent new entry, and unfrozen on
resume, and fixes cq_vector signedness to not suspend a queue twice.

Since unfreezing the queue makes it available for commands, it requires
the queue be initialized, so this moves this part after that.

Special handling is done when the device is unresponsive during
shutdown. This can be optimized to not require subsequent commands to
timeout, but saving that fix for later.

This patch also removes the kill signals in this path that were left-over
artifacts from the blk-mq conversion and no longer necessary.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index beb8d48..66ade19 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -106,7 +106,7 @@ struct nvme_queue {
 	dma_addr_t cq_dma_addr;
 	u32 __iomem *q_db;
 	u16 q_depth;
-	u16 cq_vector;
+	s16 cq_vector;
 	u16 sq_head;
 	u16 sq_tail;
 	u16 cq_head;
@@ -1183,6 +1183,8 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 		adapter_delete_sq(dev, qid);
 		adapter_delete_cq(dev, qid);
 	}
+	if (!qid && dev->admin_q)
+		blk_mq_freeze_queue_start(dev->admin_q);
 	nvme_clear_queue(nvmeq);
 }
 
@@ -1400,7 +1402,8 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 			nvme_dev_remove_admin(dev);
 			return -ENODEV;
 		}
-	}
+	} else
+		blk_mq_unfreeze_queue(dev->admin_q);
 
 	return 0;
 }
@@ -1459,19 +1462,13 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	if (result)
 		goto free_nvmeq;
 
-	result = nvme_alloc_admin_tags(dev);
-	if (result)
-		goto free_nvmeq;
-
 	nvmeq->cq_vector = 0;
 	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
 	if (result)
-		goto free_tags;
+		goto free_nvmeq;
 
 	return result;
 
- free_tags:
-	nvme_dev_remove_admin(dev);
  free_nvmeq:
 	nvme_free_queues(dev, 0);
 	return result;
@@ -2256,13 +2253,18 @@ static void nvme_wait_dq(struct nvme_delq_ctx *dq, struct nvme_dev *dev)
 			break;
 		if (!schedule_timeout(ADMIN_TIMEOUT) ||
 					fatal_signal_pending(current)) {
+			/*
+			 * Disable the controller first since we can't trust it
+			 * at this point, but leave the admin queue enabled
+			 * until all queue deletion requests are flushed.
+			 * FIXME: This may take a while if there are more h/w
+			 * queues than admin tags. 
+			 */
 			set_current_state(TASK_RUNNING);
-
 			nvme_disable_ctrl(dev, readq(&dev->bar->cap));
-			nvme_disable_queue(dev, 0);
-
-			send_sig(SIGKILL, dq->worker->task, 1);
+			nvme_clear_queue(dev->queues[0]);
 			flush_kthread_worker(dq->worker);
+			nvme_disable_queue(dev, 0);
 			return;
 		}
 	}
@@ -2339,7 +2341,6 @@ static void nvme_del_queue_start(struct kthread_work *work)
 {
 	struct nvme_queue *nvmeq = container_of(work, struct nvme_queue,
 							cmdinfo.work);
-	allow_signal(SIGKILL);
 	if (nvme_delete_sq(nvmeq))
 		nvme_del_queue_end(nvmeq);
 }
@@ -2607,15 +2608,20 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	}
 
 	nvme_init_queue(dev->queues[0], 0);
+	result = nvme_alloc_admin_tags(dev);
+	if (result)
+		goto disable;
 
 	result = nvme_setup_io_queues(dev);
 	if (result)
-		goto disable;
+		goto free_tags;
 
 	nvme_set_irq_hints(dev);
 
 	return result;
 
+ free_tags:
+	nvme_dev_remove_admin(dev);
  disable:
 	nvme_disable_queue(dev, 0);
 	nvme_dev_list_remove(dev);
-- 
1.7.10.4
