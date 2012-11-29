From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Nov 2012 17:27:28 -0700
Subject: [PATCH] NVMe: Split non-mergeable bio requests
Message-ID: <1354148848-1203-1-git-send-email-keith.busch@intel.com>

It is possible a bio request can not be submitted as a single NVMe
IO command due the bio_vec not being mergeable with the NVMe PRP list
alignement constraints.

This condition is currently handled by submitting an IO for the mergeable
portion, then submitting a follow on IO, if needed, for the remaining
data after the previous IO completes. The remainder to be sent is tracked
by manipulating the bio->bi_idx.

This patch instead splits the request and submits all the IO's
together. The two bio's are submitted on the nvme_queue's congestion
queue rather than making a recursive call to nvme_submit_bio_queue since
a bio may need to be split many times.

There are a couple other benefits from doing this. It fixes a possible
issue with the current handling of a non-mergeable bio as the existing
requeuing method could potentionally use an unlocked nvme_queue if the
callback isn't invoked on the queue's associated cpu. It will also be
possible to retry a failed bio if desired at some later time since it
does not manipulate the original bio->bi_idx.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |  104 +++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index f9ad514..b073bdb 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -120,6 +120,12 @@ struct nvme_queue {
 	unsigned long cmdid_data[];
 };
 
+struct nvme_bio_pair {
+	struct bio *b1, *b2, *parent;
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
@@ -468,6 +461,82 @@ static int nvme_setup_prps(struct nvme_dev *dev,
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
+static struct nvme_bio_pair *nvme_bio_split(struct bio *bio, int index,
+							int length, int offset)
+{
+	struct nvme_bio_pair *bp = kmalloc(sizeof(*bp), GFP_ATOMIC);
+	if (!bp)
+		return NULL;
+	bp->err = 0;
+
+	bp->b1 = bio_clone(bio, GFP_ATOMIC);
+	if (!bp->b1)
+		goto split_fail_1;
+
+	bp->b2 = bio_clone(bio, GFP_ATOMIC);
+	if (!bp->b2)
+		goto split_fail_2;
+
+	bp->b1->bi_size  = length;
+	bp->b2->bi_size -= length;
+	bp->b2->bi_sector += length >> 9;
+
+	bp->b1->bi_vcnt = index;
+	if (offset) {
+		bp->b2->bi_io_vec[index].bv_offset += offset;
+		bp->b2->bi_io_vec[index].bv_len -= offset;
+		bp->b1->bi_io_vec[index].bv_len = offset;
+		bp->b1->bi_vcnt = index + 1;
+	}
+	bp->b2->bi_idx = index;
+
+	bp->b1->bi_private = bp;
+	bp->b2->bi_private = bp;
+
+	bp->b1->bi_end_io = nvme_bio_pair_endio;
+	bp->b2->bi_end_io = nvme_bio_pair_endio;
+
+	bp->parent = bio;
+	atomic_set(&bp->cnt, 2);
+
+	return bp;
+
+ split_fail_2:
+	bio_put(bp->b1);
+ split_fail_1:
+	kfree(bp);
+	return NULL;
+}
+
+static int nvme_split_and_submit(struct bio *bio, struct nvme_queue *nvmeq,
+						int idx, int length, int offset)
+{
+	struct nvme_bio_pair *bp = nvme_bio_split(bio, idx, length, offset);
+	if (!bp)
+		return -ENOMEM;
+
+	if (bio_list_empty(&nvmeq->sq_cont))
+		add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
+	bio_list_add(&nvmeq->sq_cong, bp->b1);
+	bio_list_add(&nvmeq->sq_cong, bp->b2);
+	wake_up_process(nvme_thread);
+
+	return 0;
+}
+
 /* NVMe scatterlists require no holes in the virtual address */
 #define BIOVEC_NOT_VIRT_MERGEABLE(vec1, vec2)	((vec2)->bv_offset || \
 			(((vec1)->bv_offset + (vec1)->bv_len) % PAGE_SIZE))
@@ -486,7 +555,8 @@ static int nvme_map_bio(struct device *dev, struct nvme_iod *iod,
 			sg->length += bvec->bv_len;
 		} else {
 			if (bvprv && BIOVEC_NOT_VIRT_MERGEABLE(bvprv, bvec))
-				break;
+				return nvme_split_and_submit(bio, nvmeq, i,
+								length, 0);
 			sg = sg ? sg + 1 : iod->sg;
 			sg_set_page(sg, bvec->bv_page, bvec->bv_len,
 							bvec->bv_offset);
@@ -587,7 +657,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	}
 
 	result = nvme_map_bio(nvmeq->q_dmadev, iod, bio, dma_dir, psegs);
-	if (result < 0)
+	if (result <= 0)
 		goto free_iod;
 	length = result;
 
-- 
1.7.0.4
