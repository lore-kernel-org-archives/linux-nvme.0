From: scott.bauer@intel.com (Scott Bauer)
Date: Mon, 19 Dec 2016 12:35:49 -0700
Subject: [PATCH v3 5/5] Maintainers: Add Information for SED Opal library
In-Reply-To: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1482176149-2257-6-git-send-email-scott.bauer@intel.com>

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli at intel.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f6eb97b..76d542c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11051,6 +11051,16 @@ L:	linux-mmc at vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-spear.c
 
+SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
+M:	Scott Bauer <scott.bauer at intel.com>
+M:	Jonathan Derrick <jonathan.derrick at intel.com>
+M:	Rafael Antognolli <rafael.antognolli at intel.com>
+L:	linux-nvme at lists.infradead.org
+S:	Supported
+F:	lib/sed*
+F:	include/linux/sed*
+F:	include/uapi/linux/sed*
+
 SECURITY SUBSYSTEM
 M:	James Morris <james.l.morris at oracle.com>
 M:	"Serge E. Hallyn" <serge at hallyn.com>
-- 
2.7.4
