From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 09:22:31 +0300
Subject: [PATCH 04/12] nvme-rdma: disable the controller on resets
In-Reply-To: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
References: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499667759-15965-5-git-send-email-sagi@grimberg.me>

mimic pci driver. Also like pci, some controllers might treat
shutdown more heavily.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7ec9adef6015..496e5b686290 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1672,7 +1672,7 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.timeout	= nvme_rdma_timeout,
 };
 
-static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
 	cancel_work_sync(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->reconnect_work);
@@ -1684,8 +1684,10 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
 		nvme_rdma_free_io_queues(ctrl);
 	}
 
-	if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags))
+	if (shutdown)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
+	else
+		nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
 
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
@@ -1699,7 +1701,7 @@ static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_remove_namespaces(&ctrl->ctrl);
 	if (shutdown)
-		nvme_rdma_shutdown_ctrl(ctrl);
+		nvme_rdma_shutdown_ctrl(ctrl, shutdown);
 
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	if (ctrl->ctrl.tagset) {
@@ -1763,7 +1765,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	bool changed;
 
 	nvme_stop_ctrl(&ctrl->ctrl);
-	nvme_rdma_shutdown_ctrl(ctrl);
+	nvme_rdma_shutdown_ctrl(ctrl, false);
 
 	ret = nvme_rdma_configure_admin_queue(ctrl);
 	if (ret) {
-- 
2.7.4
