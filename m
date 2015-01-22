From: axboe@fb.com (Jens Axboe)
Date: Thu, 22 Jan 2015 12:07:58 -0700
Subject: [PATCH v2] NVMe: avoid kmalloc/kfree for smaller IO
Message-ID: <20150122190758.GA28666@kernel.dk>


Currently we allocate an nvme_iod for each IO, which holds the
sg list, prps, and other IO related info. Set a threshold of
2 pages and/or 8KB of data, below which we can just embed this
in the per-command pdu in blk-mq. For any IO at or below
NVME_INT_PAGES and NVME_INT_BYTES, we save a kmalloc and kfree.

For higher IOPS, this saves up to 1% of CPU time.

Signed-off-by: Jens Axboe <axboe at fb.com>

----

v2:     Use device page size, not page cache size

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index f4aa64160838..3eaa0becc52d 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -144,8 +144,37 @@ struct nvme_cmd_info {
 	void *ctx;
 	int aborted;
 	struct nvme_queue *nvmeq;
+	struct nvme_iod iod[0];
 };
 
+/*
+ * Max size of iod being embedded in the request payload
+ */
+#define NVME_INT_PAGES		2
+#define NVME_INT_BYTES(dev)	(NVME_INT_PAGES * (dev)->page_size)
+
+/*
+ * Will slightly overestimate the number of pages needed.  This is OK
+ * as it only leads to a small amount of wasted memory for the lifetime of
+ * the I/O.
+ */
+static int nvme_npages(unsigned size, struct nvme_dev *dev)
+{
+	unsigned nprps = DIV_ROUND_UP(size + dev->page_size, dev->page_size);
+	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
+}
+
+static unsigned int nvme_cmd_size(struct nvme_dev *dev)
+{
+	unsigned int ret = sizeof(struct nvme_cmd_info);
+
+	ret += sizeof(struct nvme_iod);
+	ret += sizeof(__le64 *) * nvme_npages(NVME_INT_BYTES(dev), dev);
+	ret += sizeof(struct scatterlist) * NVME_INT_PAGES;
+
+	return ret;
+}
+
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 				unsigned int hctx_idx)
 {
@@ -217,6 +246,19 @@ static void nvme_set_info(struct nvme_cmd_info *cmd, void *ctx,
 	cmd->aborted = 0;
 }
 
+static void *iod_get_private(struct nvme_iod *iod)
+{
+	return (void *) (iod->private & ~0x1UL);
+}
+
+/*
+ * If bit 0 is set, the iod is embedded in the request payload.
+ */
+static bool iod_should_kfree(struct nvme_iod *iod)
+{
+	return (iod->private & 0x01) == 0;
+}
+
 /* Special values must be less than 0x1000 */
 #define CMD_CTX_BASE		((void *)POISON_POINTER_DELTA)
 #define CMD_CTX_CANCELLED	(0x30C + CMD_CTX_BASE)
@@ -360,35 +402,53 @@ static __le64 **iod_list(struct nvme_iod *iod)
 	return ((void *)iod) + iod->offset;
 }
 
-/*
- * Will slightly overestimate the number of pages needed.  This is OK
- * as it only leads to a small amount of wasted memory for the lifetime of
- * the I/O.
- */
-static int nvme_npages(unsigned size, struct nvme_dev *dev)
+static inline void iod_init(struct nvme_iod *iod, unsigned nbytes,
+			    unsigned nseg, unsigned long private)
 {
-	unsigned nprps = DIV_ROUND_UP(size + dev->page_size, dev->page_size);
-	return DIV_ROUND_UP(8 * nprps, dev->page_size - 8);
+	iod->private = private;
+	iod->offset = offsetof(struct nvme_iod, sg[nseg]);
+	iod->npages = -1;
+	iod->length = nbytes;
+	iod->nents = 0;
 }
 
 static struct nvme_iod *
-nvme_alloc_iod(unsigned nseg, unsigned nbytes, struct nvme_dev *dev, gfp_t gfp)
+__nvme_alloc_iod(unsigned nseg, unsigned bytes, struct nvme_dev *dev,
+		 unsigned long priv, gfp_t gfp)
 {
 	struct nvme_iod *iod = kmalloc(sizeof(struct nvme_iod) +
-				sizeof(__le64 *) * nvme_npages(nbytes, dev) +
+				sizeof(__le64 *) * nvme_npages(bytes, dev) +
 				sizeof(struct scatterlist) * nseg, gfp);
 
-	if (iod) {
-		iod->offset = offsetof(struct nvme_iod, sg[nseg]);
-		iod->npages = -1;
-		iod->length = nbytes;
-		iod->nents = 0;
-		iod->first_dma = 0ULL;
-	}
+	if (iod)
+		iod_init(iod, bytes, nseg, priv);
 
 	return iod;
 }
 
