From: hch@lst.de (Christoph Hellwig)
Date: Thu, 24 Dec 2015 11:15:55 +0100
Subject: [PATCH 3/3] nvme: make SG_IO support optional
In-Reply-To: <1450952155-8693-1-git-send-email-hch@lst.de>
References: <1450952155-8693-1-git-send-email-hch@lst.de>
Message-ID: <1450952155-8693-4-git-send-email-hch@lst.de>

Translation SCSI commands to NVMe commands is rather pointless in general
as applications must not expext to be able to use SCSI commands on a
generic block device.

Make the huge translation layer optional and hope no one will ever enable
it in the future.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/Kconfig  | 11 +++++++++++
 drivers/nvme/host/Makefile |  3 ++-
 drivers/nvme/host/core.c   |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 002a94a..5d62373 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -8,3 +8,14 @@ config BLK_DEV_NVME
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvme.
+
+config BLK_DEV_NVME_SCSI
+	bool "SCSI emulation for NVMe device nodes"
+	depends on BLK_DEV_NVME
+	---help---
+	  This adds support for the SG_IO ioctl on the NVMe character
+	  and block devices nodes, as well a a translation for a small
+	  number of selected SCSI commands to NVMe commands to the NVMe
+	  driver.  If you don't know what this means you probably want
+	  to say N here, and if you know what it means you probably
+	  want to say N as well.
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 3e26dc9..baf9f52 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -1,4 +1,5 @@
 
 obj-$(CONFIG_BLK_DEV_NVME)     += nvme.o
 
-nvme-y		+= core.o pci.o scsi.o lightnvm.o
+nvme-y					+= core.o pci.o lightnvm.o
+nvme-$(CONFIG_BLK_DEV_NVME_SCSI)        += scsi.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 19b854e..570a36c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -467,10 +467,12 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		return nvme_user_cmd(ns->ctrl, ns, (void __user *)arg);
 	case NVME_IOCTL_SUBMIT_IO:
 		return nvme_submit_io(ns, (void __user *)arg);
+#ifdef CONFIG_BLK_DEV_NVME_SCSI
 	case SG_GET_VERSION_NUM:
 		return nvme_sg_get_version_num((void __user *)arg);
 	case SG_IO:
 		return nvme_sg_io(ns, (void __user *)arg);
+#endif
 	default:
 		return -ENOTTY;
 	}
-- 
1.9.1
