From: keith.busch@intel.com (Keith Busch)
Date: Wed,  8 Mar 2017 16:35:37 -0500
Subject: [RFC PATCH] nvmet: Back namespace with files
Message-ID: <1489008937-31043-1-git-send-email-keith.busch@intel.com>

This RFC allows NVMeOF targets to be backed by files. Prior to this,
only block device files were supported, but this patch will let you use
any file, and continue working on block files if requested.

Backing with files has more flexibility on what a namespace can be,
and it isn't difficult from here to add NVMe target support for caching,
provisioning, namespace management, and all the features Linux filesystems
provide.

This temporarily removes the admin smart log support, to be re-implemented
later. It was incorrect anyway since the smart log is supposed to report
device lifetime statistics, but we're just showing since hd_struct creation.

I only ported the loop target. The fc and rdma targets are a little more
work, so this looked like a good stopping point to guage interest.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/target/admin-cmd.c   |  54 +-------------
 drivers/nvme/target/core.c        |  54 +++++++++-----
 drivers/nvme/target/fabrics-cmd.c |   6 +-
 drivers/nvme/target/io-cmd.c      | 153 ++++++++------------------------------
 drivers/nvme/target/loop.c        |  45 ++++++++---
 drivers/nvme/target/nvmet.h       |  10 +--
 fs/exec.c                         |  18 ++---
 fs/splice.c                       |  24 ++++--
 include/linux/fs.h                |   5 ++
 9 files changed, 136 insertions(+), 233 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 94e524f..2a8152d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -33,63 +33,13 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd)
 static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		struct nvme_smart_log *slog)
 {
-	u16 status;
-	struct nvmet_ns *ns;
-	u64 host_reads, host_writes, data_units_read, data_units_written;
-
-	status = NVME_SC_SUCCESS;
-	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->get_log_page.nsid);
-	if (!ns) {
-		status = NVME_SC_INVALID_NS;
-		pr_err("nvmet : Could not find namespace id : %d\n",
-				le32_to_cpu(req->cmd->get_log_page.nsid));
-		goto out;
-	}
-
-	host_reads = part_stat_read(ns->bdev->bd_part, ios[READ]);
-	data_units_read = part_stat_read(ns->bdev->bd_part, sectors[READ]);
-	host_writes = part_stat_read(ns->bdev->bd_part, ios[WRITE]);
-	data_units_written = part_stat_read(ns->bdev->bd_part, sectors[WRITE]);
-
-	put_unaligned_le64(host_reads, &slog->host_reads[0]);
-	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
-	put_unaligned_le64(host_writes, &slog->host_writes[0]);
-	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
-	nvmet_put_namespace(ns);
-out:
-	return status;
+	return NVME_SC_SUCCESS;
 }
 
 static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 		struct nvme_smart_log *slog)
 {
-	u16 status;
-	u64 host_reads = 0, host_writes = 0;
-	u64 data_units_read = 0, data_units_written = 0;
-	struct nvmet_ns *ns;
-	struct nvmet_ctrl *ctrl;
-
-	status = NVME_SC_SUCCESS;
-	ctrl = req->sq->ctrl;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
-		host_reads += part_stat_read(ns->bdev->bd_part, ios[READ]);
-		data_units_read +=
-			part_stat_read(ns->bdev->bd_part, sectors[READ]);
-		host_writes += part_stat_read(ns->bdev->bd_part, ios[WRITE]);
-		data_units_written +=
-			part_stat_read(ns->bdev->bd_part, sectors[WRITE]);
-
-	}
-	rcu_read_unlock();
-
-	put_unaligned_le64(host_reads, &slog->host_reads[0]);
-	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
-	put_unaligned_le64(host_writes, &slog->host_writes[0]);
-	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
-
-	return status;
+	return NVME_SC_SUCCESS;
 }
 
 static u16 nvmet_get_smart_log(struct nvmet_req *req,
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5267ce2..2489ccb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -43,14 +43,30 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 u16 nvmet_copy_to_sgl(struct nvmet_req *req, off_t off, const void *buf,
 		size_t len)
 {
-	if (sg_pcopy_from_buffer(req->sg, req->sg_cnt, buf, len, off) != len)
+	struct iov_iter iter;
+
+	if (!req->kvec || !req->vlen || !req->data_len || !len)
+		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+
+	iov_iter_kvec(&iter, ITER_KVEC, req->kvec, req->vlen, req->data_len);
+	iter.iov_offset = off;
+
+	if (copy_to_iter(buf, len, &iter) != len)
 		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
 	return 0;
 }
 
 u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf, size_t len)
 {
-	if (sg_pcopy_to_buffer(req->sg, req->sg_cnt, buf, len, off) != len)
+	struct iov_iter iter;
+
+	if (!req->kvec || !req->vlen || !req->data_len || !len)
+		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+
+	iov_iter_kvec(&iter, ITER_KVEC, req->kvec, req->vlen, req->data_len);
+	iter.iov_offset = off;
+
+	if (copy_from_iter(buf, len, &iter) != len)
 		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
 	return 0;
 }
