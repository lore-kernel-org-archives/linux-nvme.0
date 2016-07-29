From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 29 Jul 2016 22:57:22 +0300
Subject: [PATCH 5/5] nvme-loop: Remove duplicate call to nvme_remove_namespaces
In-Reply-To: <1469822242-3477-1-git-send-email-sagi@grimberg.me>
References: <1469822242-3477-1-git-send-email-sagi@grimberg.me>
Message-ID: <1469822242-3477-6-git-send-email-sagi@grimberg.me>

nvme_uninit_ctrl already does that for us.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/loop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 94e782987cc9..7affd40a6b33 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -414,9 +414,8 @@ static void nvme_loop_del_ctrl_work(struct work_struct *work)
 	struct nvme_loop_ctrl *ctrl = container_of(work,
 				struct nvme_loop_ctrl, delete_work);
 
-	nvme_remove_namespaces(&ctrl->ctrl);
-	nvme_loop_shutdown_ctrl(ctrl);
 	nvme_uninit_ctrl(&ctrl->ctrl);
+	nvme_loop_shutdown_ctrl(ctrl);
 	nvme_put_ctrl(&ctrl->ctrl);
 }
 
@@ -501,7 +500,6 @@ out_free_queues:
 	nvme_loop_destroy_admin_queue(ctrl);
 out_disable:
 	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
-	nvme_remove_namespaces(&ctrl->ctrl);
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	nvme_put_ctrl(&ctrl->ctrl);
 }
-- 
1.9.1
