From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 22 Jul 2019 17:08:56 -0600
Subject: [PATCH 11/14] PCI/P2PDMA: dma_map P2PDMA map requests that traverse
 the host bridge
In-Reply-To: <20190722230859.5436-1-logang@deltatee.com>
References: <20190722230859.5436-1-logang@deltatee.com>
Message-ID: <20190722230859.5436-12-logang@deltatee.com>

Any requests that traverse the host bridge will need to be mapped into
the IOMMU, so call dma_map_sg() inside pci_p2pdma_map_sg() when
appropriate.

Similarly, call dma_unmap_sg() inside pci_p2pdma_unmap_sg().

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/pci/p2pdma.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 5f43f92f9336..76f51678342c 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -830,8 +830,22 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dev_pagemap *pgmap = sg_page(sg)->pgmap;
+	struct pci_dev *client;
+	int dist;
+
+	client = find_parent_pci_dev(dev);
+	if (WARN_ON_ONCE(!client))
+		return 0;
 
-	return __pci_p2pdma_map_sg(pgmap, dev, sg, nents);
+	dist = upstream_bridge_distance(pgmap->pci_p2pdma_provider,
+					client, NULL);
+	if (WARN_ON_ONCE(dist & P2PDMA_NOT_SUPPORTED))
+		return 0;
+
+	if (dist & P2PDMA_THRU_HOST_BRIDGE)
+		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
+	else
+		return __pci_p2pdma_map_sg(pgmap, dev, sg, nents);
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 
@@ -847,6 +861,21 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
+	struct dev_pagemap *pgmap = sg_page(sg)->pgmap;
+	struct pci_dev *client;
+	int dist;
+
+	client = find_parent_pci_dev(dev);
+	if (!client)
+		return;
+
+	dist = upstream_bridge_distance(pgmap->pci_p2pdma_provider,
+					client, NULL);
+	if (dist & P2PDMA_NOT_SUPPORTED)
+		return;
+
+	if (dist & P2PDMA_THRU_HOST_BRIDGE)
+		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
 
-- 
2.20.1
