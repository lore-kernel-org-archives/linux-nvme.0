From: mlin@kernel.org (Ming Lin)
Date: Thu, 19 Nov 2015 16:21:00 -0800
Subject: [RFC PATCH 1/9] nvme-vhost: add initial commit
In-Reply-To: <1447978868-17138-1-git-send-email-mlin@kernel.org>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
Message-ID: <1447978868-17138-2-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/target/Kconfig  | 11 +++++++++++
 drivers/nvme/target/Makefile |  2 ++
 drivers/nvme/target/vhost.c  | 16 ++++++++++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 drivers/nvme/target/vhost.c

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 1bf92db..22760f5 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -12,3 +12,14 @@ config NVME_TARGET_LOOP
 	  to test NVMe host and target side features.
 
 	  If unsure, say N.
+
+config NVME_TARGET_VHOST
+	tristate "NVMe vhost support"
+	depends on BLK_DEV_NVME
+	select NVME_TARGET
+	select VHOST
+	select VHOST_RING
+	help
+	  This enabled the NVMe vhost support.
+
+	  If unsure, say N.
diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index 21e9134..1d8d523 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -1,6 +1,8 @@
 
 obj-$(CONFIG_NVME_TARGET)		+= nvmet.o
 obj-$(CONFIG_NVME_TARGET_LOOP)		+= nvme-loop.o
+obj-$(CONFIG_NVME_TARGET_VHOST)		+= nvme-vhost.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o io-cmd.o
 nvme-loop-y	+= loop.o
+nvme-vhost-y	+= vhost.o
diff --git a/drivers/nvme/target/vhost.c b/drivers/nvme/target/vhost.c
new file mode 100644
index 0000000..623af00
--- /dev/null
+++ b/drivers/nvme/target/vhost.c
@@ -0,0 +1,16 @@
+#include <linux/module.h>
+
+static int __init nvmet_vhost_init(void)
+{
+	return 0;
+}
+module_init(nvmet_vhost_init);
+
+static void nvmet_vhost_exit(void)
+{
+}
+module_exit(nvmet_vhost_exit);
+
+MODULE_AUTHOR("Ming Lin <ming.l at ssi.samsung.com>");
+MODULE_LICENSE("GPL v2");
+
-- 
1.9.1
