From: keith.busch@intel.com (Keith Busch)
Date: Fri,  8 Mar 2013 16:52:31 -0700
Subject: [PATCH] NVMe: Device specific stripe size handling
Message-ID: <1362786751-24078-1-git-send-email-keith.busch@intel.com>

We have an nvme device that has the concept of a stripe size and an
IO request that does not transfer data crossing the stripe size has
greater performance compared to IO that does cross it. This patch sets
the stripe size for the device if the device id matches one with this
feature and splits IO requests that cross the stripe boundary.

Signed-off-by: Keith Busch <keith.busch at intel.com>

This is dependent on the patch for splitting bios:
http://merlin.infradead.org/pipermail/linux-nvme/2013-March/000158.html

After testing with split bios with offsets, it became obvious we can't
shallow copy the bio being split since the offset requires messing with
the common bi_io_vec pointer, so using bio_clone instead.
---
 drivers/block/nvme.c |   77 +++++++++++++++++++++++++++++++++++++------------
 1 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 00b4063..f03022a 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -73,6 +73,7 @@ struct nvme_dev {
 	int queue_count;
 	int db_stride;
 	u32 ctrl_config;
+	u32 stripe_size;
 	struct msix_entry *entry;
 	struct nvme_bar __iomem *bar;
 	struct list_head namespaces;
@@ -122,7 +123,7 @@ struct nvme_queue {
 };
 
 struct nvme_bio_pair {
-	struct bio b1, b2, *parent;
+	struct bio *b1, *b2, *parent;
 	int err;
 	atomic_t cnt;
 };
@@ -473,6 +474,7 @@ static void nvme_bio_pair_endio(struct bio *bio, int err)
 	if (err)
 		bp->err = err;
 
+	bio_put(bio);
 	if (atomic_dec_and_test(&bp->cnt)) {
 		bio_endio(bp->parent, bp->err);
 		kfree(bp);
@@ -483,7 +485,7 @@ static struct nvme_bio_pair *nvme_bio_split(struct bio *bio, int idx,
 							int len, int offset)
 {
 	struct nvme_bio_pair *bp;
-	
+
 	BUG_ON(len > bio->bi_size);
 	BUG_ON(idx > bio->bi_vcnt);
 
@@ -492,31 +494,43 @@ static struct nvme_bio_pair *nvme_bio_split(struct bio *bio, int idx,
 		return NULL;
 	bp->err = 0;
 
-	bp->b1 = *bio;
-	bp->b2 = *bio;
-	bp->b1.bi_size = len;
-	bp->b2.bi_size -= len;
-	bp->b1.bi_vcnt = idx;
-	bp->b2.bi_idx = idx;
-	bp->b2.bi_sector += len >> 9;
+	bp->b1 = bio_clone(bio, GFP_ATOMIC);
+	if (!bp->b1)
+		goto split_fail_1;
+
+	bp->b2 = bio_clone(bio, GFP_ATOMIC);
+	if (!bp->b2)
+		goto split_fail_2;
+
+	bp->b1->bi_size = len;
+	bp->b2->bi_size -= len;
+	bp->b1->bi_vcnt = idx;
+	bp->b2->bi_idx = idx;
+	bp->b2->bi_sector += len >> 9;
 
 	if (offset) {
-		bp->b2.bi_io_vec[idx].bv_offset += offset;
-		bp->b2.bi_io_vec[idx].bv_len -= offset;
-		bp->b1.bi_io_vec[idx].bv_len = offset;
-		bp->b1.bi_vcnt++;
+		bp->b2->bi_io_vec[idx].bv_offset += offset;
+		bp->b2->bi_io_vec[idx].bv_len -= offset;
+		bp->b1->bi_io_vec[idx].bv_len = offset;
+		bp->b1->bi_vcnt++;
 	}
 
-	bp->b1.bi_private = bp;
-	bp->b2.bi_private = bp;
+	bp->b1->bi_private = bp;
+	bp->b2->bi_private = bp;
 
-	bp->b1.bi_end_io = nvme_bio_pair_endio;
-	bp->b2.bi_end_io = nvme_bio_pair_endio;
+	bp->b1->bi_end_io = nvme_bio_pair_endio;
+	bp->b2->bi_end_io = nvme_bio_pair_endio;
 
 	bp->parent = bio;
 	atomic_set(&bp->cnt, 2);
 
 	return bp;
+
+ split_fail_2:
+	bio_put(bp->b1);
+ split_fail_1:
+	kfree(bp);
+	return NULL;
 }
 
 static int nvme_split_and_submit(struct bio *bio, struct nvme_queue *nvmeq,
@@ -528,8 +542,8 @@ static int nvme_split_and_submit(struct bio *bio, struct nvme_queue *nvmeq,
 
 	if (bio_list_empty(&nvmeq->sq_cong))
 		add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
-	bio_list_add(&nvmeq->sq_cong, &bp->b1);
-	bio_list_add(&nvmeq->sq_cong, &bp->b2);
+	bio_list_add(&nvmeq->sq_cong, bp->b1);
+	bio_list_add(&nvmeq->sq_cong, bp->b2);
 	wake_up_process(nvme_thread);
 
 	return 0;
@@ -539,6 +553,9 @@ static int nvme_split_and_submit(struct bio *bio, struct nvme_queue *nvmeq,
 #define BIOVEC_NOT_VIRT_MERGEABLE(vec1, vec2)	((vec2)->bv_offset || \
 			(((vec1)->bv_offset + (vec1)->bv_len) % PAGE_SIZE))
 
+#define BIO_CROSS_STRIPE(stripe_size, start, len) \
+	stripe_size && ((((start) & (stripe_size - 1)) + len) > stripe_size)
+
 static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 		struct bio *bio, enum dma_data_direction dma_dir, int psegs)
 {
@@ -546,6 +563,22 @@ static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	struct scatterlist *sg = NULL;
 	int i, length = 0, nsegs = 0;
 
+	if (BIO_CROSS_STRIPE(nvmeq->dev->stripe_size, bio->bi_sector << 9,
+							bio->bi_size)) {
+		int split_len = nvmeq->dev->stripe_size -
+			((bio->bi_sector << 9) & (nvmeq->dev->stripe_size - 1));
+		int iov_offset = split_len;
+
+		bio_for_each_segment(bvec, bio, i) {
+			if (iov_offset < bvec->bv_len)
+				break;
+			iov_offset -= bvec->bv_len;
+		}
+
+		return nvme_split_and_submit(bio, nvmeq, i,
+						split_len, iov_offset);
+	}
+
 	sg_init_table(iod->sg, psegs);
 	bio_for_each_segment(bvec, bio, i) {
 		if (bvprv && BIOVEC_PHYS_MERGEABLE(bvprv, bvec)) {
@@ -1584,6 +1617,12 @@ static int __devinit nvme_dev_add(struct nvme_dev *dev)
 		int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
 		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
 	}
+	if ((dev->pci_dev->vendor == PCI_VENDOR_ID_INTEL) &&
+	    			(dev->pci_dev->device == 0x0953) &&
+				ctrl->vs[3]) {
+		int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
+		dev->stripe_size = 1 << (ctrl->vs[3] + shift);
+	}
 
 	id_ns = mem;
 	for (i = 1; i <= nn; i++) {
-- 
1.7.0.4
