From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 28 Sep 2015 19:19:35 -0700
Subject: [PATCH 1/4] nvme: move block nvme driver into directory
 drivers/nvme as subdir host
Message-ID: <1443493175.3449.13.camel@linux.intel.com>

>From 76baaf25a03de9f04cebfbc6c834995d2a48d330 Mon Sep 17 00:00:00 2001
From: Jay Sternberg <jay.e.sternberg@intel.com>
Date: Mon, 28 Sep 2015 11:18:29 -0700
Subject: [PATCH 1/4] nvme: move block nvme driver into directory
drivers/nvme as subdir host

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
---
 drivers/Kconfig                                 |    2 ++
 drivers/Makefile                                |    1 +
 drivers/block/Kconfig                           |   11 -----------
 drivers/block/Makefile                          |    2 --
 drivers/nvme/Kconfig                            |   11 +++++++++++
 drivers/nvme/Makefile                           |    1 +
 drivers/nvme/host/Kconfig                       |   12 ++++++++++++
 drivers/nvme/host/Makefile                      |    3 +++
 drivers/{block/nvme-core.c => nvme/host/core.c} |    0
 drivers/{block/nvme-scsi.c => nvme/host/scsi.c} |    0
 10 files changed, 30 insertions(+), 13 deletions(-)
 create mode 100644 drivers/nvme/Kconfig
 create mode 100644 drivers/nvme/Makefile
 create mode 100644 drivers/nvme/host/Kconfig
 create mode 100644 drivers/nvme/host/Makefile
 rename drivers/{block/nvme-core.c => nvme/host/core.c} (100%)
 rename drivers/{block/nvme-scsi.c => nvme/host/scsi.c} (100%)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 46b4a8e..e69ec82 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -18,6 +18,8 @@ source "drivers/pnp/Kconfig"
 
 source "drivers/block/Kconfig"
 
+source "drivers/nvme/Kconfig"
+
 # misc before ide - BLK_DEV_SGIIOC4 depends on SGI_IOC4
 
 source "drivers/misc/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index b250b36..9307e0a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_NUBUS)		+= nubus/
 obj-y				+= macintosh/
 obj-$(CONFIG_IDE)		+= ide/
 obj-$(CONFIG_SCSI)		+= scsi/
+obj-$(CONFIG_NVME)		+= nvme/
 obj-$(CONFIG_ATA)		+= ata/
 obj-$(CONFIG_TARGET_CORE)	+= target/
 obj-$(CONFIG_MTD)		+= mtd/
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 1b8094d..29819e7 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -310,17 +310,6 @@ config BLK_DEV_NBD
 
 	  If unsure, say N.
 
-config BLK_DEV_NVME
-	tristate "NVM Express block device"
-	depends on PCI
-	---help---
-	  The NVM Express driver is for solid state drives directly
-	  connected to the PCI or PCI Express bus.  If you know you
-	  don't have one of these, it is safe to answer N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called nvme.
-
 config BLK_DEV_SKD
 	tristate "STEC S1120 Block Driver"
 	depends on PCI
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 02b688d..6713290 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -22,7 +22,6 @@ obj-$(CONFIG_XILINX_SYSACE)	+= xsysace.o
 obj-$(CONFIG_CDROM_PKTCDVD)	+= pktcdvd.o
 obj-$(CONFIG_MG_DISK)		+= mg_disk.o
 obj-$(CONFIG_SUNVDC)		+= sunvdc.o
-obj-$(CONFIG_BLK_DEV_NVME)	+= nvme.o
 obj-$(CONFIG_BLK_DEV_SKD)	+= skd.o
 obj-$(CONFIG_BLK_DEV_OSD)	+= osdblk.o
 
@@ -44,6 +43,5 @@ obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 obj-$(CONFIG_ZRAM) += zram/
 
-nvme-y		:= nvme-core.o nvme-scsi.o
 skd-y		:= skd_main.o
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/nvme/Kconfig b/drivers/nvme/Kconfig
new file mode 100644
index 0000000..1f90c29
--- /dev/null
+++ b/drivers/nvme/Kconfig
@@ -0,0 +1,11 @@
+menuconfig NVME
+        bool "NVMe devices"
+	default y
+        ---help---
+          Say Y here to get to see options for various different nvme
device
+          drivers. This option alone does not add any kernel code.
+
+          If you say N, all options in this submenu will be skipped
and disabled;
+          only do this if you know what you are doing.
+
+source "drivers/nvme/host/Kconfig"
diff --git a/drivers/nvme/Makefile b/drivers/nvme/Makefile
new file mode 100644
index 0000000..df54e8b
--- /dev/null
+++ b/drivers/nvme/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_NVME_HOST)     +=  host/
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
new file mode 100644
index 0000000..4118c2e
--- /dev/null
+++ b/drivers/nvme/host/Kconfig
@@ -0,0 +1,12 @@
+config NVME_HOST
+       tristate "NVM Express block device"
+       depends on NVME
+       depends on PCI
+       depends on BLOCK
+       ---help---
+	 The NVM Express driver is for solid state drives directly
+	 connected to the PCI or PCI Express bus.  If you know you
+	 don't have one of these, it is safe to answer N.
+
+	 To compile this driver as a module, choose M here: the
+	 module will be called nvme.
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
new file mode 100644
index 0000000..10cf9a5
--- /dev/null
+++ b/drivers/nvme/host/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_NVME_HOST)		+= nvme.o
+
+nvme-y				:= core.o scsi.o
diff --git a/drivers/block/nvme-core.c b/drivers/nvme/host/core.c
similarity index 100%
rename from drivers/block/nvme-core.c
rename to drivers/nvme/host/core.c
diff --git a/drivers/block/nvme-scsi.c b/drivers/nvme/host/scsi.c
similarity index 100%
rename from drivers/block/nvme-scsi.c
rename to drivers/nvme/host/scsi.c
-- 
1.7.1
