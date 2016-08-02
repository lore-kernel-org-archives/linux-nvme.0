From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 19:48:54 +0800
Subject: [PATCH 0812/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802114854.4100-1-baolex.ni@intel.com>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu at intel.com>
Signed-off-by: Baole Ni <baolex.ni at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index befac5b..c7bcf34 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -60,7 +60,7 @@ static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
 static bool use_cmb_sqes = true;
-module_param(use_cmb_sqes, bool, 0644);
+module_param(use_cmb_sqes, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
 static struct workqueue_struct *nvme_workq;
-- 
2.9.2
