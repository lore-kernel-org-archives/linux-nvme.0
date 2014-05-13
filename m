From: keith.busch@intel.com (Keith Busch)
Date: Tue, 13 May 2014 11:42:02 -0600
Subject: [PATCH 2/2] NVMe: Make admin timeout a module parameter
In-Reply-To: <1400002922-7219-1-git-send-email-keith.busch@intel.com>
References: <1400002922-7219-1-git-send-email-keith.busch@intel.com>
Message-ID: <1400002922-7219-2-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index be4ec45..6a572c5 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -47,9 +47,13 @@
 #define NVME_Q_DEPTH 1024
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
-#define ADMIN_TIMEOUT	(60 * HZ)
+#define ADMIN_TIMEOUT	(admin_timeout * HZ)
 #define IOD_TIMEOUT	(iod_timeout * HZ)
 
+unsigned char admin_timeout = 30;
+module_param(admin_timeout, byte, 0644);
+MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
+
 unsigned char io_timeout = 30;
 module_param(io_timeout, byte, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
-- 
1.7.10.4
