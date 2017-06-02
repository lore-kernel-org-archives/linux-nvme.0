From: jsmart2021@gmail.com (James Smart)
Date: Thu,  1 Jun 2017 22:53:51 -0700
Subject: [PATCH] nvme_fc: fix confused queue size handling
Message-ID: <20170602055351.2750-1-jsmart2021@gmail.com>

The code gets confused whether to use queue_size (the 1's) value
or the ctrl.sqsize (the 0's value) in places.

In init_io_queues - should use the 1's value.
if queue size reduced due to MQES or MAXCMD, need to reduce both
queue_size and ctrl.sqsize.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5b14cbefb724..f24c2c670618 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1681,7 +1681,7 @@ nvme_fc_init_io_queues(struct nvme_fc_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_fc_init_queue(ctrl, i, ctrl->ctrl.sqsize);
+		nvme_fc_init_queue(ctrl, i, ctrl->ctrl.opts->queue_size);
 }
 
 static void
@@ -2336,8 +2336,10 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		goto out_disconnect_admin_queue;
 	}
 
-	ctrl->ctrl.sqsize =
-		min_t(int, NVME_CAP_MQES(ctrl->cap) + 1, ctrl->ctrl.sqsize);
+	if (NVME_CAP_MQES(ctrl->cap) < ctrl->ctrl.sqsize) {
+		ctrl->ctrl.sqsize = NVME_CAP_MQES(ctrl->cap);
+		opts->queue_size = ctrl->ctrl.sqsize + 1;
+	}
 
 	ret = nvme_enable_ctrl(&ctrl->ctrl, ctrl->cap);
 	if (ret)
@@ -2371,6 +2373,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 			"to queue_size\n",
 			opts->queue_size, ctrl->ctrl.maxcmd);
 		opts->queue_size = ctrl->ctrl.maxcmd;
+		ctrl->ctrl.sqsize = opts->queue_size - 1;
 	}
 
 	ret = nvme_fc_init_aen_ops(ctrl);
-- 
2.11.0
