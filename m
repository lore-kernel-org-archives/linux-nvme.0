From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu,  4 May 2017 11:06:54 -0700
Subject: [PATCH] nvme_fc: remove extra controller reference taken on reconnect
Message-ID: <20170504180654.5356-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

remove extra controller reference taken on reconnect

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 622cac5f5db5..9993ff8d5656 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2395,13 +2395,14 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 			goto out_term_aen_ops;
 	}
 
+	if (ctrl->ctrl.state == NVME_CTRL_NEW)
+		kref_get(&ctrl->ctrl.kref);
+
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
 
 	ctrl->ctrl.opts->nr_reconnects = 0;
 
-	kref_get(&ctrl->ctrl.kref);
-
 	if (ctrl->queue_count > 1) {
 		nvme_start_queues(&ctrl->ctrl);
 		nvme_queue_scan(&ctrl->ctrl);
-- 
2.11.0
