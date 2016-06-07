From: hch@lst.de (Christoph Hellwig)
Date: Tue,  7 Jun 2016 17:19:20 +0200
Subject: [PATCH 04/11] Add macro helpers to common.h
In-Reply-To: <1465312767-10070-1-git-send-email-hch@lst.de>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
Message-ID: <1465312767-10070-5-git-send-email-hch@lst.de>

From: Ming Lin <ming.l@ssi.samsung.com>

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-and-tested-by: Sagi Grimberg <sagi at grimberg.me>
Tested-by: Armen Baloyan <armenx.baloyan at intel.com>
---
 common.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 common.h

diff --git a/common.h b/common.h
new file mode 100644
index 0000000..639186d
--- /dev/null
+++ b/common.h
@@ -0,0 +1,9 @@
+#ifndef _COMMON_H
+#define _COMMON_H
+
+#define offsetof(x, y)	__builtin_offsetof(x, y)
+
+#define __round_mask(x, y) ((__typeof__(x))((y)-1))
+#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
+
+#endif
-- 
2.1.4
