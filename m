From: kai.heng.feng@canonical.com (Kai-Heng Feng)
Date: Mon, 26 Jun 2017 15:01:29 +0800
Subject: [PATCH v2] nvme: explicitly disable APST on quirked devices
Message-ID: <20170626070129.14744-1-kai.heng.feng@canonical.com>

A user reports APST is enabled, even when the NVMe is quirked or with
option "default_ps_max_latency_us=0".

The current logic will not set APST if the device is quirked. But the
NVMe in question will enable APST automatically.

Separate the logic "apst is supported" and "to enable apst", so we can
use the latter one to explicitly disable APST at initialiaztion.

BugLink: https://bugs.launchpad.net/bugs/1699004
Signed-off-by: Kai-Heng Feng <kai.heng.feng at canonical.com>
---
v2:
 - Remove unnecessary check on device state.
 - Correct apst_enabled value when there's no APST quirk matched.

 drivers/nvme/host/core.c | 17 +++++++++--------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 903d5813023a..f0fd1bba3cdb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1372,7 +1372,7 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 	if (!table)
 		return;
 
-	if (ctrl->ps_max_latency_us == 0) {
+	if (!ctrl->apst_enabled || ctrl->ps_max_latency_us == 0) {
 		/* Turn off APST. */
 		apste = 0;
 		dev_dbg(ctrl->device, "APST disabled\n");
@@ -1539,7 +1539,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	u64 cap;
 	int ret, page_shift;
 	u32 max_hw_sectors;
-	u8 prev_apsta;
+	bool prev_apst_enabled;
 
 	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
 	if (ret) {
@@ -1607,16 +1607,17 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->kas = le16_to_cpu(id->kas);
 
 	ctrl->npss = id->npss;
-	prev_apsta = ctrl->apsta;
+	ctrl->apsta = id->apsta;
+	prev_apst_enabled = ctrl->apst_enabled;
 	if (ctrl->quirks & NVME_QUIRK_NO_APST) {
 		if (force_apst && id->apsta) {
 			dev_warn(ctrl->dev, "forcibly allowing APST due to nvme_core.force_apst -- use at your own risk\n");
-			ctrl->apsta = 1;
+			ctrl->apst_enabled = true;
 		} else {
-			ctrl->apsta = 0;
+			ctrl->apst_enabled = false;
 		}
 	} else {
-		ctrl->apsta = id->apsta;
+		ctrl->apst_enabled = id->apsta;
 	}
 	memcpy(ctrl->psd, id->psd, sizeof(ctrl->psd));
 
@@ -1644,9 +1645,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	kfree(id);
 
-	if (ctrl->apsta && !prev_apsta)
+	if (ctrl->apst_enabled && !prev_apst_enabled)
 		dev_pm_qos_expose_latency_tolerance(ctrl->device);
-	else if (!ctrl->apsta && prev_apsta)
+	else if (!ctrl->apst_enabled && prev_apst_enabled)
 		dev_pm_qos_hide_latency_tolerance(ctrl->device);
 
 	nvme_configure_apst(ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9d6a070d4391..dbabe2b728cb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -165,6 +165,7 @@ struct nvme_ctrl {
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
+	bool apst_enabled;
 
 	/* Fabrics only */
 	u16 sqsize;
-- 
2.13.1
