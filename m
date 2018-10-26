From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 26 Oct 2018 10:08:34 -0700
Subject: [PATCH 3/3] nvme-cli: fix header paths for new structure
In-Reply-To: <20181026170834.23457-1-chaitanya.kulkarni@wdc.com>
References: <20181026170834.23457-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181026170834.23457-3-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 plugins/wdc/wdc-nvme.c | 16 ++++++++--------
 plugins/wdc/wdc-nvme.h |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index 5ef965d..d9c879c 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -31,14 +31,14 @@
 
 #include "linux/nvme_ioctl.h"
 
-#include "nvme.h"
-#include "nvme-print.h"
-#include "nvme-ioctl.h"
-#include "plugin.h"
-#include "json.h"
-
-#include "argconfig.h"
-#include "suffix.h"
+#include "../../nvme.h"
+#include "../../nvme-print.h"
+#include "../../nvme-ioctl.h"
+#include "../../plugin.h"
+#include "../../json.h"
+
+#include "../../argconfig.h"
+#include "../../suffix.h"
 #include <sys/ioctl.h>
 #define CREATE_CMD
 #include "wdc-nvme.h"
diff --git a/plugins/wdc/wdc-nvme.h b/plugins/wdc/wdc-nvme.h
index c2d892b..b7cbaa3 100644
--- a/plugins/wdc/wdc-nvme.h
+++ b/plugins/wdc/wdc-nvme.h
@@ -4,7 +4,7 @@
 #if !defined(WDC_NVME) || defined(CMD_HEADER_MULTI_READ)
 #define WDC_NVME
 
-#include "cmd.h"
+#include "../../cmd.h"
 
 PLUGIN(NAME("wdc", "Western Digital vendor specific extensions"),
 	COMMAND_LIST(
@@ -24,4 +24,4 @@ PLUGIN(NAME("wdc", "Western Digital vendor specific extensions"),
 
 #endif
 
-#include "define_cmd.h"
+#include "../../define_cmd.h"
-- 
2.17.0
