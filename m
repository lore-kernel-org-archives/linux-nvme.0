From: jsmart2021@gmail.com (James Smart)
Date: Mon,  7 May 2018 15:56:32 -0700
Subject: [PATCH] nvme: move init of keep_alive work item to controller
 initialization
Message-ID: <20180507225632.5265-1-jsmart2021@gmail.com>

Currently, the code initializes the keep alive work item whenever
nvme_start_keep_alive() is called. However, this routine is called
several times while reconnecting, etc. Although it's hoped that keep
alive is always disabled and not scheduled when start is called,
re-initing if it were scheduled or completing would not be good.
There's no need for re-initialization.

Move the keep_alive work item and cmd struct initialization to
controller init.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cfa03b68d2b8..f3779f350769 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -839,9 +839,6 @@ static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 	if (unlikely(ctrl->kato == 0))
 		return;
 
-	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
-	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
-	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 }
 
@@ -3428,6 +3425,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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
