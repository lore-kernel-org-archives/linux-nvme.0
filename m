From: keith.busch@intel.com (Keith Busch)
Date: Tue, 27 May 2014 01:05:26 -0600
Subject: [RFC PATCH] NVMe: Remove IOD scatter-gather list
Message-ID: <1401174326-25045-1-git-send-email-keith.busch@intel.com>

I've seen a lot of patches recently on the mailing list about improving
driver side latencies and I want in on the action. :)

This patch proposes to remove the scatter gather list and create prp
lists directly from the bio's io vector. This way we don't have to walk
it twice, and we don't have to allocate prp lists from DMA pools when
we can point to them inline with the IOD and map them from there.

I am breaking a few things here, notably REQ_DISCARD and the IOCTL
passthroughs, but I'm just trying to gauge if this is actually as good
a win as I hope before spending too much time on it.

I don't have my normal test machine available to me from my remote
location right now, so stuck using slower hardware than I normally use
for these kinds of tests.

On 4k transfer, I measure submission side latency reduced by ~25ns.
On 128k transfer, same latency was reduced by ~110ns.

I've not been able to test at higher transfers than this. I'm not even
sure if this will not crash a system if we have to chain two prp lists
since I couldn't test that either. Maybe it will break bio splits too,
I'm not sure, it's just prototype code right now.

Would anyone be willing to give this a try on some of their faster h/w?

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c | 244 +++++++++++++++++-----------------------------
 drivers/block/nvme-scsi.c |  24 +----
 include/linux/nvme.h      |  12 +--
 3 files changed, 96 insertions(+), 184 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cd8a8bc7..861e541 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -39,9 +39,10 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <scsi/sg.h>
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
 
+#include <scsi/sg.h>
+
 #include <trace/events/block.h>
 
 #define NVME_Q_DEPTH 1024
@@ -327,55 +328,42 @@ static int nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
 	return 0;
 }
 
-static __le64 **iod_list(struct nvme_iod *iod)
-{
-	return ((void *)iod) + iod->offset;
-}
-
-/*
- * Will slightly overestimate the number of pages needed.  This is OK
- * as it only leads to a small amount of wasted memory for the lifetime of
- * the I/O.
- */
 static int nvme_npages(unsigned size)
 {
 	unsigned nprps = DIV_ROUND_UP(size + PAGE_SIZE, PAGE_SIZE);
-	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
+	return nprps + DIV_ROUND_UP(nprps + PAGE_SIZE, PAGE_SIZE);
 }
 
 static struct nvme_iod *
 nvme_alloc_iod(unsigned nseg, unsigned nbytes, gfp_t gfp)
 {
 	struct nvme_iod *iod = kmalloc(sizeof(struct nvme_iod) +
-				sizeof(__le64 *) * nvme_npages(nbytes) +
-				sizeof(struct scatterlist) * nseg, gfp);
-
+				sizeof(__le64 *) * nvme_npages(nbytes), gfp);
 	if (iod) {
-		iod->offset = offsetof(struct nvme_iod, sg[nseg]);
-		iod->npages = -1;
-		iod->length = nbytes;
 		iod->nents = 0;
-		iod->first_dma = 0ULL;
 		iod->start_time = jiffies;
 	}
