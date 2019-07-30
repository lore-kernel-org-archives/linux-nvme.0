From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 30 Jul 2019 10:35:40 -0600
Subject: [PATCH v2 09/14] PCI/P2PDMA: Introduce pci_p2pdma_unmap_sg()
In-Reply-To: <20190730163545.4915-1-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
Message-ID: <20190730163545.4915-10-logang@deltatee.com>

Add pci_p2pdma_unmap_sg() to the two places that call
pci_p2pdma_map_sg().

This is a prep patch to introduce correct mappings for p2pdma
transactions that go through the root complex.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/infiniband/core/rw.c |  6 ++++--
 drivers/nvme/host/pci.c      |  6 ++++--
 drivers/pci/p2pdma.c         | 18 +++++++++++++++++-
 include/linux/pci-p2pdma.h   | 13 +++++++++++++
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index dce06108c8c3..5337393d4dfe 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -583,8 +583,10 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
 		break;
 	}
 
-	/* P2PDMA contexts do not need to be unmapped */
-	if (!is_pci_p2pdma_page(sg_page(sg)))
+	if (is_pci_p2pdma_page(sg_page(sg)))
+		pci_p2pdma_unmap_sg(qp->pd->device->dma_device, sg,
+				    sg_cnt, dir);
+	else
 		ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f97bb031228a..0f92cca7a860 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -547,8 +547,10 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 
 	WARN_ON_ONCE(!iod->nents);
 
-	/* P2PDMA requests do not need to be unmapped */
-	if (!is_pci_p2pdma_page(sg_page(iod->sg)))
+	if (is_pci_p2pdma_page(sg_page(iod->sg)))
+		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
+				    rq_dma_dir(req));
+	else
 		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
 
 
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 0d875abea8a1..392653fe0583 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -790,7 +790,8 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
  * @dir: DMA direction
  * @attrs: dma attributes passed to dma_map_sg() (if called)
  *
- * Scatterlists mapped with this function should not be unmapped in any way.
+ * Scatterlists mapped with this function should be unmapped using
+ * pci_p2pdma_unmap_sg_attrs().
  *
  * Returns the number of SG entries mapped or 0 on error.
  */
@@ -824,6 +825,21 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 
+/**
+ * pci_p2pdma_unmap_sg - unmap a PCI peer-to-peer scatterlist that was
+ *	mapped with pci_p2pdma_map_sg()
+ * @dev: device doing the DMA request
+ * @sg: scatter list to map
+ * @nents: number of elements returned by pci_p2pdma_map_sg()
+ * @dir: DMA direction
+ * @attrs: dma attributes passed to dma_unmap_sg() (if called)
+ */
+void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
+
 /**
  * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
  *		to enable p2pdma
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 7fd51954f93a..8318a97c9c61 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -32,6 +32,8 @@ void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
 void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
 int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
+void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs);
 int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
@@ -87,6 +89,11 @@ static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
 {
 	return 0;
 }
+static inline void pci_p2pdma_unmap_sg_attrs(struct device *dev,
+		struct scatterlist *sg, int nents, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+}
 static inline int pci_p2pdma_enable_store(const char *page,
 		struct pci_dev **p2p_dev, bool *use_p2pdma)
 {
@@ -118,4 +125,10 @@ static inline int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg,
 	return pci_p2pdma_map_sg_attrs(dev, sg, nents, dir, 0);
 }
 
+static inline void pci_p2pdma_unmap_sg(struct device *dev,
+		struct scatterlist *sg, int nents, enum dma_data_direction dir)
+{
+	pci_p2pdma_unmap_sg_attrs(dev, sg, nents, dir, 0);
+}
+
 #endif /* _LINUX_PCI_P2P_H */
-- 
2.20.1
