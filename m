From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 14:03:34 +0200
Subject: [PATCH 2/9] nvme: don't take the I/O queue q_lock in nvme_timeout
In-Reply-To: <1445515421-4940-1-git-send-email-hch@lst.de>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
Message-ID: <1445515421-4940-3-git-send-email-hch@lst.de>

There is nothing it protects, but it makes lockdep unhappy in many different
ways.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fd53420..11bba95 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1057,13 +1057,13 @@ static void nvme_abort_req(struct request *req)
 	struct nvme_command cmd;
 
 	if (!nvmeq->qid || cmd_rq->aborted) {
-		spin_lock(&dev_list_lock);
+		spin_lock_irq(&dev_list_lock);
 		if (!__nvme_reset(dev)) {
 			dev_warn(dev->dev,
 				 "I/O %d QID %d timeout, reset controller\n",
 				 req->tag, nvmeq->qid);
 		}
-		spin_unlock(&dev_list_lock);
+		spin_unlock_irq(&dev_list_lock);
 		return;
 	}
 
@@ -1127,9 +1127,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 
 	dev_warn(nvmeq->q_dmadev, "Timeout I/O %d QID %d\n", req->tag,
 							nvmeq->qid);
-	spin_lock_irq(&nvmeq->q_lock);
 	nvme_abort_req(req);
-	spin_unlock_irq(&nvmeq->q_lock);
 
 	/*
 	 * The aborted req will be completed on receiving the abort req.
-- 
1.9.1
