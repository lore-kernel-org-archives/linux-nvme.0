From: Parav.pandit@avagotech.com (Parav Pandit)
Date: Tue,  2 Jun 2015 19:41:08 +0530
Subject: [PATCH] NVMe: General code cleanup for reuse.
Message-ID: <1433254268-11354-1-git-send-email-Parav.pandit@avagotech.com>

From: Parav Pandit <parav.pandit@avagotech.com>

Moved code for reusing at few places:
1. Moved lba_shift related calculation code to macro for converting block to/from len.
2. Moved req_len to nlb calculation to inline function.

Signed-off-by: Parav Pandit <parav.pandit at avagotech.com>
---
 drivers/block/nvme-core.c | 10 +++++-----
 drivers/block/nvme-scsi.c | 10 +++++-----
 include/linux/nvme.h      |  8 ++++++++
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 85b8036..b9ba36f 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -521,7 +521,7 @@ static void nvme_dif_remap(struct request *req,
 	p = pmap;
 	virt = bip_get_seed(bip);
 	phys = nvme_block_nr(ns, blk_rq_pos(req));
-	nlb = (blk_rq_bytes(req) >> ns->lba_shift);
+	nlb = nvme_req_len_to_nlb(ns, req);
 	ts = ns->disk->integrity->tuple_size;
 
 	for (i = 0; i < nlb; i++, virt++, phys++) {
@@ -722,7 +722,7 @@ static void nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	struct nvme_command *cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
 
 	range->cattr = cpu_to_le32(0);
-	range->nlb = cpu_to_le32(blk_rq_bytes(req) >> ns->lba_shift);
+	range->nlb = cpu_to_le32(nvme_req_len_to_nlb(ns, req));
 	range->slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 
 	memset(cmnd, 0, sizeof(*cmnd));
@@ -778,7 +778,7 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	cmnd->rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
 	cmnd->rw.prp2 = cpu_to_le64(iod->first_dma);
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
-	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+	cmnd->rw.length = cpu_to_le16(nvme_req_len_to_nlb(ns, req) - 1);
 
 	if (blk_integrity_rq(req)) {
 		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(iod->meta_sg));
@@ -1753,7 +1753,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
-	length = (io.nblocks + 1) << ns->lba_shift;
+	length = NVME_BLOCKS_TO_LEN(ns, io.nblocks + 1);
 	meta_len = (io.nblocks + 1) * ns->ms;
 
 	if (meta_len && ((io.metadata & 3) || !io.metadata) && !ns->ext)
@@ -2127,7 +2127,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	ns->lba_shift = 9; /* set to a default value for 512 until disk is validated */
 	list_add_tail(&ns->list, &dev->namespaces);
 
-	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
+	blk_queue_logical_block_size(ns->queue, NVME_BLOCKS_TO_LEN(ns, 1));
 	if (dev->max_hw_sectors)
 		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
 	if (dev->stripe_size)
diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 6b736b0..b7b78d0 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -2101,14 +2101,14 @@ static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 			if (retcode)
 				return -EFAULT;
 			unit_len = sgl.iov_len;
-			unit_num_blocks = unit_len >> ns->lba_shift;
+			unit_num_blocks = NVME_LEN_TO_BLOCKS(ns, unit_len);
 			next_mapping_addr = sgl.iov_base;
 		} else {
 			unit_num_blocks = min((u64)max_blocks,
 					(cdb_info->xfer_len - nvme_offset));
-			unit_len = unit_num_blocks << ns->lba_shift;
+			unit_len = NVME_BLOCKS_TO_LEN(ns, unit_num_blocks);
 			next_mapping_addr = hdr->dxferp +
-					((1 << ns->lba_shift) * nvme_offset);
+				((NVME_BLOCKS_TO_LEN(ns, 1)) * nvme_offset);
 		}
 
 		c.rw.opcode = opcode;
@@ -2208,7 +2208,7 @@ static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 is_write,
 				return -EFAULT;
 			sum_iov_len += sgl.iov_len;
 			/* IO vector sizes should be multiples of block size */
-			if (sgl.iov_len % (1 << ns->lba_shift) != 0) {
+			if (sgl.iov_len % (NVME_BLOCKS_TO_LEN(ns, 1)) != 0) {
 				res = nvme_trans_completion(hdr,
 						SAM_STAT_CHECK_CONDITION,
 						ILLEGAL_REQUEST,
@@ -2225,7 +2225,7 @@ static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8 is_write,
 	xfer_bytes = min(((u64)hdr->dxfer_len), sum_iov_len);
 
 	/* If block count and actual data buffer size dont match, error out */
-	if (xfer_bytes != (cdb_info.xfer_len << ns->lba_shift)) {
+	if (xfer_bytes != NVME_BLOCKS_TO_LEN(ns, cdb_info.xfer_len)) {
 		res = -EINVAL;
 		goto out;
 	}
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 8dbd05e..71f7984 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -124,6 +124,9 @@ struct nvme_ns {
 	u32 mode_select_block_len;
 };
 
+#define NVME_BLOCKS_TO_LEN(ns, num_blocks) ((num_blocks) << ns->lba_shift)
+#define NVME_LEN_TO_BLOCKS(ns, len) ((len) >> ns->lba_shift)
+
 /*
  * The nvme_iod describes the data in an I/O, including the list of PRP
  * entries.  You can't see it in this data structure because C doesn't let
@@ -146,6 +149,11 @@ static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
 	return (sector >> (ns->lba_shift - 9));
 }
 
+static inline u32 nvme_req_len_to_nlb(struct nvme_ns *ns, struct request *req)
+{
+	return (blk_rq_bytes(req) >> ns->lba_shift);
+}
+
 /**
  * nvme_free_iod - frees an nvme_iod
  * @dev: The device that the I/O was submitted to
-- 
1.8.3.1
