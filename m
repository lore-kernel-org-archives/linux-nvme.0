From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Thu,  8 Mar 2018 14:19:31 +0800
Subject: [PATCH V4 5/5] nvme-pci: add the timeout case for DELETEING state
In-Reply-To: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1520489971-31174-6-git-send-email-jianchao.w.wang@oracle.com>

When the controller is being removed, blk_cleanup_queue will try
to drain the queues. At the moment, if the controller no response,
because of DELETEING state, reset_work will not be able to be
scheduled, and completion of the expired request is deferred to
nvme_dev_disable, blk_cleanup_queue will hang forever. Add case
for DELETEING in nvme_timeout, when abort fails, disable the
controller and complete the request directly.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6c7c19cb..ac9efcd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1261,11 +1261,30 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	}
 
 	if (nvmeq->qid) {
-		if (dev->ctrl.state == NVME_CTRL_RESETTING ||
-				iod->aborted)
+		switch (dev->ctrl.state) {
+		case NVME_CTRL_RESETTING:
 			action = RESET;
-		else
-			action = ABORT;
+			break;
+		case NVME_CTRL_DELETING:
+			/*
+			 * When ctrl is being removed, we try to abort the
+			 * expired request first, if success, it will be
+			 * requeued, otherwise, disable the controller and
+			 * complete it directly, because we cannot schedule
+			 * the reset_work to do recovery in DELELTING state.
+			 */
+			if (iod->aborted)
+				action = DISABLE;
+			else
+				action = ABORT;
+			break;
+		default:
+			if (iod->aborted)
+				action = RESET;
+			else
+				action = ABORT;
+			break;
+		}
 	} else {
 		/*
 		 * Disable immediately if controller times out while disabling/
-- 
2.7.4
