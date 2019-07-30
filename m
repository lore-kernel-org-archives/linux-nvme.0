From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 30 Jul 2019 10:35:39 -0600
Subject: [PATCH v2 08/14] PCI/P2PDMA: Add attrs argument to pci_p2pdma_map_sg()
In-Reply-To: <20190730163545.4915-1-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
Message-ID: <20190730163545.4915-9-logang@deltatee.com>

This is to match the dma_map_sg() API which this function will have
to call in an future patch.

Adds a pci_p2pdma_map_sg_attrs() function and helper to call it with
no attributes just like the dma_map_sg() function.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/nvme/host/pci.c    |  4 ++--
 drivers/pci/p2pdma.c       |  7 ++++---
 include/linux/pci-p2pdma.h | 15 +++++++++++----
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db160cee42ad..f97bb031228a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -832,8 +832,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out;
 
 	if (is_pci_p2pdma_page(sg_page(iod->sg)))
-		nr_mapped = pci_p2pdma_map_sg(dev->dev, iod->sg, iod->nents,
-					      rq_dma_dir(req));
+		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
+				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
 	else
 		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
 					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 1504f7ea006a..0d875abea8a1 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -788,13 +788,14 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
  * @sg: scatter list to map
  * @nents: elements in the scatterlist
  * @dir: DMA direction
+ * @attrs: dma attributes passed to dma_map_sg() (if called)
  *
  * Scatterlists mapped with this function should not be unmapped in any way.
  *
  * Returns the number of SG entries mapped or 0 on error.
  */
-int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		      enum dma_data_direction dir)
+int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct pci_p2pdma_pagemap *p2p_pgmap;
 	struct scatterlist *s;
@@ -821,7 +822,7 @@ int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 
 	return nents;
 }
-EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg);
+EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 
 /**
  * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index bca9bc3e5be7..7fd51954f93a 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -30,8 +30,8 @@ struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
 					 unsigned int *nents, u32 length);
 void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
 void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
-int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		      enum dma_data_direction dir);
+int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs);
 int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
@@ -81,8 +81,9 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
 static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 {
 }
-static inline int pci_p2pdma_map_sg(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir)
+static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
+		struct scatterlist *sg, int nents, enum dma_data_direction dir,
+		unsigned long attrs)
 {
 	return 0;
 }
@@ -111,4 +112,10 @@ static inline struct pci_dev *pci_p2pmem_find(struct device *client)
 	return pci_p2pmem_find_many(&client, 1);
 }
 
+static inline int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg,
+				    int nents, enum dma_data_direction dir)
+{
+	return pci_p2pdma_map_sg_attrs(dev, sg, nents, dir, 0);
+}
+
 #endif /* _LINUX_PCI_P2P_H */
-- 
2.20.1
