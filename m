From: hch@lst.de (Christoph Hellwig)
Date: Fri, 28 Jun 2019 09:18:37 +0200
Subject: [PATCH] nvme-pci: don't fall back to a 32-bit DMA mask
Message-ID: <20190628071837.7087-1-hch@lst.de>

Since Linux 5.0 drivers can safely set the largest DMA mask supported
by the device, and don't need fallbacks to work around the dma mapping
implementations.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f50013369cc5..49c1fc9907a6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2289,8 +2289,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	pci_set_master(pdev);
 
-	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
-	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32)))
+	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)))
 		goto disable;
 
 	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
-- 
2.20.1
