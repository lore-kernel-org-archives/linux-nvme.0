From: hch@lst.de (Christoph Hellwig)
Date: Thu,  7 May 2015 09:38:14 +0200
Subject: [PATCH 2/2] nvme: disable irqs in nvme_freeze_queues
In-Reply-To: <1430984294-25859-1-git-send-email-hch@lst.de>
References: <1430984294-25859-1-git-send-email-hch@lst.de>
Message-ID: <1430984294-25859-3-git-send-email-hch@lst.de>

The queue_lock needs to be taken with irqs disabled.  This is mostly
due to the old pre blk-mq usage pattern, but we've also picked it up
in most of the few places where we use the queue_lock with blk-mq.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 85b8036..00e6419 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2585,9 +2585,9 @@ static void nvme_freeze_queues(struct nvme_dev *dev)
 	list_for_each_entry(ns, &dev->namespaces, list) {
 		blk_mq_freeze_queue_start(ns->queue);
 
-		spin_lock(ns->queue->queue_lock);
+		spin_lock_irq(ns->queue->queue_lock);
 		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
-		spin_unlock(ns->queue->queue_lock);
+		spin_unlock_irq(ns->queue->queue_lock);
 
 		blk_mq_cancel_requeue_work(ns->queue);
 		blk_mq_stop_hw_queues(ns->queue);
-- 
1.9.1
