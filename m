From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Wed,  3 Jan 2018 06:31:44 +0800
Subject: [PATCH] nvme-pci: fix the timeout case when reset is ongoing
Message-ID: <1514932304-29936-1-git-send-email-jianchao.w.wang@oracle.com>

NVME_CTRL_RESETTING used to indicate the range of nvme initializing
strictly in fd634f41(nvme: merge probe_work and reset_work), but it
is not now. The NVME_CTRL_RESETTING is set before queue the
reset_work, there could be a big gap before the reset work handles
the outstanding requests. So when the NVME_CTRL_RESETTING is set,
nvme_timeout will not only meet the admin requests from the
initializing procedure, but also the IO and admin requests from
previous work before nvme_dev_disable is invoked.

To fix it, introduce a flag NVME_DEV_FLAG_INITIALIZING to mark the
range of initializing. When this flag is not set, handle the expried
requests as nvme_cancel_request. Otherwise, the requests should be
from the initializing procedure. Handle them as before. Because the
nvme_reset_work will see the error and disable the dev itself, so
discard the nvme_dev_disable here.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f5800c3..6e58de1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -99,6 +99,9 @@ struct nvme_dev {
 	struct nvme_ctrl ctrl;
 	struct completion ioq_wait;
 
+	unsigned long flag;
+#define NVME_DEV_FLAG_INITIALIZING 0
+
 	/* shadow doorbell buffer support: */
 	u32 *dbbuf_dbs;
 	dma_addr_t dbbuf_dbs_dma_addr;
@@ -1207,17 +1210,19 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
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
 	if (dev->ctrl.state == NVME_CTRL_RESETTING) {
-		dev_warn(dev->ctrl.device,
-			 "I/O %d QID %d timeout, disable controller\n",
-			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
-		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+		if (test_bit(NVME_DEV_FLAG_INITIALIZING, &dev->flag))
+			nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+		else
+			nvme_req(req)->status = NVME_SC_ABORT_REQ;
 		return BLK_EH_HANDLED;
 	}
 
@@ -2302,6 +2307,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
 		nvme_dev_disable(dev, false);
 
+	set_bit(NVME_DEV_FLAG_INITIALIZING, &dev->flag);
 	result = nvme_pci_enable(dev);
 	if (result)
 		goto out;
@@ -2366,10 +2372,12 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
+	clear_bit(NVME_DEV_FLAG_INITIALIZING, &dev->flag);
 	nvme_start_ctrl(&dev->ctrl);
 	return;
 
  out:
+	clear_bit(NVME_DEV_FLAG_INITIALIZING, &dev->flag);
 	nvme_remove_dead_ctrl(dev, result);
 }
 
-- 
2.7.4
