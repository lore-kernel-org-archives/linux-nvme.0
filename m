From: sagig@mellanox.com (Sagi Grimberg)
Date: Thu, 24 Dec 2015 13:24:00 +0200
Subject: [PATCH RFC 3/4] nvme: Move IO termination code to the core
In-Reply-To: <1450956241-4626-1-git-send-email-sagig@mellanox.com>
References: <1450956241-4626-1-git-send-email-sagig@mellanox.com>
Message-ID: <1450956241-4626-4-git-send-email-sagig@mellanox.com>

We'll need IO termination helpers also for other transports,
so move this code to the core. The difference is that we are
iterating on tagsets and not queues. We distinguish between
io and admin commands because each might be needed for different
flows (and they iterate on different tagsets).

Note, we changed nvme_queue_cancel_ios name to nvme_cancel_io
as there is no concept of a queue now in this function (we
also lost the print).

Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
---
 drivers/nvme/host/core.c |   14 ++++++++++++++
 drivers/nvme/host/nvme.h |    4 ++++
 drivers/nvme/host/pci.c  |   22 +++++++---------------
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 31aa8ed..2c1109b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -499,6 +499,20 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl);
 
+void nvme_fail_admin_cmds(struct nvme_ctrl *ctrl,
+		busy_tag_iter_fn *terminate_io, void *priv)
+{
+	blk_mq_tagset_busy_iter(ctrl->admin_tagset, terminate_io, priv);
+}
+EXPORT_SYMBOL_GPL(nvme_fail_admin_cmds);
+
+void nvme_fail_io_cmds(struct nvme_ctrl *ctrl,
+		busy_tag_iter_fn *terminate_io, void *priv)
+{
+	blk_mq_tagset_busy_iter(ctrl->tagset, terminate_io, priv);
+}
+EXPORT_SYMBOL_GPL(nvme_fail_io_cmds);
+
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
 	struct nvme_user_io io;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2e3475e..baf67d9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -246,6 +246,10 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int count);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap, unsigned page_shift);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
+void nvme_fail_admin_cmds(struct nvme_ctrl *ctrl,
+		busy_tag_iter_fn *terminate_io, void *priv);
+void nvme_fail_io_cmds(struct nvme_ctrl *ctrl,
+		busy_tag_iter_fn *terminate_io, void *priv);
 
 extern spinlock_t dev_list_lock;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0d78b3a..a74f68c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -984,16 +984,15 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	return BLK_EH_RESET_TIMER;
 }
 
-static void nvme_cancel_queue_ios(struct request *req, void *data, bool reserved)
+static void nvme_cancel_io(struct request *req, void *data, bool reserved)
 {
-	struct nvme_queue *nvmeq = data;
+	struct nvme_dev *dev = data;
 	u16 status = NVME_SC_ABORT_REQ;
 
 	if (!blk_mq_request_started(req))
 		return;
 
-	dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d QID %d\n",
-						req->tag, nvmeq->qid);
+	dev_warn(dev->dev, "Cancelling I/O %d\n", req->tag);
 
 	if (blk_queue_dying(req->q))
 		status |= NVME_SC_DNR;
@@ -1049,14 +1048,6 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	return 0;
 }
 
-static void nvme_clear_queue(struct nvme_queue *nvmeq)
-{
-	spin_lock_irq(&nvmeq->q_lock);
-	if (nvmeq->tags && *nvmeq->tags)
-		blk_mq_all_tag_busy_iter(*nvmeq->tags, nvme_cancel_queue_ios, nvmeq);
-	spin_unlock_irq(&nvmeq->q_lock);
-}
-
 static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 {
 	struct nvme_queue *nvmeq = dev->queues[qid];
@@ -1712,7 +1703,8 @@ static void nvme_wait_dq(struct nvme_delq_ctx *dq, struct nvme_dev *dev)
 			set_current_state(TASK_RUNNING);
 			nvme_disable_ctrl(&dev->ctrl,
 				lo_hi_readq(dev->bar + NVME_REG_CAP));
-			nvme_clear_queue(dev->queues[0]);
+			nvme_fail_admin_cmds(&dev->ctrl,
+				nvme_cancel_io, dev);
 			flush_kthread_worker(dq->worker);
 			nvme_disable_queue(dev, 0);
 			return;
@@ -1929,8 +1921,8 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	}
 	nvme_dev_unmap(dev);
 
-	for (i = dev->queue_count - 1; i >= 0; i--)
-		nvme_clear_queue(dev->queues[i]);
+	nvme_fail_io_cmds(&dev->ctrl, nvme_cancel_io, dev);
+	nvme_fail_admin_cmds(&dev->ctrl, nvme_cancel_io, dev);
 }
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
-- 
1.7.1
