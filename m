From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Wed, 27 Feb 2019 15:29:53 +0000
Subject: [PATCH] NVMe-CLI WDC Plugin - add support for additional SN840 device
 ID.
Message-ID: <1551281379-27317-1-git-send-email-jeff.lien@wdc.com>

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 plugins/wdc/wdc-nvme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index ba4d419..b131b1a 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -61,6 +61,7 @@
 #define WDC_NVME_SN630_DEV_ID				0x2200
 #define WDC_NVME_SN630_DEV_ID_1				0x2201
 #define WDC_NVME_SN840_DEV_ID				0x2300
++#define WDC_NVME_SN840_DEV_ID_1			0x2500
 #define WDC_NVME_SN640_DEV_ID				0x2400
 #define WDC_NVME_SN640_DEV_ID_1				0x2401
 #define WDC_NVME_SN640_DEV_ID_2				0x2402
@@ -709,6 +710,8 @@ static __u64 wdc_get_drive_capabilities(int fd) {
 		case WDC_NVME_SN640_DEV_ID_2:
 		/* FALLTHRU */
 		case WDC_NVME_SN840_DEV_ID:
+		/* FALLTHRU */
+		case WDC_NVME_SN840_DEV_ID_1:
 			capabilities = (WDC_DRIVE_CAP_CAP_DIAG | WDC_DRIVE_CAP_INTERNAL_LOG |
 					WDC_DRIVE_CAP_DRIVE_STATUS | WDC_DRIVE_CAP_CLEAR_ASSERT |
 					WDC_DRIVE_CAP_RESIZE | WDC_DRIVE_CAP_CLEAR_PCIE);
-- 
1.8.3.1