-
 	return iod;
 }
 
 void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
 {
-	const int last_prp = PAGE_SIZE / 8 - 1;
 	int i;
-	__le64 **list = iod_list(iod);
-	dma_addr_t prp_dma = iod->first_dma;
-
-	if (iod->npages == 0)
-		dma_pool_free(dev->prp_small_pool, list[0], prp_dma);
-	for (i = 0; i < iod->npages; i++) {
-		__le64 *prp_list = list[i];
-		dma_addr_t next_prp_dma = le64_to_cpu(prp_list[last_prp]);
-		dma_pool_free(dev->prp_page_pool, prp_list, prp_dma);
-		prp_dma = next_prp_dma;
+	struct device *dmadev = &dev->pci_dev->dev;
+	__le64 *prps = iod->prps;
+
+	for (i = 0; i < iod->nents; i++) {
+		if ((i != iod->nents - 1) &&
+				(i == 1 ||
+				(i && !((uintptr_t)(&prps[i + 1]) & (PAGE_SIZE - 1)))))
+			dma_unmap_single(dmadev,
+					(dma_addr_t)le64_to_cpu(prps[i]),
+					min(PAGE_SIZE, sizeof(__le64) * (iod->nents - i)),
+					iod->dma_dir);
+		else
+			dma_unmap_page(dmadev,
+					(dma_addr_t)le64_to_cpu(prps[i]),
+					PAGE_SIZE, iod->dma_dir);
 	}
 	kfree(iod);
 }
@@ -408,7 +396,7 @@ static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	struct nvme_iod *iod = ctx;
-	struct bio *bio = iod->private;
+	struct bio *bio = ((uintptr_t)(iod) > 0x1000) ? iod->private : NULL;
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
 	int error = 0;
 
@@ -425,96 +413,14 @@ static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
 		}
 		error = -EIO;
 	}
-	if (iod->nents) {
-		dma_unmap_sg(nvmeq->q_dmadev, iod->sg, iod->nents,
-			bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	if (iod->nents)
 		nvme_end_io_acct(bio, iod->start_time);
-	}
 	nvme_free_iod(nvmeq->dev, iod);
 
 	trace_block_bio_complete(bdev_get_queue(bio->bi_bdev), bio, error);
 	bio_endio(bio, error);
 }
 
