From: hare@suse.de (Hannes Reinecke)
Date: Fri, 10 Nov 2017 10:58:22 +0100
Subject: [PATCH 1/2] nvme: add Kconfig option 'NVME_MULTIPATH_DEFAULT'
In-Reply-To: <1510307903-3346-1-git-send-email-hare@suse.de>
References: <1510307903-3346-1-git-send-email-hare@suse.de>
Message-ID: <1510307903-3346-2-git-send-email-hare@suse.de>

Add a configuration option to enable or disable NVMe multipath
per default.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/Kconfig     | 11 +++++++++++
 drivers/nvme/host/multipath.c |  8 +++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 4588680..cc0cbab 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -22,6 +22,17 @@ config NVME_MULTIPATH
 	   /dev/nvneXnY device will show up for each NVMe namespaces,
 	   even if it is accessible through multiple controllers.
 
+config NVME_MULTIPATH_DEFAULT
+       bool "NVMe multipath support enabled by default"
+       depends on NVME_MULTIPATH
+	default y
+       ---help---
+          This option enables multipath access to NVMe subsystems
+	  per default. It can be overridden with the boot/module option
+	  nvme_core.multipath later on.
+
+	  If unsure say Y.
+
 config NVME_FABRICS
 	tristate
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 8502758..9ceef3e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -14,7 +14,13 @@
 #include <linux/moduleparam.h>
 #include "nvme.h"
 
-static bool multipath = true;
+#ifdef CONFIG_NVME_MULTIPATH_DEFAULT
+#define NVME_MULTIPATH_DEFAULT true
+#else
+#define NVME_MULTIPATH_DEFAULT false
+#endif
+
+static bool multipath = NVME_MULTIPATH_DEFAULT;
 module_param(multipath, bool, 0644);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
-- 
1.8.5.6
