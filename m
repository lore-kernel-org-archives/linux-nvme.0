From: mlin@kernel.org (Ming Lin)
Date: Tue,  9 Feb 2016 16:07:53 -0800
Subject: [PATCH v2 5/5] nvme: split pci module out of core module
In-Reply-To: <1455062873-18392-1-git-send-email-mlin@kernel.org>
References: <1455062873-18392-1-git-send-email-mlin@kernel.org>
Message-ID: <1455062873-18392-6-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

NVMe over Fabrics drivers are going to reuse the core,
so splits nvme.ko into 2 modules:

nvme-core.ko: the core part
nvme.ko: the PCI driver

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/Kconfig  |  6 +++++-
 drivers/nvme/host/Makefile | 10 ++++++----
 drivers/nvme/host/core.c   |  5 +++++
 drivers/nvme/host/pci.c    | 13 +------------
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 5d62373..2ed30f0 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -1,6 +1,10 @@
+config NVME_CORE
+	tristate
+
 config BLK_DEV_NVME
 	tristate "NVM Express block device"
 	depends on PCI && BLOCK
+	select NVME_CORE
 	---help---
 	  The NVM Express driver is for solid state drives directly
 	  connected to the PCI or PCI Express bus.  If you know you
@@ -11,7 +15,7 @@ config BLK_DEV_NVME
 
 config BLK_DEV_NVME_SCSI
 	bool "SCSI emulation for NVMe device nodes"
-	depends on BLK_DEV_NVME
+	depends on NVME_CORE
 	---help---
 	  This adds support for the SG_IO ioctl on the NVMe character
 	  and block devices nodes, as well a a translation for a small
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 51bf908..9a3ca89 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -1,6 +1,8 @@
+obj-$(CONFIG_NVME_CORE)			+= nvme-core.o
+obj-$(CONFIG_BLK_DEV_NVME)		+= nvme.o
 
-obj-$(CONFIG_BLK_DEV_NVME)     += nvme.o
+nvme-core-y				:= core.o
+nvme-core-$(CONFIG_BLK_DEV_NVME_SCSI)	+= scsi.o
+nvme-core-$(CONFIG_NVM)			+= lightnvm.o
 
-lightnvm-$(CONFIG_NVM)			:= lightnvm.o
-nvme-y					+= core.o pci.o $(lightnvm-y)
-nvme-$(CONFIG_BLK_DEV_NVME_SCSI)        += scsi.o
+nvme-y					+= pci.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 740615b..c7df0ab 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1512,3 +1512,8 @@ void nvme_core_exit(void)
 	class_destroy(nvme_class);
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
 }
+
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");
+module_init(nvme_core_init);
+module_exit(nvme_core_exit);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f7266cc..a5a4567 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2221,26 +2221,15 @@ static int __init nvme_init(void)
 	if (!nvme_workq)
 		return -ENOMEM;
 
-	result = nvme_core_init();
-	if (result < 0)
-		goto kill_workq;
-
 	result = pci_register_driver(&nvme_driver);
 	if (result)
-		goto core_exit;
-	return 0;
-
- core_exit:
-	nvme_core_exit();
- kill_workq:
-	destroy_workqueue(nvme_workq);
+		destroy_workqueue(nvme_workq);
 	return result;
 }
 
 static void __exit nvme_exit(void)
 {
 	pci_unregister_driver(&nvme_driver);
-	nvme_core_exit();
 	destroy_workqueue(nvme_workq);
 	BUG_ON(nvme_thread && !IS_ERR(nvme_thread));
 	_nvme_check_size();
-- 
1.9.1
