From: keith.busch@intel.com (Keith Busch)
Date: Fri, 23 Feb 2018 17:05:47 -0700
Subject: [RFC PATCH] nvme-pci: Bounce buffer for interleaved metadata
Message-ID: <20180224000547.7252-1-keith.busch@intel.com>

NVMe namespace formats allow the possibility for metadata as extended
LBAs. These require the memory interleave block and metadata in a single
virtually contiguous buffer.

The Linux block layer, however, maintains metadata and data in separate
buffers, which is unusable for NVMe drives using interleaved metadata
formats.

This patch will enable such formats by allocating a bounce buffer
interleaving the block and metadata, copying the everythign into the
buffer for writes, or from it for reads.

I dislike this feature intensely. It is incredibly slow and enough memory
overhead to make this not very useful for reclaim, but it's possible
people will leave me alone if the Linux nvme driver accomodated this
format.

On the other hand, I get the impression some people requesting this
may think their application will get to access the extended LBAs. The
reality is the kernel owns the metadata, so I may just setting myself
up to explain why "fdisk" still shows a 512b format instead of 520b...

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c |  13 +++-
 drivers/nvme/host/nvme.h |   1 -
 drivers/nvme/host/pci.c  | 170 +++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 162 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0fe7ea35c221..b54c31eead57 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1414,11 +1414,20 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_physical_block_size(disk->queue, bs);
 	blk_queue_io_min(disk->queue, bs);
 