@@ -268,18 +284,19 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->enabled)
 		goto out_unlock;
 
-	ns->bdev = blkdev_get_by_path(ns->device_path, FMODE_READ | FMODE_WRITE,
-			NULL);
-	if (IS_ERR(ns->bdev)) {
-		pr_err("nvmet: failed to open block device %s: (%ld)\n",
-			ns->device_path, PTR_ERR(ns->bdev));
-		ret = PTR_ERR(ns->bdev);
-		ns->bdev = NULL;
+	ns->filp = filp_open(ns->device_path, O_RDWR, 0);
+	if (IS_ERR(ns->filp)) {
+		pr_err("nvmet: failed to open backing device%s: (%ld)\n",
+			ns->device_path, PTR_ERR(ns->filp));
+		ret = PTR_ERR(ns->filp);
+		ns->filp = NULL;
 		goto out_unlock;
 	}
 
-	ns->size = i_size_read(ns->bdev->bd_inode);
-	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
+	ns->size = i_size_read(ns->filp->f_inode);
+	if (!ns->size && ns->filp->f_mapping && ns->filp->f_mapping->host)
+		ns->size = i_size_read(ns->filp->f_mapping->host);
+	ns->blksize_shift = ns->filp->f_inode->i_blkbits;
 
 	ret = percpu_ref_init(&ns->ref, nvmet_destroy_namespace,
 				0, GFP_KERNEL);
@@ -316,8 +333,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	mutex_unlock(&subsys->lock);
 	return ret;
 out_blkdev_put:
-	blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
-	ns->bdev = NULL;
+	filp_close(ns->filp, NULL);
+	ns->filp = NULL;
 	goto out_unlock;
 }
 
@@ -351,8 +368,10 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE, 0, 0);
 
-	if (ns->bdev)
-		blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
+	if (ns->filp) {
+		filp_close(ns->filp, NULL);
+		ns->filp = NULL;
+	}
 out_unlock:
 	mutex_unlock(&subsys->lock);
 }
@@ -473,8 +492,9 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->cq = cq;
 	req->sq = sq;
 	req->ops = ops;
-	req->sg = NULL;
-	req->sg_cnt = 0;
+	req->kvec = NULL;
+	req->vlen = 0;
+	req->data_len = 0;
 	req->rsp->status = 0;
 
 	/* no support for fused commands yet */
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 8bd022af..8f0868f 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -122,7 +122,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	struct nvmet_ctrl *ctrl = NULL;
 	u16 status = 0;
 
-	d = kmap(sg_page(req->sg)) + req->sg->offset;
+	d = req->kvec[0].iov_base;
 
 	/* zero out initial completion result, assign values as needed */
 	req->rsp->result.u32 = 0;
@@ -158,7 +158,6 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	req->rsp->result.u16 = cpu_to_le16(ctrl->cntlid);
 
 out:
