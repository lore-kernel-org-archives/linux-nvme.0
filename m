From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Mar 2019 16:10:28 -0700
Subject: [PATCH 06/15] nvme-pci: remove nvme_init_iod
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
Message-ID: <20190321231037.25104-7-hch@lst.de>

nvme_init_iod should really be split into two parts: initialize a few
general iod fields, which can easily be done at the beginning of
nvme_queue_rq, and allocating the scatterlist if needed, which logically
belongs into nvme_map_data with the code making use of it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 56 ++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bf0d71fe243e..3f06e942fb47 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -208,10 +208,10 @@ struct nvme_queue {
 };
 
 /*
- * The nvme_iod describes the data in an I/O, including the list of PRP
- * entries.  You can't see it in this data structure because C doesn't let
- * me express that.  Use nvme_init_iod to ensure there's enough space
- * allocated to store the PRP list.
+ * The nvme_iod describes the data in an I/O.
+ *
+ * The sg pointer contains the list of PRP/SGL chunk allocations in addition
+ * to the actual struct scatterlist.
  */
 struct nvme_iod {
 	struct nvme_request req;
@@ -583,29 +583,6 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 	return true;
 }
 
-static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(rq);
-	int nseg = blk_rq_nr_phys_segments(rq);
-	unsigned int size = blk_rq_payload_bytes(rq);
-
-	iod->use_sgl = nvme_pci_use_sgls(dev, rq);
-
-	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {
-		iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
-		if (!iod->sg)
-			return BLK_STS_RESOURCE;
-	} else {
-		iod->sg = iod->inline_sg;
-	}
-
-	iod->aborted = 0;
-	iod->npages = -1;
-	iod->nents = 0;
-
-	return BLK_STS_OK;
-}
-
 static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -837,6 +814,17 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	blk_status_t ret = BLK_STS_IOERR;
 	int nr_mapped;
 
+	if (blk_rq_payload_bytes(req) > NVME_INT_BYTES(dev) ||
+	    blk_rq_nr_phys_segments(req) > NVME_INT_PAGES) {
+		iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
+		if (!iod->sg)
+			return BLK_STS_RESOURCE;
+	} else {
+		iod->sg = iod->inline_sg;
+	}
+
+	iod->use_sgl = nvme_pci_use_sgls(dev, req);
+
 	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
 	iod->nents = blk_rq_map_sg(q, req, iod->sg);
 	if (!iod->nents)
@@ -881,6 +869,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 out_unmap:
 	dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
 out:
+	nvme_free_iod(dev, req);
 	return ret;
 }
 
@@ -913,9 +902,14 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_queue *nvmeq = hctx->driver_data;
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *req = bd->rq;
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_command cmnd;
 	blk_status_t ret;
 
+	iod->aborted = 0;
+	iod->npages = -1;
+	iod->nents = 0;
+
 	/*
 	 * We should not need to do this, but we're still using this to
 	 * ensure we can drain requests on a dying queue.
@@ -927,21 +921,15 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
-	ret = nvme_init_iod(req, dev);
-	if (ret)
-		goto out_free_cmd;
-
 	if (blk_rq_nr_phys_segments(req)) {
 		ret = nvme_map_data(dev, req, &cmnd);
 		if (ret)
-			goto out_cleanup_iod;
+			goto out_free_cmd;
 	}
 
 	blk_mq_start_request(req);
 	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
 	return BLK_STS_OK;
-out_cleanup_iod:
-	nvme_free_iod(dev, req);
 out_free_cmd:
 	nvme_cleanup_cmd(req);
 	return ret;
-- 
2.20.1
