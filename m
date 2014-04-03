From: keith.busch@intel.com (Keith Busch)
Date: Thu,  3 Apr 2014 16:45:23 -0600
Subject: [PATCHv2] NVMe: Retry failed commands with non-fatal errors
Message-ID: <1396565123-8540-1-git-send-email-keith.busch@intel.com>

For commands returned with failed status, queue these for resubmission
and continue retrying them until success or for a limited amount of
time. The final timeout was arbitrarily chosen so requests can't be
retried indefinitely.

Since these are requeued on the nvmeq that submitted the command, the
callbacks have to take an nvmeq instead of an nvme_dev as a parameter
so that we can use the locked queue to append the iod to retry later.

The nvme_iod conviently can be used to track how long we've been trying
to successfully complete an iod request. The nvme_iod also provides the
nvme prp dma mappings, so I had to move a few things around so we can
keep those mappings.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v2:

Merged up with latest tree.

Reduced the final timeout value; 65 seconds was just too long.

Don't call nvme_map_bio on REQ_DISCARD types. That breaks things. :)

Fixed memory leak if the device breaks with IO's queued in the iod
list. Before, I had it just call bio_endio(), but I changed this to call
bio_completion() with non-retryable status since that routine knows how
to free the iod and dma memory mappings.

Fixed handling when the iod is queued to prevent unnecessary
stalling. Before, this would queue the command for the nvme_thread to
pick up, but that could cause the IO to stall for one second. Now I
add the wait queue entry when the iod is queued so new completions will
wake the nvme_thread.

 drivers/block/nvme-core.c |  234 ++++++++++++++++++++++++++++-----------------
 drivers/block/nvme-scsi.c |   10 +-
 include/linux/nvme.h      |    4 +-
 include/uapi/linux/nvme.h |    1 +
 4 files changed, 153 insertions(+), 96 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 625259d..59e2adcc 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -49,6 +49,7 @@
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 #define ADMIN_TIMEOUT	(60 * HZ)
+#define IOD_TIMEOUT	(4 * NVME_IO_TIMEOUT)
 
 static int nvme_major;
 module_param(nvme_major, int, 0);
@@ -88,6 +89,7 @@ struct nvme_queue {
 	wait_queue_head_t sq_full;
 	wait_queue_t sq_cong_wait;
 	struct bio_list sq_cong;
+	struct list_head iod_bio;
 	u32 __iomem *q_db;
 	u16 q_depth;
 	u16 cq_vector;
@@ -122,7 +124,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
 }
 
