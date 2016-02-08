From: mlin@kernel.org (Ming Lin)
Date: Mon,  8 Feb 2016 14:24:44 -0800
Subject: [PATCH 4/4] nvme: split pci module out of core module
In-Reply-To: <1454970284-29543-1-git-send-email-mlin@kernel.org>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
Message-ID: <1454970284-29543-5-git-send-email-mlin@kernel.org>

This splits nvme.ko into 2 modules:
nvme-core.ko: the core part
nvme.ko: the PCI driver

Also changes config name:
s/CONFIG_BLK_DEV_NVME/CONFIG_NVME_PCI
s/CONFIG_BLK_DEV_NVME_SCSI/CONFIG_NVME_SCSI

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/Kconfig  | 10 +++++++---
 drivers/nvme/host/Makefile | 10 ++++++----
 drivers/nvme/host/core.c   |  7 ++++++-
 drivers/nvme/host/pci.c    | 13 +------------
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 5d62373..883dcd6 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -1,6 +1,10 @@
-config BLK_DEV_NVME
+config NVME_CORE
+	tristate
+
+config NVME_PCI
 	tristate "NVM Express block device"
 	depends on PCI && BLOCK
+	select NVME_CORE
 	---help---
 	  The NVM Express driver is for solid state drives directly
 	  connected to the PCI or PCI Express bus.  If you know you
@@ -9,9 +13,9 @@ config BLK_DEV_NVME
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvme.
 
-config BLK_DEV_NVME_SCSI
+config NVME_SCSI
 	bool "SCSI emulation for NVMe device nodes"
-	depends on BLK_DEV_NVME
+	depends on NVME_CORE
 	---help---
 	  This adds support for the SG_IO ioctl on the NVMe character
 	  and block devices nodes, as well a a translation for a small
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 51bf908..98b057e 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -1,6 +1,8 @@
+obj-$(CONFIG_NVME_CORE)		+= nvme-core.o
+obj-$(CONFIG_NVME_PCI)		+= nvme.o
 
-obj-$(CONFIG_BLK_DEV_NVME)     += nvme.o
+nvme-core-y				:= core.o
+nvme-core-$(CONFIG_NVME_SCSI)		+= scsi.o
+nvme-core-$(CONFIG_NVM)			+= lightnvm.o
 
-lightnvm-$(CONFIG_NVM)			:= lightnvm.o
-nvme-y					+= core.o pci.o $(lightnvm-y)
-nvme-$(CONFIG_BLK_DEV_NVME_SCSI)        += scsi.o
+nvme-y					+= pci.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3928366..eaf9d34 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -485,7 +485,7 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		return nvme_user_cmd(ns->ctrl, ns, (void __user *)arg);
 	case NVME_IOCTL_SUBMIT_IO:
 		return nvme_submit_io(ns, (void __user *)arg);
-#ifdef CONFIG_BLK_DEV_NVME_SCSI
+#ifdef CONFIG_NVME_SCSI
 	case SG_GET_VERSION_NUM:
 		return nvme_sg_get_version_num((void __user *)arg);
 	case SG_IO:
@@ -1499,3 +1499,8 @@ void nvme_core_exit(void)
 	class_destroy(nvme_class);
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
 }
+
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");
+module_init(nvme_core_init);
+module_exit(nvme_core_exit);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9797595..4cc32fa 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2220,26 +2220,15 @@ static int __init nvme_init(void)
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
