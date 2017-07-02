From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  2 Jul 2017 20:45:15 +0300
Subject: [PATCH 2/4] nvme-fc: quiesce/unquiesce admin_q instead of start/stop
 its hw queues
In-Reply-To: <1499017517-18719-1-git-send-email-sagi@grimberg.me>
References: <1499017517-18719-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499017517-18719-2-git-send-email-sagi@grimberg.me>

unlike blk_mq_stop_hw_queues and blk_mq_start_stopped_hw_queues
quiescing/unquiescing respects the submission path rcu grace.
Also make sure to kick the requeue list when appropriate.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ffe0589969bd..c5621b833c66 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2319,8 +2319,10 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (ret)
 		goto out_delete_hw_queue;
 
-	if (ctrl->ctrl.state != NVME_CTRL_NEW)
-		blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
+	if (ctrl->ctrl.state != NVME_CTRL_NEW) {
+		blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+		blk_mq_kick_requeue_list(ctrl->ctrl.admin_q);
+	}
 
 	ret = nvmf_connect_admin_queue(&ctrl->ctrl);
 	if (ret)
@@ -2474,7 +2476,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	 * use blk_mq_tagset_busy_itr() and the transport routine to
 	 * terminate the exchanges.
 	 */
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 
-- 
2.7.4
