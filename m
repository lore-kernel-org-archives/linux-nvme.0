From: rakesh@tuxera.com (Rakesh Pandit)
Date: Sun, 23 Apr 2017 20:47:41 +0300
Subject: [PATCH] nvme-cli: Fix build on aarch64-linux-android-4.9
Message-ID: <20170423174741.GA4812@hercules.tuxera.com>

Need to include sys/stat.h to fix:
fabrics.c:414:45: error: 'S_IRUSR' undeclared (first use in this function)
fabrics.c:414:53: error: 'S_IWUSR' undeclared (first use in this function)

Standard header had offsetof predefined.  Fix this trivial warning.
common.h:4:0: warning: "offsetof" redefined
 #define offsetof(x, y) __builtin_offsetof(x, y)
 ^

Signed-off-by: Rakesh Pandit <rakesh at tuxera.com>
---
 common.h  |    2 ++
 fabrics.c |    1 +
 2 files changed, 3 insertions(+)

diff --git a/common.h b/common.h
index f0a94de..6f810c1 100644
--- a/common.h
+++ b/common.h
@@ -1,7 +1,9 @@
 #ifndef _COMMON_H
 #define _COMMON_H
 
+#ifndef offsetof
 #define offsetof(x, y)	__builtin_offsetof(x, y)
+#endif
 
 #define __round_mask(x, y) ((__typeof__(x))((y)-1))
 #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
diff --git a/fabrics.c b/fabrics.c
index a2e8f60..e7f42e3 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -32,6 +32,7 @@
 #include <inttypes.h>
 #include <linux/types.h>
 #include <libgen.h>
+#include <sys/stat.h>
 
 #include "parser.h"
 #include "nvme-ioctl.h"
-- 
1.7.10.4
