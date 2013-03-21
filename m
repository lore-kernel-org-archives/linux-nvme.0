From: keith.busch@intel.com (Keith Busch)
Date: Thu, 21 Mar 2013 11:52:06 -0600
Subject: [PATCH v2 6/7] NVMe: Split non-mergeable bio requests
In-Reply-To: <1363888327-7420-1-git-send-email-keith.busch@intel.com>
References: <1363888327-7420-1-git-send-email-keith.busch@intel.com>
Message-ID: <1363888327-7420-7-git-send-email-keith.busch@intel.com>

It is possible a bio request can not be submitted as a single NVMe
IO command due the bio_vec not being mergeable with the NVMe PRP list
alignement constraints. This condition was handled by submitting an IO for
the mergeable portion, then submitting a follow on IO for the remaining
data after the previous IO completes. The remainder to be sent was tracked
by manipulating the bio->bi_idx and bio->bi_sector. This patch splits
the request as many times as necessary and submits the bios together.

There are a couple other benefits from doing this: it fixes a possible
issue with the current handling of a non-mergeable bio as the existing
requeuing method may potentionally use an unlocked nvme_queue if the
callback isn't invoked on the queue's associated cpu; it will be possible
to retry a failed bio if desired at some later time since it does not
manipulate the original bio; the bio integrity extensions require the
bio to be in its original condition for the checks to work correctly if
we implement the end-to-end data protection.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |  142 ++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 115 insertions(+), 27 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 993c014..86c7f28 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -361,16 +361,6 @@ static void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
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
@@ -381,14 +371,12 @@ static void bio_completion(struct nvme_dev *dev, void *ctx,
 	if (iod->nents)
 		dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
 			bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
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
@@ -473,25 +461,130 @@ static int nvme_setup_prps(struct nvme_dev *dev,
 	return total_len;
 }
 
+struct nvme_bio_pair {
+	struct bio b1, b2, *parent;
+	struct bio_vec *bv1, *bv2;
+	int err;
+	atomic_t cnt;
+};
+
+static void nvme_bio_pair_endio(struct bio *bio, int err)
+{
+	struct nvme_bio_pair *bp = bio->bi_private;
+
+	if (err)
+		bp->err = err;
+
+	if (atomic_dec_and_test(&bp->cnt)) {
+		bio_endio(bp->parent, bp->err);
+		if (bp->bv1)
+			kfree(bp->bv1);
+		if (bp->bv2)
+			kfree(bp->bv2);
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
+
+	bp->b1.bi_size = len;
+	bp->b2.bi_size -= len;
+	bp->b1.bi_vcnt = idx;
+	bp->b2.bi_idx = idx;
+	bp->b2.bi_sector += len >> 9;
+
+	if (offset) {
+		bp->bv1 = kmalloc(bio->bi_max_vecs * sizeof(struct bio_vec),
+								GFP_ATOMIC);
+		if (!bp->bv1)
+			goto split_fail_1;
+
+		bp->bv2 = kmalloc(bio->bi_max_vecs * sizeof(struct bio_vec),
+								GFP_ATOMIC);
+		if (!bp->bv2)
+			goto split_fail_2;
+
+		memcpy(bp->bv1, bio->bi_io_vec,
+			bio->bi_max_vecs * sizeof(struct bio_vec));
+		memcpy(bp->bv2, bio->bi_io_vec,
+			bio->bi_max_vecs * sizeof(struct bio_vec));
+
+		bp->b1.bi_io_vec = bp->bv1;
+		bp->b2.bi_io_vec = bp->bv2;
+		bp->b2.bi_io_vec[idx].bv_offset += offset;
+		bp->b2.bi_io_vec[idx].bv_len -= offset;
+		bp->b1.bi_io_vec[idx].bv_len = offset;
+		bp->b1.bi_vcnt++;
+	} else
+		bp->bv1 = bp->bv2 = NULL;
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
+
+ split_fail_2:
+	kfree(bp->bv1);
+ split_fail_1:
+	kfree(bp);
+	return NULL;
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
 	struct scatterlist *sg = NULL;
-	int i, old_idx, length = 0, nsegs = 0;
+	int i, length = 0, nsegs = 0;
 
 	sg_init_table(iod->sg, psegs);
-	old_idx = bio->bi_idx;
 	bio_for_each_segment(bvec, bio, i) {
 		if (bvprv && BIOVEC_PHYS_MERGEABLE(bvprv, bvec)) {
 			sg->length += bvec->bv_len;
 		} else {
 			if (bvprv && BIOVEC_NOT_VIRT_MERGEABLE(bvprv, bvec))
-				break;
+				return nvme_split_and_submit(bio, nvmeq, i,
+								length, 0);
 			sg = sg ? sg + 1 : iod->sg;
 			sg_set_page(sg, bvec->bv_page, bvec->bv_len,
 							bvec->bv_offset);
@@ -500,13 +593,10 @@ static int nvme_map_bio(struct device *dev, struct nvme_iod *iod,
 		length += bvec->bv_len;
 		bvprv = bvec;
 	}
-	bio->bi_idx = i;
 	iod->nents = nsegs;
 	sg_mark_end(sg);
-	if (dma_map_sg(dev, iod->sg, iod->nents, dma_dir) == 0) {
-		bio->bi_idx = old_idx;
+	if (dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir) == 0)
 		return -ENOMEM;
-	}
 	return length;
 }
 
@@ -591,8 +681,8 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 		dma_dir = DMA_FROM_DEVICE;
 	}
 
-	result = nvme_map_bio(nvmeq->q_dmadev, iod, bio, dma_dir, psegs);
-	if (result < 0)
+	result = nvme_map_bio(nvmeq, iod, bio, dma_dir, psegs);
+	if (result <= 0)
 		goto free_cmdid;
 	length = result;
 
@@ -605,8 +695,6 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
 
-	bio->bi_sector += length >> 9;
-
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
 	writel(nvmeq->sq_tail, nvmeq->q_db);
-- 
1.7.0.4
