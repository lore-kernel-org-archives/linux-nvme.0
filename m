From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 13:05:47 -0700
Subject: [PATCHv2-4.5 10/10] NVMe: Rate limit nvme IO warnings
In-Reply-To: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455221147-24228-11-git-send-email-keith.busch@intel.com>

We don't need to spam the kernel logs with thousands of IO cancelling
messages. We can infer all IO's are being cancelled with fewer, or
even none at all. This patch rate limits the message and uses the debug
log level as it is mainly used for testing purposes.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4de17ae..1b0e447 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1005,7 +1005,7 @@ static void nvme_cancel_queue_ios(struct request *req, void *data, bool reserved
 	if (!blk_mq_request_started(req))
 		return;
 
-	dev_warn(nvmeq->q_dmadev,
+	dev_dbg_ratelimited(nvmeq->q_dmadev,
 		 "Cancelling I/O %d QID %d\n", req->tag, nvmeq->qid);
 
 	status = NVME_SC_ABORT_REQ;
-- 
2.6.2.307.g37023ba
