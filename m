From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  1 Nov 2016 10:41:41 +0200
Subject: [PATCH] nvme-rdma: remove redundant define and include
Message-ID: <1477989701-30810-1-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f90b32dddd7f..19d9242fcc78 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -28,7 +28,6 @@
 
 #include <rdma/ib_verbs.h>
 #include <rdma/rdma_cm.h>
-#include <rdma/ib_cm.h>
 #include <linux/nvme-rdma.h>
 
 #include "nvme.h"
@@ -43,8 +42,6 @@
 
 #define NVME_RDMA_MAX_INLINE_SEGMENTS	1
 
-#define NVME_RDMA_MAX_PAGES_PER_MR	512
-
 #define NVME_RDMA_DEF_RECONNECT_DELAY	20
 
 /*
-- 
2.7.4
