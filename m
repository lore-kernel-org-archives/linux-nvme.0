From: mlin@kernel.org (Ming Lin)
Date: Wed, 10 Feb 2016 10:03:30 -0800
Subject: [PATCH v3 2/4] nvme: move timeout variables to core.c
In-Reply-To: <1455127412-23940-1-git-send-email-mlin@kernel.org>
References: <1455127412-23940-1-git-send-email-mlin@kernel.org>
Message-ID: <1455127412-23940-3-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

These variables are used by PCI driver and will also be used in the
forthcoming NVMe over Fabrics drivers.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/core.c | 12 ++++++++++++
 drivers/nvme/host/pci.c  | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8adc598..8714847 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -33,6 +33,18 @@
 
 #define NVME_MINORS		(1U << MINORBITS)
 
+unsigned char admin_timeout = 60;
+module_param(admin_timeout, byte, 0644);
+MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
+
+unsigned char nvme_io_timeout = 30;
+module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
+MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
+
+unsigned char shutdown_timeout = 5;
+module_param(shutdown_timeout, byte, 0644);
+MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
+
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e36ca02..e3552d1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -57,18 +57,6 @@
 #define NVME_NR_AEN_COMMANDS	1
 #define NVME_AQ_BLKMQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AEN_COMMANDS)
 
-unsigned char admin_timeout = 60;
-module_param(admin_timeout, byte, 0644);
-MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
-
-unsigned char nvme_io_timeout = 30;
-module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
-MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
-
-unsigned char shutdown_timeout = 5;
-module_param(shutdown_timeout, byte, 0644);
-MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
-
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
-- 
1.9.1
