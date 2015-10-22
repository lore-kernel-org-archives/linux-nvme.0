From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 14:03:36 +0200
Subject: [PATCH 4/9] nvme: do not restart the request timeout if we're
 resetting the controller
In-Reply-To: <1445515421-4940-1-git-send-email-hch@lst.de>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
Message-ID: <1445515421-4940-5-git-send-email-hch@lst.de>

Otherwise we're never going to complete a command when it is restarted just
after we completed all other outstanding commands in nvme_clear_queue.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 644256c..a3250b8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1063,7 +1063,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 				 req->tag, nvmeq->qid);
 		}
 		spin_unlock_irq(&dev_list_lock);
-		return BLK_EH_RESET_TIMER;
+
+		req->errors = -EIO;
+		return BLK_EH_HANDLED;
 	}
 
 	if (!dev->ctrl.abort_limit)
-- 
1.9.1
