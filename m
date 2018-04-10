From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 10 Apr 2018 20:18:09 +0300
Subject: [PATCH 5/5] nvme-loop: add keep-alive mechanism as admin_q property
In-Reply-To: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
Message-ID: <1523380689-17151-6-git-send-email-maxg@mellanox.com>

Activate/deactivate it during admin queue creation/destruction
and remove association to nvme ctrl.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index b9d5b69..f54c787c 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -279,6 +279,7 @@ static int nvme_loop_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 
 static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
 {
+	nvme_stop_keep_alive(&ctrl->ctrl);
 	clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
@@ -419,6 +420,8 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	if (error)
 		goto out_cleanup_queue;
 
+	nvme_start_keep_alive(&ctrl->ctrl);
+
 	return 0;
 
 out_cleanup_queue:
-- 
1.8.3.1
