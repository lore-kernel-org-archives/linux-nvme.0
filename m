From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 30 Jul 2019 10:35:32 -0600
Subject: [PATCH v2 01/14] PCI/P2PDMA: Introduce private pagemap structure
In-Reply-To: <20190730163545.4915-1-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
Message-ID: <20190730163545.4915-2-logang@deltatee.com>

Move the PCI bus offset from the generic dev_pagemap structure to a
specific pci_p2pdma_pagemap structure.

This structure will grow in subsequent patches.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/pci/p2pdma.c     | 26 ++++++++++++++++++++------
 include/linux/memremap.h |  1 -
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 234476226529..03e9c887bdfb 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -25,6 +25,16 @@ struct pci_p2pdma {
 	bool p2pmem_published;
 };
 
+struct pci_p2pdma_pagemap {
+	struct dev_pagemap pgmap;
+	u64 bus_offset;
+};
+
+static struct pci_p2pdma_pagemap *to_p2p_pgmap(struct dev_pagemap *pgmap)
+{
+	return container_of(pgmap, struct pci_p2pdma_pagemap, pgmap);
+}
+
 static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -135,6 +145,7 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 			    u64 offset)
 {
+	struct pci_p2pdma_pagemap *p2p_pgmap;
 	struct dev_pagemap *pgmap;
 	void *addr;
 	int error;
@@ -157,14 +168,17 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 			return error;
 	}
 
-	pgmap = devm_kzalloc(&pdev->dev, sizeof(*pgmap), GFP_KERNEL);
-	if (!pgmap)
+	p2p_pgmap = devm_kzalloc(&pdev->dev, sizeof(*p2p_pgmap), GFP_KERNEL);
+	if (!p2p_pgmap)
 		return -ENOMEM;
+
+	pgmap = &p2p_pgmap->pgmap;
 	pgmap->res.start = pci_resource_start(pdev, bar) + offset;
 	pgmap->res.end = pgmap->res.start + size - 1;
 	pgmap->res.flags = pci_resource_flags(pdev, bar);
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
-	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
+
+	p2p_pgmap->bus_offset = pci_bus_address(pdev, bar) -
 		pci_resource_start(pdev, bar);
 
 	addr = devm_memremap_pages(&pdev->dev, pgmap);
@@ -720,7 +734,7 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		      enum dma_data_direction dir)
 {
-	struct dev_pagemap *pgmap;
+	struct pci_p2pdma_pagemap *p2p_pgmap;
 	struct scatterlist *s;
 	phys_addr_t paddr;
 	int i;
@@ -736,10 +750,10 @@ int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		return 0;
 
 	for_each_sg(sg, s, nents, i) {
-		pgmap = sg_page(s)->pgmap;
+		p2p_pgmap = to_p2p_pgmap(sg_page(s)->pgmap);
 		paddr = sg_phys(s);
 
-		s->dma_address = paddr - pgmap->pci_p2pdma_bus_offset;
+		s->dma_address = paddr - p2p_pgmap->bus_offset;
 		sg_dma_len(s) = s->length;
 	}
 
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index f8a5b2a19945..b459518ce475 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -112,7 +112,6 @@ struct dev_pagemap {
 	struct device *dev;
 	enum memory_type type;
 	unsigned int flags;
-	u64 pci_p2pdma_bus_offset;
 	const struct dev_pagemap_ops *ops;
 };
 
-- 
2.20.1
