From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Nov 2014 17:05:38 -0700
Subject: [PATCH] NVMe: Add rw_page support
Message-ID: <1415923538-18760-1-git-send-email-keith.busch@intel.com>

This adds the rw_page entry point to the nvme driver so a page can be
written/read without going through the block layer and not requiring
additional allocations.

Just because we implement this doesn't mean we want to use it. I only see
a performance win on some types of work, like swap where I see about 15%
reduction in system time (compared to 20% prior to blk-mq when we didn't
allocate a request to get a command id). Even then, system time accounts
for very little of the real time anyway, and it's only an over-all win
if the device has very low-latency. But the driver doesn't know this
nor if the expected workload will even benefit from using page io,
so I added a queue flag that a user can toggle on/off.

The other benefit besides reduced system time is that we can swap
pages in/out without having to allocate anything since everything is
preallocated in this path.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-sysfs.c         |    8 +++++
 drivers/block/nvme-core.c |   78 +++++++++++++++++++++++++++++++++++++++++++++
 fs/block_dev.c            |    4 +--
 include/linux/blkdev.h    |    2 ++
 4 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1fac434..b29de5f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -221,6 +221,7 @@ queue_store_##name(struct request_queue *q, const char *page, size_t count) \
 QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
 QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
+QUEUE_SYSFS_BIT_FNS(rw_page, RW_PG, 0);
 #undef QUEUE_SYSFS_BIT_FNS
 
 static ssize_t queue_nomerges_show(struct request_queue *q, char *page)
@@ -404,6 +405,12 @@ static struct queue_sysfs_entry queue_random_entry = {
 	.store = queue_store_random,
 };
 
+static struct queue_sysfs_entry queue_rw_page_entry = {
+	.attr = {.name = "rw_page", .mode = S_IRUGO | S_IWUSR },
+	.show = queue_show_rw_page,
+	.store = queue_store_rw_page,
+};
+
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -427,6 +434,7 @@ static struct attribute *default_attrs[] = {
 	&queue_rq_affinity_entry.attr,
 	&queue_iostats_entry.attr,
 	&queue_random_entry.attr,
+	&queue_rw_page_entry.attr,
 	NULL,
 };
 
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 8393f91..96a1d61 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -143,6 +143,7 @@ struct nvme_cmd_info {
 	nvme_completion_fn fn;
 	void *ctx;
 	int aborted;
+	dma_addr_t dma;
 	struct nvme_queue *nvmeq;
 };
 
@@ -1807,8 +1808,85 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	return 0;
 }
 