-/* length is in bytes.  gfp flags indicates whether we may sleep. */
-int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod, int total_len,
-								gfp_t gfp)
-{
-	struct dma_pool *pool;
-	int length = total_len;
-	struct scatterlist *sg = iod->sg;
-	int dma_len = sg_dma_len(sg);
-	u64 dma_addr = sg_dma_address(sg);
-	int offset = offset_in_page(dma_addr);
-	__le64 *prp_list;
-	__le64 **list = iod_list(iod);
-	dma_addr_t prp_dma;
-	int nprps, i;
-
-	length -= (PAGE_SIZE - offset);
-	if (length <= 0)
-		return total_len;
-
-	dma_len -= (PAGE_SIZE - offset);
-	if (dma_len) {
-		dma_addr += (PAGE_SIZE - offset);
-	} else {
-		sg = sg_next(sg);
-		dma_addr = sg_dma_address(sg);
-		dma_len = sg_dma_len(sg);
-	}
-
-	if (length <= PAGE_SIZE) {
-		iod->first_dma = dma_addr;
-		return total_len;
-	}
-
-	nprps = DIV_ROUND_UP(length, PAGE_SIZE);
-	if (nprps <= (256 / 8)) {
-		pool = dev->prp_small_pool;
-		iod->npages = 0;
-	} else {
-		pool = dev->prp_page_pool;
-		iod->npages = 1;
-	}
-
-	prp_list = dma_pool_alloc(pool, gfp, &prp_dma);
-	if (!prp_list) {
-		iod->first_dma = dma_addr;
-		iod->npages = -1;
-		return (total_len - length) + PAGE_SIZE;
-	}
-	list[0] = prp_list;
-	iod->first_dma = prp_dma;
-	i = 0;
-	for (;;) {
-		if (i == PAGE_SIZE / 8) {
-			__le64 *old_prp_list = prp_list;
-			prp_list = dma_pool_alloc(pool, gfp, &prp_dma);
-			if (!prp_list)
-				return total_len - length;
-			list[iod->npages++] = prp_list;
-			prp_list[0] = old_prp_list[i - 1];
-			old_prp_list[i - 1] = cpu_to_le64(prp_dma);
-			i = 1;
-		}
-		prp_list[i++] = cpu_to_le64(dma_addr);
-		dma_len -= PAGE_SIZE;
-		dma_addr += PAGE_SIZE;
-		length -= PAGE_SIZE;
-		if (length <= 0)
-			break;
-		if (dma_len > 0)
-			continue;
-		BUG_ON(dma_len < 0);
-		sg = sg_next(sg);
-		dma_addr = sg_dma_address(sg);
-		dma_len = sg_dma_len(sg);
-	}
-
-	return total_len;
-}
-
 static int nvme_split_and_submit(struct bio *bio, struct nvme_queue *nvmeq,
 				 int len)
 {
@@ -540,49 +446,62 @@ static int nvme_split_and_submit(struct bio *bio, struct nvme_queue *nvmeq,
 			(((vec1)->bv_offset + (vec1)->bv_len) % PAGE_SIZE))
 
 static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
-		struct bio *bio, enum dma_data_direction dma_dir, int psegs)
+		struct bio *bio, enum dma_data_direction dma_dir)
 {
-	struct bio_vec bvec, bvprv;
+	struct bio_vec bvec, bvprv = {NULL};
 	struct bvec_iter iter;
-	struct scatterlist *sg = NULL;
-	int length = 0, nsegs = 0, split_len = bio->bi_iter.bi_size;
-	int first = 1;
+	int length = 0, i = 0, j, prp_len, offset, page_offset;
+	int split_len = bio->bi_iter.bi_size;
+
+	__le64 *prps = iod->prps;
+
+	iod->dma_dir = dma_dir;
 
 	if (nvmeq->dev->stripe_size)
-		split_len = nvmeq->dev->stripe_size -
-			((bio->bi_iter.bi_sector << 9) &
-			 (nvmeq->dev->stripe_size - 1));
+		split_len = min_t(int, nvmeq->dev->stripe_size -
+					((bio->bi_iter.bi_sector << 9) &
+			 		(nvmeq->dev->stripe_size - 1)),
+				split_len);
 
-	sg_init_table(iod->sg, psegs);
 	bio_for_each_segment(bvec, bio, iter) {
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
+		if (i && BIOVEC_NOT_VIRT_MERGEABLE(&bvprv, &bvec)) {
+			iod->nents = i;
+			return nvme_split_and_submit(bio, nvmeq, length);
 		}
-
-		if (split_len - length < bvec.bv_len)
+		if (split_len - length < bvec.bv_len) {
+			iod->nents = i;
 			return nvme_split_and_submit(bio, nvmeq, split_len);
-		length += bvec.bv_len;
+		}
+
+		page_offset = offset = bvec.bv_offset;
+		for (j = 0; j < bvec.bv_len; j += PAGE_SIZE - offset) {
+			if ((i == 1 || (i && !((uintptr_t)(&prps[i + 1]) & (PAGE_SIZE - 1)))) &&
+					((split_len - length) > PAGE_SIZE)) {
+				prps[i] = cpu_to_le64(
+					dma_map_single(nvmeq->q_dmadev, &prps[i + 1],
+						min(PAGE_SIZE, sizeof(__le64) *
+							((split_len - length + (PAGE_SIZE - 1)) >> PAGE_SHIFT)),
+						iod->dma_dir));
+				i++;
+			}
+			prp_len = min_t(int, bvec.bv_len - j, PAGE_SIZE - offset),
+			prps[i++] = cpu_to_le64(
+				dma_map_page(nvmeq->q_dmadev, bvec.bv_page,
+						page_offset, prp_len,
+						iod->dma_dir));
+			page_offset += PAGE_SIZE - offset;
+			length += prp_len;
+			offset = 0;
+		}
 		bvprv = bvec;
-		first = 0;
 	}
-	iod->nents = nsegs;
-	sg_mark_end(sg);
-	if (dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir) == 0)
-		return -ENOMEM;
+	iod->nents = i;
 
 	BUG_ON(length != bio->bi_iter.bi_size);
 	return length;
 }
 
+#if 0
 static int nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 		struct bio *bio, struct nvme_iod *iod, int cmdid)
 {
@@ -608,6 +527,7 @@ static int nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 
 	return 0;
 }
+#endif
 
 static int nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 								int cmdid)
