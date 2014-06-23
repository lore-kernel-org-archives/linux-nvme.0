From: daniel.mcleran@intel.com (Dan McLeran)
Date: Mon, 23 Jun 2014 08:24:36 -0600
Subject: [PATCH] NVMe: Change nvme_enable_ctrl to set EN and manage CC thru
 ctrl_config.
Message-ID: <1403533476-7193-1-git-send-email-daniel.mcleran@intel.com>

Change the behavior of nvme_enable_ctrl to set EN.
Clear CC.SH for both nvme_enable_ctrl and nvme_disable_ctrl.
Remove reading of the CC register and manage the state in
dev->ctrl_config.

Signed-off-by: Dan McLeran <daniel.mcleran at intel.com>
---
 drivers/block/nvme-core.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 02351e2..e1c02e1 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1408,25 +1408,30 @@ static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool enabled)
  */
 static int nvme_disable_ctrl(struct nvme_dev *dev, u64 cap)
 {
-	u32 cc = readl(&dev->bar->cc);
+	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
+	dev->ctrl_config &= ~NVME_CC_ENABLE;
+	writel(dev->ctrl_config, &dev->bar->cc);
 
-	if (cc & NVME_CC_ENABLE)
-		writel(cc & ~NVME_CC_ENABLE, &dev->bar->cc);
 	return nvme_wait_ready(dev, cap, false);
 }
 
 static int nvme_enable_ctrl(struct nvme_dev *dev, u64 cap)
 {
+	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
+	dev->ctrl_config |= NVME_CC_ENABLE;
+	writel(dev->ctrl_config, &dev->bar->cc);
+
 	return nvme_wait_ready(dev, cap, true);
 }
 
 static int nvme_shutdown_ctrl(struct nvme_dev *dev)
 {
 	unsigned long timeout;
-	u32 cc;
 
-	cc = (readl(&dev->bar->cc) & ~NVME_CC_SHN_MASK) | NVME_CC_SHN_NORMAL;
-	writel(cc, &dev->bar->cc);
+	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
+	dev->ctrl_config |= NVME_CC_SHN_NORMAL;
+
+	writel(dev->ctrl_config, &dev->bar->cc);
 
 	timeout = 2 * HZ + jiffies;
 	while ((readl(&dev->bar->csts) & NVME_CSTS_SHST_MASK) !=
@@ -1465,7 +1470,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	aqa = nvmeq->q_depth - 1;
 	aqa |= aqa << 16;
 
-	dev->ctrl_config = NVME_CC_ENABLE | NVME_CC_CSS_NVM;
+	dev->ctrl_config = NVME_CC_CSS_NVM;
 	dev->ctrl_config |= (PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
 	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
-- 
1.7.10.4