-	kunmap(sg_page(req->sg));
 	nvmet_req_complete(req, status);
 }
 
@@ -170,7 +169,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	u16 qid = le16_to_cpu(c->qid);
 	u16 status = 0;
 
-	d = kmap(sg_page(req->sg)) + req->sg->offset;
+	d = req->kvec[0].iov_base;
 
 	/* zero out initial completion result, assign values as needed */
 	req->rsp->result.u32 = 0;
@@ -205,7 +204,6 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	pr_info("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
 
 out:
-	kunmap(sg_page(req->sg));
 	nvmet_req_complete(req, status);
 	return;
 
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 4195115..4c6a7df 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -13,146 +13,62 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/blkdev.h>
+#include <linux/falloc.h>
 #include <linux/module.h>
 #include "nvmet.h"
 
-static void nvmet_bio_done(struct bio *bio)
-{
-	struct nvmet_req *req = bio->bi_private;
-
-	nvmet_req_complete(req,
-		bio->bi_error ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
-
-	if (bio != &req->inline_bio)
-		bio_put(bio);
-}
-
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
 			req->ns->blksize_shift;
 }
 
-static void nvmet_inline_bio_init(struct nvmet_req *req)
-{
-	struct bio *bio = &req->inline_bio;
-
-	bio_init(bio, req->inline_bvec, NVMET_MAX_INLINE_BIOVEC);
-}
-
 static void nvmet_execute_rw(struct nvmet_req *req)
 {
-	int sg_cnt = req->sg_cnt;
-	struct scatterlist *sg;
-	struct bio *bio;
-	sector_t sector;
-	blk_qc_t cookie;
-	int op, op_flags = 0, i;
+	loff_t offset;
+	int ret;
 
-	if (!req->sg_cnt) {
+	if (!req->vlen) {
 		nvmet_req_complete(req, 0);
 		return;
 	}
 
-	if (req->cmd->rw.opcode == nvme_cmd_write) {
-		op = REQ_OP_WRITE;
-		op_flags = REQ_SYNC | REQ_IDLE;
-		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
-			op_flags |= REQ_FUA;
-	} else {
-		op = REQ_OP_READ;
-	}
+	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
+		flags |= RWF_DSYNC;
 
-	sector = le64_to_cpu(req->cmd->rw.slba);
-	sector <<= (req->ns->blksize_shift - 9);
-
-	nvmet_inline_bio_init(req);
-	bio = &req->inline_bio;
-	bio->bi_bdev = req->ns->bdev;
-	bio->bi_iter.bi_sector = sector;
-	bio->bi_private = req;
-	bio->bi_end_io = nvmet_bio_done;
-	bio_set_op_attrs(bio, op, op_flags);
-
-	for_each_sg(req->sg, sg, req->sg_cnt, i) {
-		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
-				!= sg->length) {
-			struct bio *prev = bio;
-
-			bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
-			bio->bi_bdev = req->ns->bdev;
-			bio->bi_iter.bi_sector = sector;
-			bio_set_op_attrs(bio, op, op_flags);
-
-			bio_chain(bio, prev);
-			cookie = submit_bio(prev);
-		}
-
-		sector += sg->length >> 9;
-		sg_cnt--;
-	}
+	offset = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
+	if (req->cmd->rw.opcode == nvme_cmd_write)
+		ret = kernel_writev(req->ns->filp, req->kvec, req->vlen,
+								offset);
+	else
+		ret = kernel_readv(req->ns->filp, req->kvec, req->vlen,
+								offset);
 
-	cookie = submit_bio(bio);
-
-	blk_mq_poll(bdev_get_queue(req->ns->bdev), cookie);
+	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
 }
 
 static void nvmet_execute_flush(struct nvmet_req *req)
 {
-	struct bio *bio;
-
-	nvmet_inline_bio_init(req);
-	bio = &req->inline_bio;
-
-	bio->bi_bdev = req->ns->bdev;
-	bio->bi_private = req;
-	bio->bi_end_io = nvmet_bio_done;
-	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
-
-	submit_bio(bio);
+	vfs_fsync(req->ns->filp, 0);
+	nvmet_req_complete(req, 0);
 }
 
-static u16 nvmet_discard_range(struct nvmet_ns *ns,
-		struct nvme_dsm_range *range, struct bio **bio)
-{
-	if (__blkdev_issue_discard(ns->bdev,
-			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
-			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
-			GFP_KERNEL, 0, bio))
-		return NVME_SC_INTERNAL | NVME_SC_DNR;
-	return 0;
-}
 
 static void nvmet_execute_discard(struct nvmet_req *req)
 {
 	struct nvme_dsm_range range;
-	struct bio *bio = NULL;
 	int i;
-	u16 status;
 
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
-		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
-				sizeof(range));
-		if (status)
+		if (nvmet_copy_from_sgl(req, i * sizeof(range), &range,
+			sizeof(range)))
 			break;
 
-		status = nvmet_discard_range(req->ns, &range, &bio);
-		if (status)
-			break;
-	}
-
-	if (bio) {
-		bio->bi_private = req;
-		bio->bi_end_io = nvmet_bio_done;
-		if (status) {
-			bio->bi_error = -EIO;
-			bio_endio(bio);
-		} else {
-			submit_bio(bio);
-		}
-	} else {
-		nvmet_req_complete(req, status);
+		vfs_fallocate(req->ns->filp, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			le64_to_cpu(range.slba) << req->ns->blksize_shift,
+			le32_to_cpu(range.nlb) << req->ns->blksize_shift);
 	}
