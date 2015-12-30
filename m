From: keith.busch@intel.com (Keith Busch)
Date: Wed, 30 Dec 2015 10:27:48 -0700
Subject: [PATCH 2/5] NVMe: Use a retryable error code on reset
In-Reply-To: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
Message-ID: <1451496471-29370-3-git-send-email-keith.busch@intel.com>

Use a fake status that can potentially be retried on reset.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2e6e665..3abcb3a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1017,7 +1017,7 @@ static void nvme_cancel_queue_ios(struct request *req, void *data, bool reserved
 	dev_warn(nvmeq->q_dmadev,
 		 "Cancelling I/O %d QID %d\n", req->tag, nvmeq->qid);
 
-	status = NVME_SC_CANCELLED;
+	status = NVME_SC_ABORT_REQ;
 	if (blk_queue_dying(req->q))
 		status |= NVME_SC_DNR;
 	blk_mq_complete_request(req, status);
-- 
2.6.2.307.g37023ba
