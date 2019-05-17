From: hare@suse.de (Hannes Reinecke)
Date: Fri, 17 May 2019 08:42:52 +0200
Subject: [PATCH 1/3] nvme: separate out nvme_ctrl_state_name()
In-Reply-To: <20190517064254.95561-1-hare@suse.de>
References: <20190517064254.95561-1-hare@suse.de>
Message-ID: <20190517064254.95561-2-hare@suse.de>

Separate out nvme_ctrl_state_name() to return the controller state
as a string.

Signed-off-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/core.c | 37 ++++++++++++++++++++++---------------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2e4fa694f79..bd1bc7fcbcde 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -380,6 +380,25 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
 
+static const char *const nvme_ctrl_state_names[] = {
+	[NVME_CTRL_NEW]		= "new",
+	[NVME_CTRL_LIVE]	= "live",
+	[NVME_CTRL_ADMIN_ONLY]	= "only-admin",
+	[NVME_CTRL_RESETTING]	= "resetting",
+	[NVME_CTRL_CONNECTING]	= "connecting",
+	[NVME_CTRL_DELETING]	= "deleting",
+	[NVME_CTRL_DEAD]	= "dead",
+};
+
+const char *nvme_ctrl_state_name(struct nvme_ctrl *ctrl)
+{
+	if ((unsigned)ctrl->state < ARRAY_SIZE(nvme_ctrl_state_names) &&
+	    nvme_ctrl_state_names[ctrl->state])
+		return nvme_ctrl_state_names[ctrl->state];
+	return "unknown state";
+}
+EXPORT_SYMBOL_GPL(nvme_ctrl_state_name);
+
 static void nvme_free_ns_head(struct kref *ref)
 {
 	struct nvme_ns_head *head =
@@ -2989,21 +3008,9 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
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
+	const char *state_name = nvme_ctrl_state_name(ctrl);
+
+	return sprintf(buf, "%s\n", state_name);
 }
 
 static DEVICE_ATTR(state, S_IRUGO, nvme_sysfs_show_state, NULL);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5ee75b5ff83f..b3b13e465dc6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -419,6 +419,7 @@ void nvme_complete_rq(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data, bool reserved);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
+const char *nvme_ctrl_state_name(struct nvme_ctrl *ctrl);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
-- 
2.16.4
