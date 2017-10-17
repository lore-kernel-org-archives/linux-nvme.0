From: jsmart2021@gmail.com (James Smart)
Date: Tue, 17 Oct 2017 16:32:45 -0700
Subject: [PATCH v3 2/5] nvme_fc: change ctlr state assignments during
 reset/reconnect
In-Reply-To: <20171017233248.6769-1-jsmart2021@gmail.com>
References: <20171017233248.6769-1-jsmart2021@gmail.com>
Message-ID: <20171017233248.6769-3-jsmart2021@gmail.com>

Clean up some of the controller state checks and add the
RESETTING->RECONNECTING state transition.

Specifically:
- the movement of the RESETTING state change and schedule of
  reset_work to core doesn't work wiht nvme_fc_error_recovery
  setting state to RECONNECTING before attempting to reset.
  Remove the state change as the reset request does it.
- In the rare cases where an error occurs right as we're
  transitioning to LIVE, defer the controller start actions.
- In error handling on teardown of associations while
  performing initial controller creation - avoid quiesce
  calls on the admin_q. They are unneeded.
- Add the RESETTING->RECONNECTING transition in the reset
  handler.

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>

---
v3: no change. incorporated Reviewed-by's
---
 drivers/nvme/host/fc.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 48c241620d2b..5afb518c39ad 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1881,13 +1881,6 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	dev_warn(ctrl->ctrl.device,
 		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING)) {
-		dev_err(ctrl->ctrl.device,
-			"NVME-FC{%d}: error_recovery: Couldn't change state "
-			"to RECONNECTING\n", ctrl->cnum);
-		return;
-	}
-
 	nvme_reset_ctrl(&ctrl->ctrl);
 }
 
@@ -2521,11 +2514,11 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
 
 	ctrl->ctrl.nr_reconnects = 0;
 
-	nvme_start_ctrl(&ctrl->ctrl);
+	if (changed)
+		nvme_start_ctrl(&ctrl->ctrl);
 
 	return 0;	/* Success */
 
@@ -2593,7 +2586,8 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	 * use blk_mq_tagset_busy_itr() and the transport routine to
 	 * terminate the exchanges.
 	 */
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	if (ctrl->ctrl.state != NVME_CTRL_NEW)
+		blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 
@@ -2697,12 +2691,8 @@ nvme_fc_del_nvme_ctrl(struct nvme_ctrl *nctrl)
 static void
 nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 {
-	/* If we are resetting/deleting then do nothing */
-	if (ctrl->ctrl.state != NVME_CTRL_RECONNECTING) {
-		WARN_ON_ONCE(ctrl->ctrl.state == NVME_CTRL_NEW ||
-			ctrl->ctrl.state == NVME_CTRL_LIVE);
+	if (ctrl->ctrl.state != NVME_CTRL_RECONNECTING)
 		return;
-	}
 
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
@@ -2731,9 +2721,17 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	int ret;
 
 	nvme_stop_ctrl(&ctrl->ctrl);
+
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
 
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING)) {
+		dev_err(ctrl->ctrl.device,
+			"NVME-FC{%d}: error_recovery: Couldn't change state "
+			"to RECONNECTING\n", ctrl->cnum);
+		return;
+	}
+
 	ret = nvme_fc_create_association(ctrl);
 	if (ret)
 		nvme_fc_reconnect_or_delete(ctrl, ret);
-- 
2.13.1
