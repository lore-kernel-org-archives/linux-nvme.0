From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Mar 2019 16:10:35 -0700
Subject: [PATCH 13/15] nvme-pci: optimize mapping of small single segment
 requests
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
Message-ID: <20190321231037.25104-14-hch@lst.de>

If a request is single segment and fits into one or two PRP entries we
do not have to create a scatterlist for it, but can just map the bio_vec
directly.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 45 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c6047935e825..47fc4d653961 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -221,6 +221,7 @@ struct nvme_iod {
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int nents;		/* Used in scatterlist */
 	dma_addr_t first_dma;
+	unsigned int dma_len;	/* length of single DMA segment mapping */
 	dma_addr_t meta_dma;
 	struct scatterlist *sg;
 };
@@ -576,13 +577,18 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
 	int i;
 
-	if (iod->nents) {
-		/* P2PDMA requests do not need to be unmapped */
-		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
-			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
-
+	if (iod->dma_len) {
+		dma_unmap_page(dev->dev, dma_addr, iod->dma_len, dma_dir);
+		return;
 	}
 
+	WARN_ON_ONCE(!iod->nents);
+
+	/* P2PDMA requests do not need to be unmapped */
+	if (!is_pci_p2pdma_page(sg_page(iod->sg)))
+		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
+
+
 	if (iod->npages == 0)
 		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
 			dma_addr);
@@ -795,6 +801,24 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 	return BLK_STS_OK;
 }
 
+static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
+		struct request *req, struct nvme_rw_command *cmnd,
+		struct bio_vec *bv)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	unsigned int first_prp_len = dev->ctrl.page_size - bv->bv_offset;
+
+	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
+	if (dma_mapping_error(dev->dev, iod->first_dma))
+		return BLK_STS_RESOURCE;
+	iod->dma_len = bv->bv_len;
+
+	cmnd->dptr.prp1 = cpu_to_le64(iod->first_dma);
+	if (bv->bv_len > first_prp_len)
+		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma + first_prp_len);
+	return 0;
+}
+
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -805,6 +829,17 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	blk_status_t ret = BLK_STS_IOERR;
 	int nr_mapped;
 
+	if (blk_rq_nr_phys_segments(req) == 1) {
+		struct bio_vec bv = req_bvec(req);
+
+		if (!is_pci_p2pdma_page(bv.bv_page)) {
+			if (bv.bv_offset + bv.bv_len <= dev->ctrl.page_size * 2)
+				return nvme_setup_prp_simple(dev, req,
+							     &cmnd->rw, &bv);
+		}
+	}
+
+	iod->dma_len = 0;
 	iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
 	if (!iod->sg)
 		return BLK_STS_RESOURCE;
-- 
2.20.1
