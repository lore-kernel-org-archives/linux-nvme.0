From: hch@lst.de (Christoph Hellwig)
Date: Mon, 30 Nov 2015 09:40:16 +0100
Subject: [PATCH 3/9] nvme: move remaining CC setup into nvme_enable_ctrl
In-Reply-To: <1448872822-4789-1-git-send-email-hch@lst.de>
References: <1448872822-4789-1-git-send-email-hch@lst.de>
Message-ID: <1448872822-4789-4-git-send-email-hch@lst.de>

Remove the calculation of all the bits written into the CC register into
nvme_enable_ctrl, so that they can be moved into the core NVMe driver in
the future.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 27d7449..1ae94cd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1446,8 +1446,28 @@ static int nvme_disable_ctrl(struct nvme_dev *dev, u64 cap)
 
 static int nvme_enable_ctrl(struct nvme_dev *dev, u64 cap)
 {
-	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
+	/*
+	 * Default to a 4K page size, with the intention to update this
+	 * path in the future to accomodate architectures with differing
+	 * kernel and IO page sizes.
+	 */
+	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12, page_shift = 12;
+
+	if (page_shift < dev_page_min) {
+		dev_err(dev->dev,
+			"Minimum device page size %u too large for host (%u)\n",
+			1 << dev_page_min, 1 << page_shift);
+		return -ENODEV;
+	}
+
+	dev->page_size = 1 << page_shift;
+
+	dev->ctrl_config = NVME_CC_CSS_NVM;
+	dev->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
+	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
+	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 	dev->ctrl_config |= NVME_CC_ENABLE;
+
 	writel(dev->ctrl_config, dev->bar + NVME_REG_CC);
 
 	return nvme_wait_ready(dev, cap, true);
@@ -1541,21 +1561,6 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	u32 aqa;
 	u64 cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 	struct nvme_queue *nvmeq;
-	/*
-	 * default to a 4K page size, with the intention to update this
-	 * path in the future to accomodate architectures with differing
-	 * kernel and IO page sizes.
-	 */
-	unsigned page_shift = 12;
-	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
-
-	if (page_shift < dev_page_min) {
-		dev_err(dev->dev,
-				"Minimum device page size (%u) too large for "
-				"host (%u)\n", 1 << dev_page_min,
-				1 << page_shift);
-		return -ENODEV;
-	}
 
 	dev->subsystem = readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 1) ?
 						NVME_CAP_NSSRC(cap) : 0;
@@ -1578,13 +1583,6 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	aqa = nvmeq->q_depth - 1;
 	aqa |= aqa << 16;
 
-	dev->page_size = 1 << page_shift;
-
-	dev->ctrl_config = NVME_CC_CSS_NVM;
-	dev->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
-	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
-	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
-
 	writel(aqa, dev->bar + NVME_REG_AQA);
 	lo_hi_writeq(nvmeq->sq_dma_addr, dev->bar + NVME_REG_ASQ);
 	lo_hi_writeq(nvmeq->cq_dma_addr, dev->bar + NVME_REG_ACQ);
-- 
1.9.1
