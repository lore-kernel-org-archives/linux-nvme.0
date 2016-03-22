From: mlin@kernel.org (Ming Lin)
Date: Tue, 22 Mar 2016 00:24:45 -0700
Subject: [PATCH v2 3/4] nvme: rewrite discard support
In-Reply-To: <1458631486-14120-1-git-send-email-mlin@kernel.org>
References: <1458631486-14120-1-git-send-email-mlin@kernel.org>
Message-ID: <1458631486-14120-4-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

This rewrites nvme_setup_discard() with blk_add_request_payload().
It allocates only the necessary amount(16 bytes) for the payload.

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/pci.c | 68 ++++++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2db6f89..f2f8a4d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -377,6 +377,9 @@ static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 	__le64 **list = iod_list(req);
 	dma_addr_t prp_dma = iod->first_dma;
 
+	if (req->cmd_flags & REQ_DISCARD)
+		kfree(req->completion_data);
+
 	if (iod->npages == 0)
 		dma_pool_free(dev->prp_small_pool, list[0], prp_dma);
 	for (i = 0; i < iod->npages; i++) {
@@ -538,7 +541,7 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req,
 }
 
 static int nvme_map_data(struct nvme_dev *dev, struct request *req,
-		struct nvme_command *cmnd)
+		unsigned size, struct nvme_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct request_queue *q = req->q;
@@ -555,7 +558,7 @@ static int nvme_map_data(struct nvme_dev *dev, struct request *req,
 	if (!dma_map_sg(dev->dev, iod->sg, iod->nents, dma_dir))
 		goto out;
 
-	if (!nvme_setup_prps(dev, req, blk_rq_bytes(req)))
+	if (!nvme_setup_prps(dev, req, size))
 		goto out_unmap;
 
 	ret = BLK_MQ_RQ_QUEUE_ERROR;
@@ -604,35 +607,41 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 	nvme_free_iod(dev, req);
 }
 
-/*
- * We reuse the small pool to allocate the 16-byte range here as it is not
- * worth having a special pool for these or additional cases to handle freeing
- * the iod.
- */
-static int nvme_setup_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
-		struct request *req, struct nvme_command *cmnd)
+static inline int nvme_setup_discard(struct nvme_ns *ns, struct request *req,
+		struct nvme_command *cmnd)
 {
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_dsm_range *range;
+	struct page *page;
+	int offset;
+	unsigned int nr_bytes = blk_rq_bytes(req);
 
-	range = dma_pool_alloc(nvmeq->dev->prp_small_pool, GFP_ATOMIC,
-						&iod->first_dma);
+	range = kmalloc(sizeof(*range), GFP_ATOMIC);
 	if (!range)
 		return BLK_MQ_RQ_QUEUE_BUSY;
-	iod_list(req)[0] = (__le64 *)range;
-	iod->npages = 0;
 
 	range->cattr = cpu_to_le32(0);
-	range->nlb = cpu_to_le32(blk_rq_bytes(req) >> ns->lba_shift);
+	range->nlb = cpu_to_le32(nr_bytes >> ns->lba_shift);
 	range->slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->dsm.opcode = nvme_cmd_dsm;
 	cmnd->dsm.nsid = cpu_to_le32(ns->ns_id);
-	cmnd->dsm.prp1 = cpu_to_le64(iod->first_dma);
 	cmnd->dsm.nr = 0;
 	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
-	return BLK_MQ_RQ_QUEUE_OK;
+
+	req->completion_data = range;
+	page = virt_to_page(range);
+	offset = offset_in_page(range);
+	blk_add_request_payload(req, page, offset, sizeof(*range));
+
+	/*
+	 * we set __data_len back to the size of the area to be discarded
+	 * on disk. This allows us to report completion on the full amount
+	 * of blocks described by the request.
+	 */
+	req->__data_len = nr_bytes;
+
+	return 0;
 }
 
 /*
@@ -667,19 +676,20 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
-	if (req->cmd_flags & REQ_DISCARD) {
-		ret = nvme_setup_discard(nvmeq, ns, req, &cmnd);
-	} else {
-		if (req->cmd_type == REQ_TYPE_DRV_PRIV)
-			memcpy(&cmnd, req->cmd, sizeof(cmnd));
-		else if (req->cmd_flags & REQ_FLUSH)
-			nvme_setup_flush(ns, &cmnd);
-		else
-			nvme_setup_rw(ns, req, &cmnd);
+	if (req->cmd_type == REQ_TYPE_DRV_PRIV)
+		memcpy(&cmnd, req->cmd, sizeof(cmnd));
+	else if (req->cmd_flags & REQ_FLUSH)
+		nvme_setup_flush(ns, &cmnd);
+	else if (req->cmd_flags & REQ_DISCARD)
+		ret = nvme_setup_discard(ns, req, &cmnd);
+	else
+		nvme_setup_rw(ns, req, &cmnd);
 
-		if (req->nr_phys_segments)
-			ret = nvme_map_data(dev, req, &cmnd);
-	}
+	if (ret)
+		goto out;
+
+	if (req->nr_phys_segments)
+		ret = nvme_map_data(dev, req, map_len, &cmnd);
 
 	if (ret)
 		goto out;
-- 
1.9.1
