From: keith.busch@intel.com (Keith Busch)
Date: Mon,  2 May 2016 11:12:06 -0600
Subject: [PATCH-4.7 1/3] NVMe: Return ENODEV error on invalid namespace
In-Reply-To: <1462209128-12376-1-git-send-email-keith.busch@intel.com>
References: <1462209128-12376-1-git-send-email-keith.busch@intel.com>
Message-ID: <1462209128-12376-2-git-send-email-keith.busch@intel.com>

If there is no namespace associated with the request, return an error
code that notifies the application the device isn't there.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/nvme.h | 2 ++
 drivers/nvme/host/pci.c  | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 114b928..48c7f3c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -193,6 +193,8 @@ static inline int nvme_error_status(u16 status)
 	switch (status & 0x7ff) {
 	case NVME_SC_SUCCESS:
 		return 0;
+	case NVME_SC_INVALID_NS:
+		return -ENODEV;
 	case NVME_SC_CAP_EXCEEDED:
 		return -ENOSPC;
 	default:
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 783845c..f99833b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -600,7 +600,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		if (ns && !test_bit(NVME_NS_DEAD, &ns->flags))
 			ret = BLK_MQ_RQ_QUEUE_BUSY;
 		else
-			ret = BLK_MQ_RQ_QUEUE_ERROR;
+			blk_mq_end_request(req, -ENODEV);
 		spin_unlock_irq(&nvmeq->q_lock);
 		goto out;
 	}
@@ -931,7 +931,7 @@ static void nvme_cancel_io(struct request *req, void *data, bool reserved)
 
 	status = NVME_SC_ABORT_REQ;
 	if (blk_queue_dying(req->q))
-		status |= NVME_SC_DNR;
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 	blk_mq_complete_request(req, status);
 }
 
-- 
2.7.2
