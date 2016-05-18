From: mlin@kernel.org (Ming Lin)
Date: Tue, 17 May 2016 22:56:59 -0700
Subject: [PATCH 2/2] nvme: move nvme_cancel_io() to core.c
In-Reply-To: <1463551019-16687-1-git-send-email-mlin@kernel.org>
References: <1463551019-16687-1-git-send-email-mlin@kernel.org>
Message-ID: <1463551019-16687-3-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

So it can be used by Fabrics driver also.

Signed-off-by: Ming Lin <ming.l at samsung.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 17 +++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 16 ----------------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ac950d1..4f971ed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -59,6 +59,23 @@ static DEFINE_SPINLOCK(dev_list_lock);
 
 static struct class *nvme_class;
 
+void nvme_cancel_io(struct request *req, void *data, bool reserved)
+{
+	struct nvme_ctrl *ctrl = data;
+	int status;
+
+	if (!blk_mq_request_started(req))
+		return;
+
+	dev_dbg_ratelimited(ctrl->device, "Cancelling I/O %d", req->tag);
+
+	status = NVME_SC_ABORT_REQ;
+	if (blk_queue_dying(req->q))
+		status |= NVME_SC_DNR;
+	blk_mq_complete_request(req, status);
+}
+EXPORT_SYMBOL_GPL(nvme_cancel_io);
+
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fab6507..ff234bd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -229,6 +229,7 @@ static inline bool nvme_req_needs_retry(struct request *req, u16 status)
 		(jiffies - req->start_time) < req->timeout;
 }
 
+void nvme_cancel_io(struct request *req, void *data, bool reserved);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a2481ff..d3471e4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -925,22 +925,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	return BLK_EH_RESET_TIMER;
 }
 
-static void nvme_cancel_io(struct request *req, void *data, bool reserved)
-{
-	struct nvme_ctrl *ctrl = data;
-	int status;
-
-	if (!blk_mq_request_started(req))
-		return;
-
-	dev_dbg_ratelimited(ctrl->device, "Cancelling I/O %d", req->tag);
-
-	status = NVME_SC_ABORT_REQ;
-	if (blk_queue_dying(req->q))
-		status |= NVME_SC_DNR;
-	blk_mq_complete_request(req, status);
-}
-
 static void nvme_free_queue(struct nvme_queue *nvmeq)
 {
 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
-- 
1.9.1
