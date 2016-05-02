From: jonathan.derrick@intel.com (Jon Derrick)
Date: Mon,  2 May 2016 09:28:12 -0600
Subject: [PATCH] nvme: Make CMB module parameter read-only
Message-ID: <1462202892-3429-1-git-send-email-jonathan.derrick@intel.com>

This patch changes the use_cmb_sqes module parameter to read-only. This
parameter allows the driver to place IO submission queues within the
Controller Memory Buffer. Memory allocated for queues aren't
dynamically reallocated between resets. For this reason, allowing the
use_cmb_sqes module parameter to be written may be confusing because it
should not be allowed.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4fd733f..83de5569 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -61,7 +61,7 @@ static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
 static bool use_cmb_sqes = true;
-module_param(use_cmb_sqes, bool, 0644);
+module_param(use_cmb_sqes, bool, 0444);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
 static struct workqueue_struct *nvme_workq;
-- 
1.8.3.1
