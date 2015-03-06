From: axboe@fb.com (Jens Axboe)
Date: Fri, 6 Mar 2015 12:56:13 -0700
Subject: [PATCH] NVMe: increase depth of admin queue
Message-ID: <20150306195613.GA20453@kernel.dk>

Hi,

Usually the admin queue depth of 64 is plenty, but for some use cases we
really need it larger. Examples are use cases like MAT, where you have
to touch all of NAND for init/format like purposes. In those cases, we
see a good 2x increase with an increased queue depth.

Signed-off-by: Jens Axboe <axboe at fb.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ceb32dd52a6c..b67b520e489d 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -44,7 +44,7 @@
 
 #define NVME_MINORS		(1U << MINORBITS)
 #define NVME_Q_DEPTH		1024
-#define NVME_AQ_DEPTH		64
+#define NVME_AQ_DEPTH		256
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 #define ADMIN_TIMEOUT		(admin_timeout * HZ)

-- 
Jens Axboe
