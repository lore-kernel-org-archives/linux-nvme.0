From: keith.busch@intel.com (Keith Busch)
Date: Mon, 12 Oct 2015 11:37:38 -0600
Subject: [PATCH] NVMe: Add explicit block config dependency
Message-ID: <1444671458-9947-1-git-send-email-keith.busch@intel.com>

The nvme driver was moved from drivers/block, losing our implicit
dependency on CONFIG_BLOCK. This makes it an explicit driver dependency.

Reported-by: Jim Davis <jim.epost at gmail.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 0089f78..002a94a 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -1,6 +1,6 @@
 config BLK_DEV_NVME
 	tristate "NVM Express block device"
-	depends on PCI
+	depends on PCI && BLOCK
 	---help---
 	  The NVM Express driver is for solid state drives directly
 	  connected to the PCI or PCI Express bus.  If you know you
-- 
1.7.10.4
