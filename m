From: mario.limonciello@dell.com (Mario Limonciello)
Date: Wed, 14 Aug 2019 15:08:24 -0500
Subject: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW 22301111
Message-ID: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>

One of the components in LiteON CL1 device has limitations that
can be encountered based upon boundary race conditions using the
nvme bus specific suspend to idle flow.

When this situation occurs the drive doesn't resume properly from
suspend-to-idle.

LiteON has confirmed this problem and fixed in the next firmware
version.  As this firmware is already in the field, avoid running
nvme specific suspend to idle flow.

Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
Link: http://lists.infradead.org/pipermail/linux-nvme/2019-July/thread.html
Signed-off-by: Mario Limonciello <mario.limonciello at dell.com>
Signed-off-by: Charles Hyde <charles.hyde at dellteam.com>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  |  3 ++-
 3 files changed, 17 insertions(+), 1 deletion(-)

This patch is the spiritual successor to the previously submitted
patch "[PATCH] drivers/nvme: save/restore HMB on suspend/resume".

After discussion with LiteON, they agreed to resolve the issue
in their next firmware release.

changes from v1:
 * Group all 3 possible CL1 strings together
 * Remove the resume code because it's
   already implied by ndev->last_ps = U32_MAX
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8f3fbe5..02770d6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2251,6 +2251,16 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
 		.vid = 0x1179,
 		.mn = "THNSF5256GPUK TOSHIBA",
 		.quirks = NVME_QUIRK_NO_APST,
+	},
+	/*
+	 * This LiteON CL1-3D*-Q11 firmware version has a race condition
+	 * associated with actions related to suspend to idle.  LiteON has
+	 * resolved the problem in future firmware.
+	 */
+	{
+		.vid = 0x14a4,
+		.fr = "22301111",
+		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
 	}
 };
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 26b563f..fe1ca0d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -92,6 +92,11 @@ enum nvme_quirks {
 	 * Broken Write Zeroes.
 	 */
 	NVME_QUIRK_DISABLE_WRITE_ZEROES		= (1 << 9),
+
+	/*
+	 * Force simple suspend/resume path.
+	 */
+	NVME_QUIRK_SIMPLE_SUSPEND		= (1 << 10),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 108e109..b366f54 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2875,7 +2875,8 @@ static int nvme_suspend(struct device *dev)
 	 * state (which may not be possible if the link is up).
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
-	    !pcie_aspm_enabled(pdev)) {
+	    !pcie_aspm_enabled(pdev) ||
+	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)) {
 		nvme_dev_disable(ndev, true);
 		return 0;
 	}
-- 
2.7.4