@@ -640,7 +560,7 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod)
 		return cmdid;
 
 	if (bio->bi_rw & REQ_DISCARD)
-		return nvme_submit_discard(nvmeq, ns, bio, iod, cmdid);
+		return 0;
 	if (bio->bi_rw & REQ_FLUSH)
 		return nvme_submit_flush(nvmeq, ns, cmdid);
 
@@ -660,8 +580,8 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod)
 	cmnd->rw.opcode = bio_data_dir(bio) ? nvme_cmd_write : nvme_cmd_read;
 	cmnd->rw.command_id = cmdid;
 	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
-	cmnd->rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
-	cmnd->rw.prp2 = cpu_to_le64(iod->first_dma);
+	cmnd->rw.prp1 = iod->prps[0];
+	cmnd->rw.prp2 = iod->nents > 1 ? iod->prps[1] : 0ULL;
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_iter.bi_sector));
 	cmnd->rw.length =
 		cpu_to_le16((bio->bi_iter.bi_size >> ns->lba_shift) - 1);
@@ -714,6 +634,9 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 
 	iod->private = bio;
 	if (bio->bi_rw & REQ_DISCARD) {
+		bio_endio(bio, -EIO);
+		return 0;
+#if 0
 		void *range;
 		/*
 		 * We reuse the small pool to allocate the 16-byte range here
@@ -729,17 +652,12 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 		}
 		iod_list(iod)[0] = (__le64 *)range;
 		iod->npages = 0;
+#endif
 	} else if (psegs) {
 		result = nvme_map_bio(nvmeq, iod, bio,
-			bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE,
-			psegs);
+			bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 		if (result <= 0)
 			goto free_iod;
-		if (nvme_setup_prps(nvmeq->dev, iod, result, GFP_ATOMIC) !=
-								result) {
-			result = -ENOMEM;
-			goto free_iod;
-		}
 		nvme_start_io_acct(bio);
 	}
 	if (unlikely(nvme_submit_iod(nvmeq, iod))) {
@@ -794,6 +712,8 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 	return 1;
 }
 
+
+
 static void nvme_make_request(struct request_queue *q, struct bio *bio)
 {
 	struct nvme_ns *ns = q->queuedata;
@@ -1465,6 +1385,8 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
 				unsigned long addr, unsigned length)
 {
+	return ERR_PTR(-EIO);
+#if 0
 	int i, err, count, nents, offset;
 	struct scatterlist *sg;
 	struct page **pages;
@@ -1517,11 +1439,13 @@ struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
 		put_page(pages[i]);
 	kfree(pages);
 	return ERR_PTR(err);
+#endif
 }
 
 void nvme_unmap_user_pages(struct nvme_dev *dev, int write,
 			struct nvme_iod *iod)
 {
+#if 0
 	int i;
 
 	dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
@@ -1529,10 +1453,13 @@ void nvme_unmap_user_pages(struct nvme_dev *dev, int write,
 
 	for (i = 0; i < iod->nents; i++)
 		put_page(sg_page(&iod->sg[i]));
+#endif
 }
 
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
+	return -EIO;
+#if 0
 	struct nvme_dev *dev = ns->dev;
 	struct nvme_user_io io;
 	struct nvme_command c;
@@ -1644,6 +1571,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	}
 
 	return status;
+#endif
 }
 
 static int nvme_user_admin_cmd(struct nvme_dev *dev,
@@ -1679,9 +1607,8 @@ static int nvme_user_admin_cmd(struct nvme_dev *dev,
 								length);
 		if (IS_ERR(iod))
 			return PTR_ERR(iod);
-		length = nvme_setup_prps(dev, iod, length, GFP_KERNEL);
-		c.common.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
-		c.common.prp2 = cpu_to_le64(iod->first_dma);
+		c.common.prp1 = iod->prps[0];
+		c.common.prp2 = iod->prps[1];
 	}
 
 	timeout = cmd.timeout_ms ? msecs_to_jiffies(cmd.timeout_ms) :
@@ -2498,6 +2425,8 @@ static void nvme_dev_remove(struct nvme_dev *dev)
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
 {
+	return 0;
+#if 0
 	struct device *dmadev = &dev->pci_dev->dev;
 	dev->prp_page_pool = dma_pool_create("prp list page", dmadev,
 						PAGE_SIZE, PAGE_SIZE, 0);
@@ -2512,12 +2441,15 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
 		return -ENOMEM;
 	}
 	return 0;
+#endif
 }
 
 static void nvme_release_prp_pools(struct nvme_dev *dev)
 {
+#if 0
 	dma_pool_destroy(dev->prp_page_pool);
 	dma_pool_destroy(dev->prp_small_pool);
+#endif
 }
 
 static DEFINE_IDA(nvme_instance_ida);
diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index da3b252..31ef5c2 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1538,7 +1538,7 @@ static int nvme_trans_send_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	struct nvme_dev *dev = ns->dev;
 	struct nvme_command c;
 	struct nvme_iod *iod = NULL;
-	unsigned length;
+	//unsigned length;
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = opcode;
@@ -1558,14 +1558,9 @@ static int nvme_trans_send_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 			res = PTR_ERR(iod);
 			goto out;
 		}
-		length = nvme_setup_prps(dev, iod, tot_len, GFP_KERNEL);
-		if (length != tot_len) {
-			res = -ENOMEM;
-			goto out_unmap;
-		}
 
-		c.dlfw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
-		c.dlfw.prp2 = cpu_to_le64(iod->first_dma);
+		c.dlfw.prp1 = iod->prps[0];
+		c.dlfw.prp2 = iod->prps[1];
 		c.dlfw.numd = cpu_to_le32((tot_len/BYTES_TO_DWORDS) - 1);
 		c.dlfw.offset = cpu_to_le32(offset/BYTES_TO_DWORDS);
 	} else if (opcode == nvme_admin_activate_fw) {
@@ -2089,17 +2084,8 @@ static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 			res = PTR_ERR(iod);
 			goto out;
 		}
-		retcode = nvme_setup_prps(dev, iod, unit_len, GFP_KERNEL);
-		if (retcode != unit_len) {
-			nvme_unmap_user_pages(dev,
-				(is_write) ? DMA_TO_DEVICE : DMA_FROM_DEVICE,
-				iod);
-			nvme_free_iod(dev, iod);
-			res = -ENOMEM;
-			goto out;
-		}
-		c.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
-		c.rw.prp2 = cpu_to_le64(iod->first_dma);
+		c.rw.prp1 = iod->prps[0];
+		c.rw.prp2 = iod->prps[1];
 
 		nvme_offset += unit_num_blocks;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 1813cfd..67b68f6 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -74,8 +74,6 @@ struct nvme_dev {
 	unsigned short __percpu *io_queue;
 	u32 __iomem *dbs;
 	struct pci_dev *pci_dev;
-	struct dma_pool *prp_page_pool;
-	struct dma_pool *prp_small_pool;
 	int instance;
 	unsigned queue_count;
 	unsigned online_queues;
@@ -128,14 +126,11 @@ struct nvme_ns {
  */
 struct nvme_iod {
 	void *private;		/* For the use of the submitter of the I/O */
-	int npages;		/* In the PRP list. 0 means small pool in use */
-	int offset;		/* Of PRP list */
-	int nents;		/* Used in scatterlist */
-	int length;		/* Of data, in bytes */
+	int nents;		/* Used for prps */
 	unsigned long start_time;
-	dma_addr_t first_dma;
 	struct list_head node;
-	struct scatterlist sg[0];
+	enum dma_data_direction dma_dir;
+	__le64 prps[];
 };
 
 static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
@@ -150,7 +145,6 @@ static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
  */
 void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod);
 
-int nvme_setup_prps(struct nvme_dev *, struct nvme_iod *, int , gfp_t);
 struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
 				unsigned long addr, unsigned length);
 void nvme_unmap_user_pages(struct nvme_dev *dev, int write,
-- 
1.9.1
