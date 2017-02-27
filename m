From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 27 Feb 2017 19:00:20 +0200
Subject: [PATCH 2/2] nvme-loop: fix a possible use-after-free when destroying
 the admin queue
In-Reply-To: <1488214820-3578-1-git-send-email-sagi@grimberg.me>
References: <1488214820-3578-1-git-send-email-sagi@grimberg.me>
Message-ID: <1488214820-3578-2-git-send-email-sagi@grimberg.me>

we need to destroy the nvmet sq and let it finish gracefully
before continue to cleanup the queue.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 8e19bf48691c..2fc750010e93 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -307,9 +307,9 @@ static struct blk_mq_ops nvme_loop_admin_mq_ops = {
 
 static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
 {
+	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
 	blk_mq_free_tag_set(&ctrl->admin_tag_set);
-	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
 }
 
 static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
-- 
2.7.4
