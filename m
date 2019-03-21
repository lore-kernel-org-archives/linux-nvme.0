From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Mar 2019 16:10:37 -0700
Subject: [PATCH 15/15] nvme-pci: tidy up nvme_map_data
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
Message-ID: <20190321231037.25104-16-hch@lst.de>

Remove two pointless local variables, remove ret assignment that is
never used, move the use_sgl initialization closer to where it is used.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 38869f59c296..9ec0704d5f78 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -840,10 +840,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct request_queue *q = req->q;
-	enum dma_data_direction dma_dir = rq_data_dir(req) ?
-			DMA_TO_DEVICE : DMA_FROM_DEVICE;
-	blk_status_t ret = BLK_STS_IOERR;
+	blk_status_t ret = BLK_STS_RESOURCE;
 	int nr_mapped;
 
 	if (blk_rq_nr_phys_segments(req) == 1) {
@@ -865,25 +862,21 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
 	if (!iod->sg)
 		return BLK_STS_RESOURCE;
-
-	iod->use_sgl = nvme_pci_use_sgls(dev, req);
-
 	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
-	iod->nents = blk_rq_map_sg(q, req, iod->sg);
+	iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
 	if (!iod->nents)
 		goto out;
 
-	ret = BLK_STS_RESOURCE;
-
 	if (is_pci_p2pdma_page(sg_page(iod->sg)))
 		nr_mapped = pci_p2pdma_map_sg(dev->dev, iod->sg, iod->nents,
-					  dma_dir);
+					      rq_dma_dir(req));
 	else
 		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
-					     dma_dir,  DMA_ATTR_NO_WARN);
+					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
 	if (!nr_mapped)
 		goto out;
 
+	iod->use_sgl = nvme_pci_use_sgls(dev, req);
 	if (iod->use_sgl)
 		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw, nr_mapped);
 	else
-- 
2.20.1
