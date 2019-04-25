From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 24 Apr 2019 19:40:40 -0700
Subject: [PATCH 1/2] nvme: improve logging
In-Reply-To: <20190425024041.17657-1-chaitanya.kulkarni@wdc.com>
References: <20190425024041.17657-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190425024041.17657-2-chaitanya.kulkarni@wdc.com>

Currently nvme is very reluctant if it comes to logging anything,
_unless_ it's an ANA AEN. So this patch tries to remedy this by
decreasing the priority for the ANA AEN logging message, and improve
the logging when calling nvme_reset_ctrl().

Signed-off-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c | 42 +++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ddb943395118..eac2b4441a42 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -94,6 +94,23 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 
+static const char *nvme_ctrl_state_name(struct nvme_ctrl *ctrl)
+{
+	static const char *const state_name[] = {
+		[NVME_CTRL_NEW]		= "new",
+		[NVME_CTRL_LIVE]	= "live",
+		[NVME_CTRL_ADMIN_ONLY]	= "only-admin",
+		[NVME_CTRL_RESETTING]	= "resetting",
+		[NVME_CTRL_CONNECTING]	= "connecting",
+		[NVME_CTRL_DELETING]	= "deleting",
+		[NVME_CTRL_DEAD]	= "dead",
+	};
+
+	if ((unsigned int)ctrl->state < ARRAY_SIZE(state_name))
+		return state_name[ctrl->state];
+	return "unknown";
+}
+
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
 	/*
@@ -119,10 +136,15 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
 
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
+		dev_warn(ctrl->device, "cannot reset ctrl in state %s\n",
+			 nvme_ctrl_state_name(ctrl));
 		return -EBUSY;
-	if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
+	}
+	if (!queue_work(nvme_reset_wq, &ctrl->reset_work)) {
+		dev_dbg(ctrl->device, "ctrl reset already queued\n");
 		return -EBUSY;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_reset_ctrl);
@@ -2955,21 +2977,9 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
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
+	const char *state_name = nvme_ctrl_state_name(ctrl);
 
-	return sprintf(buf, "unknown state\n");
+	return sprintf(buf, "%s\n", state_name);
 }
 
 static DEVICE_ATTR(state, S_IRUGO, nvme_sysfs_show_state, NULL);
-- 
2.17.0
