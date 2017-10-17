From: jeff.lien@hgst.com (jeffreyalien)
Date: Tue, 17 Oct 2017 11:56:43 -0500
Subject: [PATCH] nvme-cli : wdc-plugin Add support for WDC SN100 and SN200
 devices.
Message-ID: <20171017165643.31988-1-jeff.lien@hgst.com>

From: jeffreyalien <jeff.lien@wdc.com>

Update the checking for the wdc-plugin commands so that a
"Device not supported" message will be displayed for non-WDC
devices.

Signed-off-by: jeffreyalien <jeff.lien at wdc.com>
---
 wdc-nvme.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/wdc-nvme.c b/wdc-nvme.c
index 03c86c9..b981298 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -47,9 +47,11 @@
 #define WDC_NVME_SUBCMD_SHIFT	8
 
 #define WDC_NVME_LOG_SIZE_DATA_LEN			0x08
+
 /* Device Config */
-#define WDC_NVME_GF_VID		0x1c58
-#define WDC_NVME_GF_CNTL_ID 0x0003
+#define WDC_NVME_VID  			0x1c58
+#define WDC_NVME_SN100_CNTL_ID	0x0003
+#define WDC_NVME_SN200_CNTL_ID	0x0023
 
 /* Capture Diagnostics */
 #define WDC_NVME_CAP_DIAG_HEADER_TOC_SIZE	WDC_NVME_LOG_SIZE_DATA_LEN
@@ -200,9 +202,10 @@ static int wdc_check_device(int fd)
 		return -1;
 	}
 	ret = -1;
-	/* GF : ctrl->cntlid == PCI Device ID, use that with VID to identify GF Device */
-	if ((le32_to_cpu(ctrl.cntlid) == WDC_NVME_GF_CNTL_ID) &&
-			(le32_to_cpu(ctrl.vid) == WDC_NVME_GF_VID))
+	/* WDC : ctrl->cntlid == PCI Device ID, use that with VID to identify WDC Devices */
+	if ((le32_to_cpu(ctrl.vid) == WDC_NVME_VID) &&
+		((le32_to_cpu(ctrl.cntlid) == WDC_NVME_SN100_CNTL_ID) ||
+		(le32_to_cpu(ctrl.cntlid) == WDC_NVME_SN200_CNTL_ID)))
 		ret = 0;
 	else
 		fprintf(stderr, "WARNING : WDC : Device not supported\n");
-- 
1.7.1
