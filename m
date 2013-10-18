From: m@bjorling.me (Matias Bjorling)
Date: Fri, 18 Oct 2013 15:14:21 +0200
Subject: [PATCH 2/3] NVMe: Extract admin queue size
In-Reply-To: <1382102062-22270-1-git-send-email-m@bjorling.me>
References: <1382102062-22270-1-git-send-email-m@bjorling.me>
Message-ID: <1382102062-22270-3-git-send-email-m@bjorling.me>

The queue size of the admin queue should be defined as a constant for use in
multiple places.

Signed-off-by: Matias Bjorling <m at bjorling.me>
---
 drivers/block/nvme-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index da52092..e99a30a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -44,6 +44,7 @@
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
 
 #define NVME_Q_DEPTH 1024
+#define NVME_ADMIN_Q_DEPTH 64
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 #define NVME_MINORS 64
@@ -1264,7 +1265,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 
 	nvmeq = dev->queues[0];
 	if (!nvmeq) {
-		nvmeq = nvme_alloc_queue(dev, 0, 64, 0);
+		nvmeq = nvme_alloc_queue(dev, 0, NVME_ADMIN_Q_DEPTH, 0);
 		if (!nvmeq)
 			return -ENOMEM;
 		dev->queues[0] = nvmeq;
-- 
1.8.1.2
