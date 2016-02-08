From: mlin@kernel.org (Ming Lin)
Date: Mon,  8 Feb 2016 14:24:41 -0800
Subject: [PATCH 1/4] nvme: move timeout variables to core.c and export it
In-Reply-To: <1454970284-29543-1-git-send-email-mlin@kernel.org>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
Message-ID: <1454970284-29543-2-git-send-email-mlin@kernel.org>

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/core.c | 14 ++++++++++++++
 drivers/nvme/host/pci.c  | 12 ------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c5bf001..3faed20 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -33,6 +33,20 @@
 
 #define NVME_MINORS		(1U << MINORBITS)
 
+unsigned char admin_timeout = 60;
+module_param(admin_timeout, byte, 0644);
+MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
+EXPORT_SYMBOL_GPL(admin_timeout);
+
+unsigned char nvme_io_timeout = 30;
+module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
+MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
+EXPORT_SYMBOL_GPL(nvme_io_timeout);
+
+unsigned char shutdown_timeout = 5;
+module_param(shutdown_timeout, byte, 0644);
+MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
+
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72ef832..deba7ac 100644
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
