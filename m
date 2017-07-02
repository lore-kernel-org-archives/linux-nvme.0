From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  2 Jul 2017 20:45:16 +0300
Subject: [PATCH 3/4] nvme-loop: quiesce/unquiesce admin_q instead of
 start/stop its hw queues
In-Reply-To: <1499017517-18719-1-git-send-email-sagi@grimberg.me>
References: <1499017517-18719-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499017517-18719-3-git-send-email-sagi@grimberg.me>

unlike blk_mq_stop_hw_queues and blk_mq_start_stopped_hw_queues
quiescing/unquiescing respects the submission path rcu grace.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 3d51341e62ee..891002ee005f 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -434,7 +434,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
-- 
2.7.4
