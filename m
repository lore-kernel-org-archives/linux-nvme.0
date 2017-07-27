From: keith.busch@intel.com (Keith Busch)
Date: Thu, 27 Jul 2017 12:58:40 -0400
Subject: [PATCH 1/2] nvme: Fix nvme reset command timeout handling
Message-ID: <1501174721-8253-1-git-send-email-keith.busch@intel.com>

We need to return an error if a timeout occurs on any NVMe command during
initialization. Without this, the nvme reset work will be stuck. A timeout
will have a negative error code, meaning we need to stop initializing
the controller. All postitive returns mean the controller is still usable.

bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196325

Signed-off-by: Keith Busch <keith.busch at intel.com>
Cc: Martin Peres <martin.peres at intel.com>
---
 drivers/nvme/host/core.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0c27f1a..b150702 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1514,7 +1514,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	blk_queue_write_cache(q, vwc, vwc);
 }
 
-static void nvme_configure_apst(struct nvme_ctrl *ctrl)
+static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 {
 	/*
 	 * APST (Autonomous Power State Transition) lets us program a
@@ -1543,16 +1543,16 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 	 * then don't do anything.
 	 */
 	if (!ctrl->apsta)
-		return;
+		return 0;
 
 	if (ctrl->npss > 31) {
 		dev_warn(ctrl->device, "NPSS is invalid; not using APST\n");
-		return;
+		return 0;
 	}
 
 	table = kzalloc(sizeof(*table), GFP_KERNEL);
 	if (!table)
-		return;
+		return 0;
 
 	if (!ctrl->apst_enabled || ctrl->ps_max_latency_us == 0) {
 		/* Turn off APST. */
@@ -1634,6 +1634,7 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 		dev_err(ctrl->device, "failed to set APST feature (%d)\n", ret);
 
 	kfree(table);
+	return ret;
 }
 
 static void nvme_set_latency_tolerance(struct device *dev, s32 val)
@@ -1856,17 +1857,25 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	kfree(id);
 
+	if (ret < 0)
+		return ret;
+
 	if (ctrl->apst_enabled && !prev_apst_enabled)
 		dev_pm_qos_expose_latency_tolerance(ctrl->device);
 	else if (!ctrl->apst_enabled && prev_apst_enabled)
 		dev_pm_qos_hide_latency_tolerance(ctrl->device);
 
-	nvme_configure_apst(ctrl);
-	nvme_configure_directives(ctrl);
+	ret = nvme_configure_apst(ctrl);
+	if (ret < 0)
+		return ret;
+
+	ret = nvme_configure_directives(ctrl);
+	if (ret < 0)
+		return ret;
 
 	ctrl->identified = true;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_init_identify);
 
-- 
2.5.5