-typedef void (*nvme_completion_fn)(struct nvme_dev *, void *,
+typedef void (*nvme_completion_fn)(struct nvme_queue *, void *,
 						struct nvme_completion *);
 
 struct nvme_cmd_info {
@@ -194,7 +196,7 @@ static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
 #define CMD_CTX_FLUSH		(0x318 + CMD_CTX_BASE)
 #define CMD_CTX_ABORT		(0x31C + CMD_CTX_BASE)
 
-static void special_completion(struct nvme_dev *dev, void *ctx,
+static void special_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	if (ctx == CMD_CTX_CANCELLED)
@@ -202,26 +204,26 @@ static void special_completion(struct nvme_dev *dev, void *ctx,
 	if (ctx == CMD_CTX_FLUSH)
 		return;
 	if (ctx == CMD_CTX_ABORT) {
-		++dev->abort_limit;
+		++nvmeq->dev->abort_limit;
 		return;
 	}
 	if (ctx == CMD_CTX_COMPLETED) {
-		dev_warn(&dev->pci_dev->dev,
+		dev_warn(nvmeq->q_dmadev,
 				"completed id %d twice on queue %d\n",
 				cqe->command_id, le16_to_cpup(&cqe->sq_id));
 		return;
 	}
 	if (ctx == CMD_CTX_INVALID) {
-		dev_warn(&dev->pci_dev->dev,
+		dev_warn(nvmeq->q_dmadev,
 				"invalid id %d completed on queue %d\n",
 				cqe->command_id, le16_to_cpup(&cqe->sq_id));
 		return;
 	}
 
-	dev_warn(&dev->pci_dev->dev, "Unknown special completion %p\n", ctx);
+	dev_warn(nvmeq->q_dmadev, "Unknown special completion %p\n", ctx);
 }
 
-static void async_completion(struct nvme_dev *dev, void *ctx,
+static void async_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	struct async_cmd_info *cmdinfo = ctx;
@@ -351,6 +353,7 @@ nvme_alloc_iod(unsigned nseg, unsigned nbytes, gfp_t gfp)
 		iod->npages = -1;
 		iod->length = nbytes;
 		iod->nents = 0;
+		iod->first_dma = 0ULL;
 		iod->start_time = jiffies;
 	}
 
@@ -399,19 +402,30 @@ static void nvme_end_io_acct(struct bio *bio, unsigned long start_time)
 	part_stat_unlock();
 }
 
-static void bio_completion(struct nvme_dev *dev, void *ctx,
+static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	struct nvme_iod *iod = ctx;
 	struct bio *bio = iod->private;
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
 
+	if (unlikely(status)) {
+		if (!(status & NVME_SC_DNR ||
+				bio->bi_rw & REQ_FAILFAST_MASK) &&
+				(jiffies - iod->start_time) < IOD_TIMEOUT) {
+			if (!waitqueue_active(&nvmeq->sq_full))
+				add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
+			list_add_tail(&iod->node, &nvmeq->iod_bio);
+			wake_up(&nvmeq->sq_full);
+			return;
+		}
+	}
 	if (iod->nents) {
-		dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
+		dma_unmap_sg(nvmeq->q_dmadev, iod->sg, iod->nents,
 			bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 		nvme_end_io_acct(bio, iod->start_time);
 	}
-	nvme_free_iod(dev, iod);
+	nvme_free_iod(nvmeq->dev, iod);
 	if (status)
 		bio_endio(bio, -EIO);
 	else
@@ -419,8 +433,8 @@ static void bio_completion(struct nvme_dev *dev, void *ctx,
 }
 
 /* length is in bytes.  gfp flags indicates whether we may sleep. */
-int nvme_setup_prps(struct nvme_dev *dev, struct nvme_common_command *cmd,
-			struct nvme_iod *iod, int total_len, gfp_t gfp)
+int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod, int total_len,
+								gfp_t gfp)
 {
 	struct dma_pool *pool;
 	int length = total_len;
@@ -433,7 +447,6 @@ int nvme_setup_prps(struct nvme_dev *dev, struct nvme_common_command *cmd,
 	dma_addr_t prp_dma;
 	int nprps, i;
 
-	cmd->prp1 = cpu_to_le64(dma_addr);
 	length -= (PAGE_SIZE - offset);
 	if (length <= 0)
 		return total_len;
@@ -448,7 +461,7 @@ int nvme_setup_prps(struct nvme_dev *dev, struct nvme_common_command *cmd,
 	}
 
 	if (length <= PAGE_SIZE) {
-		cmd->prp2 = cpu_to_le64(dma_addr);
+		iod->first_dma = dma_addr;
 		return total_len;
 	}
 
@@ -463,13 +476,12 @@ int nvme_setup_prps(struct nvme_dev *dev, struct nvme_common_command *cmd,
 
 	prp_list = dma_pool_alloc(pool, gfp, &prp_dma);
 	if (!prp_list) {
-		cmd->prp2 = cpu_to_le64(dma_addr);
+		iod->first_dma = dma_addr;
 		iod->npages = -1;
 		return (total_len - length) + PAGE_SIZE;
 	}
 	list[0] = prp_list;
 	iod->first_dma = prp_dma;
-	cmd->prp2 = cpu_to_le64(prp_dma);
 	i = 0;
 	for (;;) {
 		if (i == PAGE_SIZE / 8) {
@@ -508,10 +520,11 @@ static int nvme_split_and_submit(struct bio *bio, struct nvme_queue *nvmeq,
 
 	bio_chain(split, bio);
 
-	if (bio_list_empty(&nvmeq->sq_cong))
+	if (!waitqueue_active(&nvmeq->sq_full))
 		add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
 	bio_list_add(&nvmeq->sq_cong, split);
 	bio_list_add(&nvmeq->sq_cong, bio);
+	wake_up(&nvmeq->sq_full);
 
 	return 0;
 }
@@ -564,25 +577,13 @@ static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	return length;
 }
 
-/*
- * We reuse the small pool to allocate the 16-byte range here as it is not
- * worth having a special pool for these or additional cases to handle freeing
- * the iod.
- */
 static int nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 		struct bio *bio, struct nvme_iod *iod, int cmdid)
 {
-	struct nvme_dsm_range *range;
+	struct nvme_dsm_range *range =
+				(struct nvme_dsm_range *)iod_list(iod)[0];
 	struct nvme_command *cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
 
-	range = dma_pool_alloc(nvmeq->dev->prp_small_pool, GFP_ATOMIC,
-							&iod->first_dma);
-	if (!range)
-		return -ENOMEM;
-
-	iod_list(iod)[0] = (__le64 *)range;
-	iod->npages = 0;
-
 	range->cattr = cpu_to_le32(0);
 	range->nlb = cpu_to_le32(bio->bi_iter.bi_size >> ns->lba_shift);
 	range->slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_iter.bi_sector));
@@ -629,44 +630,22 @@ int nvme_submit_flush_data(struct nvme_queue *nvmeq, struct nvme_ns *ns)
 	return nvme_submit_flush(nvmeq, ns, cmdid);
 }
 
-/*
- * Called with local interrupts disabled and the q_lock held.  May not sleep.
- */
-static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
-								struct bio *bio)
+static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod)
 {
+	struct bio *bio = iod->private;
+	struct nvme_ns *ns = bio->bi_bdev->bd_disk->private_data;
 	struct nvme_command *cmnd;
-	struct nvme_iod *iod;
-	enum dma_data_direction dma_dir;
-	int cmdid, length, result;
+	int cmdid;
 	u16 control;
 	u32 dsmgmt;
-	int psegs = bio_phys_segments(ns->queue, bio);
 
-	if ((bio->bi_rw & REQ_FLUSH) && psegs) {
-		result = nvme_submit_flush_data(nvmeq, ns);
-		if (result)
-			return result;
-	}
-
-	result = -ENOMEM;
-	iod = nvme_alloc_iod(psegs, bio->bi_iter.bi_size, GFP_ATOMIC);
-	if (!iod)
-		goto nomem;
-	iod->private = bio;
-
-	result = -EBUSY;
 	cmdid = alloc_cmdid(nvmeq, iod, bio_completion, NVME_IO_TIMEOUT);
 	if (unlikely(cmdid < 0))
-		goto free_iod;
+		return cmdid;
 
-	if (bio->bi_rw & REQ_DISCARD) {
-		result = nvme_submit_discard(nvmeq, ns, bio, iod, cmdid);
-		if (result)
-			goto free_cmdid;
-		return result;
-	}
-	if ((bio->bi_rw & REQ_FLUSH) && !psegs)
+	if (bio->bi_rw & REQ_DISCARD)
+		return nvme_submit_discard(nvmeq, ns, bio, iod, cmdid);
+	if ((bio->bi_rw & REQ_FLUSH) && !iod->nents)
 		return nvme_submit_flush(nvmeq, ns, cmdid);
 
 	control = 0;
@@ -680,42 +659,85 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
 	cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
-
 	memset(cmnd, 0, sizeof(*cmnd));
-	if (bio_data_dir(bio)) {
-		cmnd->rw.opcode = nvme_cmd_write;
-		dma_dir = DMA_TO_DEVICE;
-	} else {
-		cmnd->rw.opcode = nvme_cmd_read;
-		dma_dir = DMA_FROM_DEVICE;
-	}
-
-	result = nvme_map_bio(nvmeq, iod, bio, dma_dir, psegs);
-	if (result <= 0)
-		goto free_cmdid;
-	length = result;
 
+	cmnd->rw.opcode = bio_data_dir(bio) ? nvme_cmd_write : nvme_cmd_read;
 	cmnd->rw.command_id = cmdid;
 	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
-	length = nvme_setup_prps(nvmeq->dev, &cmnd->common, iod, length,
-								GFP_ATOMIC);
+	cmnd->rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+	cmnd->rw.prp2 = cpu_to_le64(iod->first_dma);
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_iter.bi_sector));
-	cmnd->rw.length = cpu_to_le16((length >> ns->lba_shift) - 1);
+	cmnd->rw.length =
+		cpu_to_le16((bio->bi_iter.bi_size >> ns->lba_shift) - 1);
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
 
-	nvme_start_io_acct(bio);
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
 	writel(nvmeq->sq_tail, nvmeq->q_db);
 
 	return 0;
+}
+
+/*
+ * Called with local interrupts disabled and the q_lock held.  May not sleep.
+ */
+static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
+								struct bio *bio)
+{
+	struct nvme_iod *iod;
+	int psegs = bio_phys_segments(ns->queue, bio);
+	int result;
+
+	if ((bio->bi_rw & REQ_FLUSH) && psegs) {
+		result = nvme_submit_flush_data(nvmeq, ns);
+		if (result)
+			return result;
+	}
+
+	iod = nvme_alloc_iod(psegs, bio->bi_iter.bi_size, GFP_ATOMIC);
+	if (!iod)
+		return -ENOMEM;
+
+	iod->private = bio;
+	if (bio->bi_rw & REQ_DISCARD) {
+		void *range;
+		/*
+		 * We reuse the small pool to allocate the 16-byte range here
+		 * as it is not worth having a special pool for these or
+		 * additional cases to handle freeing the iod.
+		 */
+		range = dma_pool_alloc(nvmeq->dev->prp_small_pool,
+						GFP_ATOMIC,
+						&iod->first_dma);
+		if (!range) {
+			result = -ENOMEM;
+			goto free_iod;
+		}
+		iod_list(iod)[0] = (__le64 *)range;
+		iod->npages = 0;
+	} else if (psegs) {
+		result = nvme_map_bio(nvmeq, iod, bio,
+			bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE,
+			psegs);
+		if (result <= 0)
+			goto free_iod;
+		if (nvme_setup_prps(nvmeq->dev, iod, result, GFP_ATOMIC) !=
+								result) {
+			result = -ENOMEM;
+			goto free_iod;
+		}
+		nvme_start_io_acct(bio);
+	}
+	if (unlikely(nvme_submit_iod(nvmeq, iod))) {
+		if (!waitqueue_active(&nvmeq->sq_full))
+			add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
+		list_add_tail(&iod->node, &nvmeq->iod_bio);
+	}
+	return 0;
 
- free_cmdid:
-	free_cmdid(nvmeq, cmdid, NULL);
  free_iod:
 	nvme_free_iod(nvmeq->dev, iod);
- nomem:
 	return result;
 }
 
@@ -739,7 +761,7 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 		}
 
 		ctx = free_cmdid(nvmeq, cqe.command_id, &fn);
