From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Jun 2017 16:09:12 -0700
Subject: [PATCH, nvme-cli] fix build without libuuid
Message-ID: <20170628230912.1598-1-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 nvme.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nvme.h b/nvme.h
index b796961..5530f90 100644
--- a/nvme.h
+++ b/nvme.h
@@ -17,6 +17,7 @@
 
 #include <stdbool.h>
 #include <endian.h>
+#include <stdint.h>
 #include "plugin.h"
 #include "json.h"
 
@@ -26,7 +27,7 @@
 #include <uuid/uuid.h>
 #else
 typedef struct {
-	__u8 b[16];
+	uint8_t b[16];
 } uuid_t;
 #endif
 
-- 
2.11.0
