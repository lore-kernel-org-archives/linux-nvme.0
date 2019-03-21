From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Mar 2019 16:10:29 -0700
Subject: [PATCH 07/15] nvme-pci: move the call to nvme_cleanup_cmd out of
 nvme_unmap_data
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
Message-ID: <20190321231037.25104-8-hch@lst.de>

Cleaning up the command setup isn't related to unmapping data, and
disentangling them will simplify error handling a bit down the road.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3f06e942fb47..2fb35d44010a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -888,7 +888,6 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);
 	}
 
-	nvme_cleanup_cmd(req);
 	nvme_free_iod(dev, req);
 }
 
@@ -939,6 +938,7 @@ static void nvme_pci_complete_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
+	nvme_cleanup_cmd(req);
 	nvme_unmap_data(iod->nvmeq->dev, req);
 	nvme_complete_rq(req);
 }
-- 
2.20.1
