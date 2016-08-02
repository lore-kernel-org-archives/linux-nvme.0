From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  2 Aug 2016 10:53:36 +0300
Subject: [PATCH v2 2/5] nvme-rdma: Remove duplicate call to
 nvme_remove_namespaces
In-Reply-To: <1470124419-30405-1-git-send-email-sagi@grimberg.me>
References: <1470124419-30405-1-git-send-email-sagi@grimberg.me>
Message-ID: <1470124419-30405-3-git-send-email-sagi@grimberg.me>

nvme_uninit_ctrl already does that for us. Note that we reordered
nvme_rdma_shutdown_ctrl and nvme_uninit_ctrl, this is perfectly
fine because we actually want ctrl uninit (aen, scan cancellation
and namespaces removal) to happen before we shutdown the rdma
resources.

Also, centralize the deletion work and the dead controller removal
work code duplication into __nvme_rdma_shutdown_ctrl that accepts
a shutdown boolean.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f391d67e4ee0..39330bd295d4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1658,15 +1658,20 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
 	nvme_rdma_destroy_admin_queue(ctrl);
 }
 
+static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
+{
+	nvme_uninit_ctrl(&ctrl->ctrl);
+	if (shutdown)
+		nvme_rdma_shutdown_ctrl(ctrl);
+	nvme_put_ctrl(&ctrl->ctrl);
+}
+
 static void nvme_rdma_del_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 				struct nvme_rdma_ctrl, delete_work);
 
-	nvme_remove_namespaces(&ctrl->ctrl);
-	nvme_rdma_shutdown_ctrl(ctrl);
-	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_put_ctrl(&ctrl->ctrl);
+	__nvme_rdma_remove_ctrl(ctrl, true);
 }
 
 static int __nvme_rdma_del_ctrl(struct nvme_rdma_ctrl *ctrl)
@@ -1699,9 +1704,7 @@ static void nvme_rdma_remove_ctrl_work(struct work_struct *work)
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 				struct nvme_rdma_ctrl, delete_work);
 
-	nvme_remove_namespaces(&ctrl->ctrl);
-	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_put_ctrl(&ctrl->ctrl);
+	__nvme_rdma_remove_ctrl(ctrl, false);
 }
 
 static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
-- 
1.9.1
