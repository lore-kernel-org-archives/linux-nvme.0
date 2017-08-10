From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 10 Aug 2017 11:23:31 +0200
Subject: [PATCH v2] nvme: Fix nvme reset command timeout handling
Message-ID: <20170810092331.11159-1-jthumshirn@suse.de>

From: Keith Busch <keith.busch@intel.com>

We need to return an error if a timeout occurs on any NVMe command during
initialization. Without this, the nvme reset work will be stuck. A timeout
will have a negative error code, meaning we need to stop initializing
the controller. All postitive returns mean the controller is still usable.

bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196325

Signed-off-by: Keith Busch <keith.busch at intel.com>
Cc: Martin Peres <martin.peres at intel.com>
[jth consolidated cleanup path ]
Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---

Notes:
    Changes in v2:
    * Consolidated cleanup path

 drivers/nvme/host/core.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c49f1f8b2e57..232eb65fe49d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1509,7 +1509,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	blk_queue_write_cache(q, vwc, vwc);
 }
 
-static void nvme_configure_apst(struct nvme_ctrl *ctrl)
+static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 {
 	/*
 	 * APST (Autonomous Power State Transition) lets us program a
@@ -1538,16 +1538,16 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
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
@@ -1629,6 +1629,7 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 		dev_err(ctrl->device, "failed to set APST feature (%d)\n", ret);
 
 	kfree(table);
+	return ret;
 }
 
 static void nvme_set_latency_tolerance(struct device *dev, s32 val)
@@ -1835,13 +1836,16 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		 * In fabrics we need to verify the cntlid matches the
 		 * admin connect
 		 */
-		if (ctrl->cntlid != le16_to_cpu(id->cntlid))
+		if (ctrl->cntlid != le16_to_cpu(id->cntlid)) {
 			ret = -EINVAL;
+			goto out_free;
+		}
 
 		if (!ctrl->opts->discovery_nqn && !ctrl->kas) {
 			dev_err(ctrl->device,
 				"keep-alive support is mandatory for fabrics\n");
 			ret = -EINVAL;
+			goto out_free;
 		}
 	} else {
 		ctrl->cntlid = le16_to_cpu(id->cntlid);
@@ -1856,11 +1860,20 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
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
 
+	return 0;
+
+out_free:
+	kfree(id);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_init_identify);
-- 
2.12.3
