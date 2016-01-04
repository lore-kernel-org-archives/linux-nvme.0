From: keith.busch@intel.com (Keith Busch)
Date: Mon,  4 Jan 2016 09:10:56 -0700
Subject: [PATCHv3 2/5] NVMe: Use a retryable error code on reset
In-Reply-To: <1451923859-14187-1-git-send-email-keith.busch@intel.com>
References: <1451923859-14187-1-git-send-email-keith.busch@intel.com>
Message-ID: <1451923859-14187-3-git-send-email-keith.busch@intel.com>

A negative status has the "do not retry" bit set, which makes it not
retryable.  Use a fake status that can potentially be retried on reset.

An aborted command's status is overridden by the timeout handler so
that it won't be retried, which is necessary to keep initialization from
getting into a reset loop.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 30ed2ab..ac6c7af 100644
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
