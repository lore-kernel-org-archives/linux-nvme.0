From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Thu, 18 Jan 2018 18:10:02 +0800
Subject: [PATCH V5 2/2] nvme-pci: fixup the timeout case when reset is ongoing
In-Reply-To: <1516270202-8051-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1516270202-8051-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1516270202-8051-3-git-send-email-jianchao.w.wang@oracle.com>

Look at the following scenario.
nvme_reset_ctrl
  -> set state to RESETTING
  -> queue reset_work
     (scheduling)
nvme_reset_work
  -> nvme_dev_disable
    -> quiesce queues
    -> nvme_cancel_request
       on outstanding requests
    -> set state to RECONNECTING
    -> nvme initializing
       (will issue request on adminq)
A request could expire after the ctrl state is set to RESETTING
and queue the reset_work.
 - If the timeout occurs before state RECONNECTING, the expired
   requests are from the previous work.
 - Otherwise, the expired requests are from the controller
   initializing procedure, such as sending cq/sq create commands
   to adminq to setup io queues.
In current implementation, nvme_timeout only handles second case
above.

To fix this, when the state is RESETTING, handle the expired
requests as nvme_cancel_request, when the state is RECONNECTING,
handle it as the original method and discard the nvme_dev_disable
there, the nvme_reset_work will see the error and invoke itself.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 05344be..a9b2359 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1210,18 +1210,24 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	}
 
 	/*
-	 * Shutdown immediately if controller times out while starting. The
-	 * reset work will see the pci device disabled when it gets the forced
-	 * cancellation error. All outstanding requests are completed on
-	 * shutdown, so we return BLK_EH_HANDLED.
+	 * - When the ctrl.state is NVME_CTRL_RESETTING, the expired
+	 *   request should come from the previous work and we handle
+	 *   it as nvme_cancel_request.
+	 * - When the ctrl.state is NVME_CTRL_RECONNECTING, the expired
+	 *   request should come from the initializing procedure such as
+	 *   setup io queues, because all the previous outstanding
+	 *   requests should have been cancelled.
 	 */
-	if (dev->ctrl.state == NVME_CTRL_RESETTING) {
-		dev_warn(dev->ctrl.device,
-			 "I/O %d QID %d timeout, disable controller\n",
-			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
+	switch (dev->ctrl.state) {
+	case NVME_CTRL_RESETTING:
+		nvme_req(req)->status = NVME_SC_ABORT_REQ;
+		return BLK_EH_HANDLED;
+	case NVME_CTRL_RECONNECTING:
+		WARN_ON_ONCE(nvmeq->qid);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_HANDLED;
+	default:
+		break;
 	}
 
 	/*
-- 
2.7.4