-		fn(nvmeq->dev, ctx, &cqe);
+		fn(nvmeq, ctx, &cqe);
 	}
 
 	/* If the controller ignores the cq head doorbell and continuously
@@ -775,7 +797,7 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
 	if (!nvmeq->q_suspended && bio_list_empty(&nvmeq->sq_cong))
 		result = nvme_submit_bio_queue(nvmeq, ns, bio);
 	if (unlikely(result)) {
-		if (bio_list_empty(&nvmeq->sq_cong))
+		if (!waitqueue_active(&nvmeq->sq_full))
 			add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
 		bio_list_add(&nvmeq->sq_cong, bio);
 	}
@@ -819,7 +841,7 @@ struct sync_cmd_info {
 	int status;
 };
 
-static void sync_completion(struct nvme_dev *dev, void *ctx,
+static void sync_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	struct sync_cmd_info *cmdinfo = ctx;
@@ -1106,7 +1128,7 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d QID %d\n", cmdid,
 								nvmeq->qid);
 		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
-		fn(nvmeq->dev, ctx, &cqe);
+		fn(nvmeq, ctx, &cqe);
 	}
 }
 
@@ -1119,6 +1141,17 @@ static void nvme_free_queue(struct rcu_head *r)
 		struct bio *bio = bio_list_pop(&nvmeq->sq_cong);
 		bio_endio(bio, -EIO);
 	}
+	while (!list_empty(&nvmeq->iod_bio)) {
+		static struct nvme_completion cqe = {
+			.status = cpu_to_le16(
+				(NVME_SC_ABORT_REQ | NVME_SC_DNR) << 1),
+		};
+		struct nvme_iod *iod = list_first_entry(&nvmeq->iod_bio,
+							struct nvme_iod,
+							node);
+		list_del(&iod->node);
+		bio_completion(nvmeq, iod, &cqe);
+	}
 	spin_unlock_irq(&nvmeq->q_lock);
 
 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
@@ -1225,6 +1258,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	init_waitqueue_head(&nvmeq->sq_full);
 	init_waitqueue_entry(&nvmeq->sq_cong_wait, nvme_thread);
 	bio_list_init(&nvmeq->sq_cong);
+	INIT_LIST_HEAD(&nvmeq->iod_bio);
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	nvmeq->q_depth = depth;
 	nvmeq->cq_vector = vector;
@@ -1558,7 +1592,9 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 		c.rw.metadata = cpu_to_le64(meta_dma_addr);
 	}
 
-	length = nvme_setup_prps(dev, &c.common, iod, length, GFP_KERNEL);
+	length = nvme_setup_prps(dev, iod, length, GFP_KERNEL);
+	c.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+	c.rw.prp2 = cpu_to_le64(iod->first_dma);
 
 	if (length != (io.nblocks + 1) << ns->lba_shift)
 		status = -ENOMEM;
@@ -1628,8 +1664,9 @@ static int nvme_user_admin_cmd(struct nvme_dev *dev,
 								length);
 		if (IS_ERR(iod))
 			return PTR_ERR(iod);
-		length = nvme_setup_prps(dev, &c.common, iod, length,
-								GFP_KERNEL);
+		length = nvme_setup_prps(dev, iod, length, GFP_KERNEL);
+		c.common.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+		c.common.prp2 = cpu_to_le64(iod->first_dma);
 	}
 
 	timeout = cmd.timeout_ms ? msecs_to_jiffies(cmd.timeout_ms) :
@@ -1716,17 +1753,33 @@ static const struct block_device_operations nvme_fops = {
 	.release	= nvme_release,
 };
 
+static void nvme_resubmit_iods(struct nvme_queue *nvmeq)
+{
+	struct nvme_iod *iod, *next;
+
+	list_for_each_entry_safe(iod, next, &nvmeq->iod_bio, node) {
+		if (unlikely(nvme_submit_iod(nvmeq, iod)))
+			break;
+		list_del(&iod->node);
+		if (bio_list_empty(&nvmeq->sq_cong) &&
+						list_empty(&nvmeq->iod_bio))
+			remove_wait_queue(&nvmeq->sq_full,
+						&nvmeq->sq_cong_wait);
+	}
+}
+
 static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
 {
 	while (bio_list_peek(&nvmeq->sq_cong)) {
 		struct bio *bio = bio_list_pop(&nvmeq->sq_cong);
 		struct nvme_ns *ns = bio->bi_bdev->bd_disk->private_data;
 
-		if (bio_list_empty(&nvmeq->sq_cong))
+		if (bio_list_empty(&nvmeq->sq_cong) &&
+						list_empty(&nvmeq->iod_bio))
 			remove_wait_queue(&nvmeq->sq_full,
 							&nvmeq->sq_cong_wait);
 		if (nvme_submit_bio_queue(nvmeq, ns, bio)) {
-			if (bio_list_empty(&nvmeq->sq_cong))
+			if (!waitqueue_active(&nvmeq->sq_full))
 				add_wait_queue(&nvmeq->sq_full,
 							&nvmeq->sq_cong_wait);
 			bio_list_add_head(&nvmeq->sq_cong, bio);
@@ -1768,6 +1821,7 @@ static int nvme_kthread(void *data)
 				nvme_process_cq(nvmeq);
 				nvme_cancel_ios(nvmeq, true);
 				nvme_resubmit_bios(nvmeq);
+				nvme_resubmit_iods(nvmeq);
  unlock:
 				spin_unlock_irq(&nvmeq->q_lock);
 			}
diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 111c920..2c3f5be 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1562,13 +1562,14 @@ static int nvme_trans_send_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 			res = PTR_ERR(iod);
 			goto out;
 		}
-		length = nvme_setup_prps(dev, &c.common, iod, tot_len,
-								GFP_KERNEL);
+		length = nvme_setup_prps(dev, iod, tot_len, GFP_KERNEL);
 		if (length != tot_len) {
 			res = -ENOMEM;
 			goto out_unmap;
 		}
 
+		c.dlfw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+		c.dlfw.prp2 = cpu_to_le64(iod->first_dma);
 		c.dlfw.numd = cpu_to_le32((tot_len/BYTES_TO_DWORDS) - 1);
 		c.dlfw.offset = cpu_to_le32(offset/BYTES_TO_DWORDS);
 	} else if (opcode == nvme_admin_activate_fw) {
@@ -2092,8 +2093,7 @@ static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 			res = PTR_ERR(iod);
 			goto out;
 		}
-		retcode = nvme_setup_prps(dev, &c.common, iod, unit_len,
-							GFP_KERNEL);
+		retcode = nvme_setup_prps(dev, iod, unit_len, GFP_KERNEL);
 		if (retcode != unit_len) {
 			nvme_unmap_user_pages(dev,
 				(is_write) ? DMA_TO_DEVICE : DMA_FROM_DEVICE,
@@ -2102,6 +2102,8 @@ static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 			res = -ENOMEM;
 			goto out;
 		}
+		c.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+		c.rw.prp2 = cpu_to_le64(iod->first_dma);
 
 		nvme_offset += unit_num_blocks;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 15d071e..5993455 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -135,6 +135,7 @@ struct nvme_iod {
 	int length;		/* Of data, in bytes */
 	unsigned long start_time;
 	dma_addr_t first_dma;
+	struct list_head node;
 	struct scatterlist sg[0];
 };
 
@@ -150,8 +151,7 @@ static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
  */
 void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod);
 
-int nvme_setup_prps(struct nvme_dev *dev, struct nvme_common_command *cmd,
-			struct nvme_iod *iod, int total_len, gfp_t gfp);
+int nvme_setup_prps(struct nvme_dev *, struct nvme_iod *, int , gfp_t);
 struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
 				unsigned long addr, unsigned length);
 void nvme_unmap_user_pages(struct nvme_dev *dev, int write,
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index e5ab622..096fe1c 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -434,6 +434,7 @@ enum {
 	NVME_SC_REFTAG_CHECK		= 0x284,
 	NVME_SC_COMPARE_FAILED		= 0x285,
 	NVME_SC_ACCESS_DENIED		= 0x286,
+	NVME_SC_DNR			= 0x4000,
 };
 
 struct nvme_completion {
-- 
1.7.10.4
