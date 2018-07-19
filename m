From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 19 Jul 2018 17:06:28 -0600
Subject: [RCF PATCH 2/2] nvme-pci: Bounce data from Host memory to CMB Memory
In-Reply-To: <20180719230628.31494-1-scott.bauer@intel.com>
References: <20180719230628.31494-1-scott.bauer@intel.com>
Message-ID: <20180719230628.31494-3-scott.bauer@intel.com>

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 drivers/nvme/host/pci.c | 91 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b8c81be4a985..2f1dd7e582ac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -53,6 +53,10 @@ static bool use_cmb_sqes = true;
 module_param(use_cmb_sqes, bool, 0444);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
+static bool use_cmb_wds = false;
+module_param(use_cmb_wds, bool, 0444);
+MODULE_PARM_DESC(use_cmb_wds, "use controller's memory buffer for I/O data");
+
 static unsigned int max_host_mem_size_mb = 128;
 module_param(max_host_mem_size_mb, uint, 0444);
 MODULE_PARM_DESC(max_host_mem_size_mb,
@@ -193,6 +197,7 @@ struct nvme_iod {
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int nents;		/* Used in scatterlist */
 	int length;		/* Of data, in bytes */
+	int cmb_data;           /* Data was copied into CMB for WDS */
 	dma_addr_t first_dma;
 	struct scatterlist meta_sg; /* metadata requires single contiguous buffer */
 	struct scatterlist *sg;
@@ -504,6 +509,30 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 	return BLK_STS_OK;
 }
 
+static void nvme_unmap_sg_cmb(struct nvme_dev *dev, struct nvme_iod *iod,
+			      int num_mapped)
+{
+	struct scatterlist *s;
+	int j;
+
+	for_each_sg(iod->sg, s, iod->nents, j) {
+		if (j == num_mapped)
+			break;
+		gen_pool_free(dev->cmb_pool, s->page_link, s->length);
+		s->dma_address = 0;
+		s->page_link = 0;
+		sg_dma_len(s) = 0;
+	}
+	iod->cmb_data = 0;
+}
+
+static void nvme_clean_cmb_iod(struct nvme_dev *dev, struct nvme_iod *iod)
+{
+	if (iod->cmb_data)
+		nvme_unmap_sg_cmb(dev, iod, iod->nents);
+	return;
+}
+
 static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -534,8 +563,10 @@ static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 		dma_addr = next_dma_addr;
 	}
 
-	if (iod->sg != iod->inline_sg)
+	if (iod->sg != iod->inline_sg) {
+		nvme_clean_cmb_iod(dev, iod);
 		mempool_free(iod->sg, dev->iod_mempool);
+	}
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
@@ -641,6 +672,12 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 		goto done;
 	}
 
+	if (iod->cmb_data)
+		dma_addr = gen_pool_virt_to_phys(dev->cmb_pool,
+						 sg_dma_address(sg));
+	else
+		dma_addr = sg_dma_address(sg);
+
 	dma_len -= (page_size - offset);
 	if (dma_len) {
 		dma_addr += (page_size - offset);
@@ -792,8 +829,37 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 	return BLK_STS_OK;
 }
 
+static int nvme_copy_to_cmb(struct nvme_dev *dev, struct nvme_iod *iod)
+{
+	struct scatterlist *s;
+	void *data_cmb;
+	int i;
+
+	iod->cmb_data = 1;
+	for_each_sg(iod->sg, s, iod->nents, i) {
+		data_cmb = (void *) gen_pool_alloc(dev->cmb_pool, s->length);
+		if (!data_cmb) {
+			pr_err("%s: failed to alloc from pool\n", __func__);
+			goto unwind;
+		}
+
+		memcpy_toio(data_cmb, page_address(sg_page(s)), s->length);
+
+		s->dma_address = gen_pool_virt_to_phys(dev->cmb_pool,
+						       (unsigned long) data_cmb);
+		sg_dma_len(s) = s->length;
+		/* We do not need the sg_page page link anymore so we'll steal it. */
+		s->page_link = (unsigned long) data_cmb;
+	}
+	return i;
+
+ unwind:
+	nvme_unmap_sg_cmb(dev, iod, i);
+	return 0;
+}
+
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
-		struct nvme_command *cmnd)
+				  struct nvme_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct request_queue *q = req->q;
@@ -808,8 +874,15 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out;
 
 	ret = BLK_STS_RESOURCE;
-	nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
-			DMA_ATTR_NO_WARN);
+
+	if (dma_dir == DMA_TO_DEVICE && use_cmb_wds
+	    && dev->cmb_pool && dev->cmbsz & NVME_CMBSZ_WDS &&
+	    iod->nvmeq->qid)
+		nr_mapped = nvme_copy_to_cmb(dev, iod);
+	else
+		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
+					     dma_dir, DMA_ATTR_NO_WARN);
+
 	if (!nr_mapped)
 		goto out;
 
@@ -842,7 +915,10 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	return BLK_STS_OK;
 
 out_unmap:
-	dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
+	if (iod->cmb_data)
+		nvme_unmap_sg_cmb(dev, iod, iod->nents);
+	else
+		dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
 out:
 	return ret;
 }
@@ -853,7 +929,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 	enum dma_data_direction dma_dir = rq_data_dir(req) ?
 			DMA_TO_DEVICE : DMA_FROM_DEVICE;
 
-	if (iod->nents) {
+	if (iod->nents && !iod->cmb_data) {
 		dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
 		if (blk_integrity_rq(req)) {
 			if (req_op(req) == REQ_OP_READ)
@@ -1210,6 +1286,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 */
 	if (nvme_should_reset(dev, csts)) {
 		nvme_warn_reset(dev, csts);
+		nvme_clean_cmb_iod(dev, iod);
 		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
 		return BLK_EH_DONE;
@@ -1237,6 +1314,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
+		nvme_clean_cmb_iod(dev, iod);
 		nvme_dev_disable(dev, false);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_DONE;
@@ -1253,6 +1331,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
+		nvme_clean_cmb_iod(dev, iod);
 		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
 
-- 
2.17.1
