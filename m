From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 09:45:04 +0100
Subject: [PATCH 10/12] nvme: meta_sg doesn't have to be an array
In-Reply-To: <1446885906-20967-1-git-send-email-hch@lst.de>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
Message-ID: <1446885906-20967-11-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a5ee159..a25157b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -168,7 +168,7 @@ struct nvme_iod {
 	int nents;		/* Used in scatterlist */
 	int length;		/* Of data, in bytes */
 	dma_addr_t first_dma;
-	struct scatterlist meta_sg[1]; /* metadata requires single contiguous buffer */
+	struct scatterlist meta_sg; /* metadata requires single contiguous buffer */
 	struct scatterlist sg[0];
 };
 
@@ -586,21 +586,21 @@ static int nvme_map_data(struct nvme_dev *dev, struct nvme_iod *iod,
 		if (blk_rq_count_integrity_sg(q, req->bio) != 1)
 			goto out_unmap;
 
-		sg_init_table(iod->meta_sg, 1);
-		if (blk_rq_map_integrity_sg(q, req->bio, iod->meta_sg) != 1)
+		sg_init_table(&iod->meta_sg, 1);
+		if (blk_rq_map_integrity_sg(q, req->bio, &iod->meta_sg) != 1)
 			goto out_unmap;
 
 		if (rq_data_dir(req))
 			nvme_dif_remap(req, nvme_dif_prep);
 
-		if (!dma_map_sg(dev->dev, iod->meta_sg, 1, dma_dir))
+		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
 			goto out_unmap;
 	}
 
 	cmnd->rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
 	cmnd->rw.prp2 = cpu_to_le64(iod->first_dma);
 	if (blk_integrity_rq(req))
-		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(iod->meta_sg));
+		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(&iod->meta_sg));
 	return BLK_MQ_RQ_QUEUE_OK;
 
 out_unmap:
@@ -620,7 +620,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct nvme_iod *iod)
 		if (blk_integrity_rq(req)) {
 			if (!rq_data_dir(req))
 				nvme_dif_remap(req, nvme_dif_complete);
-			dma_unmap_sg(dev->dev, iod->meta_sg, 1, dma_dir);
+			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);
 		}
 	}
 
-- 
1.9.1
