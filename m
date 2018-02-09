From: keith.busch@intel.com (Keith Busch)
Date: Fri,  9 Feb 2018 10:41:25 -0700
Subject: [PATCH 1/3] nvme-pci: Fix timeouts in connecting state
Message-ID: <20180209174127.7224-1-keith.busch@intel.com>

We need to halt the controller immediately if we haven't completed
initialization as indicated by the new "connecting" state.

Fixes: ad70062cdb ("nvme-pci: introduce RECONNECTING state to mark initializing procedure")
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ab9c19525fa8..90e276c05f79 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1215,13 +1215,17 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 * cancellation error. All outstanding requests are completed on
 	 * shutdown, so we return BLK_EH_HANDLED.
 	 */
-	if (dev->ctrl.state == NVME_CTRL_RESETTING) {
+	switch (dev->ctrl.state) {
+	case NVME_CTRL_CONNECTING:
+	case NVME_CTRL_RESETTING:
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_dev_disable(dev, false);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_HANDLED;
+	default:
+		break;
 	}
 
 	/*
-- 
2.14.3
