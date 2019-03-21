From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Mar 2019 16:10:32 -0700
Subject: [PATCH 10/15] nvme-pci: do not build a scatterlist to map metadata
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
Message-ID: <20190321231037.25104-11-hch@lst.de>

We always have exactly one segment, so we can simply call dma_map_bvec.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bc4ee869fe82..a7dad24e0406 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -221,7 +221,7 @@ struct nvme_iod {
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int nents;		/* Used in scatterlist */
 	dma_addr_t first_dma;
-	struct scatterlist meta_sg; /* metadata requires single contiguous buffer */
+	dma_addr_t meta_dma;
 	struct scatterlist *sg;
 	struct scatterlist inline_sg[0];
 };
@@ -592,13 +592,16 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
 	int i;
 
+	if (blk_integrity_rq(req)) {
+		dma_unmap_page(dev->dev, iod->meta_dma,
+				rq_integrity_vec(req)->bv_len, dma_dir);
+	}
+
 	if (iod->nents) {
 		/* P2PDMA requests do not need to be unmapped */
 		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
 			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
 
-		if (blk_integrity_rq(req))
-			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);
 	}
 
 	if (iod->npages == 0)
@@ -861,17 +864,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 
 	ret = BLK_STS_IOERR;
 	if (blk_integrity_rq(req)) {
-		if (blk_rq_count_integrity_sg(q, req->bio) != 1)
-			goto out;
-
-		sg_init_table(&iod->meta_sg, 1);
-		if (blk_rq_map_integrity_sg(q, req->bio, &iod->meta_sg) != 1)
-			goto out;
-
-		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
+		iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
+				dma_dir, 0);
+		if (dma_mapping_error(dev->dev, iod->meta_dma))
 			goto out;
-
-		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(&iod->meta_sg));
+		cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
 	}
 
 	return BLK_STS_OK;
-- 
2.20.1
