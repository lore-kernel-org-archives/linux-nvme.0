From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 Aug 2016 17:38:25 +0300
Subject: [PATCH] nvme-rdma: Remove unused includes
Message-ID: <1470321505-9243-1-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f2cf433f628d..6e3ad98b981f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -12,13 +12,11 @@
  * more details.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/string.h>
-#include <linux/jiffies.h>
 #include <linux/atomic.h>
 #include <linux/blk-mq.h>
 #include <linux/types.h>
@@ -26,7 +24,6 @@
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
 #include <linux/nvme.h>
-#include <linux/t10-pi.h>
 #include <asm/unaligned.h>
 
 #include <rdma/ib_verbs.h>
-- 
1.9.1
