From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 12 May 2019 16:34:09 +0900
Subject: [PATCH V3 1/5] nvme: Make trace common for host and target both
In-Reply-To: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
References: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
Message-ID: <20190512073413.32050-2-minwoo.im.dev@gmail.com>

To support target-side trace, nvme-trace should be commonized for host
and target both.  Of course, not every single tracepoints are necessary
by both of them, but we don't need to have more than one trace module
for host and target.

Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: James Smart <james.smart at broadcom.com>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 MAINTAINERS                     | 2 ++
 drivers/nvme/Makefile           | 3 +++
 drivers/nvme/host/Makefile      | 1 -
 drivers/nvme/host/core.c        | 3 +--
 drivers/nvme/host/pci.c         | 2 +-
 drivers/nvme/{host => }/trace.c | 5 +++++
 drivers/nvme/{host => }/trace.h | 2 +-
 7 files changed, 13 insertions(+), 5 deletions(-)
 rename drivers/nvme/{host => }/trace.c (95%)
 rename drivers/nvme/{host => }/trace.h (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09f43f1bdd15..5974cadafcf7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11084,6 +11084,7 @@ L:	linux-nvme at lists.infradead.org
 T:	git://git.infradead.org/nvme.git
 W:	http://git.infradead.org/nvme.git
 S:	Supported
+F:	drivers/nvme/
 F:	drivers/nvme/host/
 F:	include/linux/nvme.h
 F:	include/uapi/linux/nvme_ioctl.h
@@ -11105,6 +11106,7 @@ L:	linux-nvme at lists.infradead.org
 T:	git://git.infradead.org/nvme.git
 W:	http://git.infradead.org/nvme.git
 S:	Supported
+F:	drivers/nvme/
 F:	drivers/nvme/target/
 
 NVMEM FRAMEWORK
diff --git a/drivers/nvme/Makefile b/drivers/nvme/Makefile
index 0096a7fd1431..12f193502d46 100644
--- a/drivers/nvme/Makefile
+++ b/drivers/nvme/Makefile
@@ -1,3 +1,6 @@
 
+ccflags-y		+= -I$(src)
+obj-$(CONFIG_TRACING)	+= trace.o
+
 obj-y		+= host/
 obj-y		+= target/
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 8a4b671c5f0c..46453352bfa0 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 
 nvme-core-y				:= core.o
-nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
 nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eebaeadaa800..ae76c0b78a5f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -21,8 +21,7 @@
 #include <linux/pm_qos.h>
 #include <asm/unaligned.h>
 
-#define CREATE_TRACE_POINTS
-#include "trace.h"
+#include "../trace.h"
 
 #include "nvme.h"
 #include "fabrics.h"
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a8708c9ac18..d90b66543d25 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -24,7 +24,7 @@
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
 
-#include "trace.h"
+#include "../trace.h"
 #include "nvme.h"
 
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/trace.c
similarity index 95%
rename from drivers/nvme/host/trace.c
rename to drivers/nvme/trace.c
index 5f24ea7a28eb..a2c8186d122d 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/trace.c
@@ -5,6 +5,8 @@
  */
 
 #include <asm/unaligned.h>
+
+#define CREATE_TRACE_POINTS
 #include "trace.h"
 
 static const char *nvme_trace_create_sq(struct trace_seq *p, u8 *cdw10)
@@ -147,4 +149,7 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
 }
 EXPORT_SYMBOL_GPL(nvme_trace_disk_name);
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_setup_cmd);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_complete_rq);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_async_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_sq);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/trace.h
similarity index 99%
rename from drivers/nvme/host/trace.h
rename to drivers/nvme/trace.h
index 97d3c77365b8..acf10c7a5bef 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/trace.h
@@ -14,7 +14,7 @@
 #include <linux/tracepoint.h>
 #include <linux/trace_seq.h>
 
-#include "nvme.h"
+#include "host/nvme.h"
 
 #define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
 #define show_admin_opcode_name(val)					\
-- 
2.17.1
