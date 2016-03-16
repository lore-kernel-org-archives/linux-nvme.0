From: mlin@kernel.org (Ming Lin)
Date: Wed, 16 Mar 2016 16:15:32 -0700
Subject: [PATCH RFC] nvme: rewrite discard support
Message-ID: <1458170132-16031-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

This rewrites nvme_setup_discard() similar as sd_setup_discard_cmnd().
And moves it to common code so fabrics driver can also use it.

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/nvme.h | 26 ++++++++++++++++++++
 drivers/nvme/host/pci.c  | 64 +++++++++++++++++++++---------------------------
 2 files changed, 54 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 75982b9..c757746 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -231,6 +231,32 @@ static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
 }
 
+static inline int nvme_setup_discard(struct nvme_ns *ns,
+		struct request *req, struct nvme_command *cmnd)
+{
+	struct nvme_dsm_range *range;
+	struct page *page;
+
+	page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
+	if (!page)
+		return BLKPREP_DEFER;
+
+	range = page_address(page);
+	range->cattr = cpu_to_le32(0);
+	range->nlb = cpu_to_le32(blk_rq_bytes(req) >> ns->lba_shift);
+	range->slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+
+	memset(cmnd, 0, sizeof(*cmnd));
+	cmnd->dsm.opcode = nvme_cmd_dsm;
+	cmnd->dsm.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->dsm.nr = 0;
+	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
+
+	req->completion_data = page;
+	blk_add_request_payload(req, page, sizeof(struct nvme_dsm_range));
+
+	return 0;
+}
 
 static inline int nvme_error_status(u16 status)
 {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4301584..eb593e6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -382,6 +382,9 @@ static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 	__le64 **list = iod_list(req);
 	dma_addr_t prp_dma = iod->first_dma;
 
+	if (req->cmd_flags & REQ_DISCARD)
+		__free_page(req->completion_data);
+
 	if (iod->npages == 0)
 		dma_pool_free(dev->prp_small_pool, list[0], prp_dma);
 	for (i = 0; i < iod->npages; i++) {
@@ -610,37 +613,6 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 }
 
 /*
- * We reuse the small pool to allocate the 16-byte range here as it is not
- * worth having a special pool for these or additional cases to handle freeing
- * the iod.
- */
-static int nvme_setup_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
-		struct request *req, struct nvme_command *cmnd)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_dsm_range *range;
-
-	range = dma_pool_alloc(nvmeq->dev->prp_small_pool, GFP_ATOMIC,
-						&iod->first_dma);
-	if (!range)
-		return BLK_MQ_RQ_QUEUE_BUSY;
-	iod_list(req)[0] = (__le64 *)range;
-	iod->npages = 0;
-
-	range->cattr = cpu_to_le32(0);
-	range->nlb = cpu_to_le32(blk_rq_bytes(req) >> ns->lba_shift);
-	range->slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
-
-	memset(cmnd, 0, sizeof(*cmnd));
-	cmnd->dsm.opcode = nvme_cmd_dsm;
-	cmnd->dsm.nsid = cpu_to_le32(ns->ns_id);
-	cmnd->dsm.prp1 = cpu_to_le64(iod->first_dma);
-	cmnd->dsm.nr = 0;
-	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
-	return BLK_MQ_RQ_QUEUE_OK;
-}
-
-/*
  * NOTE: ns is NULL when called on the admin queue.
  */
 static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -671,7 +643,27 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return ret;
 
 	if (req->cmd_flags & REQ_DISCARD) {
-		ret = nvme_setup_discard(nvmeq, ns, req, &cmnd);
+		unsigned int nr_bytes = blk_rq_bytes(req);
+
+		ret = nvme_setup_discard(ns, req, &cmnd);
+		if (ret)
+			goto out;
+		ret = nvme_map_data(dev, req, &cmnd);
+		if (ret) {
+			 __free_page(req->completion_data);
+			goto out;
+		}
+
+		/*
+		 * Initially __data_len is set to the amount of data that needs
+		 * to be transferred to the namespace. This amount depends on
+		 * whether DISCARD is being used. After the scatterlist has been
+		 * mapped by nvme_map_data() we set __data_len to the size of
+		 * the area to be discarded on disk. This allows us to report
+		 * completion on the full amount of blocks described by the
+		 * request.
+		 */
+		req->__data_len = nr_bytes;
 	} else {
 		if (req->cmd_type == REQ_TYPE_DRV_PRIV)
 			memcpy(&cmnd, req->cmd, sizeof(cmnd));
@@ -680,13 +672,13 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		else
 			nvme_setup_rw(ns, req, &cmnd);
 
-		if (req->nr_phys_segments)
+		if (req->nr_phys_segments) {
 			ret = nvme_map_data(dev, req, &cmnd);
+			if (ret)
+				goto out;
+		}
 	}
 
-	if (ret)
-		goto out;
-
 	cmnd.common.command_id = req->tag;
 	blk_mq_start_request(req);
 
-- 
1.9.1
