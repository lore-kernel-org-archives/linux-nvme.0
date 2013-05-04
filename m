From: matthew.r.wilcox@intel.com (Matthew Wilcox)
Date: Sat,  4 May 2013 06:43:17 -0400
Subject: [PATCH 2/2] NVMe: Only clear the enable bit when disabling controller
In-Reply-To: <1367664197-745-1-git-send-email-matthew.r.wilcox@intel.com>
References: <1367664197-745-1-git-send-email-matthew.r.wilcox@intel.com>
Message-ID: <1367664197-745-2-git-send-email-matthew.r.wilcox@intel.com>

Many of the bits in the Controller Configuration register may only be
modified when the Enable bit is clear.  Clearing them at the same time
as the Enable bit might be OK, but let's play it safe and only touch the
Enable bit.

Signed-off-by: Matthew Wilcox <matthew.r.wilcox at intel.com>
---
 drivers/block/nvme-core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 2b1b5a7..310d573 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1137,7 +1137,10 @@ static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool enabled)
  */
 static int nvme_disable_ctrl(struct nvme_dev *dev, u64 cap)
 {
-	writel(0, &dev->bar->cc);
+	u32 cc = readl(&dev->bar->cc);
+
+	if (cc & NVME_CC_ENABLE)
+		writel(cc & ~NVME_CC_ENABLE, &dev->bar->cc);
 	return nvme_wait_ready(dev, cap, false);
 }
 
-- 
1.7.10.4
