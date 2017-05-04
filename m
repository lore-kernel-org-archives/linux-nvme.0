From: agk@godking.net (Alexander Kappner)
Date: Wed,  3 May 2017 19:02:07 -0700
Subject: [PATCH] nvme-core: add apst_override param to force APST if
 controller does not report APSTA=1
Message-ID: <1493863327-18024-1-git-send-email-agk@godking.net>

Some buggy NVMe controllers support APST (autonomous power
state transitions), but do not report APSTA=1. On these controllers, the NVMe
driver does not enable APST support. I have verified this problem occurring
on
	- Samsung 960 Pro 2TB (Firmware 2B6QCXP7, current as of 5/4/17) 
	- Samsung 960 Pro 1TB (Firmware 3L0QCXY7) 

These disks support APST, but
assert APSTA=0 and so never get enabled in the driver.

This patch introduces an apst_override module parameter.
By booting with nvme_core.apst_override=1, the driver can force using APST
on disks which claim to not support it. This patch
successfully enables APST on both Samsung disks.

This patch also introduces an additional sanity check on the NPSS to mitigate
the risk of force-enabling APST on disks that genuinely do not support it.

Signed-off-by: Alexander Kappner <agk at godking.net>
---
 drivers/nvme/host/core.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d33f829..73db723 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -61,6 +61,11 @@ module_param(default_ps_max_latency_us, ulong, 0644);
 MODULE_PARM_DESC(default_ps_max_latency_us,
 		 "max power saving latency for new devices; use PM QOS to change per device");
 
+static int nvme_apst_override = -1;
+module_param_named(apst_override, nvme_apst_override, int, 0644);
+MODULE_PARM_DESC(apst_override,
+		 "Force device APST capability bit (0=force off, 1=force on) to quirk buggy controllers.");
+
 static LIST_HEAD(nvme_ctrl_list);
 static DEFINE_SPINLOCK(dev_list_lock);
 
@@ -1314,13 +1319,31 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 	int ret;
 
 	/*
+	 * APSTA - Autonomous Power State Transition Attributes
+	 * Bit 0 should be set to 1 if APST supported, otherwise 0.
+	 * (NVMe 1.2a).
+	 *
+	 * Some controllers (e.g. Samsung 960 Pro) support APST,.
+	 * but send APSTA=0. This can be quirked around by setting
+	 * apst_override=1.
+	 */
+	if (nvme_apst_override != -1 && ctrl->apsta != nvme_apst_override) {
+		dev_dbg(ctrl->device, "Overriding APSTA.\n");
+		ctrl->apsta = nvme_apst_override;
+	}
+	/*
 	 * If APST isn't supported or if we haven't been initialized yet,
 	 * then don't do anything.
 	 */
 	if (!ctrl->apsta)
+		dev_dbg(ctrl->device, "APSTA not set, disabling APST.\n");
 		return;
 
-	if (ctrl->npss > 31) {
+	/*
+	 * NPSS - Number of Power States Support
+	 * Zero-based; valid entries are 1-32. (NVMe 1.2a).
+	 */
+	if (ctrl->npss < 1 || ctrl->npss > 31) {
 		dev_warn(ctrl->device, "NPSS is invalid; not using APST\n");
 		return;
 	}
-- 
2.1.4
