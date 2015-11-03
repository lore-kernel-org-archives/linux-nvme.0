From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Wed, 4 Nov 2015 00:47:40 +0100
Subject: [PATCH 1/2] nvme: add support for Apple NVMe controller
In-Reply-To: <33537e8a12dff1f96eaec9098724d01e@localhost>
References: <33537e8a12dff1f96eaec9098724d01e@localhost>
Message-ID: <a59fbe4252293ecbcbf8063659f06d51@localhost>

Some controllers may require ordered split transfers even on 64bit
machines, e.g. Apple's NVMe controller as found in the MacBook8,1 and
MacBookAir7,1 (256/512GB models).

This patch enforces ordered split transfers on 64bit platforms, which
works around that issue for all controllers. As pointed out by Christoph
[1] there should be no performance impact due to that modification.

[1] http://lists.infradead.org/pipermail/linux-nvme/2015-November/002965.html

Signed-off-by: Stephan Guenther <guenther at tum.de>
Signed-off-by: Maurice Leclaire <leclaire at in.tum.de>
---
 drivers/block/nvme-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ccc0c1f..2f1766b 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -43,6 +43,14 @@
 #include <scsi/sg.h>
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
 
+/*
+ * Some controllers may require ordered split transfers even on 64bit
+ * platforms, e.g. Apple's NVMe controller as found in the MacBook8,1 and
+ * MacBookAir7,1 (256/512GB models).
+ */
+#define readq lo_hi_readq
+#define writeq lo_hi_writeq
+
 #define NVME_MINORS		(1U << MINORBITS)
 #define NVME_Q_DEPTH		1024
 #define NVME_AQ_DEPTH		256
