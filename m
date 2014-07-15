From: mundu2510@gmail.com (Mundu)
Date: Tue, 15 Jul 2014 23:06:38 +0530
Subject: [PATCH 1/1] NVMe I/O queue depth change to module parameter
Message-ID: <1405445798-6440-1-git-send-email-mundu2510@gmail.com>

Signed-off-by: Mundu <mundu2510 at gmail.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..e8e88d6 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -44,12 +44,15 @@
 
 #include <trace/events/block.h>
 
-#define NVME_Q_DEPTH		1024
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 #define ADMIN_TIMEOUT		(admin_timeout * HZ)
 #define IOD_TIMEOUT		(retry_time * HZ)
 
+static unsigned short int nvme_q_depth = 1024;
+module_param(nvme_q_depth, unsigned short int, 0);
+MODULE_PARM_DESC(nvme_q_depth, "queue depth in number of entries for I/O queues");
+
 static unsigned char admin_timeout = 60;
 module_param(admin_timeout, byte, 0644);
 MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
@@ -2373,7 +2376,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
 		goto unmap;
 	}
 	cap = readq(&dev->bar->cap);
-	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
+	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, nvme_q_depth);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
 
-- 
1.9.1
