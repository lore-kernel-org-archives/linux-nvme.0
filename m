From: hch@lst.de (Christoph Hellwig)
Date: Fri, 20 Nov 2015 17:35:20 +0100
Subject: [PATCH 25/47] nvme: don't take the I/O queue q_lock in nvme_timeout
In-Reply-To: <1448037342-18384-1-git-send-email-hch@lst.de>
References: <1448037342-18384-1-git-send-email-hch@lst.de>
Message-ID: <1448037342-18384-26-git-send-email-hch@lst.de>

There is nothing it protects, but it makes lockdep unhappy in many different
ways.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c8e381b..df3ddeb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1086,13 +1086,13 @@ static void nvme_abort_req(struct request *req)
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
 
@@ -1156,9 +1156,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 
 	dev_warn(nvmeq->q_dmadev, "Timeout I/O %d QID %d\n", req->tag,
 							nvmeq->qid);
-	spin_lock_irq(&nvmeq->q_lock);
 	nvme_abort_req(req);
-	spin_unlock_irq(&nvmeq->q_lock);
 
 	/*
 	 * The aborted req will be completed on receiving the abort req.
-- 
1.9.1
