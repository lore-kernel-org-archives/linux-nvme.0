From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu,  4 May 2017 11:07:31 -0700
Subject: [RFC 1/7] nvme_fc: change ctlr state assignments during
 reset/reconnect
In-Reply-To: <20170504180737.5472-1-jsmart2021@gmail.com>
References: <20170504180737.5472-1-jsmart2021@gmail.com>
Message-ID: <20170504180737.5472-2-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Existing code:
Set NVME_CTRL_RESETTING upon entry from the core reset_ctrl
callback and left it set that way until reconnected.
Set NVME_CTRL_REcONNECTING after a transport detected error
and left it set that way until reconnected.

Revise the code so that NVME_CTRL_RESETTING is always set when
tearing down the association regardless of why/how, and after
the association is torn down, transition to NVME_CTRL_RECONNECTING
while it attempts to establish a new association with the target.

The RESETTING->RECONNECTING state transition is dependent upon the
patch that enables the transition.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9993ff8d5656..ac7e8145e5ec 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1759,7 +1759,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	if (ctrl->queue_count > 1)
 		nvme_stop_queues(&ctrl->ctrl);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: error_recovery: Couldn't change state "
 			"to RECONNECTING\n", ctrl->cnum);
@@ -2628,6 +2628,13 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
 
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING)) {
+		dev_err(ctrl->ctrl.device,
+			"NVME-FC{%d}: controller reset: Couldn't change "
+			"state to RECONNECTING\n", ctrl->cnum);
+		return;
+	}
+
 	ret = nvme_fc_create_association(ctrl);
 	if (ret)
 		nvme_fc_reconnect_or_delete(ctrl, ret);
-- 
2.11.0
