From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 14 May 2013 08:32:13 +0530
Subject: [PATCH Resend] NVMe: Remove redundant version.h header include
Message-ID: <1368500533-9486-1-git-send-email-sachin.kamat@linaro.org>

version.h header inclusion is not necessary as detected by
checkversion.pl.

Signed-off-by: Sachin Kamat <sachin.kamat at linaro.org>
---
 drivers/block/nvme-scsi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index fed54b0..64bde68 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -44,7 +44,6 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/version.h>
 #include <scsi/sg.h>
 #include <scsi/scsi.h>
 
-- 
1.7.9.5
