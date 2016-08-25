From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 26 Aug 2016 00:41:15 +0300
Subject: [PATCH 2/2] nvme-rdma: Get rid of redundant defines
In-Reply-To: <1472161275-6642-1-git-send-email-sagi@grimberg.me>
References: <1472161275-6642-1-git-send-email-sagi@grimberg.me>
Message-ID: <1472161275-6642-3-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 881ac28575ef..ab545fb347a0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -43,10 +43,6 @@
 
 #define NVME_RDMA_MAX_INLINE_SEGMENTS	1
 
-#define NVME_RDMA_MAX_PAGES_PER_MR	512
-
-#define NVME_RDMA_DEF_RECONNECT_DELAY	20
-
 /*
  * We handle AEN commands ourselves and don't even let the
  * block layer know about them.
-- 
1.9.1
