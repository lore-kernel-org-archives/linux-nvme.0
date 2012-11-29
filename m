From: keith.busch@intel.com (Keith Busch)
Date: Thu, 29 Nov 2012 12:41:45 -0700
Subject: [PATCH] NVMe: Split non-mergeable bio requests
In-Reply-To: <1354148848-1203-1-git-send-email-keith.busch@intel.com>
References: <1354148848-1203-1-git-send-email-keith.busch@intel.com>
Message-ID: <1354218105-13114-1-git-send-email-keith.busch@intel.com>

Oops! I messed up the previous patch by creating it from the wrong 
directory, and it wasn't what I had been testing. The previous patch
wouldn't even compile! Here's the right one; my apologies for the bad
submission.
---
 drivers/block/nvme.c |  103 ++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 83 insertions(+), 20 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index f9ad514..20139aa 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -120,6 +120,12 @@ struct nvme_queue {
 	unsigned long cmdid_data[];
 };
 
+struct nvme_bio_pair {
+	struct bio b1, b2, *parent;
+	int err;
+	atomic_t cnt;
+};
+
 /*
  * Check we didin't inadvertently grow the command struct
  */
@@ -357,16 +363,6 @@ static void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
 	kfree(iod);
 }
 
-static void requeue_bio(struct nvme_dev *dev, struct bio *bio)
-{
-	struct nvme_queue *nvmeq = get_nvmeq(dev);
-	if (bio_list_empty(&nvmeq->sq_cong))
-		add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
-	bio_list_add(&nvmeq->sq_cong, bio);
-	put_nvmeq(nvmeq);
-	wake_up_process(nvme_thread);
-}
-
 static void bio_completion(struct nvme_dev *dev, void *ctx,
 						struct nvme_completion *cqe)
 {
@@ -377,13 +373,10 @@ static void bio_completion(struct nvme_dev *dev, void *ctx,
 	dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
 			bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	nvme_free_iod(dev, iod);
-	if (status) {
+	if (status)
 		bio_endio(bio, -EIO);
-	} else if (bio->bi_vcnt > bio->bi_idx) {
-		requeue_bio(dev, bio);
-	} else {
+	else
 		bio_endio(bio, 0);
-	}
 }
 
 /* length is in bytes.  gfp flags indicates whether we may sleep. */
@@ -468,11 +461,80 @@ static int nvme_setup_prps(struct nvme_dev *dev,
 	return total_len;
 }
 
+static void nvme_bio_pair_endio(struct bio *bio, int err)
+{
+	struct nvme_bio_pair *bp = bio->bi_private;
+
+	if (err)
+		bp->err = err;
+
+	if (atomic_dec_and_test(&bp->cnt)) {
+		bio_endio(bp->parent, bp->err);
+		kfree(bp);
+	}
+}
+
+static struct nvme_bio_pair *nvme_bio_split(struct bio *bio, int idx,
+							int len, int offset)
+{
+	struct nvme_bio_pair *bp;
+	
+	BUG_ON(len > bio->bi_size);
+	BUG_ON(idx > bio->bi_vcnt);
+
+	bp = kmalloc(sizeof(*bp), GFP_ATOMIC);
+	if (!bp)
+		return NULL;
+	bp->err = 0;
+
+	bp->b1 = *bio;
+	bp->b2 = *bio;
+	bp->b1.bi_size = len;
+	bp->b2.bi_size -= len;
+	bp->b1.bi_vcnt = idx;
+	bp->b2.bi_idx = idx;
+	bp->b2.bi_sector += len >> 9;
+
+	if (offset) {
+		bp->b2.bi_io_vec[idx].bv_offset += offset;
+		bp->b2.bi_io_vec[idx].bv_len -= offset;
+		bp->b1.bi_io_vec[idx].bv_len = offset;
+		bp->b1.bi_vcnt++;
+	}
+
+	bp->b1.bi_private = bp;
+	bp->b2.bi_private = bp;
+
+	bp->b1.bi_end_io = nvme_bio_pair_endio;
+	bp->b2.bi_end_io = nvme_bio_pair_endio;
+
+	bp->parent = bio;
+	atomic_set(&bp->cnt, 2);
+
+	return bp;
+}
+
+static int nvme_split_and_submit(struct bio *bio, struct nvme_queue *nvmeq,
+						int idx, int len, int offset)
+{
+	struct nvme_bio_pair *bp = nvme_bio_split(bio, idx, len, offset);
+	if (!bp)
+		return -ENOMEM;
+
+	if (bio_list_empty(&nvmeq->sq_cong))
+		add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
+	bio_list_add(&nvmeq->sq_cong, &bp->b1);
+	bio_list_add(&nvmeq->sq_cong, &bp->b2);
+	wake_up_process(nvme_thread);
+
+	return 0;
+}
+
 /* NVMe scatterlists require no holes in the virtual address */
 #define BIOVEC_NOT_VIRT_MERGEABLE(vec1, vec2)	((vec2)->bv_offset || \
 			(((vec1)->bv_offset + (vec1)->bv_len) % PAGE_SIZE))
 
-static int nvme_map_bio(struct device *dev, struct nvme_iod *iod,
+static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 		struct bio *bio, enum dma_data_direction dma_dir, int psegs)
 {
 	struct bio_vec *bvec, *bvprv = NULL;
@@ -486,7 +548,8 @@ static int nvme_map_bio(struct device *dev, struct nvme_iod *iod,
 			sg->length += bvec->bv_len;
 		} else {
 			if (bvprv && BIOVEC_NOT_VIRT_MERGEABLE(bvprv, bvec))
-				break;
+				return nvme_split_and_submit(bio, nvmeq, i,
+								length, 0);
 			sg = sg ? sg + 1 : iod->sg;
 			sg_set_page(sg, bvec->bv_page, bvec->bv_len,
 							bvec->bv_offset);
@@ -498,7 +561,7 @@ static int nvme_map_bio(struct device *dev, struct nvme_iod *iod,
 	bio->bi_idx = i;
 	iod->nents = nsegs;
 	sg_mark_end(sg);
-	if (dma_map_sg(dev, iod->sg, iod->nents, dma_dir) == 0) {
+	if (dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir) == 0) {
 		bio->bi_idx = old_idx;
 		return -ENOMEM;
 	}
@@ -586,8 +649,8 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 		dma_dir = DMA_FROM_DEVICE;
 	}
 
-	result = nvme_map_bio(nvmeq->q_dmadev, iod, bio, dma_dir, psegs);
-	if (result < 0)
+	result = nvme_map_bio(nvmeq, iod, bio, dma_dir, psegs);
+	if (result <= 0)
 		goto free_iod;
 	length = result;
 
-- 
1.7.0.4
