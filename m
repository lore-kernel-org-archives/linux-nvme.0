From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 18:21:42 +0300
Subject: [PATCH rfc 08/30] nvme-rdma: cleanup error path in controller reset
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497799324-19598-9-git-send-email-sagi@grimberg.me>

No need to queue an extra work to indirect controller
uninit and put the final reference.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 86998de90f52..099b3d7b6721 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1745,21 +1745,14 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 	nvme_rdma_destroy_admin_queue(ctrl, shutdown);
 }
 
-static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
-{
-	nvme_uninit_ctrl(&ctrl->ctrl);
-	if (shutdown)
-		nvme_rdma_shutdown_ctrl(ctrl, shutdown);
-
-	nvme_put_ctrl(&ctrl->ctrl);
-}
-
 static void nvme_rdma_del_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 				struct nvme_rdma_ctrl, delete_work);
 
-	__nvme_rdma_remove_ctrl(ctrl, true);
+	nvme_uninit_ctrl(&ctrl->ctrl);
+	nvme_rdma_shutdown_ctrl(ctrl, true);
+	nvme_put_ctrl(&ctrl->ctrl);
 }
 
 static int __nvme_rdma_del_ctrl(struct nvme_rdma_ctrl *ctrl)
@@ -1791,14 +1784,6 @@ static int nvme_rdma_del_ctrl(struct nvme_ctrl *nctrl)
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
@@ -1809,16 +1794,13 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	nvme_rdma_shutdown_ctrl(ctrl, false);
 
 	ret = nvme_rdma_configure_admin_queue(ctrl, false);
-	if (ret) {
-		/* ctrl is already shutdown, just remove the ctrl */
-		INIT_WORK(&ctrl->delete_work, nvme_rdma_remove_ctrl_work);
-		goto del_dead_ctrl;
-	}
+	if (ret)
+		goto out_destroy_admin;
 
 	if (ctrl->ctrl.opts->nr_io_queues) {
 		ret = nvme_rdma_configure_io_queues(ctrl, false);
 		if (ret)
-			goto del_dead_ctrl;
+			goto out_destroy_io;
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
@@ -1832,10 +1814,13 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 
 	return;
 
-del_dead_ctrl:
-	/* Deleting this dead controller... */
+out_destroy_io:
+	nvme_rdma_destroy_io_queues(ctrl, true);
+out_destroy_admin:
+	nvme_rdma_destroy_admin_queue(ctrl, true);
 	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
-	WARN_ON(!queue_work(nvme_wq, &ctrl->delete_work));
+	nvme_uninit_ctrl(&ctrl->ctrl);
+	nvme_put_ctrl(&ctrl->ctrl);
 }
 
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
-- 
2.7.4
