From: keith.busch@intel.com (Keith Busch)
Date: Fri, 10 Feb 2017 18:15:52 -0500
Subject: [PATCH 4/5] nvme/pci: No special case for queue busy on IO
In-Reply-To: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
Message-ID: <1486768553-13738-5-git-send-email-keith.busch@intel.com>

This driver previously required we have a special check for IO submitted
to nvme IO queues that are temporarily suspended. That is no longer
necessary since blk-mq provides a quiesce, so any IO that actually gets
submitted to such a queue must be ended since the queue isn't going to
start back up.

This is fixing a condition where we have fewer IO queues after a
controller reset. This may happen if the number of CPU's has changed,
or controller firmware update changed the queue count, for example.

While it may be possible to complete the IO on a different queue, the
block layer does not provide a way to resubmit a request on a different
hardware context once the request has entered the queue. We don't want
these requests to be stuck indefinitely either, so ending them in error
is our only option at the moment.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 52cca9f..92010fd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -613,10 +613,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	spin_lock_irq(&nvmeq->q_lock);
 	if (unlikely(nvmeq->cq_vector < 0)) {
-		if (ns && !test_bit(NVME_NS_DEAD, &ns->flags))
-			ret = BLK_MQ_RQ_QUEUE_BUSY;
-		else
-			ret = BLK_MQ_RQ_QUEUE_ERROR;
+		ret = BLK_MQ_RQ_QUEUE_ERROR;
 		spin_unlock_irq(&nvmeq->q_lock);
 		goto out_cleanup_iod;
 	}
-- 
1.8.3.1
