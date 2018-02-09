From: keith.busch@intel.com (Keith Busch)
Date: Fri,  9 Feb 2018 10:41:27 -0700
Subject: [PATCH 3/3] nvme: Fail controller on timeouts during reset
In-Reply-To: <20180209174127.7224-1-keith.busch@intel.com>
References: <20180209174127.7224-1-keith.busch@intel.com>
Message-ID: <20180209174127.7224-3-keith.busch@intel.com>

We can't schedule a second controller reset if the controller fails while
the driver is already attempting to start it. Synchronous admin commands
are already handled appropriately since they are never retried and the
completion status is read directly. Asynchronous IO commands, however,
were previously undetected.

This patch fixes that by preventing retries on IO commands during
controller connecting states, and directing the controller to a failed
state after aborting the timed out commands. Without this patch, a
controller that fails IO commands during start up would hang indefinitely.

Reported-by: Jianchao Wang <jianchao.w.wang at oracle.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 6 ++++--
 drivers/nvme/host/pci.c  | 6 +++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a9bce23a991f..c0f4771d79a2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -240,13 +240,15 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
 void nvme_cancel_request(struct request *req, void *data, bool reserved)
 {
+	struct nvme_ctrl *ctrl = data;
 	if (!blk_mq_request_started(req))
 		return;
 
-	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
-				"Cancelling I/O %d", req->tag);
+	dev_dbg_ratelimited(ctrl->device, "Cancelling I/O %d", req->tag);
 
 	nvme_req(req)->status = NVME_SC_ABORT_REQ;
+	if (ctrl->state == NVME_CTRL_CONNECTING)
+		nvme_req(req)->status |= NVME_SC_DNR;
 	blk_mq_complete_request(req);
 
 }
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7a2e4383c468..77929d35eae8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1212,11 +1212,15 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	/*
 	 * Shutdown immediately if controller times out while starting. The
 	 * reset work will see the pci device disabled when it gets the forced
-	 * cancellation error. All outstanding requests are completed on
+	 * cancellation error. The driver won't see the status if it is waiting
+	 * on asynchronous comands, so we set the state to deleting to prevent
+	 * it from progressing. All outstanding requests are completed on
 	 * shutdown, so we return BLK_EH_HANDLED.
 	 */
 	switch (dev->ctrl.state) {
 	case NVME_CTRL_CONNECTING:
+		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
+		/* FALLTHRU */
 	case NVME_CTRL_RESETTING:
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
-- 
2.14.3
