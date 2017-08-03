From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu,  3 Aug 2017 11:28:47 +0200
Subject: [PATCH 1/2] nvme: rdma: remove NVME_RDMA_MAX_SEGMENT_SIZE
Message-ID: <20170803092848.7788-1-jthumshirn@suse.de>

NVME_RDMA_MAX_SEGMENT_SIZE is not used anywhere, zap it.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/rdma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index da04df1af231..57ac96ff9acb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -36,8 +36,6 @@
 
 #define NVME_RDMA_CONNECT_TIMEOUT_MS	3000		/* 3 second */
 
-#define NVME_RDMA_MAX_SEGMENT_SIZE	0xffffff	/* 24-bit SGL field */
-
 #define NVME_RDMA_MAX_SEGMENTS		256
 
 #define NVME_RDMA_MAX_INLINE_SEGMENTS	1
-- 
2.12.3
