From: xerofoify@gmail.com (Nicholas Krause)
Date: Wed, 13 May 2015 12:21:18 -0400
Subject: [PATCH] block:Remove including of the header file,
 linux/mm.h for the file, nvme-core.c
Message-ID: <1431534078-17740-1-git-send-email-xerofoify@gmail.com>

This removes the include statement for including the header file,
linux/mm.h in the file, nvme-core.c due this driver file never
calling any functions from the header file, linux/mm.h  and
only adding bloat to this driver by including this unnessary
header file.

Signed-off-by: Nicholas Krause <xerofoify at gmail.com>
---
 drivers/block/nvme-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 85b8036..8edf262 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -29,7 +29,6 @@
 #include <linux/kdev_t.h>
 #include <linux/kthread.h>
 #include <linux/kernel.h>
-#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
-- 
2.1.4