+	nvmet_req_complete(req, 0);
 }
 
 static void nvmet_execute_dsm(struct nvmet_req *req)
@@ -173,27 +89,16 @@ static void nvmet_execute_dsm(struct nvmet_req *req)
 static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 {
 	struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
-	struct bio *bio = NULL;
-	u16 status = NVME_SC_SUCCESS;
 	sector_t sector;
 	sector_t nr_sector;
 
-	sector = le64_to_cpu(write_zeroes->slba) <<
-		(req->ns->blksize_shift - 9);
-	nr_sector = (((sector_t)le32_to_cpu(write_zeroes->length)) <<
-		(req->ns->blksize_shift - 9)) + 1;
-
-	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
-				GFP_KERNEL, &bio, true))
-		status = NVME_SC_INTERNAL | NVME_SC_DNR;
-
-	if (bio) {
-		bio->bi_private = req;
-		bio->bi_end_io = nvmet_bio_done;
-		submit_bio(bio);
-	} else {
-		nvmet_req_complete(req, status);
-	}
+	sector = le64_to_cpu(write_zeroes->slba) << req->ns->blksize_shift;
+	nr_sector = (((sector_t)le32_to_cpu(write_zeroes->length) + 1) <<
+							req->ns->blksize_shift);
+
+	vfs_fallocate(req->ns->filp, FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE,
+							sector, nr_sector);
+	nvmet_req_complete(req, 0);
 }
 
 int nvmet_parse_io_cmd(struct nvmet_req *req)
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d1f06e7..e6cc226 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -12,7 +12,6 @@
  * more details.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#include <linux/scatterlist.h>
 #include <linux/delay.h>
 #include <linux/blk-mq.h>
 #include <linux/nvme.h>
