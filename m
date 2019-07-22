From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 22 Jul 2019 17:08:55 -0600
Subject: [PATCH 10/14] PCI/P2PDMA: Factor out __pci_p2pdma_map_sg()
In-Reply-To: <20190722230859.5436-1-logang@deltatee.com>
References: <20190722230859.5436-1-logang@deltatee.com>
Message-ID: <20190722230859.5436-11-logang@deltatee.com>

Factor out the bus only mapping into it's own static function.
No functional changes. The original pci_p2pdma_map_sg_attrs() will
be used to decide whether this is an appropriate way to map.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/pci/p2pdma.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index d3ced8eee30a..5f43f92f9336 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -785,23 +785,9 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 
-/**
- * pci_p2pdma_map_sg - map a PCI peer-to-peer scatterlist for DMA
- * @dev: device doing the DMA request
- * @sg: scatter list to map
- * @nents: elements in the scatterlist
- * @dir: DMA direction
- * @attrs: dma attributes passed to dma_map_sg() (if called)
- *
- * Scatterlists mapped with this function should be unmapped using
- * pci_p2pdma_unmap_sg_attrs().
- *
- * Returns the number of SG entries mapped or 0 on error.
- */
-int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
+static int __pci_p2pdma_map_sg(struct dev_pagemap *pgmap,
+		struct device *dev, struct scatterlist *sg, int nents)
 {
-	struct dev_pagemap *pgmap;
 	struct scatterlist *s;
 	phys_addr_t paddr;
 	int i;
@@ -826,6 +812,27 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 
 	return nents;
 }
+
+/**
+ * pci_p2pdma_map_sg - map a PCI peer-to-peer scatterlist for DMA
+ * @dev: device doing the DMA request
+ * @sg: scatter list to map
+ * @nents: elements in the scatterlist
+ * @dir: DMA direction
+ * @attrs: dma attributes passed to dma_map_sg() (if called)
+ *
+ * Scatterlists mapped with this function should be unmapped using
+ * pci_p2pdma_unmap_sg_attrs().
+ *
+ * Returns the number of SG entries mapped or 0 on error.
+ */
+int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	struct dev_pagemap *pgmap = sg_page(sg)->pgmap;
+
+	return __pci_p2pdma_map_sg(pgmap, dev, sg, nents);
+}
 EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 
 /**
-- 
2.20.1
