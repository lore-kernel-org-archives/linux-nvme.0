From: jsmart2021@gmail.com (James Smart)
Date: Mon, 15 May 2017 17:10:19 -0700
Subject: [PATCH v2 05/10] nvme_fc: set logging level on resets/deletes
In-Reply-To: <20170516001024.5281-1-jsmart2021@gmail.com>
References: <20170516001024.5281-1-jsmart2021@gmail.com>
Message-ID: <20170516001024.5281-6-jsmart2021@gmail.com>

Per the review by Sagi on:
http://lists.infradead.org/pipermail/linux-nvme/2017-April/009261.html

Looked at existing warn vs info vs err dev_xxx levels for the messages
printed on reconnects and deletes:
- Resets due to error and resets transitioned to deletes are dev_warn
- Other reset/disconnect messages are dev_info
- Removed chatty io queue related messages

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
v2: remove admin-requested delete info message as deletes are common
 for discovery controllers
---
 drivers/nvme/host/fc.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2708c0caee14..8a721aa11387 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1750,7 +1750,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	dev_warn(ctrl->ctrl.device,
 		"NVME-FC{%d}: transport association error detected: %s\n",
 		ctrl->cnum, errmsg);
-	dev_info(ctrl->ctrl.device,
+	dev_warn(ctrl->ctrl.device,
 		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
 
 	/* stop the queues on error, cleanup is in reset thread */
@@ -2194,9 +2194,6 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	if (!opts->nr_io_queues)
 		return 0;
 
-	dev_info(ctrl->ctrl.device, "creating %d I/O queues.\n",
-			opts->nr_io_queues);
-
 	nvme_fc_init_io_queues(ctrl);
 
 	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
@@ -2267,9 +2264,6 @@ nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
 	if (ctrl->queue_count == 1)
 		return 0;
 
-	dev_info(ctrl->ctrl.device, "Recreating %d I/O queues.\n",
-			opts->nr_io_queues);
-
 	nvme_fc_init_io_queues(ctrl);
 
 	ret = blk_mq_reinit_tagset(&ctrl->tag_set);
@@ -2599,7 +2593,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		return;
 	}
 
-	dev_warn(ctrl->ctrl.device,
+	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
 		ctrl->cnum, status);
 
@@ -2610,7 +2604,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		queue_delayed_work(nvme_fc_wq, &ctrl->connect_work,
 				ctrl->ctrl.opts->reconnect_delay * HZ);
 	} else {
-		dev_info(ctrl->ctrl.device,
+		dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: Max reconnect attempts (%d) "
 				"reached. Removing controller\n",
 				ctrl->cnum, ctrl->ctrl.opts->nr_reconnects);
@@ -2645,7 +2639,7 @@ nvme_fc_reset_nvme_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
-	dev_warn(ctrl->ctrl.device,
+	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: admin requested controller reset\n", ctrl->cnum);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
-- 
2.11.0
