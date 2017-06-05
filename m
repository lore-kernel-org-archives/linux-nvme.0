From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  5 Jun 2017 11:20:47 +0300
Subject: [PATCH] nvme-pci: remove redundant includes
Message-ID: <1496650847-30157-1-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d52701df7245..173ab31aae80 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -17,28 +17,15 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-pci.h>
-#include <linux/cpu.h>
-#include <linux/delay.h>
 #include <linux/dmi.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/genhd.h>
-#include <linux/hdreg.h>
-#include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/kdev_t.h>
-#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/poison.h>
-#include <linux/ptrace.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
 #include <linux/t10-pi.h>
 #include <linux/timer.h>
 #include <linux/types.h>
-- 
2.7.4
