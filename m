From: keith.busch@intel.com (Keith Busch)
Date: Tue, 24 May 2016 09:06:10 -0600
Subject: [PATCHv2] NVMe: Sync reset and scan work
Message-ID: <1464102370-11283-1-git-send-email-keith.busch@intel.com>

This adds a new state for scheduling a reset and synchronizes that state
with active scanning work. This is so a user can't interrupt namespace
discovery, which can cause identification to fail.

Reported-by: Ming Lin <mlin at kernel.org>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v2: 
  added appropriate state transition from the new schedule reset state.

 drivers/nvme/host/core.c | 22 ++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6290477..09448a0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -66,6 +66,14 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 
 	spin_lock_irq(&ctrl->lock);
 	switch (new_state) {
+	case NVME_CTRL_SCHED_RESET:
+		switch (old_state) {
+		case NVME_CTRL_LIVE:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
 		case NVME_CTRL_RESETTING:
@@ -79,6 +87,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
+		case NVME_CTRL_SCHED_RESET:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -1209,6 +1218,15 @@ out_unlock:
 	return ret;
 }
 
+static int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
+{
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_SCHED_RESET))
+		return -EPERM;
+
+	flush_work(&ctrl->scan_work);
+	return ctrl->ops->reset_ctrl(ctrl);
+}
+
 static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
@@ -1222,7 +1240,7 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		return nvme_dev_user_cmd(ctrl, argp);
 	case NVME_IOCTL_RESET:
 		dev_warn(ctrl->device, "resetting controller\n");
-		return ctrl->ops->reset_ctrl(ctrl);
+		return nvme_reset_ctrl(ctrl);
 	case NVME_IOCTL_SUBSYS_RESET:
 		return nvme_reset_subsystem(ctrl);
 	case NVME_IOCTL_RESCAN:
@@ -1248,7 +1266,7 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret;
 
-	ret = ctrl->ops->reset_ctrl(ctrl);
+	ret = nvme_reset_ctrl(ctrl);
 	if (ret < 0)
 		return ret;
 	return count;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1daa048..2206f32 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -73,6 +73,7 @@ enum nvme_ctrl_state {
 	NVME_CTRL_RESETTING,
 	NVME_CTRL_DELETING,
 	NVME_CTRL_DEAD,
+	NVME_CTRL_SCHED_RESET,
 };
 
 struct nvme_ctrl {
-- 
2.7.2
