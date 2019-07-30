From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 30 Jul 2019 10:35:41 -0600
Subject: [PATCH v2 10/14] PCI/P2PDMA: Factor out __pci_p2pdma_map_sg()
In-Reply-To: <20190730163545.4915-1-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
Message-ID: <20190730163545.4915-11-logang@deltatee.com>

Factor out the bus only mapping into it's own static function.
No functional changes. The original pci_p2pdma_map_sg_attrs() will
be used to decide whether this is an appropriate way to map.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/pci/p2pdma.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 392653fe0583..fe647bd8f947 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -782,23 +782,9 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
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
+static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
+		struct device *dev, struct scatterlist *sg, int nents)
 {
-	struct pci_p2pdma_pagemap *p2p_pgmap;
 	struct scatterlist *s;
 	phys_addr_t paddr;
 	int i;
@@ -814,7 +800,6 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		return 0;
 
 	for_each_sg(sg, s, nents, i) {
-		p2p_pgmap = to_p2p_pgmap(sg_page(s)->pgmap);
 		paddr = sg_phys(s);
 
 		s->dma_address = paddr - p2p_pgmap->bus_offset;
@@ -823,6 +808,28 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 
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
+	struct pci_p2pdma_pagemap *p2p_pgmap =
+		to_p2p_pgmap(sg_page(sg)->pgmap);
+
+	return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
+}
 EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 
 /**
-- 
2.20.1
