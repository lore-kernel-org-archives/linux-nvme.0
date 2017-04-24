From: rakesh@tuxera.com (Rakesh Pandit)
Date: Mon, 24 Apr 2017 10:44:17 +0300
Subject: [PATCH v2] nvme-cli: Fix build on aarch64-linux-android-4.9
Message-ID: <20170424074417.GA3319@hercules.tuxera.com>

Need to include sys/stat.h to fix:
fabrics.c:414:45: error: 'S_IRUSR' undeclared (first use in this function)
fabrics.c:414:53: error: 'S_IWUSR' undeclared (first use in this function)

Also fix warning:
common.h:4:0:
warning: "offsetof" redefined #define offsetof(x, y)
__builtin_offsetof(x, y) ^

Fix this trivial warning by including stddef.h and removing this
definition.

V2: Instead of using ifndef remove the offsetof definition and include
stddef.h
Signed-off-by: Rakesh Pandit <rakesh at tuxera.com>
---
 common.h  | 2 --
 fabrics.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common.h b/common.h
index f0a94de..8338a3d 100644
--- a/common.h
+++ b/common.h
@@ -1,8 +1,6 @@
 #ifndef _COMMON_H
 #define _COMMON_H
 
-#define offsetof(x, y)	__builtin_offsetof(x, y)
-
 #define __round_mask(x, y) ((__typeof__(x))((y)-1))
 #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
 
diff --git a/fabrics.c b/fabrics.c
index a2e8f60..6648bae 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -32,6 +32,8 @@
 #include <inttypes.h>
 #include <linux/types.h>
 #include <libgen.h>
+#include <sys/stat.h>
+#include <stddef.h>
 
 #include "parser.h"
 #include "nvme-ioctl.h"
-- 
2.9.3
