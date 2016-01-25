From: keith.busch@intel.com (Keith Busch)
Date: Mon, 25 Jan 2016 14:23:36 -0700
Subject: [PATCH 1/2] NVMe: Make surprise removal work again
Message-ID: <1453757017-13640-1-git-send-email-keith.busch@intel.com>

Ends all IO on disk removal when the controller can't respond. For
device failure or surprise removal, the driver ends new requests after
disabling the controller and setting the queue to dying. The h/w queue
is restarted to flush pending commands so they can be failed.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 19 ++++++++++++++-----
 drivers/nvme/host/pci.c  | 13 +++++++++++++
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c5bf001..37815c9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1178,6 +1178,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	kfree(ns);
 }
 
+static void __nvme_start_queue_locked(struct nvme_ns *ns)
+{
+	queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
+	blk_mq_start_stopped_hw_queues(ns->queue, true);
+	blk_mq_kick_requeue_list(ns->queue);
+}
+
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
 	bool kill = nvme_io_incapable(ns->ctrl) &&
@@ -1187,15 +1194,20 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	if (kill) {
 		blk_set_queue_dying(ns->queue);
+		mb();
 
 		/*
 		 * The controller was shutdown first if we got here through
 		 * device removal. The shutdown may requeue outstanding
 		 * requests. These need to be aborted immediately so
 		 * del_gendisk doesn't block indefinitely for their completion.
+		 * The queue needs to be restarted to let pending requests
+		 * fail.
 		 */
 		blk_mq_abort_requeue_list(ns->queue);
+		__nvme_start_queue_locked(ns);
 	}
+
 	if (ns->disk->flags & GENHD_FL_UP) {
 		if (blk_get_integrity(ns->disk))
 			blk_integrity_unregister(ns->disk);
@@ -1424,11 +1436,8 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	mutex_lock(&ctrl->namespaces_mutex);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
-		blk_mq_start_stopped_hw_queues(ns->queue, true);
-		blk_mq_kick_requeue_list(ns->queue);
-	}
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		__nvme_start_queue_locked(ns);
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72ef832..bdf148e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -640,6 +640,10 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_command cmnd;
 	int ret = BLK_MQ_RQ_QUEUE_OK;
 
+	if (unlikely(blk_queue_dying(req->q))) {
+		blk_mq_end_request(req, -EIO);
+		return BLK_MQ_RQ_QUEUE_OK;
+	}
 	/*
 	 * If formated with metadata, require the block layer provide a buffer
 	 * unless this namespace is formated such that the metadata can be
@@ -2118,6 +2122,15 @@ static void nvme_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->reset_work);
 	flush_work(&dev->scan_work);
+
+	/*
+	 * If the controller can't do IO (surprise removal, for example), we
+	 * need to quiesce prior to deleting namespaces. This ends outstanding
+	 * requests and prevents attempts to sync dirty data.
+	 */
+	if (nvme_io_incapable(&dev->ctrl))
+		nvme_dev_disable(dev, true);
+
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, true);
-- 
2.6.2.307.g37023ba