+static void pgrd_completion(struct nvme_queue *nvmeq, void *ctx,
+						struct nvme_completion *cqe)
+{
+	struct request *req = ctx;
+	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
+	struct page *page = req->special;
+	u16 status = le16_to_cpup(&cqe->status) >> 1;
+
+	dma_unmap_page(nvmeq->q_dmadev, cmd_rq->dma, PAGE_CACHE_SIZE, DMA_FROM_DEVICE);
+	page_endio(page, READ, status != NVME_SC_SUCCESS);
+	blk_put_request(req);
+}
+
+static void pgwr_completion(struct nvme_queue *nvmeq, void *ctx,
+						struct nvme_completion *cqe)
+{
+	struct request *req = ctx;
+	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
+	struct page *page = req->special;
+	u16 status = le16_to_cpup(&cqe->status) >> 1;
+
+	dma_unmap_page(nvmeq->q_dmadev, cmd_rq->dma, PAGE_CACHE_SIZE, DMA_TO_DEVICE);
+	page_endio(page, WRITE, status != NVME_SC_SUCCESS);
+	blk_put_request(req);
+}
+
+static const enum dma_data_direction nvme_to_direction[] = {
+	DMA_NONE, DMA_TO_DEVICE, DMA_FROM_DEVICE, DMA_BIDIRECTIONAL
+};
+
+static int nvme_rw_page(struct block_device *bdev, sector_t sector,
+					struct page *page, int rw)
+{
+	dma_addr_t dma;
+	struct request *req;
+	struct nvme_command *cmd;
+	struct nvme_queue *nvmeq;
+	struct nvme_cmd_info *cmd_rq;
+	struct nvme_ns *ns = bdev->bd_disk->private_data;
+	nvme_completion_fn fn = (rw & WRITE) ? pgwr_completion : pgrd_completion;
+	u8 op = (rw & WRITE) ? nvme_cmd_write : nvme_cmd_read;
+	enum dma_data_direction dma_dir = nvme_to_direction[op & 3];
+
+	req = blk_mq_alloc_request(ns->queue, rw, GFP_ATOMIC, false);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+	req->special = page;
+	cmd_rq = blk_mq_rq_to_pdu(req);
+	nvmeq = cmd_rq->nvmeq;
+
+	nvme_set_info(cmd_rq, req, fn);
+
+	dma = dma_map_page(nvmeq->q_dmadev, page, 0, PAGE_CACHE_SIZE, dma_dir);
+	cmd_rq->dma = dma;
+
+	spin_lock_irq(&nvmeq->q_lock);
+	cmd = &nvmeq->sq_cmds[nvmeq->sq_tail];
+	memset(cmd, 0, sizeof(*cmd));
+
+	cmd->rw.opcode = op;
+	cmd->rw.command_id = req->tag;
+	cmd->rw.nsid = cpu_to_le32(ns->ns_id);
+	cmd->rw.slba = cpu_to_le64(nvme_block_nr(ns, sector));
+	cmd->rw.length = cpu_to_le16((PAGE_CACHE_SIZE >> ns->lba_shift) - 1);
+	cmd->rw.prp1 = cpu_to_le64(dma);
+
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+	writel(nvmeq->sq_tail, nvmeq->q_db);
+
+	nvme_process_cq(nvmeq);
+	spin_unlock_irq(&nvmeq->q_lock);
+
+	return 0;
+}
+
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
+	.rw_page	= nvme_rw_page,
 	.ioctl		= nvme_ioctl,
 	.compat_ioctl	= nvme_compat_ioctl,
 	.open		= nvme_open,
diff --git a/fs/block_dev.c b/fs/block_dev.c
index cc9d411..f17f95d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -380,7 +380,7 @@ int bdev_read_page(struct block_device *bdev, sector_t sector,
 			struct page *page)
 {
 	const struct block_device_operations *ops = bdev->bd_disk->fops;
-	if (!ops->rw_page)
+	if (!ops->rw_page || !blk_queue_rw_page(bdev->bd_queue))
 		return -EOPNOTSUPP;
 	return ops->rw_page(bdev, sector + get_start_sect(bdev), page, READ);
 }
@@ -411,7 +411,7 @@ int bdev_write_page(struct block_device *bdev, sector_t sector,
 	int result;
 	int rw = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : WRITE;
 	const struct block_device_operations *ops = bdev->bd_disk->fops;
-	if (!ops->rw_page)
+	if (!ops->rw_page || !blk_queue_rw_page(bdev->bd_queue))
 		return -EOPNOTSUPP;
 	set_page_writeback(page);
 	result = ops->rw_page(bdev, sector + get_start_sect(bdev), page, rw);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 77db6dc..17a6058 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -509,6 +509,7 @@ struct request_queue {
 #define QUEUE_FLAG_INIT_DONE   20	/* queue is initialized */
 #define QUEUE_FLAG_NO_SG_MERGE 21	/* don't attempt to merge SG segments*/
 #define QUEUE_FLAG_SG_GAPS     22	/* queue doesn't support SG gaps */
+#define QUEUE_FLAG_RW_PG       23	/* use .rw_page if implemented */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
@@ -596,6 +597,7 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_flags)
 #define blk_queue_secdiscard(q)	(blk_queue_discard(q) && \
 	test_bit(QUEUE_FLAG_SECDISCARD, &(q)->queue_flags))
+#define blk_queue_rw_page(q)	test_bit(QUEUE_FLAG_RW_PG, &(q)->queue_flags)
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
-- 
1.7.10.4
