From: keith.busch@intel.com (Keith Busch)
Date: Thu, 26 Apr 2018 15:49:55 -0600
Subject: [PATCH 1/2] nvme/multipath: Disable runtime writable enabling
 parameter
In-Reply-To: <20180426214956.3377-1-keith.busch@intel.com>
References: <20180426214956.3377-1-keith.busch@intel.com>
Message-ID: <20180426214956.3377-2-keith.busch@intel.com>

We can't allow the user to change multipath settings at runtime, as this
will create naming conflicts due to the different naming schemes used
for each mode.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 956e0b8e9c4d..3ded009e7631 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -15,7 +15,7 @@
 #include "nvme.h"
 
 static bool multipath = true;
-module_param(multipath, bool, 0644);
+module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
-- 
2.14.3
