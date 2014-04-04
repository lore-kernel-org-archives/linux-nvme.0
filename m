From: keith.busch@intel.com (Keith Busch)
Date: Fri,  4 Apr 2014 11:43:36 -0600
Subject: [PATCH] NVMe: Make IO timeout a module parameter
Message-ID: <1396633416-6000-1-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    5 +++++
 include/linux/nvme.h      |    3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 625259d..b43d2b6 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -50,6 +50,11 @@
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 #define ADMIN_TIMEOUT	(60 * HZ)
 
+ushort io_timeout = 5;
+module_param(io_timeout, ushort, 0644);
+MODULE_PARM_DESC(io_timeout,
+			"timeout in seconds for io submitted to h/w queue");
+
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 15d071e..2a28d84 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -66,7 +66,8 @@ enum {
 
 #define NVME_VS(major, minor)	(major << 16 | minor)
 
-#define NVME_IO_TIMEOUT	(5 * HZ)
+extern ushort io_timeout;
+#define NVME_IO_TIMEOUT	(io_timeout * HZ)
 
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
-- 
1.7.10.4
