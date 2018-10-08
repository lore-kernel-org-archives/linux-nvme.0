From: bvanassche@acm.org (Bart Van Assche)
Date: Mon,  8 Oct 2018 14:28:48 -0700
Subject: [PATCH 10/16] nvmet-fcloop: Suppress a compiler warning
In-Reply-To: <20181008212854.68310-1-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
Message-ID: <20181008212854.68310-11-bvanassche@acm.org>

Building with W=1 enables the compiler warning -Wimplicit-fallthrough=3. That
option does not recognize the fall-through comment in the fcloop driver. Hence
relax that compiler option. This patch avoids that the compiler reports the
following warning when building with W=1:

drivers/nvme/target/fcloop.c:647:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (op == NVMET_FCOP_READDATA)
      ^

Cc: James Smart <james.smart at broadcom.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/target/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index 8118c93391c6..ed578a73a376 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+ccflags-y += $(call cc-option,-Wimplicit-fallthrough=2)
+
 obj-$(CONFIG_NVME_TARGET)		+= nvmet.o
 obj-$(CONFIG_NVME_TARGET_LOOP)		+= nvme-loop.o
 obj-$(CONFIG_NVME_TARGET_RDMA)		+= nvmet-rdma.o
-- 
2.19.0.605.g01d371f741-goog
