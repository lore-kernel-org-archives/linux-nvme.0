From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 13 May 2013 18:00:42 +0300
Subject: [patch] MAINTAINERS: update NVM EXPRESS DRIVER file list
In-Reply-To: <100D68C7BA14664A8938383216E40DE027F80EAB@fmsmsx111.amr.corp.intel.com>
Message-ID: <20130513150042.GB21239@elgon.mountain>

There isn't an nvme.c file any more.  It has been split into multiple
files.

Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f190f5..97ec343 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5747,7 +5747,7 @@ M:	Matthew Wilcox <willy at linux.intel.com>
 L:	linux-nvme at lists.infradead.org
 T:	git git://git.infradead.org/users/willy/linux-nvme.git
 S:	Supported
-F:	drivers/block/nvme.c
+F:	drivers/block/nvme*
 F:	include/linux/nvme.h
 
 OMAP SUPPORT
