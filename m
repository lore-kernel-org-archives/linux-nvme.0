From: daniel.mcleran@intel.com (Dan McLeran)
Date: Thu, 19 Jun 2014 09:42:55 -0600
Subject: [PATCH] NVMe: Change nvme_enable_ctrl behavior and track CC
Message-ID: <1403192575-9704-1-git-send-email-daniel.mcleran@intel.com>

In the current implementation, nvme_enable_ctrl does not actually enable the controller.
It waits for the controller, which has previously been enabled from nvme_configure_admin_queue,
to become ready to receive commands. This patch moves the logic of enabling the controller into
nvme_enable_ctrl. This patch also ensure that shutdown flags are not passed as part of enabling
or disabling the controller. This patch also ensures the software representation of the CC
register remains in sync with actual reads and writes to the hardware.

Signed-off-by: Dan McLeran <daniel.mcleran at intel.com>
---
 drivers/block/nvme-core.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 02351e2..3e31b67 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1408,15 +1408,27 @@ static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool enabled)
  */
 static int nvme_disable_ctrl(struct nvme_dev *dev, u64 cap)
 {
-	u32 cc = readl(&dev->bar->cc);
+	u32 cc = (readl(&dev->bar->cc) & ~NVME_CC_SHN_MASK);
+
+	if (cc & NVME_CC_ENABLE) {
+		cc &= ~NVME_CC_ENABLE;
+		writel(cc, &dev->bar->cc);
+		dev->ctrl_config = cc;
+	}
 
-	if (cc & NVME_CC_ENABLE)
-		writel(cc & ~NVME_CC_ENABLE, &dev->bar->cc);
 	return nvme_wait_ready(dev, cap, false);
 }
 
 static int nvme_enable_ctrl(struct nvme_dev *dev, u64 cap)
 {
+	u32 cc = (readl(&dev->bar->cc) & ~NVME_CC_SHN_MASK);
+
+	if (!(cc & NVME_CC_ENABLE)) {
+		cc |= NVME_CC_ENABLE | NVME_CC_CSS_NVM;
+		writel(cc, &dev->bar->cc);
+		dev->ctrl_config = cc;
+	}
+
 	return nvme_wait_ready(dev, cap, true);
 }
 
@@ -1427,6 +1439,7 @@ static int nvme_shutdown_ctrl(struct nvme_dev *dev)
 
 	cc = (readl(&dev->bar->cc) & ~NVME_CC_SHN_MASK) | NVME_CC_SHN_NORMAL;
 	writel(cc, &dev->bar->cc);
+	dev->ctrl_config = cc;
 
 	timeout = 2 * HZ + jiffies;
 	while ((readl(&dev->bar->csts) & NVME_CSTS_SHST_MASK) !=
@@ -1465,7 +1478,6 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	aqa = nvmeq->q_depth - 1;
 	aqa |= aqa << 16;
 
-	dev->ctrl_config = NVME_CC_ENABLE | NVME_CC_CSS_NVM;
 	dev->ctrl_config |= (PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
 	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
-- 
1.7.10.4
