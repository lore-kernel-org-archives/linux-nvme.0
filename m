From: info@metux.net (Enrico Weigelt, metux IT consult)
Date: Wed,  6 Mar 2019 19:30:30 +0100
Subject: [PATCH] drivers: nvme: Kconfig: pedantic cleanups
Message-ID: <1551897030-2219-1-git-send-email-info@metux.net>

Signed-off-by: Enrico Weigelt, metux IT consult <info at metux.net>
---
 drivers/nvme/host/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 0f345e2..ce361c9 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -17,10 +17,10 @@ config NVME_MULTIPATH
 	bool "NVMe multipath support"
 	depends on NVME_CORE
 	---help---
-	   This option enables support for multipath access to NVMe
-	   subsystems.  If this option is enabled only a single
-	   /dev/nvmeXnY device will show up for each NVMe namespaces,
-	   even if it is accessible through multiple controllers.
+	  This option enables support for multipath access to NVMe
+	  subsystems.  If this option is enabled only a single
+	  /dev/nvmeXnY device will show up for each NVMe namespaces,
+	  even if it is accessible through multiple controllers.
 
 config NVME_FABRICS
 	tristate
-- 
1.9.1
