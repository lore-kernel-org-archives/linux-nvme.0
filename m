From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Tue, 25 Apr 2017 15:32:34 -0700
Subject: [PATCH] nvme_fc: set logging level on resets/deletes
Message-ID: <20170425223234.3958-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Per the review by Sagi on:
http://lists.infradead.org/pipermail/linux-nvme/2017-April/009261.html

Looked at existing warn vs info vs err dev_xxx levels for the messages
printed on reconnects and deletes:
- Resets due to error and resets transitioned to deletes are dev_warn
- Other reset/disconnect messages are dev_info
- Added admin-requested delete info message
- Removed chatty io queue related messages

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e917d91..c0f92b0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1751,7 +1751,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	dev_warn(ctrl->ctrl.device,
 		"NVME-FC{%d}: transport association error detected: %s\n",
 		ctrl->cnum, errmsg);
-	dev_info(ctrl->ctrl.device,
+	dev_warn(ctrl->ctrl.device,
 		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
 
 	/* stop the queues on error, cleanup is in reset thread */
@@ -2195,9 +2195,6 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	if (!opts->nr_io_queues)
 		return 0;
 
-	dev_info(ctrl->ctrl.device, "creating %d I/O queues.\n",
-			opts->nr_io_queues);
-
 	nvme_fc_init_io_queues(ctrl);
 
 	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
@@ -2268,9 +2265,6 @@ nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
 	if (ctrl->queue_count == 1)
 		return 0;
 
-	dev_info(ctrl->ctrl.device, "Recreating %d I/O queues.\n",
-			opts->nr_io_queues);
-
 	nvme_fc_init_io_queues(ctrl);
 
 	ret = blk_mq_reinit_tagset(&ctrl->tag_set);
@@ -2577,6 +2571,9 @@ nvme_fc_del_nvme_ctrl(struct nvme_ctrl *nctrl)
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 	int ret;
 
+	dev_info(ctrl->ctrl.device,
+		"NVME-FC{%d}: admin requested controller delete\n", ctrl->cnum);
+
 	if (!kref_get_unless_zero(&ctrl->ctrl.kref))
 		return -EBUSY;
 
@@ -2600,7 +2597,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		return;
 	}
 
-	dev_warn(ctrl->ctrl.device,
+	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
 		ctrl->cnum, status);
 
@@ -2611,7 +2608,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		queue_delayed_work(nvme_fc_wq, &ctrl->connect_work,
 				ctrl->ctrl.opts->reconnect_delay * HZ);
 	} else {
-		dev_info(ctrl->ctrl.device,
+		dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: Max reconnect attempts (%d) "
 				"reached. Removing controller\n",
 				ctrl->cnum, ctrl->ctrl.opts->nr_reconnects);
@@ -2646,7 +2643,7 @@ nvme_fc_reset_nvme_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
-	dev_warn(ctrl->ctrl.device,
+	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: admin requested controller reset\n", ctrl->cnum);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
-- 
2.9.3
