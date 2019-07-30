From: Charles.Hyde@dellteam.com (Charles.Hyde@dellteam.com)
Date: Tue, 30 Jul 2019 20:09:15 +0000
Subject: [PATCH] drivers/nvme: save/restore HMB on suspend/resume
Message-ID: <362aad7f1cf547c2a73e1c4f564984db@AUSX13MPS303.AMER.DELL.COM>

LiteOn CL1 devices allocate host memory buffer at initialization.
This patch saves and restores the host memory buffer allocation
for any NVMe device which has HMB.  Devices which have on-board
memory buffers are not impacted.  This patch has been tested locally
with the following devices: LiteOn CL1 and CA3, Hynix BC511 and
PC601, WDC SN520 and SN720.  This patch has also been tested by
our partners at Wistron and Compal.

Signed-off-by: Charles Hyde <charles_hyde at dellteam.com>
Cc: Mario Limonciello <mario.limonciello at dell.com>
Cc: Rajat Jain <rajatja at google.com>
---
 drivers/nvme/host/pci.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db160cee42ad..7c07d6ddbbac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2847,8 +2847,20 @@ static int nvme_resume(struct device *dev)
 	struct nvme_ctrl *ctrl = &ndev->ctrl;
 
 	if (pm_resume_via_firmware() || !ctrl->npss ||
-	    nvme_set_power_state(ctrl, ndev->last_ps) != 0)
-		nvme_reset_ctrl(ctrl);
+	    nvme_set_power_state(ctrl, ndev->last_ps) != 0) {
+		goto reset;
+	}
+
+	/*
+	 * If the device has allocated system memory for host memory buffer,
+	 * such as LiteOn CL1 devices, deal with it.
+	 */
+	if (ndev->host_mem_descs) {
+		if (nvme_setup_host_mem(ndev) != 0) {
+reset:
+			nvme_reset_ctrl(ctrl);
+		}
+	}
 	return 0;
 }
 
@@ -2880,6 +2892,16 @@ static int nvme_suspend(struct device *dev)
 	    ctrl->state != NVME_CTRL_ADMIN_ONLY)
 		goto unfreeze;
 
+	/*
+	 * If the device has allocated system memory for host memory buffer,
+	 * such as LiteOn CL1 devices, we need to deal with that.
+	 */
+	if (ndev->host_mem_descs) {
+		ret = nvme_set_host_mem(ndev, 0);
+		if (ret < 0)
+			goto unfreeze;
+	}
+
 	ndev->last_ps = 0;
 	ret = nvme_get_power_state(ctrl, &ndev->last_ps);
 	if (ret < 0)
-- 
2.20.1
