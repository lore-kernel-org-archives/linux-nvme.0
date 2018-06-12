From: jsmart2021@gmail.com (James Smart)
Date: Tue, 12 Jun 2018 16:28:24 -0700
Subject: [REPOST][PATCH] nvme: move init of keep_alive work item to controller
 initialization
Message-ID: <20180612232824.12379-1-jsmart2021@gmail.com>

Currently, the code initializes the keep alive work item whenever
nvme_start_keep_alive() is called. However, this routine is called
several times while reconnecting, etc. Although it's hoped that keep
alive is always disabled and not scheduled when start is called,
re-initing if it were scheduled or completing can have very bad
side effects. There's no need for re-initialization.

Move the keep_alive work item and cmd struct initialization to
controller init.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6ca4598c027..20470eb6e05c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -848,9 +848,6 @@ static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 	if (unlikely(ctrl->kato == 0))
 		return;
 
-	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
-	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
-	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 }
 
@@ -3497,6 +3494,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
 
+	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
+	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
+	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
+
 	ret = ida_simple_get(&nvme_instance_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0)
 		goto out;
-- 
2.13.1
