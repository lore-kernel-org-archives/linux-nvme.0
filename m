From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 29 Dec 2016 12:26:55 -0700
Subject: [PATCH v4 6/6] Maintainers: Add maintainer info for SED/Opal library
In-Reply-To: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1483039615-22407-7-git-send-email-scott.bauer@intel.com>

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfff2c9..fe936c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11065,6 +11065,17 @@ L:	linux-mmc at vger.kernel.org
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
