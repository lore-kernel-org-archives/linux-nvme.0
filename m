From: vishal.l.verma@intel.com (Verma, Vishal L)
Date: Tue, 14 May 2013 19:32:15 +0000
Subject: [PATCH Resend] NVMe: Remove redundant version.h header include
In-Reply-To: <1368500533-9486-1-git-send-email-sachin.kamat@linaro.org>
References: <1368500533-9486-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <0E80A88123A1094A8373D7EE49AF51076D3CFAAD@FMSMSX113.amr.corp.intel.com>

Acked-by: Vishal Verma <vishal.l.verma at linux.intel.com>

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Sachin Kamat
Sent: Monday, May 13, 2013 9:02 PM
To: linux-nvme at lists.infradead.org
Cc: sachin.kamat at linaro.org; willy at linux.intel.com
Subject: [PATCH Resend] NVMe: Remove redundant version.h header include

version.h header inclusion is not necessary as detected by checkversion.pl.

Signed-off-by: Sachin Kamat <sachin.kamat at linaro.org>
---
 drivers/block/nvme-scsi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c index fed54b0..64bde68 100644
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


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://merlin.infradead.org/mailman/listinfo/linux-nvme
