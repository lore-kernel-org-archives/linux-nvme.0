From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 21 Mar 2017 15:59:58 +0200
Subject: [PATCH] nvme-loop: remove unneeded includes
Message-ID: <1490104798-7548-1-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 7053676aa87f..bdf207825718 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -13,12 +13,10 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/scatterlist.h>
-#include <linux/delay.h>
 #include <linux/blk-mq.h>
 #include <linux/nvme.h>
 #include <linux/module.h>
 #include <linux/parser.h>
-#include <linux/t10-pi.h>
 #include "nvmet.h"
 #include "../host/nvme.h"
 #include "../host/fabrics.h"
-- 
2.7.4
