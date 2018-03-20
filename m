From: nitzanc@mellanox.com (Nitzan Carmi)
Date: Tue, 20 Mar 2018 11:07:30 +0000
Subject: [PATCH 2/2] nvme: Add .stop_ctrl to nvme ctrl ops
In-Reply-To: <20180320110730.24070-1-nitzanc@mellanox.com>
References: <20180320110730.24070-1-nitzanc@mellanox.com>
Message-ID: <20180320110730.24070-2-nitzanc@mellanox.com>

For consistancy reasons, any fabric-specific works
(e.g error recovery/reconnect) should be canceled in
nvme_stop_ctrl, as for all other NVMe pending works
(e.g. scan, keep alive).

The patch aims to simplify the logic of the code, as
we now only rely on a vague demand from any fabric
to flush its private workqueues at the beginning of
.delete_ctrl op.

Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c |  2 ++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/rdma.c | 12 +++++++++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 832c51a..17e0fdd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3336,6 +3336,8 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
 	cancel_work_sync(&ctrl->fw_act_work);
+	if (ctrl->ops->stop_ctrl)
+		ctrl->ops->stop_ctrl(ctrl);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 133b783..4adb413 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -298,6 +298,7 @@ struct nvme_ctrl_ops {
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 	int (*reinit_request)(void *data, struct request *rq);
+	void (*stop_ctrl)(struct nvme_ctrl *ctrl);
 };
 
 static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 987691c..535a4b4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -871,6 +871,14 @@ out_free_io_queues:
 	return ret;
 }
 
+static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+
+	cancel_work_sync(&ctrl->err_work);
+	cancel_delayed_work_sync(&ctrl->reconnect_work);
+}
+
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -1723,9 +1731,6 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 
 static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
-	cancel_work_sync(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->reconnect_work);
-
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
@@ -1803,6 +1808,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.submit_async_event	= nvme_rdma_submit_async_event,
 	.delete_ctrl		= nvme_rdma_delete_ctrl,
 	.get_address		= nvmf_get_address,
+	.stop_ctrl		= nvme_rdma_stop_ctrl,
 };
 
 static inline bool
-- 
1.8.2.3
