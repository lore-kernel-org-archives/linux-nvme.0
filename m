From: kai.heng.feng@canonical.com (Kai-Heng Feng)
Date: Fri, 23 Jun 2017 14:19:42 +0800
Subject: [PATCH] nvme: explicitly disable APST on quirked devices
Message-ID: <20170623061942.5225-1-kai.heng.feng@canonical.com>

A user reports APST is enabled, even when the NVMe is quirked or with
option "default_ps_max_latency_us=0".

The current logic will not set APST if the device is quirked. But the
NVMe in question will enable APST automatically.

Separate the logic "apst is supported" and "to enable apst", so we can
use the latter one to explicitly disable APST at initialiaztion.

BugLink: https://bugs.launchpad.net/bugs/1699004
Signed-off-by: Kai-Heng Feng <kai.heng.feng at canonical.com>
---
 drivers/nvme/host/core.c | 25 +++++++++++++++++--------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0ddd6b9af7fc..c459d15d18f5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1477,6 +1477,14 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 	if (!ctrl->apsta)
 		return;
 
+	if (!ctrl->apst_enabled) {
+		if (ctrl->state == NVME_CTRL_NEW ||
+		    ctrl->state == NVME_CTRL_RESETTING)
+			dev_info(ctrl->device, "Disable APST at initialization\n");
+		else
+			return;
+	}
+
 	if (ctrl->npss > 31) {
 		dev_warn(ctrl->device, "NPSS is invalid; not using APST\n");
 		return;
@@ -1486,7 +1494,7 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 	if (!table)
 		return;
 
-	if (ctrl->ps_max_latency_us == 0) {
+	if (ctrl->ps_max_latency_us == 0 || !ctrl->apst_enabled) {
 		/* Turn off APST. */
 		apste = 0;
 		dev_dbg(ctrl->device, "APST disabled\n");
@@ -1653,7 +1661,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	u64 cap;
 	int ret, page_shift;
 	u32 max_hw_sectors;
-	u8 prev_apsta;
+	bool prev_apst_enabled;
 
 	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
 	if (ret) {
@@ -1721,16 +1729,17 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->kas = le16_to_cpu(id->kas);
 
 	ctrl->npss = id->npss;
-	prev_apsta = ctrl->apsta;
+	ctrl->apsta = id->apsta;
+	prev_apst_enabled = ctrl->apst_enabled;
 	if (ctrl->quirks & NVME_QUIRK_NO_APST) {
 		if (force_apst && id->apsta) {
 			dev_warn(ctrl->device, "forcibly allowing APST due to nvme_core.force_apst -- use at your own risk\n");
-			ctrl->apsta = 1;
+			ctrl->apst_enabled = true;
 		} else {
-			ctrl->apsta = 0;
+			ctrl->apst_enabled = false;
 		}
 	} else {
-		ctrl->apsta = id->apsta;
+		ctrl->apst_enabled = true;
 	}
 	memcpy(ctrl->psd, id->psd, sizeof(ctrl->psd));
 
@@ -1760,9 +1769,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	kfree(id);
 
-	if (ctrl->apsta && !prev_apsta)
+	if (ctrl->apst_enabled && !prev_apst_enabled)
 		dev_pm_qos_expose_latency_tolerance(ctrl->device);
-	else if (!ctrl->apsta && prev_apsta)
+	else if (!ctrl->apst_enabled && prev_apst_enabled)
 		dev_pm_qos_hide_latency_tolerance(ctrl->device);
 
 	nvme_configure_apst(ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ec8c7363934d..95d0cdafe0d5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -165,6 +165,7 @@ struct nvme_ctrl {
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
+	bool apst_enabled;
 
 	u32 hmpre;
 	u32 hmmin;
-- 
2.13.1
