From: daniel.mcleran@intel.com (Dan McLeran)
Date: Mon, 23 Jun 2014 05:00:46 -0600
Subject: [PATCH] NVMe: Change nvme_enable_ctrl to set CC.EN and stop tracking
 CC in nvme_dev
Message-ID: <1403521246-6396-1-git-send-email-daniel.mcleran@intel.com>

I took another crack at changing nvme_enable_ctrl so that it sets
CC.EN. nvme_enable_ctrl and nvme_disable_ctrl ensure that CC.SH
is cleared before setting/clearing CC.EN. I have also removed ctrl_config
from struct nvme_dev. We don't need to track the state of CC in software.

Signed-off-by: Dan McLeran <daniel.mcleran at intel.com>
---
 drivers/block/nvme-core.c |   27 +++++++++++++++++++--------
 include/linux/nvme.h      |    1 -
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 02351e2..87c3b9a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1408,15 +1408,25 @@ static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool enabled)
  */
 static int nvme_disable_ctrl(struct nvme_dev *dev, u64 cap)
 {
-	u32 cc = readl(&dev->bar->cc);
+	u32 cc = (readl(&dev->bar->cc) & ~NVME_CC_SHN_MASK);
+
+	if (cc & NVME_CC_ENABLE) {
+		cc &= ~NVME_CC_ENABLE;
+		writel(cc, &dev->bar->cc);
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
+		cc |= NVME_CC_ENABLE;
+		writel(cc, &dev->bar->cc);
+	}
+
 	return nvme_wait_ready(dev, cap, true);
 }
 
@@ -1448,6 +1458,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 {
 	int result;
 	u32 aqa;
+	u32 cc;
 	u64 cap = readq(&dev->bar->cap);
 	struct nvme_queue *nvmeq;
 
@@ -1465,15 +1476,15 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	aqa = nvmeq->q_depth - 1;
 	aqa |= aqa << 16;
 
-	dev->ctrl_config = NVME_CC_ENABLE | NVME_CC_CSS_NVM;
-	dev->ctrl_config |= (PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
-	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
-	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
+	cc = NVME_CC_CSS_NVM;
+	cc |= (PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
+	cc |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
+	cc |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 
 	writel(aqa, &dev->bar->aqa);
 	writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
 	writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
-	writel(dev->ctrl_config, &dev->bar->cc);
+	writel(cc, &dev->bar->cc);
 
 	result = nvme_enable_ctrl(dev, cap);
 	if (result)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 2bf4031..3d70be5 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -82,7 +82,6 @@ struct nvme_dev {
 	unsigned max_qid;
 	int q_depth;
 	u32 db_stride;
-	u32 ctrl_config;
 	struct msix_entry *entry;
 	struct nvme_bar __iomem *bar;
 	struct list_head namespaces;
-- 
1.7.10.4
