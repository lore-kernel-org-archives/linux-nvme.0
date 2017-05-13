From: jsmart2021@gmail.com (James Smart)
Date: Sat, 13 May 2017 12:07:15 -0700
Subject: [PATCH 1/8] nvme core: allow controller RESETTING to RECONNECTING
 transition
In-Reply-To: <20170513190722.25536-1-jsmart2021@gmail.com>
References: <20170513190722.25536-1-jsmart2021@gmail.com>
Message-ID: <20170513190722.25536-2-jsmart2021@gmail.com>

Allow controller state transition : RESETTING to RECONNECTING

The nvme_fc transport will set the state to RESETTING when
tearing down the current association (error or controller reset),
then transition to RECONNECTING when attempting to establish a new
association.

-- james

Signed-off-by: James Smart <james.smart at broadcom.com>
---
originally posted standalone
recut on nvme-4.12

 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5e0906262ea..ae977ef886a3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -175,6 +175,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	case NVME_CTRL_RECONNECTING:
 		switch (old_state) {
 		case NVME_CTRL_LIVE:
+		case NVME_CTRL_RESETTING:
 			changed = true;
 			/* FALLTHRU */
 		default:
-- 
2.11.0