+static struct nvme_iod *nvme_alloc_iod(struct request *rq, struct nvme_dev *dev,
+			               gfp_t gfp)
+{
+	unsigned size = !(rq->cmd_flags & REQ_DISCARD) ? blk_rq_bytes(rq) :
+                                                sizeof(struct nvme_dsm_range);
+	unsigned long mask = 0;
+	struct nvme_iod *iod;
+
+	if (rq->nr_phys_segments <= NVME_INT_PAGES &&
+	    size <= NVME_INT_BYTES(dev)) {
+		struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(rq);
+
+		iod = cmd->iod;
+		mask = 0x01;
+		iod_init(iod, size, rq->nr_phys_segments,
+				(unsigned long) rq | 0x01);
+		return iod;
+	}
+
+	return __nvme_alloc_iod(rq->nr_phys_segments, size, dev,
+				(unsigned long) rq, gfp);
+}
+
 void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
 {
 	const int last_prp = dev->page_size / 8 - 1;
@@ -404,7 +464,9 @@ void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
 		dma_pool_free(dev->prp_page_pool, prp_list, prp_dma);
 		prp_dma = next_prp_dma;
 	}
-	kfree(iod);
+
+	if (iod_should_kfree(iod))
+		kfree(iod);
 }
 
 static int nvme_error_status(u16 status)
@@ -423,7 +485,7 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	struct nvme_iod *iod = ctx;
-	struct request *req = iod->private;
+	struct request *req = iod_get_private(iod);
 	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
 
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
@@ -579,7 +641,7 @@ static void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 							struct nvme_ns *ns)
 {
-	struct request *req = iod->private;
+	struct request *req = iod_get_private(iod);
 	struct nvme_command *cmnd;
 	u16 control = 0;
 	u32 dsmgmt = 0;
@@ -620,17 +682,12 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *req = bd->rq;
 	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
 	struct nvme_iod *iod;
-	int psegs = req->nr_phys_segments;
 	enum dma_data_direction dma_dir;
-	unsigned size = !(req->cmd_flags & REQ_DISCARD) ? blk_rq_bytes(req) :
-						sizeof(struct nvme_dsm_range);
 
-	iod = nvme_alloc_iod(psegs, size, ns->dev, GFP_ATOMIC);
+	iod = nvme_alloc_iod(req, ns->dev, GFP_ATOMIC);
 	if (!iod)
 		return BLK_MQ_RQ_QUEUE_BUSY;
 
-	iod->private = req;
-
 	if (req->cmd_flags & REQ_DISCARD) {
 		void *range;
 		/*
@@ -645,10 +702,10 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 			goto retry_cmd;
 		iod_list(iod)[0] = (__le64 *)range;
 		iod->npages = 0;
-	} else if (psegs) {
+	} else if (req->nr_phys_segments) {
 		dma_dir = rq_data_dir(req) ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
 
-		sg_init_table(iod->sg, psegs);
+		sg_init_table(iod->sg, req->nr_phys_segments);
 		iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
 		if (!iod->nents)
 			goto error_cmd;
@@ -1362,7 +1419,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.queue_depth = NVME_AQ_DEPTH - 1;
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(&dev->pci_dev->dev);
-		dev->admin_tagset.cmd_size = sizeof(struct nvme_cmd_info);
+		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
 		dev->admin_tagset.driver_data = dev;
 
 		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
@@ -1483,7 +1540,7 @@ struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
 	}
 
 	err = -ENOMEM;
-	iod = nvme_alloc_iod(count, length, dev, GFP_KERNEL);
+	iod = __nvme_alloc_iod(count, length, dev, 0, GFP_KERNEL);
 	if (!iod)
 		goto put_pages;
 
@@ -2109,7 +2166,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	dev->tagset.numa_node = dev_to_node(&dev->pci_dev->dev);
 	dev->tagset.queue_depth =
 				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
-	dev->tagset.cmd_size = sizeof(struct nvme_cmd_info);
+	dev->tagset.cmd_size = nvme_cmd_size(dev);
 	dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 	dev->tagset.driver_data = dev;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 258945fcabf1..19a5d4b23209 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -132,13 +132,12 @@ struct nvme_ns {
  * allocated to store the PRP list.
  */
 struct nvme_iod {
-	void *private;		/* For the use of the submitter of the I/O */
+	unsigned long private;	/* For the use of the submitter of the I/O */
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int offset;		/* Of PRP list */
 	int nents;		/* Used in scatterlist */
 	int length;		/* Of data, in bytes */
 	dma_addr_t first_dma;
-	struct list_head node;
 	struct scatterlist sg[0];
 };
 

-- 
Jens Axboe
