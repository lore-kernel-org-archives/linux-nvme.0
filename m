From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 19:48:49 +0800
Subject: [PATCH 0811/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802114849.4034-1-baolex.ni@intel.com>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu at intel.com>
Signed-off-by: Baole Ni <baolex.ni at intel.com>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a51584..d0404ab 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -34,17 +34,17 @@
 #define NVME_MINORS		(1U << MINORBITS)
 
 unsigned char admin_timeout = 60;
-module_param(admin_timeout, byte, 0644);
+module_param(admin_timeout, byte, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
 EXPORT_SYMBOL_GPL(admin_timeout);
 
 unsigned char nvme_io_timeout = 30;
-module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
+module_param_named(io_timeout, nvme_io_timeout, byte, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
 EXPORT_SYMBOL_GPL(nvme_io_timeout);
 
 unsigned char shutdown_timeout = 5;
-module_param(shutdown_timeout, byte, 0644);
+module_param(shutdown_timeout, byte, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
 
 static int nvme_major;
-- 
2.9.2
