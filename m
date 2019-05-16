From: hare@suse.de (Hannes Reinecke)
Date: Thu, 16 May 2019 10:37:39 +0200
Subject: [PATCH 2/3] nvme-fc: track state change failures during reconnect
In-Reply-To: <20190516083740.95894-1-hare@suse.de>
References: <20190516083740.95894-1-hare@suse.de>
Message-ID: <20190516083740.95894-3-hare@suse.de>

The nvme-fc driver has several situation under which an expected
state transition fails, but doesn't print out any messages if
this happens.
The patch adds logging for these situations.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0c9e036afd09..e5c81ba2b7a1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2867,8 +2867,12 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 	unsigned long recon_delay = ctrl->ctrl.opts->reconnect_delay * HZ;
 	bool recon = true;
 
-	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING)
+	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
+		dev_info(ctrl->ctrl.device,
+			 "NVME-FC{%d}: couldn't reconnect in state %s\n",
+			 ctrl->cnum, nvme_ctrl_state_name(&ctrl->ctrl));
 		return;
+	}
 
 	if (portptr->port_state == FC_OBJSTATE_ONLINE)
 		dev_info(ctrl->ctrl.device,
@@ -2914,7 +2918,8 @@ __nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl)
 	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: error_recovery: Couldn't change state "
-			"to CONNECTING\n", ctrl->cnum);
+			"from %s to CONNECTING\n", ctrl->cnum,
+			nvme_ctrl_state_name(&ctrl->ctrl));
 }
 
 static void
-- 
2.16.4