-	if (ns->ms && !ns->ext &&
-	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
+	if (ns->ms && (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		nvme_init_integrity(disk, ns->ms, ns->pi_type);
 	if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
 		capacity = 0;
+	else if (ns->ms && ns->ext && ns->ctrl->max_hw_sectors != UINT_MAX) {
+		/* Interleaved metadata counts toward MDTS */
+		unsigned sectors = ns->ctrl->max_hw_sectors >>
+					(ns->lba_shift - 9);
+		unsigned new_max = ns->ctrl->max_hw_sectors -
+					DIV_ROUND_UP(sectors * ns->ms, 512);
+
+		blk_queue_max_hw_sectors(disk->queue, new_max);
+	} else
+		blk_queue_max_hw_sectors(disk->queue, ns->ctrl->max_hw_sectors);
 	set_capacity(disk, capacity);
 
 	if (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0521e4707d1c..503a94ff6125 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -152,7 +152,6 @@ struct nvme_ctrl {
 
 	struct opal_dev *opal_dev;
 
-	char name[12];
 	u16 cntlid;
 
 	u32 ctrl_config;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 73036d2fbbd5..3040b9a2a749 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -68,6 +68,11 @@ MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
 struct nvme_dev;
 struct nvme_queue;
 
+static void nvme_dif_remap(struct request *req,
+			void (*dif_swap)(u32 p, u32 v, struct t10_pi_tuple *pi));
+static void nvme_dif_prep(u32 p, u32 v, struct t10_pi_tuple *pi);
+static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi);
+
 static void nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 
@@ -176,8 +181,14 @@ struct nvme_queue {
 struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_queue *nvmeq;
-	bool use_sgl;
-	int aborted;
+	union {
+		unsigned int flags;
+		struct {
+			unsigned int use_sgl :1;
+			unsigned int aborted :1;
+			unsigned int remapped:1;
+		};
+	};
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int nents;		/* Used in scatterlist */
 	int length;		/* Of data, in bytes */
@@ -445,7 +456,10 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
 static void **nvme_pci_iod_list(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	return (void **)(iod->sg + blk_rq_nr_phys_segments(req));
+
+	if (!iod->remapped)
+		return (void **)(iod->sg + blk_rq_nr_phys_segments(req));
+	return (void **)(iod->sg + 1);
 }
 
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
@@ -468,14 +482,128 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 	return true;
 }
 
-static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
+static void nvme_iod_unmap(struct nvme_iod *iod, struct request *rq,
+			struct nvme_dev *dev)
+{
+	struct nvme_ns *ns = rq->rq_disk->private_data;
+	struct bio_integrity_payload *bip;
+	struct bio_vec bvec;
+	struct bio *bio = rq->bio;
+	struct bvec_iter iter = bio->bi_iter;
+	void *mem, *meta, *tmp = sg_virt(iod->sg);
+
+	if (req_op(rq) == REQ_OP_READ) {
+		u32 i, nlb, ts, bs;
+
+		bs = 1 << ns->lba_shift;
+		ts = ns->disk->queue->integrity.tuple_size;
+		nlb = (blk_rq_bytes(rq) >> ns->lba_shift);
+
+		bip = bio_integrity(rq->bio);
+		if (!bip)
+			return;
+
+		meta = kmap_atomic(bip->bip_vec->bv_page) + bip->bip_vec->bv_offset;
+		for (i = 0; i < nlb; i++) {
+			bvec = bio_iter_iovec(bio, iter);
+			bio_advance_iter(bio, &iter, bs);
+
+			mem = kmap_atomic(bvec.bv_page) + bvec.bv_offset;
+			memcpy(mem, tmp, bs);
+			kunmap_atomic(mem);
+			tmp += bs;
+
+			memcpy(meta + (i * ts), tmp, ts);
+			tmp += ts;
+		}
+		kunmap_atomic(meta);
+		nvme_dif_remap(rq, nvme_dif_complete);
+	}
+	kfree(sg_virt(iod->sg));
+}
+
+static blk_status_t nvme_iod_remap(struct nvme_iod *iod, struct request *rq,
+		struct nvme_ns *ns, struct nvme_dev *dev)
+{
+	struct bio_integrity_payload *bip;
+	struct bio_vec bvec;
+	struct bio *bio = rq->bio;
+	struct bvec_iter iter = bio->bi_iter;
+	void *mem, *meta, *tmp;
+	u32 i, nlb, ts, bs;
+
+	ts = ns->disk->queue->integrity.tuple_size;
+	nlb = (blk_rq_bytes(rq) >> ns->lba_shift);
+	bs = 1 << ns->lba_shift;
+
+	iod->length = blk_rq_bytes(rq) + ts * nlb;
+	if (!iod->length)
+		return BLK_STS_IOERR;
+
+	bip = bio_integrity(rq->bio);
+	if (!bip)
+		return BLK_STS_IOERR;
+
+	tmp = kmalloc(iod->length, GFP_KERNEL);
+	if (!tmp)
+		return BLK_STS_RESOURCE;
+
+	if (iod->length > NVME_INT_BYTES(dev)) {
+		iod->sg = kmalloc(nvme_pci_iod_alloc_size(dev, iod->length, 1, 0), GFP_ATOMIC);
+		if (!iod->sg) {
+			kfree(tmp);
+			return BLK_STS_RESOURCE;
+		}
+	} else {
+		iod->sg = iod->inline_sg;
+	}
+	iod->remapped = 1;
+	iod->npages = -1;
+	iod->nents = 1;
+
+	sg_init_table(iod->sg, 1);
+	sg_set_buf(iod->sg, tmp, iod->length);
+	sg_mark_end(iod->sg);
+
+	if (req_op(rq) == REQ_OP_READ)
+		return BLK_STS_OK;
+
+	nvme_dif_remap(rq, nvme_dif_prep);
+	meta = kmap_atomic(bip->bip_vec->bv_page) + bip->bip_vec->bv_offset;
+	for (i = 0; i < nlb; i++) {
+		bvec = bio_iter_iovec(bio, iter);
+		bio_advance_iter(bio, &iter, bs);
+
+		mem = kmap_atomic(bvec.bv_page) + bvec.bv_offset;
+		memcpy(tmp, mem, bs);
+		kunmap_atomic(mem);
+		tmp += bs;
+
+		memcpy(tmp, meta + (i * ts), ts);
+		tmp += ts;
+	}
+	kunmap_atomic(meta);
+	return BLK_STS_OK;
+}
+
+static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev, struct nvme_ns *ns)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(rq);
 	int nseg = blk_rq_nr_phys_segments(rq);
 	unsigned int size = blk_rq_payload_bytes(rq);
 
-	iod->use_sgl = nvme_pci_use_sgls(dev, rq);
+	iod->flags = 0;
+	if (ns && ns->ext && blk_integrity_rq(rq)) {
+		switch (req_op(rq)) {
+		case REQ_OP_WRITE:
+		case REQ_OP_READ:
+			return nvme_iod_remap(iod, rq, ns, dev);
+		default:
+			break;
+		}
+	}
 
+	iod->use_sgl = nvme_pci_use_sgls(dev, rq);
 	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {
 		size_t alloc_size = nvme_pci_iod_alloc_size(dev, size, nseg,
 				iod->use_sgl);
@@ -487,7 +615,6 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 		iod->sg = iod->inline_sg;
 	}
 
-	iod->aborted = 0;
 	iod->npages = -1;
 	iod->nents = 0;
 	iod->length = size;
@@ -525,6 +652,8 @@ static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 		dma_addr = next_dma_addr;
 	}
 
+	if (iod->remapped)
+		nvme_iod_unmap(iod, req, dev);
 	if (iod->sg != iod->inline_sg)
 		kfree(iod->sg);
 }
@@ -615,7 +744,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct dma_pool *pool;
-	int length = blk_rq_payload_bytes(req);
+	int length = iod->length;
 	struct scatterlist *sg = iod->sg;
 	int dma_len = sg_dma_len(sg);
 	u64 dma_addr = sg_dma_address(sg);
@@ -626,6 +755,9 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	dma_addr_t prp_dma;
 	int nprps, i;
 
+	if (iod->remapped)
+		nvme_print_sgl(sg, iod->nents);
+
 	length -= (page_size - offset);
 	if (length <= 0) {
 		iod->first_dma = 0;
@@ -791,12 +923,14 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	enum dma_data_direction dma_dir = rq_data_dir(req) ?
 			DMA_TO_DEVICE : DMA_FROM_DEVICE;
 	blk_status_t ret = BLK_STS_IOERR;
-	int nr_mapped;
+	int nr_mapped = 0;
 
-	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
-	iod->nents = blk_rq_map_sg(q, req, iod->sg);
-	if (!iod->nents)
-		goto out;
+	if (!iod->remapped) {
+		sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
+		iod->nents = blk_rq_map_sg(q, req, iod->sg);
+		if (!iod->nents)
+			goto out;
+	}
 
 	ret = BLK_STS_RESOURCE;
 	nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
@@ -813,7 +947,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		goto out_unmap;
 
 	ret = BLK_STS_IOERR;
-	if (blk_integrity_rq(req)) {
+	if (blk_integrity_rq(req) && !iod->remapped) {
 		if (blk_rq_count_integrity_sg(q, req->bio) != 1)
 			goto out_unmap;
 
@@ -826,10 +960,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 
 		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
 			goto out_unmap;
-	}
-
-	if (blk_integrity_rq(req))
 		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(&iod->meta_sg));
+	}
 	return BLK_STS_OK;
 
 out_unmap:
@@ -846,7 +978,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 
 	if (iod->nents) {
 		dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
-		if (blk_integrity_rq(req)) {
+		if (blk_integrity_rq(req) && !iod->remapped) {
 			if (req_op(req) == REQ_OP_READ)
 				nvme_dif_remap(req, nvme_dif_complete);
 			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);
@@ -867,6 +999,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_queue *nvmeq = hctx->driver_data;
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *req = bd->rq;
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_command cmnd;
 	blk_status_t ret;
 
@@ -874,7 +1007,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
-	ret = nvme_init_iod(req, dev);
+	ret = nvme_init_iod(req, dev, ns);
 	if (ret)
 		goto out_free_cmd;
 
@@ -885,7 +1018,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	blk_mq_start_request(req);
-
 	spin_lock_irq(&nvmeq->q_lock);
 	if (unlikely(nvmeq->cq_vector < 0)) {
 		ret = BLK_STS_IOERR;
-- 
2.14.3
