From: hare@suse.de (Hannes Reinecke)
Date: Fri, 17 May 2019 08:42:54 +0200
Subject: [PATCH 3/3] nvme-fc: fail reconnect if state change fails
In-Reply-To: <20190517064254.95561-1-hare@suse.de>
References: <20190517064254.95561-1-hare@suse.de>
Message-ID: <20190517064254.95561-4-hare@suse.de>

If the final state change to LIVE in nvme_fc_create_association()
fails the controller is not operational as no I/O is possible.
So we should be returning an error here to reschedule reconnect.
Additionally it should only be called while in CONNECTING state, so
add a check for this, too.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e5c81ba2b7a1..a8ef62512d9a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2624,6 +2624,14 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 	++ctrl->ctrl.nr_reconnects;
 
+	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
+		dev_info(ctrl->ctrl.device,
+			 "NVME-FC{%d}: state %s cancelled new "
+			 "association attempt\n",
+			 ctrl->cnum, nvme_ctrl_state_name(&ctrl->ctrl));
+		return -ENODEV;
+	}
+
 	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
 		return -ENODEV;
 
@@ -2726,6 +2734,13 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
+	if (!changed && ctrl->ctrl.state != NVME_CTRL_DELETING) {
+		dev_err(ctrl->ctrl.device,
+			"NVME-FC{%d}: error_recovery: Couldn't change "
+			"state from %s to LIVE\n", ctrl->cnum,
+			nvme_ctrl_state_name(&ctrl->ctrl));
+		return -EAGAIN;
+	}
 
 	ctrl->ctrl.nr_reconnects = 0;
 
-- 
2.16.4
