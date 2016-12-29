From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 29 Dec 2016 12:26:53 -0700
Subject: [PATCH v4 4/6] block: Add Opal Files to Makefile & add config option
 to Kconfig
In-Reply-To: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1483039615-22407-5-git-send-email-scott.bauer@intel.com>

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli at intel.com>
---
 block/Kconfig  | 6 ++++++
 block/Makefile | 1 +
 2 files changed, 7 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 8bf114a..45a7863 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -147,6 +147,12 @@ config BLK_WBT_MQ
 	Multiqueue currently doesn't have support for IO scheduling,
 	enabling this option is recommended.
 
+config BLK_SED_OPAL
+        bool "Library for interfacing with Opal enabled SEDs"
+	default n
+	---help---
+	Builds library for interfacing with Opal enabled controllers.
+
 menu "Partition Types"
 
 source "block/partitions/Kconfig"
diff --git a/block/Makefile b/block/Makefile
index a827f98..876c28d 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o
 obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
 obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
+obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o sed-ioctl.o
-- 
2.7.4
