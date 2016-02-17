From: keith.busch@intel.com (Keith Busch)
Date: Wed, 17 Feb 2016 11:36:54 -0700
Subject: [PATCH-4.5-v3 4/5] NVMe: Move error handling to failed reset handler
In-Reply-To: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
References: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455734215-20396-5-git-send-email-keith.busch@intel.com>

This moves failed queue handling out of the namespace removal path and
into the reset failure path, fixing a hanging condition if the controller
fails or link down during del_gendisk. Previously the driver had to see
the controller as degraded prior to calling del_gendisk to setup the
queues to fail. If the controller happened to fail after this though,
there was no task to end the request_queue.

On failure, all namespace states are set to dead. This has capacity
revalidate to 0, and ends all new requests with error status.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 53 ++++++++++++++++++++++++++++++++----------------
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  |  7 ++++++-
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1b7387d..face31f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -560,6 +560,10 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	u16 old_ms;
 	unsigned short bs;
 
+	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
+		set_capacity(disk, 0);
+		return -ENODEV;
+	}
 	if (nvme_identify_ns(ns->ctrl, ns->ns_id, &id)) {
 		dev_warn(ns->ctrl->dev, "%s: Identify failure nvme%dn%d\n",
 				__func__, ns->ctrl->instance, ns->ns_id);
@@ -1183,32 +1187,15 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
-	bool kill;
-
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
-	kill = nvme_io_incapable(ns->ctrl) &&
-			!blk_queue_dying(ns->queue);
-	if (kill) {
-		blk_set_queue_dying(ns->queue);
-
-		/*
-		 * The controller was shutdown first if we got here through
-		 * device removal. The shutdown may requeue outstanding
-		 * requests. These need to be aborted immediately so
-		 * del_gendisk doesn't block indefinitely for their completion.
-		 */
-		blk_mq_abort_requeue_list(ns->queue);
-	}
 	if (ns->disk->flags & GENHD_FL_UP) {
 		if (blk_get_integrity(ns->disk))
 			blk_integrity_unregister(ns->disk);
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
 					&nvme_ns_attr_group);
 		del_gendisk(ns->disk);
-	}
-	if (kill || !blk_queue_dying(ns->queue)) {
 		blk_mq_abort_requeue_list(ns->queue);
 		blk_cleanup_queue(ns->queue);
 	}
@@ -1405,6 +1392,38 @@ out:
 	return ret;
 }
 
+/**
+ * nvme_kill_queues(): Ends all namespace queues
+ * @ctrl: the dead controller that needs to end
+ *
+ * Call this function when the driver determines it is unable to get the
+ * controller in a state capable of servicing IO.
+ */
+void nvme_kill_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (!kref_get_unless_zero(&ns->kref))
+			continue;
+
+		/*
+		 * Revalidating a dead namespace sets capacity to 0. This will
+		 * end buffered writers dirtying pages that can't be synced.
+		 */
+		if (!test_and_set_bit(NVME_NS_DEAD, &ns->flags))
+			revalidate_disk(ns->disk);
+
+		blk_set_queue_dying(ns->queue);
+		blk_mq_abort_requeue_list(ns->queue);
+		blk_mq_start_stopped_hw_queues(ns->queue, true);
+
+		nvme_put_ns(ns);
+	}
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index db413a7..dcdc2d7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -115,6 +115,7 @@ struct nvme_ns {
 	unsigned long flags;
 
 #define NVME_NS_REMOVING 0
+#define NVME_NS_DEAD     1
 
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
@@ -244,6 +245,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
+void nvme_kill_queues(struct nvme_ctrl *ctrl);
 
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, unsigned int flags);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9e050dd..27042c0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -679,7 +679,10 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	spin_lock_irq(&nvmeq->q_lock);
 	if (unlikely(nvmeq->cq_vector < 0)) {
-		ret = BLK_MQ_RQ_QUEUE_BUSY;
+		if (ns && test_bit(NVME_NS_DEAD, &ns->flags))
+			ret = BLK_MQ_RQ_QUEUE_ERROR;
+		else
+			ret = BLK_MQ_RQ_QUEUE_BUSY;
 		spin_unlock_irq(&nvmeq->q_lock);
 		goto out;
 	}
@@ -1906,6 +1909,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 	dev_warn(dev->dev, "Removing after probe failure status: %d\n", status);
 
 	kref_get(&dev->ctrl.kref);
+	nvme_dev_disable(dev, false);
 	if (!schedule_work(&dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
 }
@@ -1978,6 +1982,7 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
+	nvme_kill_queues(&dev->ctrl);
 	if (pci_get_drvdata(pdev))
 		pci_stop_and_remove_bus_device_locked(pdev);
 	nvme_put_ctrl(&dev->ctrl);
-- 
2.6.2.307.g37023ba
