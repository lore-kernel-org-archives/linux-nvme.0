From: sagig@mellanox.com (Sagi Grimberg)
Date: Thu, 10 Mar 2016 13:58:47 +0200
Subject: [PATCH v3 for-4.6 2/4] nvme: Use blk-mq helper for IO termination
In-Reply-To: <1457611129-8036-1-git-send-email-sagig@mellanox.com>
References: <1457611129-8036-1-git-send-email-sagig@mellanox.com>
Message-ID: <1457611129-8036-3-git-send-email-sagig@mellanox.com>

blk-mq offers a tagset iterator so let's use that
instead of using nvme_clear_queues.

Note, we changed nvme_queue_cancel_ios name to nvme_cancel_io
as there is no concept of a queue now in this function (we
also lost the print).

Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Acked-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/pci.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e9f18e1d73e5..b713b390aa4f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -982,16 +982,15 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	return BLK_EH_RESET_TIMER;
 }
 
-static void nvme_cancel_queue_ios(struct request *req, void *data, bool reserved)
+static void nvme_cancel_io(struct request *req, void *data, bool reserved)
 {
-	struct nvme_queue *nvmeq = data;
+	struct nvme_dev *dev = data;
 	int status;
 
 	if (!blk_mq_request_started(req))
 		return;
 
-	dev_warn(nvmeq->dev->ctrl.device,
-		 "Cancelling I/O %d QID %d\n", req->tag, nvmeq->qid);
+	dev_warn(dev->ctrl.device, "Cancelling I/O %d\n", req->tag);
 
 	status = NVME_SC_ABORT_REQ;
 	if (blk_queue_dying(req->q))
@@ -1048,14 +1047,6 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	return 0;
 }
 
-static void nvme_clear_queue(struct nvme_queue *nvmeq)
-{
-	spin_lock_irq(&nvmeq->q_lock);
-	if (nvmeq->tags && *nvmeq->tags)
-		blk_mq_all_tag_busy_iter(*nvmeq->tags, nvme_cancel_queue_ios, nvmeq);
-	spin_unlock_irq(&nvmeq->q_lock);
-}
-
 static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 {
 	struct nvme_queue *nvmeq = dev->queues[0];
@@ -1779,8 +1770,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	}
 	nvme_dev_unmap(dev);
 
-	for (i = dev->queue_count - 1; i >= 0; i--)
-		nvme_clear_queue(dev->queues[i]);
+	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_io, dev);
+	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_io, dev);
 	mutex_unlock(&dev->shutdown_lock);
 }
 
-- 
1.8.4.3
