From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Feb 2016 11:17:30 -0700
Subject: [PATCH for-4.5 13/13] NVMe: Rate limit nvme IO warnings
In-Reply-To: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455128250-5984-14-git-send-email-keith.busch@intel.com>

We don't need to spam the kernel logs with thousands of messages. We
can infer all IO's are being cancelled with fewer messages.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 18c14f6..4d3b3d0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1005,7 +1005,7 @@ static void nvme_cancel_queue_ios(struct request *req, void *data, bool reserved
 	if (!blk_mq_request_started(req))
 		return;
 
-	dev_warn(nvmeq->q_dmadev,
+	dev_warn_ratelimited(nvmeq->q_dmadev,
 		 "Cancelling I/O %d QID %d\n", req->tag, nvmeq->qid);
 
 	status = NVME_SC_ABORT_REQ;
-- 
2.6.2.307.g37023ba
