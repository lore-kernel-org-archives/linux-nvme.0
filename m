From: keith.busch@intel.com (Keith Busch)
Date: Tue, 13 May 2014 11:42:01 -0600
Subject: [PATCH 1/2] NVMe: Make iod bio timeout a parameter
Message-ID: <1400002922-7219-1-git-send-email-keith.busch@intel.com>

This was originally set to 4 times the IO timeout, but that was when
the IO timeout was 5 seconds instead of 30. 20 seconds for total time
to failure seemed more reasonable than 2 minutes for most, but other
users have requested to make this a module parameter instead.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cd8a8bc7..be4ec45 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -48,12 +48,16 @@
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 #define ADMIN_TIMEOUT	(60 * HZ)
-#define IOD_TIMEOUT	(4 * NVME_IO_TIMEOUT)
+#define IOD_TIMEOUT	(iod_timeout * HZ)
 
 unsigned char io_timeout = 30;
 module_param(io_timeout, byte, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
 
+unsigned char iod_timeout = 30;
+module_param(iod_timeout, byte, 0644);
+MODULE_PARM_DESC(iod_timeout, "time in seconds to retry failed I/O");
+
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
-- 
1.7.10.4
