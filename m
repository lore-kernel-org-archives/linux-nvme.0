From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 29 Jul 2016 22:57:21 +0300
Subject: [PATCH 4/5] nvme-rdma: Remove duplicate call to nvme_remove_namespaces
In-Reply-To: <1469822242-3477-1-git-send-email-sagi@grimberg.me>
References: <1469822242-3477-1-git-send-email-sagi@grimberg.me>
Message-ID: <1469822242-3477-5-git-send-email-sagi@grimberg.me>

nvme_uninit_ctrl already does that for us.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 641ab7f91899..bd9b416fe21a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1658,9 +1658,8 @@ static void nvme_rdma_del_ctrl_work(struct work_struct *work)
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 				struct nvme_rdma_ctrl, delete_work);
 
-	nvme_remove_namespaces(&ctrl->ctrl);
-	nvme_rdma_shutdown_ctrl(ctrl);
 	nvme_uninit_ctrl(&ctrl->ctrl);
+	nvme_rdma_shutdown_ctrl(ctrl);
 	if (ctrl->ctrl.tagset) {
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
 		blk_mq_free_tag_set(&ctrl->tag_set);
@@ -1699,7 +1698,6 @@ static void nvme_rdma_remove_ctrl_work(struct work_struct *work)
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 				struct nvme_rdma_ctrl, delete_work);
 
-	nvme_remove_namespaces(&ctrl->ctrl);
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	if (ctrl->ctrl.tagset) {
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
-- 
1.9.1
