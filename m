From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 30 Jul 2019 10:35:43 -0600
Subject: [PATCH v2 12/14] PCI/P2PDMA: dma_map P2PDMA map requests that
 traverse the host bridge
In-Reply-To: <20190730163545.4915-1-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
Message-ID: <20190730163545.4915-13-logang@deltatee.com>

Any requests that traverse the host bridge will need to be mapped into
the IOMMU, so call dma_map_sg() inside pci_p2pdma_map_sg() when
appropriate.

Similarly, call dma_unmap_sg() inside pci_p2pdma_unmap_sg().

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/pci/p2pdma.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 010aa8742bec..b86a1c0c11a0 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -812,6 +812,16 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 
+static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct pci_dev *provider,
+						    struct pci_dev *client)
+{
+	if (!provider->p2pdma)
+		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+
+	return xa_to_value(xa_load(&provider->p2pdma->map_types,
+				   map_types_idx(client)));
+}
+
 static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
 		struct device *dev, struct scatterlist *sg, int nents)
 {
@@ -857,8 +867,22 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 {
 	struct pci_p2pdma_pagemap *p2p_pgmap =
 		to_p2p_pgmap(sg_page(sg)->pgmap);
+	struct pci_dev *client;
 
-	return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
+	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+		return 0;
+
+	client = to_pci_dev(dev);
+
+	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
+	case PCI_P2PDMA_MAP_THRU_IOMMU:
+		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 
@@ -874,6 +898,20 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
+	struct pci_p2pdma_pagemap *p2p_pgmap =
+		to_p2p_pgmap(sg_page(sg)->pgmap);
+	enum pci_p2pdma_map_type map_type;
+	struct pci_dev *client;
+
+	if (WARN_ON_ONCE(!dev_is_pci(dev)))
+		return;
+
+	client = to_pci_dev(dev);
+
+	map_type = pci_p2pdma_map_type(p2p_pgmap->provider, client);
+
+	if (map_type == PCI_P2PDMA_MAP_THRU_IOMMU)
+		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
 
-- 
2.20.1
