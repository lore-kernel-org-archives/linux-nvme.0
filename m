From: keith.busch@intel.com (Keith Busch)
Date: Tue, 30 Apr 2019 09:33:40 -0600
Subject: [PATCH 1/2] nvme/pci: Shutdown on timeout during deletion
Message-ID: <20190430153341.25433-1-keith.busch@intel.com>

We do not restart a controller in a deleting state for timeout errors.
When in this state, unblock potential request dispatchers with failed
completions by shutting down the controller on timeout detection.

Reported-by: Yufen Yu <yuyufen at huawei.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c1eecde6b853..c5a997727c4f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1276,6 +1276,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *abort_req;
 	struct nvme_command cmd;
+	bool shutdown = false;
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
 	/* If PCI error recovery process is happening, we cannot reset or
@@ -1312,12 +1313,14 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 * shutdown, so we return BLK_EH_DONE.
 	 */
 	switch (dev->ctrl.state) {
+	case NVME_CTRL_DELETING:
+		shutdown = true;
 	case NVME_CTRL_CONNECTING:
 	case NVME_CTRL_RESETTING:
 		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, shutdown);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_DONE;
 	default:
-- 
2.14.4
