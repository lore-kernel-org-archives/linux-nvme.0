From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Tue,  9 Jan 2018 10:03:13 +0800
Subject: [PATCH V2 2/2] nvme-pci: fix the timeout case when reset is ongoing
In-Reply-To: <1515463393-3004-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1515463393-3004-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1515463393-3004-3-git-send-email-jianchao.w.wang@oracle.com>

There could be request timeout when the reset is ongoing.
nvme_timeout will not only meet the admin requests from the
initializing procedure, but also the IO and admin requests
from previous work before nvme_dev_disable is invoked. These
requests should be handled separately.

We could distinguish them through the ctrl->state.
If the state is NVME_CTRL_RESET_PREPARE,  handle the expried
requests as nvme_cancel_request.
If the state is NVME_CTRL_RESETTING, the requests should be
from the initializing procedure. Handle them as before. Because the
nvme_reset_work will see the error and disable the dev itself, so
discard the nvme_dev_disable here.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e477c35..2947757 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1212,19 +1212,26 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	}
 
 	/*
-	 * Shutdown immediately if controller times out while starting. The
-	 * reset work will see the pci device disabled when it gets the forced
-	 * cancellation error. All outstanding requests are completed on
-	 * shutdown, so we return BLK_EH_HANDLED.
+	 * There could be two kinds of expired reqs when reset is ongoing.
+	 * Outstanding IO or admin requests from previous work before the
+	 * nvme_reset_work invokes nvme_dev_disable. Handle them as the
+	 * nvme_cancel_request. Outstanding admin requests from the
+	 * initializing procedure. Set NVME_REQ_CANCELLED flag on them,
+	 * then nvme_reset_work will see the error, then disable the device
+	 * and remove the ctrl.
 	 */
-	if (dev->ctrl.state == NVME_CTRL_RESETTING) {
-		dev_warn(dev->ctrl.device,
-			 "I/O %d QID %d timeout, disable controller\n",
-			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
+	switch (dev->ctrl.state) {
+	case NVME_CTRL_RESET_PREPARE:
+		nvme_req(req)->status = NVME_SC_ABORT_REQ;
+		return BLK_EH_HANDLED;
+	case NVME_CTRL_RESETTING:
+		WARN_ON_ONCE(nvmeq->qid);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_HANDLED;
+	default:
+		break;
 	}
+
 	/*
  	 * Shutdown the controller immediately and schedule a reset if the
  	 * command was already aborted once before and still hasn't been
-- 
2.7.4
