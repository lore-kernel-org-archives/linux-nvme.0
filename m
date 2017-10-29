From: hch@lst.de (Christoph Hellwig)
Date: Sun, 29 Oct 2017 10:44:31 +0200
Subject: [PATCH 5/5] nvme: consolidate common code from ->reset_work
In-Reply-To: <20171029084431.8702-1-hch@lst.de>
References: <20171029084431.8702-1-hch@lst.de>
Message-ID: <20171029084431.8702-6-hch@lst.de>

No change in behavior except that the FC code cancels two work items a
little later now.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c   |  4 ++++
 drivers/nvme/host/fc.c     | 13 -------------
 drivers/nvme/host/rdma.c   |  4 ----
 drivers/nvme/target/loop.c |  4 ----
 4 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d835ac05bbf7..4fa748c9a3f6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -102,7 +102,11 @@ static void nvme_delete_ctrl_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, delete_work);
 
+	nvme_stop_ctrl(ctrl);
+	nvme_remove_namespaces(ctrl);
 	ctrl->ops->delete_ctrl(ctrl);
+	nvme_uninit_ctrl(ctrl);
+	nvme_put_ctrl(ctrl);
 }
 
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a7bdb17de29d..e447b532b9ee 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2640,24 +2640,11 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 
 	cancel_work_sync(&ctrl->ctrl.reset_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
-	nvme_stop_ctrl(&ctrl->ctrl);
-	nvme_remove_namespaces(&ctrl->ctrl);
 	/*
 	 * kill the association on the link side.  this will block
 	 * waiting for io to terminate
 	 */
 	nvme_fc_delete_association(ctrl);
-
-	/*
-	 * tear down the controller
-	 * After the last reference on the nvme ctrl is removed,
-	 * the transport nvme_fc_nvme_ctrl_freed() callback will be
-	 * invoked. From there, the transport will tear down it's
-	 * logical queues and association.
-	 */
-	nvme_uninit_ctrl(&ctrl->ctrl);
-
-	nvme_put_ctrl(&ctrl->ctrl);
 }
 
 static void
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a3521b852ea8..ed6e05018a92 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1757,11 +1757,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 
 static void nvme_rdma_delete_ctrl(struct nvme_ctrl *ctrl)
 {
-	nvme_stop_ctrl(ctrl);
-	nvme_remove_namespaces(ctrl);
 	nvme_rdma_shutdown_ctrl(to_rdma_ctrl(ctrl), true);
-	nvme_uninit_ctrl(ctrl);
-	nvme_put_ctrl(ctrl);
 }
 
 static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 7f9f3fc3fb2a..bc95c6ed531a 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -440,11 +440,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 
 static void nvme_loop_delete_ctrl_host(struct nvme_ctrl *ctrl)
 {
-	nvme_stop_ctrl(ctrl);
-	nvme_remove_namespaces(ctrl);
 	nvme_loop_shutdown_ctrl(to_loop_ctrl(ctrl));
-	nvme_uninit_ctrl(ctrl);
-	nvme_put_ctrl(ctrl);
 }
 
 static void nvme_loop_delete_ctrl(struct nvmet_ctrl *nctrl)
-- 
2.14.2
