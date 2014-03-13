From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Mar 2014 17:33:04 -0600 (MDT)
Subject: [PATCH 1/9] block: Make generic_make_request handle arbitrary
 sized bios
In-Reply-To: <20140228233039.GA2739@moria.home.lan>
References: <1393457997-17618-1-git-send-email-kmo@daterainc.com>
 <1393457997-17618-2-git-send-email-kmo@daterainc.com>
 <20140227172254.GI5744@linux.intel.com>
 <20140228233039.GA2739@moria.home.lan>
Message-ID: <alpine.LRH.2.03.1403131719540.2885@AMR>

On Fri, 28 Feb 2014, Kent Overstreet wrote:
> On Thu, Feb 27, 2014@12:22:54PM -0500, Matthew Wilcox wrote:
>> On Wed, Feb 26, 2014@03:39:49PM -0800, Kent Overstreet wrote:
>>> We do this by adding calls to blk_queue_split() to the various
>>> make_request functions that need it - a few can already handle arbitrary
>>> size bios. Note that we add the call _after_ any call to blk_queue_bounce();
>>> this means that blk_queue_split() and blk_recalc_rq_segments() don't need to
>>> be concerned with bouncing affecting segment merging.
>>
>>> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
>>> index 51824d1f23..e4376b9613 100644
>>> --- a/drivers/block/nvme-core.c
>>> +++ b/drivers/block/nvme-core.c
>>> @@ -737,6 +737,8 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
>>>  	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
>>>  	int result = -EBUSY;
>>>
>>> +	blk_queue_split(q, &bio, q->bio_split);
>>> +
>>>  	if (!nvmeq) {
>>>  		put_nvmeq(NULL);
>>>  		bio_endio(bio, -EIO);
>>
>> I'd suggest that we do:
>>
>> -	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
>> +	struct nvme_queue *nvmeq;
>>  	int result = -EBUSY;
>>
>> +	blk_queue_split(q, &bio, q->bio_split);
>> +
>> +	nvmeq = get_nvmeq(ns->dev);
>>  	if (!nvmeq) {
>>
>> so that we're running the blk_queue_split() code outside the get_cpu()
>> call.
>>
>> Now, the NVMe driver has its own rules about when BIOs have to be split.
>> Right now, that's way down inside the nvme_map_bio() call when we're
>> walking the bio to compose the scatterlist.  Should we instead have an
>> nvme_bio_split() routine that is called instead of blk_queue_split(),
>> and we can simplify nvme_map_bio() since it'll know that it's working
>> with bios that don't have to be split.
>>
>> In fact, I think it would have little NVMe-specific in it at that point,
>> so we could name __blk_bios_map_sg() better, export it to drivers and
>> call it from nvme_map_bio(), which I think would make everybody happier.
>
> Actually, reading nvme_map_bio() (it's different since last I looked at
> it) it looks like nvme should already be able to handle arbitrary size
> bios?
>
> I do intend to rework the blk_bio_map_sg() (or add a new one?) to
> incrementally map as much of a bio as will fit in the provided
> scatterlist, but it looks like nvme has some odd restrictions where it's
> using BIOVEC_PHYS_MERGABLE()/BIOVEC_NOT_VIRT_MERGABLE() so I dunno if
> it's worth bothering to try and have it use generic code.
>
> However we don't need an explicit split here: if the sg fills up (i.e.
> the places nvme_split_and_submit() is called), we can just mark the bio
> as partially completed (set bio->bi_iter = iter, i.e. use the iterator
> you passed to bio_for_each_segment), then increment bi_remaining (which
> just counts completions, i.e. bio_endio() calls before the bio is really
> completed) and resubmit the original bio. No need to allocate a split
> bio, or loop over the bio again in bio_split().

Hi Kent,

I wanted to see about getting rid of nvme_map_bio and do all the
splits generically. I built this on top of your original patch and
added additional split criteria for NVMe, which includes the "segment"
address offset and the vendor specific "stripe_size" (I think "chunk_size"
may have been a more appropriate description, but I used someone else's
term for this). This is what I came up with; I hoped the additions would
be useful, but maybe the additional split criteria applies only to nvme.

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 0afbe3f..2848181 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -66,11 +66,9 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
  					 struct bio *bio,
  					 struct bio_set *bs)
  {
-	struct bio *split;
  	struct bio_vec bv, bvprv;
  	struct bvec_iter iter;
  	unsigned seg_size = 0, nsegs = 0;
-	int prev = 0;

  	struct bvec_merge_data bvm = {
  		.bi_bdev	= bio->bi_bdev,
@@ -79,17 +77,26 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
  		.bi_rw		= bio->bi_rw,
  	};

+	if (bio->bi_iter.bi_size >> 9 > queue_max_sectors(q)) {
+		bvm.bi_size = queue_max_sectors(q) << 9;
+		goto split;
+	}
+	if (queue_stripe_sectors(q)) {
+		unsigned split_len =
+			(queue_stripe_sectors(q) -
+				(bio->bi_iter.bi_sector &
+					(queue_stripe_sectors(q) - 1))) << 9;
+		if (split_len < bio->bi_iter.bi_size) {
+			bvm.bi_size = split_len;
+			goto split;
+		}
+	}
+
  	bio_for_each_segment(bv, bio, iter) {
  		if (q->merge_bvec_fn &&
  		    q->merge_bvec_fn(q, &bvm, &bv) < (int) bv.bv_len)
  			goto split;
-
-		bvm.bi_size += bv.bv_len;
-
-		if (bvm.bi_size >> 9 > queue_max_sectors(q))
-			goto split;
-
-		if (prev && blk_queue_cluster(q)) {
+		if (nsegs && blk_queue_cluster(q)) {
  			if (seg_size + bv.bv_len > queue_max_segment_size(q))
  				goto new_segment;
  			if (!BIOVEC_PHYS_MERGEABLE(&bvprv, &bv))
@@ -97,34 +104,26 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
  			if (!BIOVEC_SEG_BOUNDARY(q, &bvprv, &bv))
  				goto new_segment;

+			bvm.bi_size += bv.bv_len;
  			seg_size += bv.bv_len;
  			bvprv = bv;
-			prev = 1;
  			continue;
  		}
  new_segment:
+		if (nsegs && BIOVEC_SEG_OFFSET(q, &bvprv, &bv))
+			goto split;
  		if (nsegs == queue_max_segments(q))
  			goto split;

+		bvm.bi_size += bv.bv_len;
  		nsegs++;
  		bvprv = bv;
-		prev = 1;
  		seg_size = bv.bv_len;
  	}

  	return NULL;
  split:
-	split = bio_clone_bioset(bio, GFP_NOIO, bs);
-
-	split->bi_iter.bi_size -= iter.bi_size;
-	bio->bi_iter = iter;
-
-	if (bio_integrity(bio)) {
-		bio_integrity_advance(bio, split->bi_iter.bi_size);
-		bio_integrity_trim(split, 0, bio_sectors(split));
-	}
-
-	return split;
+	return bio_split(bio, bvm.bi_size >> 9, GFP_ATOMIC, bs);
  }

  void blk_queue_split(struct request_queue *q, struct bio **bio,
@@ -303,7 +302,7 @@ new_segment:
  	*bvprv = *bvec;
  }

-static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
+int blk_bios_map_sg(struct request_queue *q, struct bio *bio,
  			     struct scatterlist *sglist,
  			     struct scatterlist **sg)
  {
@@ -344,6 +343,7 @@ single_segment:

  	return nsegs;
  }
+EXPORT_SYMBOL(blk_bios_map_sg);

  /*
   * map a request to scatterlist, return number of sg entries setup. Caller
@@ -356,7 +356,7 @@ int blk_rq_map_sg(struct request_queue *q, struct request *rq,
  	int nsegs = 0;

  	if (rq->bio)
-		nsegs = __blk_bios_map_sg(q, rq->bio, sglist, &sg);
+		nsegs = blk_bios_map_sg(q, rq->bio, sglist, &sg);

  	if (unlikely(rq->cmd_flags & REQ_COPY_USER) &&
  	    (blk_rq_bytes(rq) & q->dma_pad_mask)) {
@@ -407,7 +407,7 @@ int blk_bio_map_sg(struct request_queue *q, struct bio *bio,
  	struct bio *next = bio->bi_next;
  	bio->bi_next = NULL;

-	nsegs = __blk_bios_map_sg(q, bio, sglist, &sg);
+	nsegs = blk_bios_map_sg(q, bio, sglist, &sg);
  	bio->bi_next = next;
  	if (sg)
  		sg_mark_end(sg);
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 5d21239..6590703 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -111,8 +111,10 @@ void blk_set_default_limits(struct queue_limits *lim)
  	lim->max_segments = BLK_MAX_SEGMENTS;
  	lim->max_integrity_segments = 0;
  	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
+	lim->seg_offset_mask = 0;
  	lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
  	lim->max_sectors = lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
+	lim->stripe_sectors = 0;
  	lim->max_write_same_sectors = 0;
  	lim->max_discard_sectors = 0;
  	lim->discard_granularity = 0;
@@ -146,6 +148,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
  	lim->max_hw_sectors = UINT_MAX;
  	lim->max_segment_size = UINT_MAX;
  	lim->max_sectors = UINT_MAX;
+	lim->stripe_sectors = 0;
  	lim->max_write_same_sectors = UINT_MAX;
  }
  EXPORT_SYMBOL(blk_set_stacking_limits);
@@ -262,6 +265,18 @@ void blk_limits_max_hw_sectors(struct queue_limits *limits, unsigned int max_hw_
  }
  EXPORT_SYMBOL(blk_limits_max_hw_sectors);

+void blk_queue_stripe_sectors(struct request_queue *q, unsigned int hw_stripe_sectors)
+{
+	if (hw_stripe_sectors && ((hw_stripe_sectors << 9) < PAGE_CACHE_SIZE ||
+					!is_power_of_2(hw_stripe_sectors))) {
+		hw_stripe_sectors = 1 << (PAGE_CACHE_SHIFT - 9);
+		printk(KERN_INFO "%s: set to minimum %d\n",
+		       __func__, hw_stripe_sectors);
+	}
+	q->limits.stripe_sectors = hw_stripe_sectors;
+}
+EXPORT_SYMBOL(blk_queue_stripe_sectors);
+
  /**
   * blk_queue_max_hw_sectors - set max sectors for a request for this queue
   * @q:  the request queue for the device
@@ -527,10 +542,13 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
  	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
  	t->max_write_same_sectors = min(t->max_write_same_sectors,
  					b->max_write_same_sectors);
+	t->stripe_sectors = min_not_zero(t->stripe_sectors, b->stripe_sectors);
  	t->bounce_pfn = min_not_zero(t->bounce_pfn, b->bounce_pfn);

  	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
  					    b->seg_boundary_mask);
+	t->seg_offset_mask = min_not_zero(t->seg_offset_mask,
+					    b->seg_offset_mask);

  	t->max_segments = min_not_zero(t->max_segments, b->max_segments);
  	t->max_integrity_segments = min_not_zero(t->max_integrity_segments,
@@ -758,7 +776,7 @@ EXPORT_SYMBOL_GPL(blk_queue_dma_drain);
   **/
  void blk_queue_segment_boundary(struct request_queue *q, unsigned long mask)
  {
-	if (mask < PAGE_CACHE_SIZE - 1) {
+	if (mask < (PAGE_CACHE_SIZE - 1)) {
  		mask = PAGE_CACHE_SIZE - 1;
  		printk(KERN_INFO "%s: set to minimum %lx\n",
  		       __func__, mask);
@@ -769,6 +787,23 @@ void blk_queue_segment_boundary(struct request_queue *q, unsigned long mask)
  EXPORT_SYMBOL(blk_queue_segment_boundary);

  /**
+ * blk_queue_segment_offset - set boundary rules for segment start address
+ * @q:  the request queue for the device
+ * @mask:  the memory offset mask at which the request must be split
+ **/
+void blk_queue_segment_offset(struct request_queue *q, unsigned long mask)
+{
+	if (mask && mask < (PAGE_CACHE_SIZE - 1)) {
+		printk(KERN_INFO "%s: mask:%lx set to minimum %lx\n",
+		       __func__, mask, PAGE_CACHE_SIZE - 1);
+		mask = PAGE_CACHE_SIZE - 1;
+	}
+
+	q->limits.seg_offset_mask = mask;
+}
+EXPORT_SYMBOL(blk_queue_segment_offset);
+
+/**
   * blk_queue_dma_alignment - set dma length and memory alignment
   * @q:     the request queue for the device
   * @mask:  alignment mask
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e4376b9..7980697 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -471,71 +471,6 @@ int nvme_setup_prps(struct nvme_dev *dev, struct nvme_common_command *cmd,
  	return total_len;
  }

-static int nvme_split_and_submit(struct bio *bio, struct nvme_queue *nvmeq,
-				 int len)
-{
-	struct bio *split = bio_split(bio, len >> 9, GFP_ATOMIC, NULL);
-	if (!split)
-		return -ENOMEM;
-
-	bio_chain(split, bio);
-
-	if (bio_list_empty(&nvmeq->sq_cong))
-		add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
-	bio_list_add(&nvmeq->sq_cong, split);
-	bio_list_add(&nvmeq->sq_cong, bio);
-
-	return 0;
-}
-
-/* NVMe scatterlists require no holes in the virtual address */
-#define BIOVEC_NOT_VIRT_MERGEABLE(vec1, vec2)	((vec2)->bv_offset || \
-			(((vec1)->bv_offset + (vec1)->bv_len) % PAGE_SIZE))
-
-static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
-		struct bio *bio, enum dma_data_direction dma_dir, int psegs)
-{
-	struct bio_vec bvec, bvprv;
-	struct bvec_iter iter;
-	struct scatterlist *sg = NULL;
-	int length = 0, nsegs = 0, split_len = bio->bi_iter.bi_size;
-	int first = 1;
-
-	if (nvmeq->dev->stripe_size)
-		split_len = nvmeq->dev->stripe_size -
-			((bio->bi_iter.bi_sector << 9) &
-			 (nvmeq->dev->stripe_size - 1));
-
-	sg_init_table(iod->sg, psegs);
-	bio_for_each_segment(bvec, bio, iter) {
-		if (!first && BIOVEC_PHYS_MERGEABLE(&bvprv, &bvec)) {
-			sg->length += bvec.bv_len;
-		} else {
-			if (!first && BIOVEC_NOT_VIRT_MERGEABLE(&bvprv, &bvec))
-				return nvme_split_and_submit(bio, nvmeq,
-							     length);
-
-			sg = sg ? sg + 1 : iod->sg;
-			sg_set_page(sg, bvec.bv_page,
-				    bvec.bv_len, bvec.bv_offset);
-			nsegs++;
-		}
-
-		if (split_len - length < bvec.bv_len)
-			return nvme_split_and_submit(bio, nvmeq, split_len);
-		length += bvec.bv_len;
-		bvprv = bvec;
-		first = 0;
-	}
-	iod->nents = nsegs;
-	sg_mark_end(sg);
-	if (dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir) == 0)
-		return -ENOMEM;
-
-	BUG_ON(length != bio->bi_iter.bi_size);
-	return length;
-}
-
  /*
   * We reuse the small pool to allocate the 16-byte range here as it is not
   * worth having a special pool for these or additional cases to handle freeing
@@ -607,6 +542,7 @@ int nvme_submit_flush_data(struct nvme_queue *nvmeq, struct nvme_ns *ns)
  static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
  								struct bio *bio)
  {
+	struct scatterlist *sg = NULL;
  	struct nvme_command *cmnd;
  	struct nvme_iod *iod;
  	enum dma_data_direction dma_dir;
@@ -662,14 +598,17 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
  		dma_dir = DMA_FROM_DEVICE;
  	}

-	result = nvme_map_bio(nvmeq, iod, bio, dma_dir, psegs);
-	if (result <= 0)
+	sg_init_table(iod->sg, psegs);
+	iod->nents = blk_bios_map_sg(ns->queue, bio, iod->sg, &sg);
+	sg_mark_end(sg);
+	if (dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir) == 0) {
+		result = -ENOMEM;
  		goto free_cmdid;
-	length = result;
+	}

  	cmnd->rw.command_id = cmdid;
  	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
-	length = nvme_setup_prps(nvmeq->dev, &cmnd->common, iod, length,
+	length = nvme_setup_prps(nvmeq->dev, &cmnd->common, iod, bio->bi_iter.bi_size,
  								GFP_ATOMIC);
  	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_iter.bi_sector));
  	cmnd->rw.length = cpu_to_le16((length >> ns->lba_shift) - 1);
@@ -734,11 +673,12 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
  static void nvme_make_request(struct request_queue *q, struct bio *bio)
  {
  	struct nvme_ns *ns = q->queuedata;
-	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
+	struct nvme_queue *nvmeq;
  	int result = -EBUSY;

  	blk_queue_split(q, &bio, q->bio_split);

+	nvmeq = get_nvmeq(ns->dev);
  	if (!nvmeq) {
  		put_nvmeq(NULL);
  		bio_endio(bio, -EIO);
@@ -812,6 +752,9 @@ int nvme_submit_sync_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
  	int cmdid;
  	struct sync_cmd_info cmdinfo;

+	if (!nvmeq || nvmeq->q_suspended)
+		return -EBUSY;
+
  	cmdinfo.task = current;
  	cmdinfo.status = -EINTR;

@@ -1767,6 +1710,9 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
  	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
  	if (dev->max_hw_sectors)
  		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
+	if (dev->stripe_size)
+		blk_queue_stripe_sectors(ns->queue, dev->stripe_size >> 9);
+	blk_queue_segment_offset(ns->queue, PAGE_SIZE - 1);

  	disk->major = nvme_major;
  	disk->first_minor = 0;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 5a4d39b..7dbbd03 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -186,6 +186,11 @@ static inline void *bio_data(struct bio *bio)
  #define BIOVEC_SEG_BOUNDARY(q, b1, b2) \
  	__BIO_SEG_BOUNDARY(bvec_to_phys((b1)), bvec_to_phys((b2)) + (b2)->bv_len, queue_segment_boundary((q)))

+#define __BIO_SEG_OFFSET(addr1, addr2, mask) \
+	(((addr1) & (mask)) || (((addr2) & (mask))))
+#define BIOVEC_SEG_OFFSET(q, b1, b2) \
+	__BIO_SEG_OFFSET(bvec_to_phys((b1)), bvec_to_phys((b2)) + (b2)->bv_len, queue_segment_offset((q)))
+
  #define bio_io_error(bio) bio_endio((bio), -EIO)

  /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 95e789d..08cad22 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -267,9 +267,11 @@ struct blk_queue_tag {
  struct queue_limits {
  	unsigned long		bounce_pfn;
  	unsigned long		seg_boundary_mask;
+	unsigned long		seg_offset_mask;

  	unsigned int		max_hw_sectors;
  	unsigned int		max_sectors;
+	unsigned int		stripe_sectors;
  	unsigned int		max_segment_size;
  	unsigned int		physical_block_size;
  	unsigned int		alignment_offset;
@@ -987,6 +989,8 @@ extern int blk_queue_dma_drain(struct request_queue *q,
  			       void *buf, unsigned int size);
  extern void blk_queue_lld_busy(struct request_queue *q, lld_busy_fn *fn);
  extern void blk_queue_segment_boundary(struct request_queue *, unsigned long);
+extern void blk_queue_segment_offset(struct request_queue *, unsigned long);
+extern void blk_queue_stripe_sectors(struct request_queue *, unsigned int);
  extern void blk_queue_prep_rq(struct request_queue *, prep_rq_fn *pfn);
  extern void blk_queue_unprep_rq(struct request_queue *, unprep_rq_fn *ufn);
  extern void blk_queue_merge_bvec(struct request_queue *, merge_bvec_fn *);
@@ -999,6 +1003,8 @@ extern void blk_queue_flush(struct request_queue *q, unsigned int flush);
  extern void blk_queue_flush_queueable(struct request_queue *q, bool queueable);
  extern struct backing_dev_info *blk_get_backing_dev_info(struct block_device *bdev);

+extern int blk_bios_map_sg(struct request_queue *q, struct bio *bio, struct scatterlist *sglist,
+			     struct scatterlist **sg);
  extern int blk_rq_map_sg(struct request_queue *, struct request *, struct scatterlist *);
  extern int blk_bio_map_sg(struct request_queue *q, struct bio *bio,
  			  struct scatterlist *sglist);
@@ -1159,11 +1165,21 @@ static inline unsigned long queue_segment_boundary(struct request_queue *q)
  	return q->limits.seg_boundary_mask;
  }

+static inline unsigned long queue_segment_offset(struct request_queue *q)
+{
+	return q->limits.seg_offset_mask;
+}
+
  static inline unsigned int queue_max_sectors(struct request_queue *q)
  {
  	return q->limits.max_sectors;
  }

+static inline unsigned int queue_stripe_sectors(struct request_queue *q)
+{
+	return q->limits.stripe_sectors;
+}
+
  static inline unsigned int queue_max_hw_sectors(struct request_queue *q)
  {
  	return q->limits.max_hw_sectors;
