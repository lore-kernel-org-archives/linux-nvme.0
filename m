From: lijie34@huawei.com (lijie)
Date: Thu, 8 Nov 2018 21:23:17 +0800
Subject: [PATCH] nvme-cli: fix a typo
Message-ID: <1541683397-10260-1-git-send-email-lijie34@huawei.com>

This patch fixes a typo in nvme-cli usage text.
---
 nvme-builtin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-builtin.h b/nvme-builtin.h
index b913cea..a7ea5ae 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -56,7 +56,7 @@ COMMAND_LIST(
 	ENTRY("sanitize", "Submit a sanitize command", sanitize)
 	ENTRY("sanitize-log", "Retrieve sanitize log, show it", sanitize_log)
 	ENTRY("reset", "Resets the controller", reset)
-	ENTRY("subsystem-reset", "Resets the controller", subsystem_reset)
+	ENTRY("subsystem-reset", "Resets the subsystem", subsystem_reset)
 	ENTRY("ns-rescan", "Rescans the NVME namespaces", ns_rescan)
 	ENTRY("show-regs", "Shows the controller registers or properties. Requires character device", show_registers)
 	ENTRY("discover", "Discover NVMeoF subsystems", discover_cmd)
-- 
2.6.4.windows.1
