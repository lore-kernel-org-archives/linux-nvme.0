From: hch@lst.de (hch@lst.de)
Date: Mon, 8 Jan 2018 10:49:51 +0100
Subject: Bug report - drivers/nvme/host/pci.c?
In-Reply-To: <20180103201131.GB11172@localhost.localdomain>
References: <4dcd8c76-872e-69e3-3cbd-d051bdf0bf62@huawei.com>
 <BY2PR04MB2101903E77826A0479550572861E0@BY2PR04MB2101.namprd04.prod.outlook.com>
 <20180103200140.GA11172@localhost.localdomain>
 <20180103201131.GB11172@localhost.localdomain>
Message-ID: <20180108094951.GB4673@lst.de>

On Wed, Jan 03, 2018@01:11:31PM -0700, Keith Busch wrote:
> Just fyi, the driver selecting when to use SGL vs PRP is done prior to
> DMA mapping the scatter list. An IOMMU may map a virtually contiguous
> buffer into a single address, which is probably where biggest win for
> SGL over PRP exists. I think this driver handling ought to be reworked.

True.  The virtually contiguous (vs physical) case is rather unusual
and can only happen on PARISC and HP IA64 systems, though.

Anyway, moving the decision to after dma_map makes sense.  What do you
think of the untested patch below?  I also (so far very crudely)
enforces we only use SGLs if they fit into the same allocation as the
equivalent PRPs, so that we don't need to check use_sgl at allocation
time:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d53550e612bc..b74031ce1e19 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -330,35 +330,17 @@ static int nvme_npages(unsigned size, struct nvme_dev *dev)
 	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
 }
 
-/*
- * Calculates the number of pages needed for the SGL segments. For example a 4k
- * page can accommodate 256 SGL descriptors.
- */
-static int nvme_pci_npages_sgl(unsigned int num_seg)
-{
-	return DIV_ROUND_UP(num_seg * sizeof(struct nvme_sgl_desc), PAGE_SIZE);
-}
-
 static unsigned int nvme_pci_iod_alloc_size(struct nvme_dev *dev,
-		unsigned int size, unsigned int nseg, bool use_sgl)
+		unsigned int size, unsigned int nseg)
 {
-	size_t alloc_size;
-
-	if (use_sgl)
-		alloc_size = sizeof(__le64 *) * nvme_pci_npages_sgl(nseg);
-	else
-		alloc_size = sizeof(__le64 *) * nvme_npages(size, dev);
-
-	return alloc_size + sizeof(struct scatterlist) * nseg;
+	return sizeof(__le64 *) * nvme_npages(size, dev) +
+		sizeof(struct scatterlist) * nseg;
 }
 
-static unsigned int nvme_pci_cmd_size(struct nvme_dev *dev, bool use_sgl)
+static unsigned int nvme_pci_cmd_size(struct nvme_dev *dev)
 {
-	unsigned int alloc_size = nvme_pci_iod_alloc_size(dev,
-				    NVME_INT_BYTES(dev), NVME_INT_PAGES,
-				    use_sgl);
-
-	return sizeof(struct nvme_iod) + alloc_size;
+	return sizeof(struct nvme_iod) + nvme_pci_iod_alloc_size(dev,
+			NVME_INT_BYTES(dev), NVME_INT_PAGES);
 }
 
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
@@ -448,20 +430,32 @@ static void **nvme_pci_iod_list(struct request *req)
 	return (void **)(iod->sg + blk_rq_nr_phys_segments(req));
 }
 
-static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
+#define SGL_FACTOR  (sizeof(struct nvme_sgl_desc) / sizeof(__le64))
+
+static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
+		int nr_mapped)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	unsigned int avg_seg_size;
-
-	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req),
-			blk_rq_nr_phys_segments(req));
 
 	if (!(dev->ctrl.sgls & ((1 << 0) | (1 << 1))))
 		return false;
 	if (!iod->nvmeq->qid)
 		return false;
-	if (!sgl_threshold || avg_seg_size < sgl_threshold)
+	if (!sgl_threshold)
 		return false;
+	/*
+	 * Need to make sure we have enough space for the SGLs, which are twice
+	 * as large as the PRPs.
+	 *
+	 * XXX: probably should move to module parameter parsing time.
+	 */
+	if (WARN_ON_ONCE(sgl_threshold < SGL_FACTOR * PAGE_SIZE))
+		return false;
+
+	if (DIV_ROUND_UP(blk_rq_payload_bytes(req), nr_mapped) < sgl_threshold)
+		return false;
+
+	iod->use_sgl = true;
 	return true;
 }
 
