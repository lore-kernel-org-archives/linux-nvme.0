From: daniel.mcleran@intel.com (Dan McLeran)
Date: Tue,  1 Jul 2014 09:33:32 -0600
Subject: [PATCH] NVMe: Add shutdown timeout as module parameter.
Message-ID: <1404228812-6619-1-git-send-email-daniel.mcleran@intel.com>

The current implementation hard-codes the shutdown timeout to 2 seconds.
Some devices take longer than this to complete a normal shutdown.
Changing the shutdown timeout to a module parameter with a default
timeout of 5 seconds.

Signed-off-by: Dan McLeran <daniel.mcleran at intel.com>
---
 drivers/block/nvme-core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..76949a9 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -48,6 +48,7 @@
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 #define ADMIN_TIMEOUT		(admin_timeout * HZ)
+#define SHUTDOWN_TIMEOUT	(shutdown_timeout * HZ)
 #define IOD_TIMEOUT		(retry_time * HZ)
 
 static unsigned char admin_timeout = 60;
@@ -62,6 +63,10 @@ static unsigned char retry_time = 30;
 module_param(retry_time, byte, 0644);
 MODULE_PARM_DESC(retry_time, "time in seconds to retry failed I/O");
 
+static unsigned char shutdown_timeout = 5;
+module_param(shutdown_timeout, byte, 0644);
+MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
+
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
@@ -1447,7 +1452,7 @@ static int nvme_shutdown_ctrl(struct nvme_dev *dev)
 
 	writel(dev->ctrl_config, &dev->bar->cc);
 
-	timeout = 2 * HZ + jiffies;
+	timeout = SHUTDOWN_TIMEOUT + jiffies;
 	while ((readl(&dev->bar->csts) & NVME_CSTS_SHST_MASK) !=
 							NVME_CSTS_SHST_CMPLT) {
 		msleep(100);
-- 
1.7.10.4
