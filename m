From: scott.bauer@intel.com (Scott Bauer)
Date: Tue, 14 Feb 2017 17:29:37 -0700
Subject: [PATCH V6 3/3] Maintainers: Modify SED list from nvme to block
In-Reply-To: <1487118577-1719-1-git-send-email-scott.bauer@intel.com>
References: <1487118577-1719-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1487118577-1719-3-git-send-email-scott.bauer@intel.com>

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e325373..b983b25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11094,7 +11094,7 @@ SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
 M:	Scott Bauer <scott.bauer at intel.com>
 M:	Jonathan Derrick <jonathan.derrick at intel.com>
 M:	Rafael Antognolli <rafael.antognolli at intel.com>
-L:	linux-nvme at lists.infradead.org
+L:	linux-block at vger.kernel.org
 S:	Supported
 F:	block/sed*
 F:	block/opal_proto.h
-- 
2.7.4