@@ -471,11 +465,8 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 	int nseg = blk_rq_nr_phys_segments(rq);
 	unsigned int size = blk_rq_payload_bytes(rq);
 
-	iod->use_sgl = nvme_pci_use_sgls(dev, rq);
-
 	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {
-		size_t alloc_size = nvme_pci_iod_alloc_size(dev, size, nseg,
-				iod->use_sgl);
+		size_t alloc_size = nvme_pci_iod_alloc_size(dev, size, nseg);
 
 		iod->sg = kmalloc(alloc_size, GFP_ATOMIC);
 		if (!iod->sg)
@@ -488,6 +479,7 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 	iod->npages = -1;
 	iod->nents = 0;
 	iod->length = size;
+	iod->use_sgl = false;
 
 	return BLK_STS_OK;
 }
@@ -722,25 +714,24 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 }
 
 static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmd)
+		struct request *req, int nr_sgl, struct nvme_rw_command *cmd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	int length = blk_rq_payload_bytes(req);
 	struct dma_pool *pool;
 	struct nvme_sgl_desc *sg_list;
 	struct scatterlist *sg = iod->sg;
-	int entries = iod->nents, i = 0;
 	dma_addr_t sgl_dma;
+	int i = 0;
 
 	/* setting the transfer type as SGL */
 	cmd->flags = NVME_CMD_SGL_METABUF;
 
-	if (length == sg_dma_len(sg)) {
+	if (nr_sgl == 1) {
 		nvme_pci_sgl_set_data(&cmd->dptr.sgl, sg);
 		return BLK_STS_OK;
 	}
 
-	if (entries <= (256 / sizeof(struct nvme_sgl_desc))) {
+	if (nr_sgl <= 256 / sizeof(struct nvme_sgl_desc)) {
 		pool = dev->prp_small_pool;
 		iod->npages = 0;
 	} else {
@@ -757,7 +748,7 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 	nvme_pci_iod_list(req)[0] = sg_list;
 	iod->first_dma = sgl_dma;
 
-	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, entries);
+	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, nr_sgl);
 
 	do {
 		if (i == SGES_PER_PAGE) {
@@ -771,17 +762,13 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 			i = 0;
 			nvme_pci_iod_list(req)[iod->npages++] = sg_list;
 			sg_list[i++] = *link;
-			nvme_pci_sgl_set_seg(link, sgl_dma, entries);
+			nvme_pci_sgl_set_seg(link, sgl_dma, nr_sgl);
 		}
 
 		nvme_pci_sgl_set_data(&sg_list[i++], sg);
-
-		length -= sg_dma_len(sg);
 		sg = sg_next(sg);
-		entries--;
-	} while (length > 0);
+	} while (--nr_sgl > 0);
 
-	WARN_ON(entries > 0);
 	return BLK_STS_OK;
 }
 
@@ -793,6 +780,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	enum dma_data_direction dma_dir = rq_data_dir(req) ?
 			DMA_TO_DEVICE : DMA_FROM_DEVICE;
 	blk_status_t ret = BLK_STS_IOERR;
+	int nr_mapped;
 
 	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
 	iod->nents = blk_rq_map_sg(q, req, iod->sg);
@@ -800,15 +788,15 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out;
 
 	ret = BLK_STS_RESOURCE;
-	if (!dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
-				DMA_ATTR_NO_WARN))
+	nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
+			DMA_ATTR_NO_WARN);
+	if (!nr_mapped)
 		goto out;
 
-	if (iod->use_sgl)
-		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw);
+	if (nvme_pci_use_sgls(dev, req, nr_mapped))
+		ret = nvme_pci_setup_sgls(dev, req, nr_mapped, &cmnd->rw);
 	else
 		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
-
 	if (ret != BLK_STS_OK)
 		goto out_unmap;
 
@@ -1519,7 +1507,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
-		dev->admin_tagset.cmd_size = nvme_pci_cmd_size(dev, false);
+		dev->admin_tagset.cmd_size = nvme_pci_cmd_size(dev);
 		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
 		dev->admin_tagset.driver_data = dev;
 
@@ -2047,11 +2035,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.numa_node = dev_to_node(dev->dev);
 		dev->tagset.queue_depth =
 				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
-		dev->tagset.cmd_size = nvme_pci_cmd_size(dev, false);
-		if ((dev->ctrl.sgls & ((1 << 0) | (1 << 1))) && sgl_threshold) {
-			dev->tagset.cmd_size = max(dev->tagset.cmd_size,
-					nvme_pci_cmd_size(dev, true));
-		}
+		dev->tagset.cmd_size = nvme_pci_cmd_size(dev);
 		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 		dev->tagset.driver_data = dev;
 
