From: jsmart2021@gmail.com (James Smart)
Date: Wed, 21 Jun 2017 17:43:21 -0700
Subject: [PATCH] nvme_fc: fix error recovery on link down.
Message-ID: <20170622004321.30679-1-jsmart2021@gmail.com>

Currently, the fc transport invokes nvme_fc_error_recovery() on every
io in which the transport detects an error.  Which means:
a) it's really noisy on large io loads that all get hit by a link down.
b) we repeatively call nvme_stop_queues() even though queues are
 stopped upon the first error or as first steps of reset_work.

Correct by:
Errors are only meaningful if the controller is in the LIVE state.
Thus, enact the reset_work only if LIVE. If called repeatively, state
will have already transitioned.
There's no need to stop the queues here. Let the first steps of
reset_work do the queue stopping.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 02a6df84dc3c..25e5955b7235 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1746,16 +1746,16 @@ nvme_fc_nvme_ctrl_freed(struct nvme_ctrl *nctrl)
 static void
 nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 {
+	/* only proceed if in LIVE state - e.g. on first error */
+	if (ctrl->ctrl.state != NVME_CTRL_LIVE)
+		return;
+
 	dev_warn(ctrl->ctrl.device,
 		"NVME-FC{%d}: transport association error detected: %s\n",
 		ctrl->cnum, errmsg);
 	dev_warn(ctrl->ctrl.device,
 		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
 
-	/* stop the queues on error, cleanup is in reset thread */
-	if (ctrl->queue_count > 1)
-		nvme_stop_queues(&ctrl->ctrl);
-
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: error_recovery: Couldn't change state "
-- 
2.11.0
