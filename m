From: scott.bauer@intel.com (Scott Bauer)
Date: Tue, 29 Nov 2016 14:52:02 -0700
Subject: [PATCH v2 4/4] Maintainers: Add Information for SED Opal library
In-Reply-To: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1480456322-27339-5-git-send-email-scott.bauer@intel.com>

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli at intel.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d414840..929eba3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10846,6 +10846,16 @@ L:	linux-mmc at vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-spear.c
 
+SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
+M:	Scott Bauer <scott.bauer at intel.com>
+M:	Jonathan Derrick <jonathan.derrick at intel.com>
+M:	Rafael Antognolli <rafael.antognolli at intel.com>
+L:	linux-nvme at lists.infradead.org
+S:	Supported
+F:	block/sed*
+F:	include/linux/sed*
+F:	include/uapi/linux/sed*
+
 SECURITY SUBSYSTEM
 M:	James Morris <james.l.morris at oracle.com>
 M:	"Serge E. Hallyn" <serge at hallyn.com>
-- 
2.7.4
