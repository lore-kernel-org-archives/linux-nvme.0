From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Wed, 23 Dec 2015 21:05:26 +0530
Subject: [PATCH v2] PCI/AER: include header file
Message-ID: <1450884926-15014-1-git-send-email-sudipm.mukherjee@gmail.com>

We are having build failure with sparc allmodconfig with the error:

drivers/nvme/host/pci.c:15:0:
include/linux/aer.h: In function 'pci_enable_pcie_error_reporting':
include/linux/aer.h:49:10: error: 'EINVAL' undeclared (first use in this function)

The file aer.h is using the error values but they are defined in
errno.h. Include errno.h so that we have the definitions of the error
codes.

Fixes: a0a3408ee614 ("NVMe: Add pci error handlers")
Cc: Keith Busch <keith.busch at intel.com>
Signed-off-by: Sudip Mukherjee <sudip at vectorindia.org>
---

v1 and its review is at:
https://lkml.org/lkml/2015/12/23/226

sparc allmodconfig build is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/98451364


 include/linux/aer.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/aer.h b/include/linux/aer.h
index 744b997..1640493 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -7,6 +7,7 @@
 #ifndef _AER_H_
 #define _AER_H_
 
+#include <linux/errno.h>
 #include <linux/types.h>
 
 #define AER_NONFATAL			0
-- 
1.9.1
