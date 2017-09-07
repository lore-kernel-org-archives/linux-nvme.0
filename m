From: marcolso@amazon.com (Marc Olson)
Date: Wed,  6 Sep 2017 17:23:56 -0700
Subject: [PATCH] nvme: update timeout module parameter type
Message-ID: <1504743836-25516-1-git-send-email-marcolso@amazon.com>

The underlying blk_mq_tag_set, and request timeout parameters support an
unsigned int. Extend the size of the nvme module parameters for io and
admin commands to match.

Signed-off-by: Marc Olson <marcolso at amazon.com>

---
 drivers/nvme/host/core.c | 8 ++++----
 drivers/nvme/host/nvme.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fbeca06..097f678 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -34,13 +34,13 @@
 
 #define NVME_MINORS		(1U << MINORBITS)
 
-unsigned char admin_timeout = 60;
-module_param(admin_timeout, byte, 0644);
+unsigned int admin_timeout = 60;
+module_param(admin_timeout, uint, 0644);
 MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
 EXPORT_SYMBOL_GPL(admin_timeout);
 
-unsigned char nvme_io_timeout = 30;
-module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
+unsigned int nvme_io_timeout = 30;
+module_param_named(io_timeout, nvme_io_timeout, uint, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
 EXPORT_SYMBOL_GPL(nvme_io_timeout);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8edafd8..6afabc4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -30,10 +30,10 @@ enum {
 	NVME_SC_CANCELLED		= -EINTR,
 };
 
-extern unsigned char nvme_io_timeout;
+extern unsigned int nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
 
-extern unsigned char admin_timeout;
+extern unsigned int admin_timeout;
 #define ADMIN_TIMEOUT	(admin_timeout * HZ)
 
 extern unsigned char shutdown_timeout;
-- 
2.7.4
