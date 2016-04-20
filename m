From: shhuiw@foxmail.com (Wang Sheng-Hui)
Date: Wed, 20 Apr 2016 10:04:32 +0800
Subject: [PATCH] NVMe: small typo in section BLK_DEV_NVME_SCSI of host/Kconfig
Message-ID: <1461117872-30435-1-git-send-email-shhuiw@foxmail.com>

"as well as " is miss typed "as well a " in section
"config BLK_DEV_NVME_SCSI"

Signed-off-by: Wang Sheng-Hui <shhuiw at foxmail.com>
---
 drivers/nvme/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index c894841..d296fc3 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -18,7 +18,7 @@ config BLK_DEV_NVME_SCSI
 	depends on NVME_CORE
 	---help---
 	  This adds support for the SG_IO ioctl on the NVMe character
-	  and block devices nodes, as well a a translation for a small
+	  and block devices nodes, as well as a translation for a small
 	  number of selected SCSI commands to NVMe commands to the NVMe
 	  driver.  If you don't know what this means you probably want
 	  to say N here, unless you run a distro that abuses the SCSI
-- 
2.8.1
