From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Fri, 16 Oct 2015 10:48:31 -0700
Subject: [PATCH] Update target repo for nvme patch contributions
Message-ID: <1445017711-4371-1-git-send-email-james_p_freyensee@linux.intel.com>

Per http://www.nvmexpress.org/resources/linux-driver-information/, the
old nvme git repo is stale.  Updating MAINTAINERS to the Supported
target currently used by the community.

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 601d766..578563b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7441,7 +7441,8 @@ F:	drivers/video/fbdev/nvidia/
 NVM EXPRESS DRIVER
 M:	Matthew Wilcox <willy at linux.intel.com>
 L:	linux-nvme at lists.infradead.org
-T:	git git://git.infradead.org/users/willy/linux-nvme.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
+W:	https://kernel.googlesource.com/pub/scm/linux/kernel/git/axboe/linux-block/
 S:	Supported
 F:	drivers/nvme/host/
 F:	include/linux/nvme.h
-- 
2.4.3
