From: daniel.mcleran@intel.com (Dan McLeran)
Date: Fri, 20 Jun 2014 03:22:54 -0600
Subject: [PATCH] NVMe: Create module parameter for shutdown timeout.
Message-ID: <1403256174-3595-1-git-send-email-daniel.mcleran@intel.com>

The current implementation hard-codes shutdown timeout to 2 seconds. Some devices take
longer than this to successfully complete a normal shutdown. This patch creates a module
parameter for shutdown timeout and sets the default to 5 seconds.

Signed-off-by: Dan McLeran <daniel.mcleran at intel.com>
---
 drivers/block/nvme-core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 02351e2..a3c0af7 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -48,6 +48,7 @@
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 #define ADMIN_TIMEOUT		(admin_timeout * HZ)
+#define SHUTDOWN_TIMEOUT	(nvme_shutdown_timeout * HZ)
 #define IOD_TIMEOUT		(retry_time * HZ)
 
 static unsigned char admin_timeout = 60;
@@ -62,6 +63,10 @@ static unsigned char retry_time = 30;
 module_param(retry_time, byte, 0644);
 MODULE_PARM_DESC(retry_time, "time in seconds to retry failed I/O");
 
+unsigned char nvme_shutdown_timeout = 5;
+module_param_named(shutdown_timeout, nvme_shutdown_timeout, byte, 0644);
+MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
+
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
@@ -1428,7 +1433,7 @@ static int nvme_shutdown_ctrl(struct nvme_dev *dev)
 	cc = (readl(&dev->bar->cc) & ~NVME_CC_SHN_MASK) | NVME_CC_SHN_NORMAL;
 	writel(cc, &dev->bar->cc);
 
-	timeout = 2 * HZ + jiffies;
+	timeout = SHUTDOWN_TIMEOUT + jiffies;
 	while ((readl(&dev->bar->csts) & NVME_CSTS_SHST_MASK) !=
 							NVME_CSTS_SHST_CMPLT) {
 		msleep(100);
-- 
1.7.10.4
