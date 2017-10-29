From: hch@lst.de (Christoph Hellwig)
Date: Sun, 29 Oct 2017 10:44:30 +0200
Subject: [PATCH 4/5] nvme-rdma: remove nvme_rdma_remove_ctrl
In-Reply-To: <20171029084431.8702-1-hch@lst.de>
References: <20171029084431.8702-1-hch@lst.de>
Message-ID: <20171029084431.8702-5-hch@lst.de>

It is only used in two places, and some of the work done by it will
be taken into common code soon.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/rdma.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5175b465997d..a3521b852ea8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1755,18 +1755,13 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 	nvme_rdma_destroy_admin_queue(ctrl, shutdown);
 }
 
-static void nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl)
-{
-	nvme_remove_namespaces(&ctrl->ctrl);
-	nvme_rdma_shutdown_ctrl(ctrl, true);
-	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_put_ctrl(&ctrl->ctrl);
-}
-
 static void nvme_rdma_delete_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_stop_ctrl(ctrl);
-	nvme_rdma_remove_ctrl(to_rdma_ctrl(ctrl));
+	nvme_remove_namespaces(ctrl);
+	nvme_rdma_shutdown_ctrl(to_rdma_ctrl(ctrl), true);
+	nvme_uninit_ctrl(ctrl);
+	nvme_put_ctrl(ctrl);
 }
 
 static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
@@ -1802,7 +1797,10 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 
 out_fail:
 	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
-	nvme_rdma_remove_ctrl(ctrl);
+	nvme_remove_namespaces(&ctrl->ctrl);
+	nvme_rdma_shutdown_ctrl(ctrl, true);
+	nvme_uninit_ctrl(&ctrl->ctrl);
+	nvme_put_ctrl(&ctrl->ctrl);
 }
 
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
-- 
2.14.2
