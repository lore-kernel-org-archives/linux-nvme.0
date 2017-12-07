From: nitzanc@mellanox.com (Nitzan Carmi)
Date: Thu,  7 Dec 2017 14:34:50 +0000
Subject: [PATCH] Revert "nvme: allow controller RESETTING to RECONNECTING
 transition"
Message-ID: <20171207143450.7005-1-nitzanc@mellanox.com>

Allowing controller to move from RESETTING to RECONNECTING state
causes nvme_reset_ctrl_sync() to get out of sync, and start
reset and reconnect flows simultaneously.

consider the following scenario:
-> calling reset_controller from sysfs
-> ctrl.state changes to RESETTING.
-> queue work for reset_work
-> failing connection - entering error_recovery
-> ctrl.state changes to RECONNECTING (now it is allowed)
-> queue work for err_work

This reverts commit 3cec7f9de448131778a1428100621fd371db75f4.
Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f837d66..caf5456 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -256,7 +256,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	case NVME_CTRL_RECONNECTING:
 		switch (old_state) {
 		case NVME_CTRL_LIVE:
-		case NVME_CTRL_RESETTING:
 			changed = true;
 			/* FALLTHRU */
 		default:
-- 
2.9.4
