From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 16:00:26 -0700
Subject: [PATCH 2/2] NVMe: NULL pointer check for admin queues
In-Reply-To: <1455231626-7166-1-git-send-email-keith.busch@intel.com>
References: <1455231626-7166-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455231626-7166-2-git-send-email-keith.busch@intel.com>

Admin commands don't have a namespace, so don't check the state when
there isn't one.

An admin command that does happen to make it to a disabled queue can
failed immediatly: Initialization commands should not be requeued
across resets as they would mess up the controller if/when it is
reinitialized. If a user command made hits this condition, it should
be able to handle this error as that's the existing result for commands
when the controller is reset with outstanding admin commands.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 24a7972..44ccd23 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -678,7 +678,12 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	spin_lock_irq(&nvmeq->q_lock);
 	if (unlikely(nvmeq->cq_vector < 0)) {
-		ret = test_bit(NVME_NS_DEAD, &ns->flags) ?
+		/*
+		 * Admin commands need to fail immediatly when device is
+		 * disabled: initialization commands should not requeue
+		 * across resets.
+		 */
+		ret = !ns || test_bit(NVME_NS_DEAD, &ns->flags) ?
 					BLK_MQ_RQ_QUEUE_ERROR :
 					BLK_MQ_RQ_QUEUE_BUSY;
 		spin_unlock_irq(&nvmeq->q_lock);
-- 
2.6.2.307.g37023ba
