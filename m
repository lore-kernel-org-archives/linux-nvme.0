From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Jun 2017 18:30:51 +0200
Subject: [PATCH] nvme: mark shutdown_timeout static
Message-ID: <20170612163051.21795-1-hch@lst.de>

And open code the SHUTDOWN_TIMEOUT macro.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 4 ++--
 drivers/nvme/host/nvme.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0628bfddf480..1a8b0bd77673 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -45,7 +45,7 @@ module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
 EXPORT_SYMBOL_GPL(nvme_io_timeout);
 
-unsigned char shutdown_timeout = 5;
+static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
 
@@ -1379,7 +1379,7 @@ EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 {
-	unsigned long timeout = SHUTDOWN_TIMEOUT + jiffies;
+	unsigned long timeout = jiffies + (shutdown_timeout * HZ);
 	u32 csts;
 	int ret;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 94ec0bc405ed..f27c58b860f4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -27,9 +27,6 @@ extern unsigned char nvme_io_timeout;
 extern unsigned char admin_timeout;
 #define ADMIN_TIMEOUT	(admin_timeout * HZ)
 
-extern unsigned char shutdown_timeout;
-#define SHUTDOWN_TIMEOUT	(shutdown_timeout * HZ)
-
 #define NVME_DEFAULT_KATO	5
 #define NVME_KATO_GRACE		10
 
-- 
2.11.0
