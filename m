From: scott.bauer@intel.com (Scott Bauer)
Date: Wed, 16 Nov 2016 16:17:28 -0700
Subject: [PATCH v1 3/7] lib: Add Sed to Kconfig and Makefile
In-Reply-To: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1479338252-8777-4-git-send-email-scott.bauer@intel.com>

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli at intel.com>
---
 lib/Kconfig  | 12 ++++++++++++
 lib/Makefile |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 260a80e..47c39ac 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -547,6 +547,18 @@ config STACKDEPOT
 	bool
 	select STACKTRACE
 
+config SED
+	bool "Self-Encrypting Drive library"
+	help
+	  Provides self-encrypting drive helpers
+
+config SED_OPAL
+	bool "Self-Encrypting Drive library - Opal implementation"
+	depends on SED
+	help
+	  Provides self-encrypting drive helpers for drives that implement the
+	  Opal spec.
+
 config SBITMAP
 	bool
 
diff --git a/lib/Makefile b/lib/Makefile
index 50144a3..976da7a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -229,4 +229,11 @@ obj-$(CONFIG_UBSAN) += ubsan.o
 
 UBSAN_SANITIZE_ubsan.o := n
 
+
+obj-$(CONFIG_SED) += sed.o
+
+obj-$(CONFIG_SED_OPAL) += sed-opal.o
+obj-$(CONFIG_SED_OPAL) += sed-opal_key.o
+
 obj-$(CONFIG_SBITMAP) += sbitmap.o
+
-- 
2.7.4
