From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 28 Apr 2019 20:24:41 -0700
Subject: [PATCH V2 2/3] nvme: improve logging
In-Reply-To: <20190429032442.5923-1-chaitanya.kulkarni@wdc.com>
References: <20190429032442.5923-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190429032442.5923-3-chaitanya.kulkarni@wdc.com>

From: Hannes Reinecke <hare@suse.com>

Currently nvme is very reluctant if it comes to logging anything,
_unless_ it's an ANA AEN. So this patch tries to remedy this by
decreasing the priority for the ANA AEN logging message, and improve
the logging when calling nvme_reset_ctrl().

Also, print ctrl state transition info.

Signed-off-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c | 41 ++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3dd043aa6d1f..c17e731f53e3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -94,6 +94,13 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 
+static const char *nvme_get_ctrl_state_name(unsigned int state)
+{
+	if ((unsigned int) state < ARRAY_SIZE(nvme_ctrl_state_name))
+		return nvme_ctrl_state_name[state];
+	return "unknown";
+}
+
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
 	/*
@@ -119,10 +126,16 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
 
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
+		dev_warn(ctrl->device, "cannot reset ctrl in state %s\n",
+				nvme_get_ctrl_state_name(ctrl->state));
 		return -EBUSY;
-	if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
+	}
+	if (!queue_work(nvme_reset_wq, &ctrl->reset_work)) {
+		dev_dbg(ctrl->device, "ctrl reset already queued\n");
 		return -EBUSY;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_reset_ctrl);
@@ -370,8 +383,13 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		break;
 	}
 
-	if (changed)
+	if (changed) {
 		ctrl->state = new_state;
+		dev_info(ctrl->device, "state change from (%s -> %s)\n",
+				nvme_get_ctrl_state_name(new_state),
+					nvme_get_ctrl_state_name(ctrl->state));
+
+	}
 
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (changed && ctrl->state == NVME_CTRL_LIVE)
@@ -2960,21 +2978,8 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 				     char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	static const char *const state_name[] = {
-		[NVME_CTRL_NEW]		= "new",
-		[NVME_CTRL_LIVE]	= "live",
-		[NVME_CTRL_ADMIN_ONLY]	= "only-admin",
-		[NVME_CTRL_RESETTING]	= "resetting",
-		[NVME_CTRL_CONNECTING]	= "connecting",
-		[NVME_CTRL_DELETING]	= "deleting",
-		[NVME_CTRL_DEAD]	= "dead",
-	};
-
-	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
-	    state_name[ctrl->state])
-		return sprintf(buf, "%s\n", state_name[ctrl->state]);
-
-	return sprintf(buf, "unknown state\n");
+
+	return sprintf(buf, "%s\n", nvme_get_ctrl_state_name(ctrl->state));
 }
 
 static DEVICE_ATTR(state, S_IRUGO, nvme_sysfs_show_state, NULL);
-- 
2.17.0
