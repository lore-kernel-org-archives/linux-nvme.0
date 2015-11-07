From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 18:00:39 +0100
Subject: [PATCH 4/8] nvme: move the timeout module paramters to common code
In-Reply-To: <1446915643-21175-1-git-send-email-hch@lst.de>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
Message-ID: <1446915643-21175-5-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 8 ++++++++
 drivers/nvme/host/pci.c  | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2254ce9..6737aaf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -33,6 +33,14 @@
 
 #define NVME_MINORS		(1U << MINORBITS)
 
+unsigned char admin_timeout = 60;
+module_param(admin_timeout, byte, 0644);
+MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
+
+unsigned char nvme_io_timeout = 30;
+module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
+MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
+
 static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 45255e3..91522bb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -49,14 +49,6 @@
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 
-unsigned char admin_timeout = 60;
-module_param(admin_timeout, byte, 0644);
-MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
-
-unsigned char nvme_io_timeout = 30;
-module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
-MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
-
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
-- 
1.9.1
