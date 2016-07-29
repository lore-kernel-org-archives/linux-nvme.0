From: krisman@linux.vnet.ibm.com (Gabriel Krisman Bertazi)
Date: Fri, 29 Jul 2016 16:15:18 -0300
Subject: [PATCH] nvme: Prevent controller state invalid transition
Message-ID: <1469819718-25511-1-git-send-email-krisman@linux.vnet.ibm.com>

Acquiring the nvme_ctrl lock before reading ctrl->state in
nvme_change_ctrl_state() should prevent a theoretical invalid state
transition, in the event of two threads racing inside that function.

I haven't been able to observe this happening with the current code, and
the current state machine seems to be simple enough to not be
affected by these invalid transitions, but future modifications could
make it more likely to happen.

Signed-off-by: Gabriel Krisman Bertazi <krisman at linux.vnet.ibm.com>
---
 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7ff2e82..7f75d66 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -81,10 +81,12 @@ EXPORT_SYMBOL_GPL(nvme_cancel_request);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
 {
-	enum nvme_ctrl_state old_state = ctrl->state;
+	enum nvme_ctrl_state old_state;
 	bool changed = false;
 
 	spin_lock_irq(&ctrl->lock);
+
+	old_state = ctrl->state;
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
@@ -140,11 +142,12 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	default:
 		break;
 	}
-	spin_unlock_irq(&ctrl->lock);
 
 	if (changed)
 		ctrl->state = new_state;
 
+	spin_unlock_irq(&ctrl->lock);
+
 	return changed;
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
-- 
2.7.4
