From: hch@lst.de (Christoph Hellwig)
Date: Fri,  9 Oct 2015 18:55:54 +0200
Subject: [PATCH 1/3] nvme: add missing unmaps in nvme_queue_rq
In-Reply-To: <1444409756-7317-1-git-send-email-hch@lst.de>
References: <1444409756-7317-1-git-send-email-hch@lst.de>
Message-ID: <1444409756-7317-2-git-send-email-hch@lst.de>

When we fail various metadata related operations in nvme_queue_rq we
need to unmap the data SGL.

Cc: stable at vger.kernel.org
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a526696..0a85fab 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -904,19 +904,28 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 			goto retry_cmd;
 		}
 		if (blk_integrity_rq(req)) {
-			if (blk_rq_count_integrity_sg(req->q, req->bio) != 1)
+			if (blk_rq_count_integrity_sg(req->q, req->bio) != 1) {
+				dma_unmap_sg(dev->dev, iod->sg, iod->nents,
+						dma_dir);
 				goto error_cmd;
+			}
 
 			sg_init_table(iod->meta_sg, 1);
 			if (blk_rq_map_integrity_sg(
-					req->q, req->bio, iod->meta_sg) != 1)
+					req->q, req->bio, iod->meta_sg) != 1) {
+				dma_unmap_sg(dev->dev, iod->sg, iod->nents,
+						dma_dir);
 				goto error_cmd;
+			}
 
 			if (rq_data_dir(req))
 				nvme_dif_remap(req, nvme_dif_prep);
 
-			if (!dma_map_sg(nvmeq->q_dmadev, iod->meta_sg, 1, dma_dir))
+			if (!dma_map_sg(nvmeq->q_dmadev, iod->meta_sg, 1, dma_dir)) {
+				dma_unmap_sg(dev->dev, iod->sg, iod->nents,
+						dma_dir);
 				goto error_cmd;
+			}
 		}
 	}
 
-- 
1.9.1
