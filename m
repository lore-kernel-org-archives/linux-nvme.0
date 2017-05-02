From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Tue,  2 May 2017 11:54:58 -0700
Subject: [PATCH] nvme core: allow controller RESETTING to RECONNECTING
 transition
Message-ID: <20170502185458.3495-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Allow controller state transition : RESETTING to RECONNECTING

I intend to have the nvme_fc transport set the state to RESETTING when
tearing down the current association (error or controller reset), then
transitioning to RECONNECTING when attempting to establish a new
association.

-- james

Signed-off-by: James Smart <james.smart at broadcom.com>
---
patch cut against the nvme-4.12 tree

 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 263946b23628..a265e528a02f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -171,6 +171,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	case NVME_CTRL_RECONNECTING:
 		switch (old_state) {
 		case NVME_CTRL_LIVE:
+		case NVME_CTRL_RESETTING:
 			changed = true;
 			/* FALLTHRU */
 		default:
-- 
2.11.0
