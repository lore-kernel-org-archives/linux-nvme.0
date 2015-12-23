From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Wed, 23 Dec 2015 19:07:07 +0530
Subject: [PATCH] nvme: arrange header files
Message-ID: <1450877827-19983-1-git-send-email-sudipm.mukherjee@gmail.com>

We are having build failure with sparc allmodconfig with the error:
drivers/nvme/host/pci.c:15:0:
include/linux/aer.h: In function 'pci_enable_pcie_error_reporting':
include/linux/aer.h:49:10: error: 'EINVAL' undeclared (first use in this function)

The file aer.h is using the error values but they are defined in
errno.h. So if we keep aer.h at the top of header file then we do not
have any definition of EINVAL.

Fixes: a0a3408ee614 ("NVMe: Add pci error handlers")
Cc: Keith Busch <keith.busch at intel.com>
Signed-off-by: Sudip Mukherjee <sudip at vectorindia.org>
---

If you insist on having the headers in alphabetical order then I can
send v2 by including errno.h in aer.h

sparc allmodconfig build is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/98451364

 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 92fa1a6..1124a7a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -12,13 +12,13 @@
  * more details.
  */
 
+#include <linux/errno.h>
 #include <linux/aer.h>
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
-#include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/genhd.h>
 #include <linux/hdreg.h>
-- 
1.9.1
