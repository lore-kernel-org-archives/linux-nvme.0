From: keith.busch@intel.com (Keith Busch)
Date: Fri, 20 Oct 2017 16:18:03 -0600
Subject: [PATCH] nvme: Remove unused headers
Message-ID: <20171020221803.30484-1-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 11e6fd9d0ba4..7e4d704ec198 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -13,7 +13,6 @@
  */
 
 #include <linux/aer.h>
-#include <linux/bitops.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-pci.h>
@@ -26,12 +25,9 @@
 #include <linux/mutex.h>
 #include <linux/once.h>
 #include <linux/pci.h>
-#include <linux/poison.h>
 #include <linux/t10-pi.h>
-#include <linux/timer.h>
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
-#include <asm/unaligned.h>
 #include <linux/sed-opal.h>
 
 #include "nvme.h"
-- 
2.13.6
