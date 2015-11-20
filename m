From: hch@lst.de (Christoph Hellwig)
Date: Fri, 20 Nov 2015 17:35:22 +0100
Subject: [PATCH 27/47] nvme: do not restart the request timeout if we're
 resetting the controller
In-Reply-To: <1448037342-18384-1-git-send-email-hch@lst.de>
References: <1448037342-18384-1-git-send-email-hch@lst.de>
Message-ID: <1448037342-18384-28-git-send-email-hch@lst.de>

Otherwise we're never going to complete a command when it is restarted just
after we completed all other outstanding commands in nvme_clear_queue.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 58cff75..9a6e47e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1092,7 +1092,13 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 				 req->tag, nvmeq->qid);
 		}
 		spin_unlock_irq(&dev_list_lock);
-		return BLK_EH_RESET_TIMER;
+
+		/*
+		 * Mark the request as quiesced, that is don't do anything with
+		 * it until the error completion from the controller reset
+		 * comes in.
+		 */
+		return BLK_EH_QUIESCED;
 	}
 
 	if (!dev->ctrl.abort_limit)
-- 
1.9.1
