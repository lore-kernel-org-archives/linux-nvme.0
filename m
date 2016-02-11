From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 13:05:45 -0700
Subject: [PATCHv2-4.5 08/10] NVMe: Move error handling to failed reset handler
In-Reply-To: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455221147-24228-9-git-send-email-keith.busch@intel.com>

This moves failed queue handling out of the namespace removal path and into
the reset failure path, fixing a deadlock condition if the controller
fails or link down during del_gendisk. Previously the driver had to see
the controller as degraded prior to calling del_gendisk to setup the
queues to fail. If the controller happened to fail after this though,
there was no task to end the request_queue.

On failure, all namespace states are set to 'dead'. This has capacity
revalidate to 0, and ends all new requests with error status.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/core.c | 51 ++++++++++++++++++++++++++++++++++--------------
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  |  6 +++++-
 3 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ceea7f0..5ff1e77 100644
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
@@ -1113,34 +1117,51 @@ static struct nvme_ns *nvme_find_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 static void nvme_ns_remove_work(struct work_struct *work)
 {
 	struct nvme_ns *ns = container_of(work, struct nvme_ns, remove_work);
-	bool kill = nvme_io_incapable(ns->ctrl) &&
-			!blk_queue_dying(ns->queue);
-
-	if (kill) {
-		blk_set_queue_dying(ns->queue);
 
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
 	nvme_put_ns(ns);
 }
 
+/**
+ * nvme_kill_ns_queues(): Ends all namespace queues
+ * @ctrl: the dead controller that needs to end
+ *
+ * Call this function when the driver determines it is unable to get the
+ * controller in a state capable of servicing IO.
+ */
+void nvme_kill_ns_queues(struct nvme_ctrl *ctrl)
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
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d330512..8fa5ceb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -117,6 +117,7 @@ struct nvme_ns {
 	unsigned long flags;
 
 #define NVME_NS_REMOVING 0
+#define NVME_NS_DEAD     1
 
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
@@ -270,6 +271,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
 int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 			dma_addr_t dma_addr, u32 *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
+void nvme_kill_ns_queues(struct nvme_ctrl *ctrl);
 
 extern spinlock_t dev_list_lock;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9e1be57..32286e9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -678,7 +678,9 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	spin_lock_irq(&nvmeq->q_lock);
 	if (unlikely(nvmeq->cq_vector < 0)) {
-		ret = BLK_MQ_RQ_QUEUE_BUSY;
+		ret = test_bit(NVME_NS_DEAD, &ns->flags) ?
+					BLK_MQ_RQ_QUEUE_ERROR :
+					BLK_MQ_RQ_QUEUE_BUSY;
 		spin_unlock_irq(&nvmeq->q_lock);
 		goto out;
 	}
@@ -1903,6 +1905,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 	dev_warn(dev->dev, "Removing after probe failure status: %d\n", status);
 
 	kref_get(&dev->ctrl.kref);
+	nvme_dev_disable(dev, false);
 	if (!schedule_work(&dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
 }
@@ -1975,6 +1978,7 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
+	nvme_kill_ns_queues(&dev->ctrl);
 	if (pci_get_drvdata(pdev))
 		pci_stop_and_remove_bus_device_locked(pdev);
 	nvme_put_ctrl(&dev->ctrl);
-- 
2.6.2.307.g37023ba
