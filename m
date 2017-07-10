From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 09:22:38 +0300
Subject: [PATCH 11/12] nvme-rdma: cleanup error path in controller reset
In-Reply-To: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
References: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499667759-15965-12-git-send-email-sagi@grimberg.me>

No need to queue an extra work to indirect controller
removal, just call a ctrl remove routine.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8f8a4ecef82f..bd0d9f7a04ec 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1749,13 +1749,10 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 	nvme_rdma_destroy_admin_queue(ctrl, shutdown);
 }
 
-static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
+static void nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl)
 {
-	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_remove_namespaces(&ctrl->ctrl);
-	if (shutdown)
-		nvme_rdma_shutdown_ctrl(ctrl, shutdown);
-
+	nvme_rdma_shutdown_ctrl(ctrl, true);
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	nvme_put_ctrl(&ctrl->ctrl);
 }
@@ -1765,7 +1762,8 @@ static void nvme_rdma_del_ctrl_work(struct work_struct *work)
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 				struct nvme_rdma_ctrl, delete_work);
 
-	__nvme_rdma_remove_ctrl(ctrl, true);
+	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_rdma_remove_ctrl(ctrl);
 }
 
 static int __nvme_rdma_del_ctrl(struct nvme_rdma_ctrl *ctrl)
@@ -1797,14 +1795,6 @@ static int nvme_rdma_del_ctrl(struct nvme_ctrl *nctrl)
 	return ret;
 }
 
-static void nvme_rdma_remove_ctrl_work(struct work_struct *work)
-{
-	struct nvme_rdma_ctrl *ctrl = container_of(work,
-				struct nvme_rdma_ctrl, delete_work);
-
-	__nvme_rdma_remove_ctrl(ctrl, false);
-}
-
 static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl =
@@ -1816,16 +1806,13 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	nvme_rdma_shutdown_ctrl(ctrl, false);
 
 	ret = nvme_rdma_configure_admin_queue(ctrl, false);
-	if (ret) {
-		/* ctrl is already shutdown, just remove the ctrl */
-		INIT_WORK(&ctrl->delete_work, nvme_rdma_remove_ctrl_work);
-		goto del_dead_ctrl;
-	}
+	if (ret)
+		goto out_fail;
 
 	if (ctrl->ctrl.queue_count > 1) {
 		ret = nvme_rdma_configure_io_queues(ctrl, false);
 		if (ret)
-			goto del_dead_ctrl;
+			goto out_fail;
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
@@ -1835,10 +1822,9 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 
 	return;
 
-del_dead_ctrl:
-	/* Deleting this dead controller... */
+out_fail:
 	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
-	WARN_ON(!queue_work(nvme_wq, &ctrl->delete_work));
+	nvme_rdma_remove_ctrl(ctrl);
 }
 
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
-- 
2.7.4
