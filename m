From: hare@suse.de (Hannes Reinecke)
Date: Thu, 10 Jan 2019 09:10:06 +0100
Subject: [PATCH] nvme-cli: Fixup compilation with user-defined CFLAGS
Message-ID: <20190110081006.35288-1-hare@suse.de>

Calling 'make CFLAGS="-Wall"' breaks compilation as the include
statement will be overwritten.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 525616a..4ea19dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,5 @@
-CFLAGS ?= -O2 -g -Wall -Werror -I.
-CFLAGS += -std=gnu99
+CFLAGS ?= -O2 -g -Wall -Werror
+CFLAGS += -I. -std=gnu99
 CPPFLAGS += -D_GNU_SOURCE -D__CHECK_ENDIAN__
 LIBUUID = $(shell $(LD) -o /dev/null -luuid >/dev/null 2>&1; echo $$?)
 NVME = nvme
-- 
2.13.7
