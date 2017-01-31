From: scott.bauer@intel.com (Scott Bauer)
Date: Tue, 31 Jan 2017 03:17:24 -0700
Subject: [PATCH v5 4/4] Maintainers: Add maintainer info for SED/Opal code
In-Reply-To: <1485857844-15130-1-git-send-email-scott.bauer@intel.com>
References: <1485857844-15130-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1485857844-15130-5-git-send-email-scott.bauer@intel.com>

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f10c28..8ddf6bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11091,6 +11091,17 @@ L:	linux-mmc at vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-spear.c
 
+SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
+M:	Scott Bauer <scott.bauer at intel.com>
+M:	Jonathan Derrick <jonathan.derrick at intel.com>
+M:	Rafael Antognolli <rafael.antognolli at intel.com>
+L:	linux-nvme at lists.infradead.org
+S:	Supported
+F:	block/sed*
+F:      block/opal_proto.h
+F:	include/linux/sed*
+F:	include/uapi/linux/sed*
+
 SECURITY SUBSYSTEM
 M:	James Morris <james.l.morris at oracle.com>
 M:	"Serge E. Hallyn" <serge at hallyn.com>
-- 
2.7.4
