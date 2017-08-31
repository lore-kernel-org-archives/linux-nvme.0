From: changpeng.liu@intel.com (Changpeng Liu)
Date: Thu, 31 Aug 2017 15:55:49 +0800
Subject: [PATCH v2] nvme: fix the definition of Admin doorbell buffer config
 support
Message-ID: <1504166149-16770-1-git-send-email-changpeng.liu@intel.com>

NVMe 1.3 specification defines the Optional Admin Command Support
feature flags, bit 8 set to '1' then the controller supports the
Doorbell Buffer Config command. Bit 7 is used for Virtualization
Mangement command.

Signed-off-by: Changpeng Liu <changpeng.liu at intel.com>
---
 include/linux/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 25d8225..8efff88 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -254,7 +254,7 @@ enum {
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
-	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 7,
+	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
 };
 
 struct nvme_lbaf {
-- 
1.9.3
