From: sagig@mellanox.com (Sagi Grimberg)
Date: Tue,  2 Feb 2016 14:44:58 +0200
Subject: [PATCH v1 2/3] nvme: Use blk-mq helper for IO termination
In-Reply-To: <1454417099-19332-1-git-send-email-sagig@mellanox.com>
References: <1454417099-19332-1-git-send-email-sagig@mellanox.com>
Message-ID: <1454417099-19332-3-git-send-email-sagig@mellanox.com>

blk-mq offers a tagset iterator so let's use that
instead of using nvme_clear_queues.

Note, we changed nvme_queue_cancel_ios name to nvme_cancel_io
as there is no concept of a queue now in this function (we
also lost the print).

Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Acked-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6e80390d8bd5..7872dd884c6b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -991,16 +991,15 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
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
 
-	dev_warn(nvmeq->q_dmadev,
-		 "Cancelling I/O %d QID %d\n", req->tag, nvmeq->qid);
+	dev_warn(dev->dev, "Cancelling I/O %d\n", req->tag);
 
 	status = NVME_SC_ABORT_REQ;
 	if (blk_queue_dying(req->q))
@@ -1057,14 +1056,6 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
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
@@ -1836,8 +1827,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
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
