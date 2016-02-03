From: keith.busch@intel.com (Keith Busch)
Date: Wed,  3 Feb 2016 09:05:42 -0700
Subject: [PATCH 3/4] NVMe: Surprise removal fixes
In-Reply-To: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
References: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
Message-ID: <1454515543-21683-4-git-send-email-keith.busch@intel.com>

Temporarily halts IO queues on surprise removal prior to flushing
pending requests to an error completion.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 13 +++++++------
 drivers/nvme/host/pci.c  | 14 ++++++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9d415489..f11cb5a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1186,15 +1186,16 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	lockdep_assert_held(&ns->ctrl->namespaces_mutex);
 
 	if (kill) {
-		blk_set_queue_dying(ns->queue);
-
 		/*
-		 * The controller was shutdown first if we got here through
-		 * device removal. The shutdown may requeue outstanding
-		 * requests. These need to be aborted immediately so
-		 * del_gendisk doesn't block indefinitely for their completion.
+		 * The request queue is currently stoppped if we got here.
+		 * Prevent new requests from entering before flushing the rest.
+		 * New requests will fail to enter a dying frozen queue, which
+		 * allows blk_cleanup_queue to complete.
 		 */
+		blk_mq_freeze_queue_start(ns->queue);
+		blk_set_queue_dying(ns->queue);
 		blk_mq_abort_requeue_list(ns->queue);
+		blk_mq_start_hw_queues(ns->queue);
 	}
 	if (ns->disk->flags & GENHD_FL_UP) {
 		if (blk_get_integrity(ns->disk))
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72ef832..4cc7398 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -640,6 +640,11 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_command cmnd;
 	int ret = BLK_MQ_RQ_QUEUE_OK;
 
+	if (unlikely(blk_queue_dying(req->q))) {
+		blk_mq_end_request(req, -EFAULT);
+		return BLK_MQ_RQ_QUEUE_OK;
+	}
+
 	/*
 	 * If formated with metadata, require the block layer provide a buffer
 	 * unless this namespace is formated such that the metadata can be
@@ -2118,6 +2123,15 @@ static void nvme_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->reset_work);
 	flush_work(&dev->scan_work);
+
+	/*
+	 * If the controller can't do IO (surprise removal, for example), we
+	 * need to halt queues prior to deleting namespaces. This ends
+	 * outstanding requests and prevents attempts to sync dirty data.
+	 */
+	if (nvme_io_incapable(&dev->ctrl))
+		nvme_dev_disable(dev, true);
+
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, true);
-- 
2.6.2.307.g37023ba
