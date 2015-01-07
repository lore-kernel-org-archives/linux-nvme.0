From: keith.busch@intel.com (Keith Busch)
Date: Tue,  6 Jan 2015 19:58:03 -0700
Subject: [PATCHv2 09/10] NVMe: Admin queue error handling
In-Reply-To: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
References: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420599484-21582-10-git-send-email-keith.busch@intel.com>

This protects the admin queue access in a variety of scenarios:

Its request_queue is reference counted once it is allocated so it can't
be deleted while there is an open reference on the controller and fixes
a use-after-free error on some hot-remove scenarios.

The queue is frozen on reset after all IO queues have been deleted
since the controller cannot accept commands after this anyway, so new
requests will block until the reset completes. Since the queue has to
be unfrozen, the function doing that was moved to the point after the
h/w queue was initialized, which is probably where it should have gone
in the first place.

Special handling is done if the controller becomes unresponsive on a
shutdown to forcefully cancel commands, and then wait for the remaining
queue deletion workers to finish.

This patch also removed the unnecessary software signals that were
previously used to signal the worker thread to die, but that mechanism
is not used in this path anymore, and fixed the signedness on cq_vector
so we don't disable a queue twice.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   67 +++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 571577c..f20e6c6 100644
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
@@ -1186,6 +1186,8 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 		adapter_delete_sq(dev, qid);
 		adapter_delete_cq(dev, qid);
 	}
+	if (!qid)
+		blk_mq_freeze_queue_start(dev->admin_q);
 	nvme_clear_queue(nvmeq);
 }
 
@@ -1372,6 +1374,14 @@ static struct blk_mq_ops nvme_mq_ops = {
 	.timeout	= nvme_timeout,
 };
 
+static void nvme_dev_remove_admin(struct nvme_dev *dev)
+{
+	if (dev->admin_q && !blk_queue_dying(dev->admin_q)) {
+		blk_cleanup_queue(dev->admin_q);
+		blk_mq_free_tag_set(&dev->admin_tagset);
+	}
+}
+
 static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 {
 	if (!dev->admin_q) {
@@ -1391,17 +1401,16 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 			blk_mq_free_tag_set(&dev->admin_tagset);
 			return -ENOMEM;
 		}
-	}
+		if (!blk_get_queue(dev->admin_q)) {
+			nvme_dev_remove_admin(dev);
+			return -ENODEV;
+		}
+	} else
+		blk_mq_unfreeze_queue(dev->admin_q);
 
 	return 0;
 }
 
-static void nvme_free_admin_tags(struct nvme_dev *dev)
-{
-	if (dev->admin_q)
-		blk_mq_free_tag_set(&dev->admin_tagset);
-}
-
 static int nvme_configure_admin_queue(struct nvme_dev *dev)
 {
 	int result;
@@ -1456,19 +1465,13 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
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
-	nvme_free_admin_tags(dev);
  free_nvmeq:
 	nvme_free_queues(dev, 0);
 	return result;
@@ -2251,15 +2254,19 @@ static void nvme_wait_dq(struct nvme_delq_ctx *dq, struct nvme_dev *dev)
 		set_current_state(TASK_KILLABLE);
 		if (!atomic_read(&dq->refcount))
 			break;
-		if (!schedule_timeout(ADMIN_TIMEOUT) ||
-					fatal_signal_pending(current)) {
+		if (!schedule_timeout(ADMIN_TIMEOUT)) {
+			/*
+			 * Disable the controller first since we can't trust it
+			 * at this point, but leave the admin queue enabled
+			 * until all queue deletion requests are flushed. This
+			 * may take a while if there are more h/w queues than
+			 * admin tags.
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
@@ -2336,7 +2343,6 @@ static void nvme_del_queue_start(struct kthread_work *work)
 {
 	struct nvme_queue *nvmeq = container_of(work, struct nvme_queue,
 							cmdinfo.work);
-	allow_signal(SIGKILL);
 	if (nvme_delete_sq(nvmeq))
 		nvme_del_queue_end(nvmeq);
 }
@@ -2448,12 +2454,6 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	nvme_dev_unmap(dev);
 }
 
-static void nvme_dev_remove_admin(struct nvme_dev *dev)
-{
-	if (dev->admin_q && !blk_queue_dying(dev->admin_q))
-		blk_cleanup_queue(dev->admin_q);
-}
-
 static void nvme_dev_remove(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns;
@@ -2543,6 +2543,7 @@ static void nvme_free_dev(struct kref *kref)
 	nvme_free_namespaces(dev);
 	nvme_release_instance(dev);
 	blk_mq_free_tag_set(&dev->tagset);
+	blk_put_queue(dev->admin_q);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
@@ -2639,15 +2640,18 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	}
 
 	nvme_init_queue(dev->queues[0], 0);
-
-	result = nvme_setup_io_queues(dev);
+	result = nvme_alloc_admin_tags(dev);
 	if (result)
 		goto disable;
 
-	nvme_set_irq_hints(dev);
+	result = nvme_setup_io_queues(dev);
+	if (result)
+		goto free_tags;
 
 	return result;
 
+ free_tags:
+	nvme_dev_remove_admin(dev);
  disable:
 	nvme_disable_queue(dev, 0);
 	nvme_dev_list_remove(dev);
@@ -2831,7 +2835,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_remove(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
-	nvme_free_admin_tags(dev);
 	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
 }
-- 
1.7.10.4