@@ -42,8 +41,6 @@ struct nvme_loop_iod {
 	struct nvmet_req	req;
 	struct nvme_loop_queue	*queue;
 	struct work_struct	work;
-	struct sg_table		sg_table;
-	struct scatterlist	first_sgl[];
 };
 
 struct nvme_loop_ctrl {
@@ -96,7 +93,6 @@ static void nvme_loop_complete_rq(struct request *req)
 	int error = 0;
 
 	nvme_cleanup_cmd(req);
-	sg_free_table_chained(&iod->sg_table, true);
 
 	if (unlikely(req->errors)) {
 		if (nvme_req_needs_retry(req, req->errors)) {
@@ -109,6 +105,7 @@ static void nvme_loop_complete_rq(struct request *req)
 		else
 			error = nvme_error_status(req->errors);
 	}
+	kfree(iod->req.kvec);
 
 	blk_mq_end_request(req, error);
 }
@@ -166,6 +163,7 @@ static int nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_loop_queue *queue = hctx->driver_data;
 	struct request *req = bd->rq;
 	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(req);
+	struct bio *bio = req->bio;
 	int ret;
 
 	ret = nvme_setup_cmd(ns, req, &iod->cmd);
@@ -183,16 +181,39 @@ static int nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	if (blk_rq_bytes(req)) {
-		iod->sg_table.sgl = iod->first_sgl;
-		ret = sg_alloc_table_chained(&iod->sg_table,
-				blk_rq_nr_phys_segments(req),
-				iod->sg_table.sgl);
-		if (ret)
+		int i = 0, nents = blk_rq_nr_phys_segments(req), prev = 0;
+		struct bio_vec bvec, bvprv = { NULL };
+		struct bvec_iter iter;
+
+		iod->req.kvec = kmalloc(nents * sizeof(struct kvec), GFP_ATOMIC);
+		if (!iod->req.kvec)
 			return BLK_MQ_RQ_QUEUE_BUSY;
 
-		iod->req.sg = iod->sg_table.sgl;
-		iod->req.sg_cnt = blk_rq_map_sg(req->q, req, iod->sg_table.sgl);
-	}
+		for_each_bio(bio) {
+			bio_for_each_segment(bvec, bio, iter) {
+				BUG_ON(i > nents);
+
+				if (prev) {
+					if (!BIOVEC_PHYS_MERGEABLE(&bvprv, &bvec))
+						goto new_segment;
+					iod->req.kvec[i].iov_len += bvec.bv_len;
+					bvprv = bvec;
+					continue;
+				}
+ new_segment:
+				iod->req.kvec[i].iov_base =
+						page_address(bvec.bv_page) +
+						bvec.bv_offset;
+				iod->req.kvec[i].iov_len = bvec.bv_len;
+				prev = 1;
+
+				i++;
+				bvprv = bvec;
+			}
+		}
+		iod->req.vlen = i;
+	} else
+		iod->req.kvec = NULL;
 
 	blk_mq_start_request(req);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 1370eee..e466636 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -41,7 +41,7 @@
 struct nvmet_ns {
 	struct list_head	dev_link;
 	struct percpu_ref	ref;
-	struct block_device	*bdev;
+	struct file		*filp;
 	u32			nsid;
 	u32			blksize_shift;
 	loff_t			size;
@@ -206,18 +206,14 @@ struct nvmet_fabrics_ops {
 	void (*delete_ctrl)(struct nvmet_ctrl *ctrl);
 };
 
-#define NVMET_MAX_INLINE_BIOVEC	8
-
 struct nvmet_req {
 	struct nvme_command	*cmd;
 	struct nvme_completion	*rsp;
 	struct nvmet_sq		*sq;
 	struct nvmet_cq		*cq;
 	struct nvmet_ns		*ns;
-	struct scatterlist	*sg;
-	struct bio		inline_bio;
-	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
-	int			sg_cnt;
+	struct kvec		*kvec;
+	int			vlen;
 	size_t			data_len;
 
 	struct nvmet_port	*port;
diff --git a/fs/exec.c b/fs/exec.c
index 698a860..cd45195 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -859,21 +859,17 @@ struct file *open_exec(const char *name)
 }
 EXPORT_SYMBOL(open_exec);
 
+
 int kernel_read(struct file *file, loff_t offset,
 		char *addr, unsigned long count)
 {
-	mm_segment_t old_fs;
-	loff_t pos = offset;
-	int result;
-
-	old_fs = get_fs();
-	set_fs(get_ds());
-	/* The cast to a user pointer is valid due to the set_fs() */
-	result = vfs_read(file, (void __user *)addr, count, &pos);
-	set_fs(old_fs);
-	return result;
-}
+	struct kvec vec = {
+		.iov_base = addr,
+		.iov_len = count,
+	};
 
+	return kernel_readv(file, &vec, 1, offset);
+}
 EXPORT_SYMBOL(kernel_read);
 
 int kernel_read_file(struct file *file, void **buf, loff_t *size,
diff --git a/fs/splice.c b/fs/splice.c
index 4ef78aa..5ac63cc 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -351,24 +351,24 @@ const struct pipe_buf_operations nosteal_pipe_buf_ops = {
 };
 EXPORT_SYMBOL(nosteal_pipe_buf_ops);
 
-static ssize_t kernel_readv(struct file *file, const struct kvec *vec,
+ssize_t kernel_readv(struct file *file, const struct kvec *vec,
 			    unsigned long vlen, loff_t offset)
 {
 	mm_segment_t old_fs;
-	loff_t pos = offset;
 	ssize_t res;
 
 	old_fs = get_fs();
 	set_fs(get_ds());
 	/* The cast to a user pointer is valid due to the set_fs() */
-	res = vfs_readv(file, (const struct iovec __user *)vec, vlen, &pos, 0);
+	res = vfs_readv(file, (const struct iovec __user *)vec, vlen, &offset, 0);
 	set_fs(old_fs);
 
 	return res;
 }
+EXPORT_SYMBOL(kernel_readv);
 
-ssize_t kernel_write(struct file *file, const char *buf, size_t count,
-			    loff_t pos)
+ssize_t kernel_writev(struct file *file, const struct kvec *vec,
+			    unsigned long vlen, loff_t offset)
 {
 	mm_segment_t old_fs;
 	ssize_t res;
@@ -376,11 +376,23 @@ ssize_t kernel_write(struct file *file, const char *buf, size_t count,
 	old_fs = get_fs();
 	set_fs(get_ds());
 	/* The cast to a user pointer is valid due to the set_fs() */
-	res = vfs_write(file, (__force const char __user *)buf, count, &pos);
+	res = vfs_writev(file, (const struct iovec __user *)vec, vlen, &offset, 0);
 	set_fs(old_fs);
 
 	return res;
 }
+EXPORT_SYMBOL(kernel_writev);
+
+ssize_t kernel_write(struct file *file, const char *buf, size_t count,
+			    loff_t pos)
+{
+	struct kvec vec = {
+		.iov_base = (void *)buf,
+		.iov_len = count,
+	};
+
+	return kernel_writev(file, &vec, 1, pos);
+}
 EXPORT_SYMBOL(kernel_write);
 
 static ssize_t default_file_splice_read(struct file *in, loff_t *ppos,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c930cbc..854eb68 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -31,6 +31,7 @@
 #include <linux/workqueue.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/delayed_call.h>
+#include <linux/uio.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -2654,6 +2655,8 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 }
 
 extern int kernel_read(struct file *, loff_t, char *, unsigned long);
+extern ssize_t kernel_readv(struct file *file, const struct kvec *vec,
+			    unsigned long vlen, loff_t offset);
 extern int kernel_read_file(struct file *, void **, loff_t *, loff_t,
 			    enum kernel_read_file_id);
 extern int kernel_read_file_from_path(char *, void **, loff_t *, loff_t,
@@ -2661,6 +2664,8 @@ extern int kernel_read_file_from_path(char *, void **, loff_t *, loff_t,
 extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
 				    enum kernel_read_file_id);
 extern ssize_t kernel_write(struct file *, const char *, size_t, loff_t);
+extern ssize_t kernel_writev(struct file *file, const struct kvec *vec,
+			    unsigned long vlen, loff_t offset);
 extern ssize_t __kernel_write(struct file *, const char *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
  
-- 
2.5.5
