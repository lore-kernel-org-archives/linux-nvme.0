From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Sat, 26 Sep 2015 18:35:10 -0700
Subject: [PATCH 1/4] nvme: move driver into subdirectory
Message-ID: <1443317710.4357.25.camel@linux.intel.com>

>From 16d464da995bb698a5045ac434d6c2f1efc5a346 Mon Sep 17 00:00:00 2001
From: Jay Sternberg <jay.e.sternberg@intel.com>
Date: Fri, 25 Sep 2015 10:14:17 -0700
Subject: [PATCH 1/4] nvme: move driver into subdirectory

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
---
 drivers/block/Kconfig       |   11 +-
 drivers/block/Makefile      |    3 +-
 drivers/block/nvme-core.c   | 3395 -----------------------------------
--------
 drivers/block/nvme-scsi.c   | 2556 --------------------------------
 drivers/block/nvme/Kconfig  |   10 +
 drivers/block/nvme/Makefile |    3 +
 drivers/block/nvme/core.c   | 3395
+++++++++++++++++++++++++++++++++++++++++++
 drivers/block/nvme/scsi.c   | 2556 ++++++++++++++++++++++++++++++++
 8 files changed, 5966 insertions(+), 5963 deletions(-)
 delete mode 100644 drivers/block/nvme-core.c
 delete mode 100644 drivers/block/nvme-scsi.c
 create mode 100644 drivers/block/nvme/Kconfig
 create mode 100644 drivers/block/nvme/Makefile
 create mode 100644 drivers/block/nvme/core.c
 create mode 100644 drivers/block/nvme/scsi.c

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 1b8094d..fda69ca 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -310,16 +310,7 @@ config BLK_DEV_NBD
 
 	  If unsure, say N.
 
-config BLK_DEV_NVME
-	tristate "NVM Express block device"
-	depends on PCI
-	---help---
-	  The NVM Express driver is for solid state drives directly
-	  connected to the PCI or PCI Express bus.  If you know you
-	  don't have one of these, it is safe to answer N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called nvme.
+source "drivers/block/nvme/Kconfig"
 
 config BLK_DEV_SKD
 	tristate "STEC S1120 Block Driver"
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 02b688d..b96a474 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_XILINX_SYSACE)	+= xsysace.o
 obj-$(CONFIG_CDROM_PKTCDVD)	+= pktcdvd.o
 obj-$(CONFIG_MG_DISK)		+= mg_disk.o
 obj-$(CONFIG_SUNVDC)		+= sunvdc.o
-obj-$(CONFIG_BLK_DEV_NVME)	+= nvme.o
+obj-$(CONFIG_BLK_DEV_NVME)	+= nvme/
 obj-$(CONFIG_BLK_DEV_SKD)	+= skd.o
 obj-$(CONFIG_BLK_DEV_OSD)	+= osdblk.o
 
@@ -44,6 +44,5 @@ obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 obj-$(CONFIG_ZRAM) += zram/
 
-nvme-y		:= nvme-core.o nvme-scsi.o
 skd-y		:= skd_main.o
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
deleted file mode 100644
index b97fc3f..0000000
--- a/drivers/block/nvme-core.c
+++ /dev/null
@@ -1,3395 +0,0 @@
-/*
- * NVM Express device driver
- * Copyright (c) 2011-2014, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or
modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but
WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
License for
- * more details.
- */
-
-#include <linux/nvme.h>
-#include <linux/bitops.h>
-#include <linux/blkdev.h>
-#include <linux/blk-mq.h>
-#include <linux/cpu.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/genhd.h>
-#include <linux/hdreg.h>
-#include <linux/idr.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/kdev_t.h>
-#include <linux/kthread.h>
-#include <linux/kernel.h>
-#include <linux/list_sort.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/pci.h>
-#include <linux/poison.h>
-#include <linux/ptrace.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/t10-pi.h>
-#include <linux/types.h>
-#include <scsi/sg.h>
-#include <asm-generic/io-64-nonatomic-lo-hi.h>
-
-#define NVME_MINORS		(1U << MINORBITS)
-#define NVME_Q_DEPTH		1024
-#define NVME_AQ_DEPTH		256
-#define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
-#define CQ_SIZE(depth)		(depth * sizeof(struct
nvme_completion))
-#define ADMIN_TIMEOUT		(admin_timeout * HZ)
-#define SHUTDOWN_TIMEOUT	(shutdown_timeout * HZ)
-
-static unsigned char admin_timeout = 60;
-module_param(admin_timeout, byte, 0644);
-MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin
commands");
-
-unsigned char nvme_io_timeout = 30;
-module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
-MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
-
-static unsigned char shutdown_timeout = 5;
-module_param(shutdown_timeout, byte, 0644);
-MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller
shutdown");
-
-static int nvme_major;
-module_param(nvme_major, int, 0);
-
-static int nvme_char_major;
-module_param(nvme_char_major, int, 0);
-
-static int use_threaded_interrupts;
-module_param(use_threaded_interrupts, int, 0);
-
-static bool use_cmb_sqes = true;
-module_param(use_cmb_sqes, bool, 0644);
-MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O
SQes");
-
-static DEFINE_SPINLOCK(dev_list_lock);
-static LIST_HEAD(dev_list);
-static struct task_struct *nvme_thread;
-static struct workqueue_struct *nvme_workq;
-static wait_queue_head_t nvme_kthread_wait;
-
-static struct class *nvme_class;
-
-static void nvme_reset_failed_dev(struct work_struct *ws);
-static int nvme_reset(struct nvme_dev *dev);
-static int nvme_process_cq(struct nvme_queue *nvmeq);
-
-struct async_cmd_info {
-	struct kthread_work work;
-	struct kthread_worker *worker;
-	struct request *req;
-	u32 result;
-	int status;
-	void *ctx;
-};
-
-/*
- * An NVM Express queue.  Each device has at least two (one for admin
- * commands and one for I/O commands).
- */
-struct nvme_queue {
-	struct device *q_dmadev;
-	struct nvme_dev *dev;
-	char irqname[24];	/* nvme4294967295-65535\0 */
-	spinlock_t q_lock;
-	struct nvme_command *sq_cmds;
-	struct nvme_command __iomem *sq_cmds_io;
-	volatile struct nvme_completion *cqes;
-	struct blk_mq_tags **tags;
-	dma_addr_t sq_dma_addr;
-	dma_addr_t cq_dma_addr;
-	u32 __iomem *q_db;
-	u16 q_depth;
-	s16 cq_vector;
-	u16 sq_head;
-	u16 sq_tail;
-	u16 cq_head;
-	u16 qid;
-	u8 cq_phase;
-	u8 cqe_seen;
-	struct async_cmd_info cmdinfo;
-};
-
-/*
- * Check we didin't inadvertently grow the command struct
- */
-static inline void _nvme_check_size(void)
-{
-	BUILD_BUG_ON(sizeof(struct nvme_rw_command) != 64);
-	BUILD_BUG_ON(sizeof(struct nvme_create_cq) != 64);
-	BUILD_BUG_ON(sizeof(struct nvme_create_sq) != 64);
-	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
-	BUILD_BUG_ON(sizeof(struct nvme_features) != 64);
-	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
-	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
-	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
-	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != 4096);
-	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
-	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
-	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
-}
-
-typedef void (*nvme_completion_fn)(struct nvme_queue *, void *,
-						struct nvme_completion
*);
-
-struct nvme_cmd_info {
-	nvme_completion_fn fn;
-	void *ctx;
-	int aborted;
-	struct nvme_queue *nvmeq;
-	struct nvme_iod iod[0];
-};
-
-/*
- * Max size of iod being embedded in the request payload
- */
-#define NVME_INT_PAGES		2
-#define NVME_INT_BYTES(dev)	(NVME_INT_PAGES * (dev)->page_size)
-#define NVME_INT_MASK		0x01
-
-/*
- * Will slightly overestimate the number of pages needed.  This is OK
- * as it only leads to a small amount of wasted memory for the
lifetime of
- * the I/O.
- */
-static int nvme_npages(unsigned size, struct nvme_dev *dev)
-{
-	unsigned nprps = DIV_ROUND_UP(size + dev->page_size, dev
->page_size);
-	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
-}
-
-static unsigned int nvme_cmd_size(struct nvme_dev *dev)
-{
-	unsigned int ret = sizeof(struct nvme_cmd_info);
-
-	ret += sizeof(struct nvme_iod);
-	ret += sizeof(__le64 *) * nvme_npages(NVME_INT_BYTES(dev),
dev);
-	ret += sizeof(struct scatterlist) * NVME_INT_PAGES;
-
-	return ret;
-}
-
-static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void
*data,
-				unsigned int hctx_idx)
-{
-	struct nvme_dev *dev = data;
-	struct nvme_queue *nvmeq = dev->queues[0];
-
-	WARN_ON(hctx_idx != 0);
-	WARN_ON(dev->admin_tagset.tags[0] != hctx->tags);
-	WARN_ON(nvmeq->tags);
-
-	hctx->driver_data = nvmeq;
-	nvmeq->tags = &dev->admin_tagset.tags[0];
-	return 0;
-}
-
-static void nvme_admin_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned
int hctx_idx)
-{
-	struct nvme_queue *nvmeq = hctx->driver_data;
-
-	nvmeq->tags = NULL;
-}
-
-static int nvme_admin_init_request(void *data, struct request *req,
-				unsigned int hctx_idx, unsigned int
rq_idx,
-				unsigned int numa_node)
-{
-	struct nvme_dev *dev = data;
-	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq = dev->queues[0];
-
-	BUG_ON(!nvmeq);
-	cmd->nvmeq = nvmeq;
-	return 0;
-}
-
-static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
-			  unsigned int hctx_idx)
-{
-	struct nvme_dev *dev = data;
-	struct nvme_queue *nvmeq = dev->queues[hctx_idx + 1];
-
-	if (!nvmeq->tags)
-		nvmeq->tags = &dev->tagset.tags[hctx_idx];
-
-	WARN_ON(dev->tagset.tags[hctx_idx] != hctx->tags);
-	hctx->driver_data = nvmeq;
-	return 0;
-}
-
-static int nvme_init_request(void *data, struct request *req,
-				unsigned int hctx_idx, unsigned int
rq_idx,
-				unsigned int numa_node)
-{
-	struct nvme_dev *dev = data;
-	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq = dev->queues[hctx_idx + 1];
-
-	BUG_ON(!nvmeq);
-	cmd->nvmeq = nvmeq;
-	return 0;
-}
-
-static void nvme_set_info(struct nvme_cmd_info *cmd, void *ctx,
-				nvme_completion_fn handler)
-{
-	cmd->fn = handler;
-	cmd->ctx = ctx;
-	cmd->aborted = 0;
-	blk_mq_start_request(blk_mq_rq_from_pdu(cmd));
-}
-
-static void *iod_get_private(struct nvme_iod *iod)
-{
-	return (void *) (iod->private & ~0x1UL);
-}
-
-/*
- * If bit 0 is set, the iod is embedded in the request payload.
- */
-static bool iod_should_kfree(struct nvme_iod *iod)
-{
-	return (iod->private & NVME_INT_MASK) == 0;
-}
-
-/* Special values must be less than 0x1000 */
-#define CMD_CTX_BASE		((void *)POISON_POINTER_DELTA)
-#define CMD_CTX_CANCELLED	(0x30C + CMD_CTX_BASE)
-#define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
-#define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
-
-static void special_completion(struct nvme_queue *nvmeq, void *ctx,
-						struct nvme_completion
*cqe)
-{
-	if (ctx == CMD_CTX_CANCELLED)
-		return;
-	if (ctx == CMD_CTX_COMPLETED) {
-		dev_warn(nvmeq->q_dmadev,
-				"completed id %d twice on queue %d\n",
-				cqe->command_id, le16_to_cpup(&cqe
->sq_id));
-		return;
-	}
-	if (ctx == CMD_CTX_INVALID) {
-		dev_warn(nvmeq->q_dmadev,
-				"invalid id %d completed on queue
%d\n",
-				cqe->command_id, le16_to_cpup(&cqe
->sq_id));
-		return;
-	}
-	dev_warn(nvmeq->q_dmadev, "Unknown special completion %p\n",
ctx);
-}
-
-static void *cancel_cmd_info(struct nvme_cmd_info *cmd,
nvme_completion_fn *fn)
-{
-	void *ctx;
-
-	if (fn)
-		*fn = cmd->fn;
-	ctx = cmd->ctx;
-	cmd->fn = special_completion;
-	cmd->ctx = CMD_CTX_CANCELLED;
-	return ctx;
-}
-
-static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
-						struct nvme_completion
*cqe)
-{
-	u32 result = le32_to_cpup(&cqe->result);
-	u16 status = le16_to_cpup(&cqe->status) >> 1;
-
-	if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ)
-		++nvmeq->dev->event_limit;
-	if (status != NVME_SC_SUCCESS)
-		return;
-
-	switch (result & 0xff07) {
-	case NVME_AER_NOTICE_NS_CHANGED:
-		dev_info(nvmeq->q_dmadev, "rescanning\n");
-		schedule_work(&nvmeq->dev->scan_work);
-	default:
-		dev_warn(nvmeq->q_dmadev, "async event result %08x\n",
result);
-	}
-}
-
-static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
-						struct nvme_completion
*cqe)
-{
-	struct request *req = ctx;
-
-	u16 status = le16_to_cpup(&cqe->status) >> 1;
-	u32 result = le32_to_cpup(&cqe->result);
-
-	blk_mq_free_request(req);
-
-	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x", status,
result);
-	++nvmeq->dev->abort_limit;
-}
-
-static void async_completion(struct nvme_queue *nvmeq, void *ctx,
-						struct nvme_completion
*cqe)
-{
-	struct async_cmd_info *cmdinfo = ctx;
-	cmdinfo->result = le32_to_cpup(&cqe->result);
-	cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
-	queue_kthread_work(cmdinfo->worker, &cmdinfo->work);
-	blk_mq_free_request(cmdinfo->req);
-}
-
-static inline struct nvme_cmd_info *get_cmd_from_tag(struct nvme_queue
*nvmeq,
-				  unsigned int tag)
-{
-	struct request *req = blk_mq_tag_to_rq(*nvmeq->tags, tag);
-
-	return blk_mq_rq_to_pdu(req);
-}
-
-/*
- * Called with local interrupts disabled and the q_lock held.  May not
sleep.
- */
-static void *nvme_finish_cmd(struct nvme_queue *nvmeq, int tag,
-						nvme_completion_fn
*fn)
-{
-	struct nvme_cmd_info *cmd = get_cmd_from_tag(nvmeq, tag);
-	void *ctx;
-	if (tag >= nvmeq->q_depth) {
-		*fn = special_completion;
-		return CMD_CTX_INVALID;
-	}
-	if (fn)
-		*fn = cmd->fn;
-	ctx = cmd->ctx;
-	cmd->fn = special_completion;
-	cmd->ctx = CMD_CTX_COMPLETED;
-	return ctx;
-}
-
-/**
- * nvme_submit_cmd() - Copy a command into a queue and ring the
doorbell
- * @nvmeq: The queue to use
- * @cmd: The command to send
- *
- * Safe to use from interrupt context
- */
-static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
-						struct nvme_command
*cmd)
-{
-	u16 tail = nvmeq->sq_tail;
-
-	if (nvmeq->sq_cmds_io)
-		memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd,
sizeof(*cmd));
-	else
-		memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
-
-	if (++tail == nvmeq->q_depth)
-		tail = 0;
-	writel(tail, nvmeq->q_db);
-	nvmeq->sq_tail = tail;
-}
-
-static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct
nvme_command *cmd)
-{
-	unsigned long flags;
-	spin_lock_irqsave(&nvmeq->q_lock, flags);
-	__nvme_submit_cmd(nvmeq, cmd);
-	spin_unlock_irqrestore(&nvmeq->q_lock, flags);
-}
-
-static __le64 **iod_list(struct nvme_iod *iod)
-{
-	return ((void *)iod) + iod->offset;
-}
-
-static inline void iod_init(struct nvme_iod *iod, unsigned nbytes,
-			    unsigned nseg, unsigned long private)
-{
-	iod->private = private;
-	iod->offset = offsetof(struct nvme_iod, sg[nseg]);
-	iod->npages = -1;
-	iod->length = nbytes;
-	iod->nents = 0;
-}
-
-static struct nvme_iod *
-__nvme_alloc_iod(unsigned nseg, unsigned bytes, struct nvme_dev *dev,
-		 unsigned long priv, gfp_t gfp)
-{
-	struct nvme_iod *iod = kmalloc(sizeof(struct nvme_iod) +
-				sizeof(__le64 *) * nvme_npages(bytes,
dev) +
-				sizeof(struct scatterlist) * nseg,
gfp);
-
-	if (iod)
-		iod_init(iod, bytes, nseg, priv);
-
-	return iod;
-}
-
-static struct nvme_iod *nvme_alloc_iod(struct request *rq, struct
nvme_dev *dev,
-			               gfp_t gfp)
-{
-	unsigned size = !(rq->cmd_flags & REQ_DISCARD) ?
blk_rq_bytes(rq) :
-                                                sizeof(struct
nvme_dsm_range);
-	struct nvme_iod *iod;
-
-	if (rq->nr_phys_segments <= NVME_INT_PAGES &&
-	    size <= NVME_INT_BYTES(dev)) {
-		struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(rq);
-
-		iod = cmd->iod;
-		iod_init(iod, size, rq->nr_phys_segments,
-				(unsigned long) rq | NVME_INT_MASK);
-		return iod;
-	}
-
-	return __nvme_alloc_iod(rq->nr_phys_segments, size, dev,
-				(unsigned long) rq, gfp);
-}
-
-static void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
-{
-	const int last_prp = dev->page_size / 8 - 1;
-	int i;
-	__le64 **list = iod_list(iod);
-	dma_addr_t prp_dma = iod->first_dma;
-
-	if (iod->npages == 0)
-		dma_pool_free(dev->prp_small_pool, list[0], prp_dma);
-	for (i = 0; i < iod->npages; i++) {
-		__le64 *prp_list = list[i];
-		dma_addr_t next_prp_dma =
le64_to_cpu(prp_list[last_prp]);
-		dma_pool_free(dev->prp_page_pool, prp_list, prp_dma);
-		prp_dma = next_prp_dma;
-	}
-
-	if (iod_should_kfree(iod))
-		kfree(iod);
-}
-
-static int nvme_error_status(u16 status)
-{
-	switch (status & 0x7ff) {
-	case NVME_SC_SUCCESS:
-		return 0;
-	case NVME_SC_CAP_EXCEEDED:
-		return -ENOSPC;
-	default:
-		return -EIO;
-	}
-}
-
-#ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_dif_prep(u32 p, u32 v, struct t10_pi_tuple *pi)
-{
-	if (be32_to_cpu(pi->ref_tag) == v)
-		pi->ref_tag = cpu_to_be32(p);
-}
-
-static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
-{
-	if (be32_to_cpu(pi->ref_tag) == p)
-		pi->ref_tag = cpu_to_be32(v);
-}
-
-/**
- * nvme_dif_remap - remaps ref tags to bip seed and physical lba
- *
- * The virtual start sector is the one that was originally submitted
by the
- * block layer.	Due to partitioning, MD/DM cloning, etc. the
actual physical
- * start sector may be different. Remap protection information to
match the
- * physical LBA on writes, and back to the original seed on reads.
- *
- * Type 0 and 3 do not have a ref tag, so no remapping required.
- */
-static void nvme_dif_remap(struct request *req,
-			void (*dif_swap)(u32 p, u32 v, struct
t10_pi_tuple *pi))
-{
-	struct nvme_ns *ns = req->rq_disk->private_data;
-	struct bio_integrity_payload *bip;
-	struct t10_pi_tuple *pi;
-	void *p, *pmap;
-	u32 i, nlb, ts, phys, virt;
-
-	if (!ns->pi_type || ns->pi_type == NVME_NS_DPS_PI_TYPE3)
-		return;
-
-	bip = bio_integrity(req->bio);
-	if (!bip)
-		return;
-
-	pmap = kmap_atomic(bip->bip_vec->bv_page) + bip->bip_vec
->bv_offset;
-
-	p = pmap;
-	virt = bip_get_seed(bip);
-	phys = nvme_block_nr(ns, blk_rq_pos(req));
-	nlb = (blk_rq_bytes(req) >> ns->lba_shift);
-	ts = ns->disk->integrity->tuple_size;
-
-	for (i = 0; i < nlb; i++, virt++, phys++) {
-		pi = (struct t10_pi_tuple *)p;
-		dif_swap(phys, virt, pi);
-		p += ts;
-	}
-	kunmap_atomic(pmap);
-}
-
-static int nvme_noop_verify(struct blk_integrity_iter *iter)
-{
-	return 0;
-}
-
-static int nvme_noop_generate(struct blk_integrity_iter *iter)
-{
-	return 0;
-}
-
-struct blk_integrity nvme_meta_noop = {
-	.name			= "NVME_META_NOOP",
-	.generate_fn		= nvme_noop_generate,
-	.verify_fn		= nvme_noop_verify,
-};
-
-static void nvme_init_integrity(struct nvme_ns *ns)
-{
-	struct blk_integrity integrity;
-
-	switch (ns->pi_type) {
-	case NVME_NS_DPS_PI_TYPE3:
-		integrity = t10_pi_type3_crc;
-		break;
-	case NVME_NS_DPS_PI_TYPE1:
-	case NVME_NS_DPS_PI_TYPE2:
-		integrity = t10_pi_type1_crc;
-		break;
-	default:
-		integrity = nvme_meta_noop;
-		break;
-	}
-	integrity.tuple_size = ns->ms;
-	blk_integrity_register(ns->disk, &integrity);
-	blk_queue_max_integrity_segments(ns->queue, 1);
-}
-#else /* CONFIG_BLK_DEV_INTEGRITY */
-static void nvme_dif_remap(struct request *req,
-			void (*dif_swap)(u32 p, u32 v, struct
t10_pi_tuple *pi))
-{
-}
-static void nvme_dif_prep(u32 p, u32 v, struct t10_pi_tuple *pi)
-{
-}
-static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
-{
-}
-static void nvme_init_integrity(struct nvme_ns *ns)
-{
-}
-#endif
-
-static void req_completion(struct nvme_queue *nvmeq, void *ctx,
-						struct nvme_completion
*cqe)
-{
-	struct nvme_iod *iod = ctx;
-	struct request *req = iod_get_private(iod);
-	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
-
-	u16 status = le16_to_cpup(&cqe->status) >> 1;
-
-	if (unlikely(status)) {
-		if (!(status & NVME_SC_DNR ||
blk_noretry_request(req))
-		    && (jiffies - req->start_time) < req->timeout) {
-			unsigned long flags;
-
-			blk_mq_requeue_request(req);
-			spin_lock_irqsave(req->q->queue_lock, flags);
-			if (!blk_queue_stopped(req->q))
-				blk_mq_kick_requeue_list(req->q);
-			spin_unlock_irqrestore(req->q->queue_lock,
flags);
-			return;
-		}
-		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
-			if (cmd_rq->ctx == CMD_CTX_CANCELLED)
-				req->errors = -EINTR;
-			else
-				req->errors = status;
-		} else {
-			req->errors = nvme_error_status(status);
-		}
-	} else
-		req->errors = 0;
-	if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
-		u32 result = le32_to_cpup(&cqe->result);
-		req->special = (void *)(uintptr_t)result;
-	}
-
-	if (cmd_rq->aborted)
-		dev_warn(nvmeq->dev->dev,
-			"completing aborted command with
status:%04x\n",
-			status);
-
-	if (iod->nents) {
-		dma_unmap_sg(nvmeq->dev->dev, iod->sg, iod->nents,
-			rq_data_dir(req) ? DMA_TO_DEVICE :
DMA_FROM_DEVICE);
-		if (blk_integrity_rq(req)) {
-			if (!rq_data_dir(req))
-				nvme_dif_remap(req,
nvme_dif_complete);
-			dma_unmap_sg(nvmeq->dev->dev, iod->meta_sg, 1,
-				rq_data_dir(req) ? DMA_TO_DEVICE :
DMA_FROM_DEVICE);
-		}
-	}
-	nvme_free_iod(nvmeq->dev, iod);
-
-	blk_mq_complete_request(req);
-}
-
-/* length is in bytes.  gfp flags indicates whether we may sleep. */
-static int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
-		int total_len, gfp_t gfp)
-{
-	struct dma_pool *pool;
-	int length = total_len;
-	struct scatterlist *sg = iod->sg;
-	int dma_len = sg_dma_len(sg);
-	u64 dma_addr = sg_dma_address(sg);
-	u32 page_size = dev->page_size;
-	int offset = dma_addr & (page_size - 1);
-	__le64 *prp_list;
-	__le64 **list = iod_list(iod);
-	dma_addr_t prp_dma;
-	int nprps, i;
-
-	length -= (page_size - offset);
-	if (length <= 0)
-		return total_len;
-
-	dma_len -= (page_size - offset);
-	if (dma_len) {
-		dma_addr += (page_size - offset);
-	} else {
-		sg = sg_next(sg);
-		dma_addr = sg_dma_address(sg);
-		dma_len = sg_dma_len(sg);
-	}
-
-	if (length <= page_size) {
-		iod->first_dma = dma_addr;
-		return total_len;
-	}
-
-	nprps = DIV_ROUND_UP(length, page_size);
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
-		return (total_len - length) + page_size;
-	}
-	list[0] = prp_list;
-	iod->first_dma = prp_dma;
-	i = 0;
-	for (;;) {
-		if (i == page_size >> 3) {
-			__le64 *old_prp_list = prp_list;
-			prp_list = dma_pool_alloc(pool, gfp,
&prp_dma);
-			if (!prp_list)
-				return total_len - length;
-			list[iod->npages++] = prp_list;
-			prp_list[0] = old_prp_list[i - 1];
-			old_prp_list[i - 1] = cpu_to_le64(prp_dma);
-			i = 1;
-		}
-		prp_list[i++] = cpu_to_le64(dma_addr);
-		dma_len -= page_size;
-		dma_addr += page_size;
-		length -= page_size;
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
-static void nvme_submit_priv(struct nvme_queue *nvmeq, struct request
*req,
-		struct nvme_iod *iod)
-{
-	struct nvme_command cmnd;
-
-	memcpy(&cmnd, req->cmd, sizeof(cmnd));
-	cmnd.rw.command_id = req->tag;
-	if (req->nr_phys_segments) {
-		cmnd.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
-		cmnd.rw.prp2 = cpu_to_le64(iod->first_dma);
-	}
-
-	__nvme_submit_cmd(nvmeq, &cmnd);
-}
-
-/*
- * We reuse the small pool to allocate the 16-byte range here as it is
not
- * worth having a special pool for these or additional cases to handle
freeing
- * the iod.
- */
-static void nvme_submit_discard(struct nvme_queue *nvmeq, struct
nvme_ns *ns,
-		struct request *req, struct nvme_iod *iod)
-{
-	struct nvme_dsm_range *range =
-				(struct nvme_dsm_range
*)iod_list(iod)[0];
-	struct nvme_command cmnd;
-
-	range->cattr = cpu_to_le32(0);
-	range->nlb = cpu_to_le32(blk_rq_bytes(req) >> ns->lba_shift);
-	range->slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
-
-	memset(&cmnd, 0, sizeof(cmnd));
-	cmnd.dsm.opcode = nvme_cmd_dsm;
-	cmnd.dsm.command_id = req->tag;
-	cmnd.dsm.nsid = cpu_to_le32(ns->ns_id);
-	cmnd.dsm.prp1 = cpu_to_le64(iod->first_dma);
-	cmnd.dsm.nr = 0;
-	cmnd.dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
-
-	__nvme_submit_cmd(nvmeq, &cmnd);
-}
-
-static void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns
*ns,
-								int
cmdid)
-{
-	struct nvme_command cmnd;
-
-	memset(&cmnd, 0, sizeof(cmnd));
-	cmnd.common.opcode = nvme_cmd_flush;
-	cmnd.common.command_id = cmdid;
-	cmnd.common.nsid = cpu_to_le32(ns->ns_id);
-
-	__nvme_submit_cmd(nvmeq, &cmnd);
-}
-
-static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod
*iod,
-							struct nvme_ns
*ns)
-{
-	struct request *req = iod_get_private(iod);
-	struct nvme_command cmnd;
-	u16 control = 0;
-	u32 dsmgmt = 0;
-
-	if (req->cmd_flags & REQ_FUA)
-		control |= NVME_RW_FUA;
-	if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
-		control |= NVME_RW_LR;
-
-	if (req->cmd_flags & REQ_RAHEAD)
-		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
-
-	memset(&cmnd, 0, sizeof(cmnd));
-	cmnd.rw.opcode = (rq_data_dir(req) ? nvme_cmd_write :
nvme_cmd_read);
-	cmnd.rw.command_id = req->tag;
-	cmnd.rw.nsid = cpu_to_le32(ns->ns_id);
-	cmnd.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
-	cmnd.rw.prp2 = cpu_to_le64(iod->first_dma);
-	cmnd.rw.slba = cpu_to_le64(nvme_block_nr(ns,
blk_rq_pos(req)));
-	cmnd.rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns
->lba_shift) - 1);
-
-	if (ns->ms) {
-		switch (ns->pi_type) {
-		case NVME_NS_DPS_PI_TYPE3:
-			control |= NVME_RW_PRINFO_PRCHK_GUARD;
-			break;
-		case NVME_NS_DPS_PI_TYPE1:
-		case NVME_NS_DPS_PI_TYPE2:
-			control |= NVME_RW_PRINFO_PRCHK_GUARD |
-					NVME_RW_PRINFO_PRCHK_REF;
-			cmnd.rw.reftag = cpu_to_le32(
-					nvme_block_nr(ns,
blk_rq_pos(req)));
-			break;
-		}
-		if (blk_integrity_rq(req))
-			cmnd.rw.metadata =
-				cpu_to_le64(sg_dma_address(iod
->meta_sg));
-		else
-			control |= NVME_RW_PRINFO_PRACT;
-	}
-
-	cmnd.rw.control = cpu_to_le16(control);
-	cmnd.rw.dsmgmt = cpu_to_le32(dsmgmt);
-
-	__nvme_submit_cmd(nvmeq, &cmnd);
-
-	return 0;
-}
-
-/*
- * NOTE: ns is NULL when called on the admin queue.
- */
-static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
-			 const struct blk_mq_queue_data *bd)
-{
-	struct nvme_ns *ns = hctx->queue->queuedata;
-	struct nvme_queue *nvmeq = hctx->driver_data;
-	struct nvme_dev *dev = nvmeq->dev;
-	struct request *req = bd->rq;
-	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
-	struct nvme_iod *iod;
-	enum dma_data_direction dma_dir;
-
-	/*
-	 * If formated with metadata, require the block layer provide
a buffer
-	 * unless this namespace is formated such that the metadata
can be
-	 * stripped/generated by the controller with PRACT=1.
-	 */
-	if (ns && ns->ms && !blk_integrity_rq(req)) {
-		if (!(ns->pi_type && ns->ms == 8) &&
-					req->cmd_type !=
REQ_TYPE_DRV_PRIV) {
-			req->errors = -EFAULT;
-			blk_mq_complete_request(req);
-			return BLK_MQ_RQ_QUEUE_OK;
-		}
-	}
-
-	iod = nvme_alloc_iod(req, dev, GFP_ATOMIC);
-	if (!iod)
-		return BLK_MQ_RQ_QUEUE_BUSY;
-
-	if (req->cmd_flags & REQ_DISCARD) {
-		void *range;
-		/*
-		 * We reuse the small pool to allocate the 16-byte
range here
-		 * as it is not worth having a special pool for these
or
-		 * additional cases to handle freeing the iod.
-		 */
-		range = dma_pool_alloc(dev->prp_small_pool,
GFP_ATOMIC,
-						&iod->first_dma);
-		if (!range)
-			goto retry_cmd;
-		iod_list(iod)[0] = (__le64 *)range;
-		iod->npages = 0;
-	} else if (req->nr_phys_segments) {
-		dma_dir = rq_data_dir(req) ? DMA_TO_DEVICE :
DMA_FROM_DEVICE;
-
-		sg_init_table(iod->sg, req->nr_phys_segments);
-		iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
-		if (!iod->nents)
-			goto error_cmd;
-
-		if (!dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents,
dma_dir))
-			goto retry_cmd;
-
-		if (blk_rq_bytes(req) !=
-                    nvme_setup_prps(dev, iod, blk_rq_bytes(req),
GFP_ATOMIC)) {
-			dma_unmap_sg(dev->dev, iod->sg, iod->nents,
dma_dir);
-			goto retry_cmd;
-		}
-		if (blk_integrity_rq(req)) {
-			if (blk_rq_count_integrity_sg(req->q, req
->bio) != 1)
-				goto error_cmd;
-
-			sg_init_table(iod->meta_sg, 1);
-			if (blk_rq_map_integrity_sg(
-					req->q, req->bio, iod
->meta_sg) != 1)
-				goto error_cmd;
-
-			if (rq_data_dir(req))
-				nvme_dif_remap(req, nvme_dif_prep);
-
-			if (!dma_map_sg(nvmeq->q_dmadev, iod->meta_sg,
1, dma_dir))
-				goto error_cmd;
-		}
-	}
-
-	nvme_set_info(cmd, iod, req_completion);
-	spin_lock_irq(&nvmeq->q_lock);
-	if (req->cmd_type == REQ_TYPE_DRV_PRIV)
-		nvme_submit_priv(nvmeq, req, iod);
-	else if (req->cmd_flags & REQ_DISCARD)
-		nvme_submit_discard(nvmeq, ns, req, iod);
-	else if (req->cmd_flags & REQ_FLUSH)
-		nvme_submit_flush(nvmeq, ns, req->tag);
-	else
-		nvme_submit_iod(nvmeq, iod, ns);
-
-	nvme_process_cq(nvmeq);
-	spin_unlock_irq(&nvmeq->q_lock);
-	return BLK_MQ_RQ_QUEUE_OK;
-
- error_cmd:
-	nvme_free_iod(dev, iod);
-	return BLK_MQ_RQ_QUEUE_ERROR;
- retry_cmd:
-	nvme_free_iod(dev, iod);
-	return BLK_MQ_RQ_QUEUE_BUSY;
-}
-
-static int nvme_process_cq(struct nvme_queue *nvmeq)
-{
-	u16 head, phase;
-
-	head = nvmeq->cq_head;
-	phase = nvmeq->cq_phase;
-
-	for (;;) {
-		void *ctx;
-		nvme_completion_fn fn;
-		struct nvme_completion cqe = nvmeq->cqes[head];
-		if ((le16_to_cpu(cqe.status) & 1) != phase)
-			break;
-		nvmeq->sq_head = le16_to_cpu(cqe.sq_head);
-		if (++head == nvmeq->q_depth) {
-			head = 0;
-			phase = !phase;
-		}
-		ctx = nvme_finish_cmd(nvmeq, cqe.command_id, &fn);
-		fn(nvmeq, ctx, &cqe);
-	}
-
-	/* If the controller ignores the cq head doorbell and
continuously
-	 * writes to the queue, it is theoretically possible to wrap
around
-	 * the queue twice and mistakenly return IRQ_NONE.  Linux only
-	 * requires that 0.1% of your interrupts are handled, so this
isn't
-	 * a big problem.
-	 */
-	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
-		return 0;
-
-	writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
-	nvmeq->cq_head = head;
-	nvmeq->cq_phase = phase;
-
-	nvmeq->cqe_seen = 1;
-	return 1;
-}
-
-static irqreturn_t nvme_irq(int irq, void *data)
-{
-	irqreturn_t result;
-	struct nvme_queue *nvmeq = data;
-	spin_lock(&nvmeq->q_lock);
-	nvme_process_cq(nvmeq);
-	result = nvmeq->cqe_seen ? IRQ_HANDLED : IRQ_NONE;
-	nvmeq->cqe_seen = 0;
-	spin_unlock(&nvmeq->q_lock);
-	return result;
-}
-
-static irqreturn_t nvme_irq_check(int irq, void *data)
-{
-	struct nvme_queue *nvmeq = data;
-	struct nvme_completion cqe = nvmeq->cqes[nvmeq->cq_head];
-	if ((le16_to_cpu(cqe.status) & 1) != nvmeq->cq_phase)
-		return IRQ_NONE;
-	return IRQ_WAKE_THREAD;
-}
-
-/*
- * Returns 0 on success.  If the result is negative, it's a Linux
error code;
- * if the result is positive, it's an NVM Express status code
- */
-int __nvme_submit_sync_cmd(struct request_queue *q, struct
nvme_command *cmd,
-		void *buffer, void __user *ubuffer, unsigned bufflen,
-		u32 *result, unsigned timeout)
-{
-	bool write = cmd->common.opcode & 1;
-	struct bio *bio = NULL;
-	struct request *req;
-	int ret;
-
-	req = blk_mq_alloc_request(q, write, GFP_KERNEL, false);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	req->cmd_type = REQ_TYPE_DRV_PRIV;
-	req->cmd_flags |= REQ_FAILFAST_DRIVER;
-	req->__data_len = 0;
-	req->__sector = (sector_t) -1;
-	req->bio = req->biotail = NULL;
-
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
-
-	req->cmd = (unsigned char *)cmd;
-	req->cmd_len = sizeof(struct nvme_command);
-	req->special = (void *)0;
-
-	if (buffer && bufflen) {
-		ret = blk_rq_map_kern(q, req, buffer, bufflen,
__GFP_WAIT);
-		if (ret)
-			goto out;
-	} else if (ubuffer && bufflen) {
-		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
__GFP_WAIT);
-		if (ret)
-			goto out;
-		bio = req->bio;
-	}
-
-	blk_execute_rq(req->q, NULL, req, 0);
-	if (bio)
-		blk_rq_unmap_user(bio);
-	if (result)
-		*result = (u32)(uintptr_t)req->special;
-	ret = req->errors;
- out:
-	blk_mq_free_request(req);
-	return ret;
-}
-
-int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command
*cmd,
-		void *buffer, unsigned bufflen)
-{
-	return __nvme_submit_sync_cmd(q, cmd, buffer, NULL, bufflen,
NULL, 0);
-}
-
-static int nvme_submit_async_admin_req(struct nvme_dev *dev)
-{
-	struct nvme_queue *nvmeq = dev->queues[0];
-	struct nvme_command c;
-	struct nvme_cmd_info *cmd_info;
-	struct request *req;
-
-	req = blk_mq_alloc_request(dev->admin_q, WRITE, GFP_ATOMIC,
true);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	req->cmd_flags |= REQ_NO_TIMEOUT;
-	cmd_info = blk_mq_rq_to_pdu(req);
-	nvme_set_info(cmd_info, NULL, async_req_completion);
-
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = nvme_admin_async_event;
-	c.common.command_id = req->tag;
-
-	blk_mq_free_request(req);
-	__nvme_submit_cmd(nvmeq, &c);
-	return 0;
-}
-
-static int nvme_submit_admin_async_cmd(struct nvme_dev *dev,
-			struct nvme_command *cmd,
-			struct async_cmd_info *cmdinfo, unsigned
timeout)
-{
-	struct nvme_queue *nvmeq = dev->queues[0];
-	struct request *req;
-	struct nvme_cmd_info *cmd_rq;
-
-	req = blk_mq_alloc_request(dev->admin_q, WRITE, GFP_KERNEL,
false);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	req->timeout = timeout;
-	cmd_rq = blk_mq_rq_to_pdu(req);
-	cmdinfo->req = req;
-	nvme_set_info(cmd_rq, cmdinfo, async_completion);
-	cmdinfo->status = -EINTR;
-
-	cmd->common.command_id = req->tag;
-
-	nvme_submit_cmd(nvmeq, cmd);
-	return 0;
-}
-
-static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16
id)
-{
-	struct nvme_command c;
-
-	memset(&c, 0, sizeof(c));
-	c.delete_queue.opcode = opcode;
-	c.delete_queue.qid = cpu_to_le16(id);
-
-	return nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0);
-}
-
-static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
-						struct nvme_queue
*nvmeq)
-{
-	struct nvme_command c;
-	int flags = NVME_QUEUE_PHYS_CONTIG | NVME_CQ_IRQ_ENABLED;
-
-	/*
-	 * Note: we (ab)use the fact the the prp fields survive if no
data
-	 * is attached to the request.
-	 */
-	memset(&c, 0, sizeof(c));
-	c.create_cq.opcode = nvme_admin_create_cq;
-	c.create_cq.prp1 = cpu_to_le64(nvmeq->cq_dma_addr);
-	c.create_cq.cqid = cpu_to_le16(qid);
-	c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
-	c.create_cq.cq_flags = cpu_to_le16(flags);
-	c.create_cq.irq_vector = cpu_to_le16(nvmeq->cq_vector);
-
-	return nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0);
-}
-
-static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
-						struct nvme_queue
*nvmeq)
-{
-	struct nvme_command c;
-	int flags = NVME_QUEUE_PHYS_CONTIG | NVME_SQ_PRIO_MEDIUM;
-
-	/*
-	 * Note: we (ab)use the fact the the prp fields survive if no
data
-	 * is attached to the request.
-	 */
-	memset(&c, 0, sizeof(c));
-	c.create_sq.opcode = nvme_admin_create_sq;
-	c.create_sq.prp1 = cpu_to_le64(nvmeq->sq_dma_addr);
-	c.create_sq.sqid = cpu_to_le16(qid);
-	c.create_sq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
-	c.create_sq.sq_flags = cpu_to_le16(flags);
-	c.create_sq.cqid = cpu_to_le16(qid);
-
-	return nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0);
-}
-
-static int adapter_delete_cq(struct nvme_dev *dev, u16 cqid)
-{
-	return adapter_delete_queue(dev, nvme_admin_delete_cq, cqid);
-}
-
-static int adapter_delete_sq(struct nvme_dev *dev, u16 sqid)
-{
-	return adapter_delete_queue(dev, nvme_admin_delete_sq, sqid);
-}
-
-int nvme_identify_ctrl(struct nvme_dev *dev, struct nvme_id_ctrl **id)
-{
-	struct nvme_command c = { };
-	int error;
-
-	/* gcc-4.4.4 (at least) has issues with initializers and anon
unions */
-	c.identify.opcode = nvme_admin_identify;
-	c.identify.cns = cpu_to_le32(1);
-
-	*id = kmalloc(sizeof(struct nvme_id_ctrl), GFP_KERNEL);
-	if (!*id)
-		return -ENOMEM;
-
-	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
-			sizeof(struct nvme_id_ctrl));
-	if (error)
-		kfree(*id);
-	return error;
-}
-
-int nvme_identify_ns(struct nvme_dev *dev, unsigned nsid,
-		struct nvme_id_ns **id)
-{
-	struct nvme_command c = { };
-	int error;
-
-	/* gcc-4.4.4 (at least) has issues with initializers and anon
unions */
-	c.identify.opcode = nvme_admin_identify,
-	c.identify.nsid = cpu_to_le32(nsid),
-
-	*id = kmalloc(sizeof(struct nvme_id_ns), GFP_KERNEL);
-	if (!*id)
-		return -ENOMEM;
-
-	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
-			sizeof(struct nvme_id_ns));
-	if (error)
-		kfree(*id);
-	return error;
-}
-
-int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned
nsid,
-					dma_addr_t dma_addr, u32
*result)
-{
-	struct nvme_command c;
-
-	memset(&c, 0, sizeof(c));
-	c.features.opcode = nvme_admin_get_features;
-	c.features.nsid = cpu_to_le32(nsid);
-	c.features.prp1 = cpu_to_le64(dma_addr);
-	c.features.fid = cpu_to_le32(fid);
-
-	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, NULL, 0,
-			result, 0);
-}
-
-int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned
dword11,
-					dma_addr_t dma_addr, u32
*result)
-{
-	struct nvme_command c;
-
-	memset(&c, 0, sizeof(c));
-	c.features.opcode = nvme_admin_set_features;
-	c.features.prp1 = cpu_to_le64(dma_addr);
-	c.features.fid = cpu_to_le32(fid);
-	c.features.dword11 = cpu_to_le32(dword11);
-
-	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, NULL, 0,
-			result, 0);
-}
-
-int nvme_get_log_page(struct nvme_dev *dev, struct nvme_smart_log
**log)
-{
-	struct nvme_command c = { };
-	int error;
-
-	c.common.opcode = nvme_admin_get_log_page,
-	c.common.nsid = cpu_to_le32(0xFFFFFFFF),
-	c.common.cdw10[0] = cpu_to_le32(
-			(((sizeof(struct nvme_smart_log) / 4) - 1) <<
16) |
-			 NVME_LOG_SMART),
-
-	*log = kmalloc(sizeof(struct nvme_smart_log), GFP_KERNEL);
-	if (!*log)
-		return -ENOMEM;
-
-	error = nvme_submit_sync_cmd(dev->admin_q, &c, *log,
-			sizeof(struct nvme_smart_log));
-	if (error)
-		kfree(*log);
-	return error;
-}
-
-/**
- * nvme_abort_req - Attempt aborting a request
- *
- * Schedule controller reset if the command was already aborted once
before and
- * still hasn't been returned to the driver, or if this is the admin
queue.
- */
-static void nvme_abort_req(struct request *req)
-{
-	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq = cmd_rq->nvmeq;
-	struct nvme_dev *dev = nvmeq->dev;
-	struct request *abort_req;
-	struct nvme_cmd_info *abort_cmd;
-	struct nvme_command cmd;
-
-	if (!nvmeq->qid || cmd_rq->aborted) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&dev_list_lock, flags);
-		if (work_busy(&dev->reset_work))
-			goto out;
-		list_del_init(&dev->node);
-		dev_warn(dev->dev, "I/O %d QID %d timeout, reset
controller\n",
-							req->tag,
nvmeq->qid);
-		dev->reset_workfn = nvme_reset_failed_dev;
-		queue_work(nvme_workq, &dev->reset_work);
- out:
-		spin_unlock_irqrestore(&dev_list_lock, flags);
-		return;
-	}
-
-	if (!dev->abort_limit)
-		return;
-
-	abort_req = blk_mq_alloc_request(dev->admin_q, WRITE,
GFP_ATOMIC,
-									false);
-	if (IS_ERR(abort_req))
-		return;
-
-	abort_cmd = blk_mq_rq_to_pdu(abort_req);
-	nvme_set_info(abort_cmd, abort_req, abort_completion);
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.abort.opcode = nvme_admin_abort_cmd;
-	cmd.abort.cid = req->tag;
-	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
-	cmd.abort.command_id = abort_req->tag;
-
-	--dev->abort_limit;
-	cmd_rq->aborted = 1;
-
-	dev_warn(nvmeq->q_dmadev, "Aborting I/O %d QID %d\n", req
->tag,
-							nvmeq->qid);
-	nvme_submit_cmd(dev->queues[0], &cmd);
-}
-
-static void nvme_cancel_queue_ios(struct request *req, void *data,
bool reserved)
-{
-	struct nvme_queue *nvmeq = data;
-	void *ctx;
-	nvme_completion_fn fn;
-	struct nvme_cmd_info *cmd;
-	struct nvme_completion cqe;
-
-	if (!blk_mq_request_started(req))
-		return;
-
-	cmd = blk_mq_rq_to_pdu(req);
-
-	if (cmd->ctx == CMD_CTX_CANCELLED)
-		return;
-
-	if (blk_queue_dying(req->q))
-		cqe.status = cpu_to_le16((NVME_SC_ABORT_REQ |
NVME_SC_DNR) << 1);
-	else
-		cqe.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1);
-
-
-	dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d QID %d\n",
-						req->tag, nvmeq->qid);
-	ctx = cancel_cmd_info(cmd, &fn);
-	fn(nvmeq, ctx, &cqe);
-}
-
-static enum blk_eh_timer_return nvme_timeout(struct request *req, bool
reserved)
-{
-	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq = cmd->nvmeq;
-
-	dev_warn(nvmeq->q_dmadev, "Timeout I/O %d QID %d\n", req->tag,
-							nvmeq->qid);
-	spin_lock_irq(&nvmeq->q_lock);
-	nvme_abort_req(req);
-	spin_unlock_irq(&nvmeq->q_lock);
-
-	/*
-	 * The aborted req will be completed on receiving the abort
req.
-	 * We enable the timer again. If hit twice, it'll cause a
device reset,
-	 * as the device then is in a faulty state.
-	 */
-	return BLK_EH_RESET_TIMER;
-}
-
-static void nvme_free_queue(struct nvme_queue *nvmeq)
-{
-	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
-				(void *)nvmeq->cqes, nvmeq
->cq_dma_addr);
-	if (nvmeq->sq_cmds)
-		dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq
->q_depth),
-					nvmeq->sq_cmds, nvmeq
->sq_dma_addr);
-	kfree(nvmeq);
-}
-
-static void nvme_free_queues(struct nvme_dev *dev, int lowest)
-{
-	int i;
-
-	for (i = dev->queue_count - 1; i >= lowest; i--) {
-		struct nvme_queue *nvmeq = dev->queues[i];
-		dev->queue_count--;
-		dev->queues[i] = NULL;
-		nvme_free_queue(nvmeq);
-	}
-}
-
-/**
- * nvme_suspend_queue - put queue into suspended state
- * @nvmeq - queue to suspend
- */
-static int nvme_suspend_queue(struct nvme_queue *nvmeq)
-{
-	int vector;
-
-	spin_lock_irq(&nvmeq->q_lock);
-	if (nvmeq->cq_vector == -1) {
-		spin_unlock_irq(&nvmeq->q_lock);
-		return 1;
-	}
-	vector = nvmeq->dev->entry[nvmeq->cq_vector].vector;
-	nvmeq->dev->online_queues--;
-	nvmeq->cq_vector = -1;
-	spin_unlock_irq(&nvmeq->q_lock);
-
-	if (!nvmeq->qid && nvmeq->dev->admin_q)
-		blk_mq_freeze_queue_start(nvmeq->dev->admin_q);
-
-	irq_set_affinity_hint(vector, NULL);
-	free_irq(vector, nvmeq);
-
-	return 0;
-}
-
-static void nvme_clear_queue(struct nvme_queue *nvmeq)
-{
-	spin_lock_irq(&nvmeq->q_lock);
-	if (nvmeq->tags && *nvmeq->tags)
-		blk_mq_all_tag_busy_iter(*nvmeq->tags,
nvme_cancel_queue_ios, nvmeq);
-	spin_unlock_irq(&nvmeq->q_lock);
-}
-
-static void nvme_disable_queue(struct nvme_dev *dev, int qid)
-{
-	struct nvme_queue *nvmeq = dev->queues[qid];
-
-	if (!nvmeq)
-		return;
-	if (nvme_suspend_queue(nvmeq))
-		return;
-
-	/* Don't tell the adapter to delete the admin queue.
-	 * Don't tell a removed adapter to delete IO queues. */
-	if (qid && readl(&dev->bar->csts) != -1) {
-		adapter_delete_sq(dev, qid);
-		adapter_delete_cq(dev, qid);
-	}
-
-	spin_lock_irq(&nvmeq->q_lock);
-	nvme_process_cq(nvmeq);
-	spin_unlock_irq(&nvmeq->q_lock);
-}
-
-static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
-				int entry_size)
-{
-	int q_depth = dev->q_depth;
-	unsigned q_size_aligned = roundup(q_depth * entry_size, dev
->page_size);
-
-	if (q_size_aligned * nr_io_queues > dev->cmb_size) {
-		u64 mem_per_q = div_u64(dev->cmb_size, nr_io_queues);
-		mem_per_q = round_down(mem_per_q, dev->page_size);
-		q_depth = div_u64(mem_per_q, entry_size);
-
-		/*
-		 * Ensure the reduced q_depth is above some threshold
where it
-		 * would be better to map queues in system memory with
the
-		 * original depth
-		 */
-		if (q_depth < 64)
-			return -ENOMEM;
-	}
-
-	return q_depth;
-}
-
-static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue
*nvmeq,
-				int qid, int depth)
-{
-	if (qid && dev->cmb && use_cmb_sqes && NVME_CMB_SQS(dev
->cmbsz)) {
-		unsigned offset = (qid - 1) *
-					roundup(SQ_SIZE(depth), dev
->page_size);
-		nvmeq->sq_dma_addr = dev->cmb_dma_addr + offset;
-		nvmeq->sq_cmds_io = dev->cmb + offset;
-	} else {
-		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev,
SQ_SIZE(depth),
-					&nvmeq->sq_dma_addr,
GFP_KERNEL);
-		if (!nvmeq->sq_cmds)
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int
qid,
-							int depth)
-{
-	struct nvme_queue *nvmeq = kzalloc(sizeof(*nvmeq),
GFP_KERNEL);
-	if (!nvmeq)
-		return NULL;
-
-	nvmeq->cqes = dma_zalloc_coherent(dev->dev, CQ_SIZE(depth),
-					  &nvmeq->cq_dma_addr,
GFP_KERNEL);
-	if (!nvmeq->cqes)
-		goto free_nvmeq;
-
-	if (nvme_alloc_sq_cmds(dev, nvmeq, qid, depth))
-		goto free_cqdma;
-
-	nvmeq->q_dmadev = dev->dev;
-	nvmeq->dev = dev;
-	snprintf(nvmeq->irqname, sizeof(nvmeq->irqname), "nvme%dq%d",
-			dev->instance, qid);
-	spin_lock_init(&nvmeq->q_lock);
-	nvmeq->cq_head = 0;
-	nvmeq->cq_phase = 1;
-	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
-	nvmeq->q_depth = depth;
-	nvmeq->qid = qid;
-	nvmeq->cq_vector = -1;
-	dev->queues[qid] = nvmeq;
-
-	/* make sure queue descriptor is set before queue count, for
kthread */
-	mb();
-	dev->queue_count++;
-
-	return nvmeq;
-
- free_cqdma:
-	dma_free_coherent(dev->dev, CQ_SIZE(depth), (void *)nvmeq
->cqes,
-							nvmeq
->cq_dma_addr);
- free_nvmeq:
-	kfree(nvmeq);
-	return NULL;
-}
-
-static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue
*nvmeq,
-							const char
*name)
-{
-	if (use_threaded_interrupts)
-		return request_threaded_irq(dev->entry[nvmeq
->cq_vector].vector,
-					nvme_irq_check, nvme_irq,
IRQF_SHARED,
-					name, nvmeq);
-	return request_irq(dev->entry[nvmeq->cq_vector].vector,
nvme_irq,
-				IRQF_SHARED, name, nvmeq);
-}
-
-static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
-{
-	struct nvme_dev *dev = nvmeq->dev;
-
-	spin_lock_irq(&nvmeq->q_lock);
-	nvmeq->sq_tail = 0;
-	nvmeq->cq_head = 0;
-	nvmeq->cq_phase = 1;
-	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
-	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
-	dev->online_queues++;
-	spin_unlock_irq(&nvmeq->q_lock);
-}
-
-static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
-{
-	struct nvme_dev *dev = nvmeq->dev;
-	int result;
-
-	nvmeq->cq_vector = qid - 1;
-	result = adapter_alloc_cq(dev, qid, nvmeq);
-	if (result < 0)
-		return result;
-
-	result = adapter_alloc_sq(dev, qid, nvmeq);
-	if (result < 0)
-		goto release_cq;
-
-	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
-	if (result < 0)
-		goto release_sq;
-
-	nvme_init_queue(nvmeq, qid);
-	return result;
-
- release_sq:
-	adapter_delete_sq(dev, qid);
- release_cq:
-	adapter_delete_cq(dev, qid);
-	return result;
-}
-
-static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool
enabled)
-{
-	unsigned long timeout;
-	u32 bit = enabled ? NVME_CSTS_RDY : 0;
-
-	timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
-
-	while ((readl(&dev->bar->csts) & NVME_CSTS_RDY) != bit) {
-		msleep(100);
-		if (fatal_signal_pending(current))
-			return -EINTR;
-		if (time_after(jiffies, timeout)) {
-			dev_err(dev->dev,
-				"Device not ready; aborting %s\n",
enabled ?
-						"initialisation" :
"reset");
-			return -ENODEV;
-		}
-	}
-
-	return 0;
-}
-
-/*
- * If the device has been passed off to us in an enabled state, just
clear
- * the enabled bit.  The spec says we should set the 'shutdown
notification
- * bits', but doing so may cause the device to complete commands to
the
- * admin queue ... and we don't know what memory that might be
pointing at!
- */
-static int nvme_disable_ctrl(struct nvme_dev *dev, u64 cap)
-{
-	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
-	dev->ctrl_config &= ~NVME_CC_ENABLE;
-	writel(dev->ctrl_config, &dev->bar->cc);
-
-	return nvme_wait_ready(dev, cap, false);
-}
-
-static int nvme_enable_ctrl(struct nvme_dev *dev, u64 cap)
-{
-	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
-	dev->ctrl_config |= NVME_CC_ENABLE;
-	writel(dev->ctrl_config, &dev->bar->cc);
-
-	return nvme_wait_ready(dev, cap, true);
-}
-
-static int nvme_shutdown_ctrl(struct nvme_dev *dev)
-{
-	unsigned long timeout;
-
-	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
-	dev->ctrl_config |= NVME_CC_SHN_NORMAL;
-
-	writel(dev->ctrl_config, &dev->bar->cc);
-
-	timeout = SHUTDOWN_TIMEOUT + jiffies;
-	while ((readl(&dev->bar->csts) & NVME_CSTS_SHST_MASK) !=
-							NVME_CSTS_SHST
_CMPLT) {
-		msleep(100);
-		if (fatal_signal_pending(current))
-			return -EINTR;
-		if (time_after(jiffies, timeout)) {
-			dev_err(dev->dev,
-				"Device shutdown incomplete; abort
shutdown\n");
-			return -ENODEV;
-		}
-	}
-
-	return 0;
-}
-
-static struct blk_mq_ops nvme_mq_admin_ops = {
-	.queue_rq	= nvme_queue_rq,
-	.map_queue	= blk_mq_map_queue,
-	.init_hctx	= nvme_admin_init_hctx,
-	.exit_hctx      = nvme_admin_exit_hctx,
-	.init_request	= nvme_admin_init_request,
-	.timeout	= nvme_timeout,
-};
-
-static struct blk_mq_ops nvme_mq_ops = {
-	.queue_rq	= nvme_queue_rq,
-	.map_queue	= blk_mq_map_queue,
-	.init_hctx	= nvme_init_hctx,
-	.init_request	= nvme_init_request,
-	.timeout	= nvme_timeout,
-};
-
-static void nvme_dev_remove_admin(struct nvme_dev *dev)
-{
-	if (dev->admin_q && !blk_queue_dying(dev->admin_q)) {
-		blk_cleanup_queue(dev->admin_q);
-		blk_mq_free_tag_set(&dev->admin_tagset);
-	}
-}
-
-static int nvme_alloc_admin_tags(struct nvme_dev *dev)
-{
-	if (!dev->admin_q) {
-		dev->admin_tagset.ops = &nvme_mq_admin_ops;
-		dev->admin_tagset.nr_hw_queues = 1;
-		dev->admin_tagset.queue_depth = NVME_AQ_DEPTH - 1;
-		dev->admin_tagset.reserved_tags = 1;
-		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
-		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
-		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
-		dev->admin_tagset.driver_data = dev;
-
-		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
-			return -ENOMEM;
-
-		dev->admin_q = blk_mq_init_queue(&dev->admin_tagset);
-		if (IS_ERR(dev->admin_q)) {
-			blk_mq_free_tag_set(&dev->admin_tagset);
-			return -ENOMEM;
-		}
-		if (!blk_get_queue(dev->admin_q)) {
-			nvme_dev_remove_admin(dev);
-			dev->admin_q = NULL;
-			return -ENODEV;
-		}
-	} else
-		blk_mq_unfreeze_queue(dev->admin_q);
-
-	return 0;
-}
-
-static int nvme_configure_admin_queue(struct nvme_dev *dev)
-{
-	int result;
-	u32 aqa;
-	u64 cap = readq(&dev->bar->cap);
-	struct nvme_queue *nvmeq;
-	unsigned page_shift = PAGE_SHIFT;
-	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
-	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
-
-	if (page_shift < dev_page_min) {
-		dev_err(dev->dev,
-				"Minimum device page size (%u) too
large for "
-				"host (%u)\n", 1 << dev_page_min,
-				1 << page_shift);
-		return -ENODEV;
-	}
-	if (page_shift > dev_page_max) {
-		dev_info(dev->dev,
-				"Device maximum page size (%u) smaller
than "
-				"host (%u); enabling work-around\n",
-				1 << dev_page_max, 1 << page_shift);
-		page_shift = dev_page_max;
-	}
-
-	dev->subsystem = readl(&dev->bar->vs) >= NVME_VS(1, 1) ?
-						NVME_CAP_NSSRC(cap) :
0;
-
-	if (dev->subsystem && (readl(&dev->bar->csts) &
NVME_CSTS_NSSRO))
-		writel(NVME_CSTS_NSSRO, &dev->bar->csts);
-
-	result = nvme_disable_ctrl(dev, cap);
-	if (result < 0)
-		return result;
-
-	nvmeq = dev->queues[0];
-	if (!nvmeq) {
-		nvmeq = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH);
-		if (!nvmeq)
-			return -ENOMEM;
-	}
-
-	aqa = nvmeq->q_depth - 1;
-	aqa |= aqa << 16;
-
-	dev->page_size = 1 << page_shift;
-
-	dev->ctrl_config = NVME_CC_CSS_NVM;
-	dev->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
-	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
-	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
-
-	writel(aqa, &dev->bar->aqa);
-	writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
-	writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
-
-	result = nvme_enable_ctrl(dev, cap);
-	if (result)
-		goto free_nvmeq;
-
-	nvmeq->cq_vector = 0;
-	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
-	if (result) {
-		nvmeq->cq_vector = -1;
-		goto free_nvmeq;
-	}
-
-	return result;
-
- free_nvmeq:
-	nvme_free_queues(dev, 0);
-	return result;
-}
-
-static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io
__user *uio)
-{
-	struct nvme_dev *dev = ns->dev;
-	struct nvme_user_io io;
-	struct nvme_command c;
-	unsigned length, meta_len;
-	int status, write;
-	dma_addr_t meta_dma = 0;
-	void *meta = NULL;
-	void __user *metadata;
-
-	if (copy_from_user(&io, uio, sizeof(io)))
-		return -EFAULT;
-
-	switch (io.opcode) {
-	case nvme_cmd_write:
-	case nvme_cmd_read:
-	case nvme_cmd_compare:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	length = (io.nblocks + 1) << ns->lba_shift;
-	meta_len = (io.nblocks + 1) * ns->ms;
-	metadata = (void __user *)(unsigned long)io.metadata;
-	write = io.opcode & 1;
-
-	if (ns->ext) {
-		length += meta_len;
-		meta_len = 0;
-	}
-	if (meta_len) {
-		if (((io.metadata & 3) || !io.metadata) && !ns->ext)
-			return -EINVAL;
-
-		meta = dma_alloc_coherent(dev->dev, meta_len,
-						&meta_dma,
GFP_KERNEL);
-
-		if (!meta) {
-			status = -ENOMEM;
-			goto unmap;
-		}
-		if (write) {
-			if (copy_from_user(meta, metadata, meta_len))
{
-				status = -EFAULT;
-				goto unmap;
-			}
-		}
-	}
-
-	memset(&c, 0, sizeof(c));
-	c.rw.opcode = io.opcode;
-	c.rw.flags = io.flags;
-	c.rw.nsid = cpu_to_le32(ns->ns_id);
-	c.rw.slba = cpu_to_le64(io.slba);
-	c.rw.length = cpu_to_le16(io.nblocks);
-	c.rw.control = cpu_to_le16(io.control);
-	c.rw.dsmgmt = cpu_to_le32(io.dsmgmt);
-	c.rw.reftag = cpu_to_le32(io.reftag);
-	c.rw.apptag = cpu_to_le16(io.apptag);
-	c.rw.appmask = cpu_to_le16(io.appmask);
-	c.rw.metadata = cpu_to_le64(meta_dma);
-
-	status = __nvme_submit_sync_cmd(ns->queue, &c, NULL,
-			(void __user *)io.addr, length, NULL, 0);
- unmap:
-	if (meta) {
-		if (status == NVME_SC_SUCCESS && !write) {
-			if (copy_to_user(metadata, meta, meta_len))
-				status = -EFAULT;
-		}
-		dma_free_coherent(dev->dev, meta_len, meta, meta_dma);
-	}
-	return status;
-}
-
-static int nvme_user_cmd(struct nvme_dev *dev, struct nvme_ns *ns,
-			struct nvme_passthru_cmd __user *ucmd)
-{
-	struct nvme_passthru_cmd cmd;
-	struct nvme_command c;
-	unsigned timeout = 0;
-	int status;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
-		return -EFAULT;
-
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = cmd.opcode;
-	c.common.flags = cmd.flags;
-	c.common.nsid = cpu_to_le32(cmd.nsid);
-	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
-	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
-	c.common.cdw10[0] = cpu_to_le32(cmd.cdw10);
-	c.common.cdw10[1] = cpu_to_le32(cmd.cdw11);
-	c.common.cdw10[2] = cpu_to_le32(cmd.cdw12);
-	c.common.cdw10[3] = cpu_to_le32(cmd.cdw13);
-	c.common.cdw10[4] = cpu_to_le32(cmd.cdw14);
-	c.common.cdw10[5] = cpu_to_le32(cmd.cdw15);
-
-	if (cmd.timeout_ms)
-		timeout = msecs_to_jiffies(cmd.timeout_ms);
-
-	status = __nvme_submit_sync_cmd(ns ? ns->queue : dev->admin_q,
&c,
-			NULL, (void __user *)cmd.addr, cmd.data_len,
-			&cmd.result, timeout);
-	if (status >= 0) {
-		if (put_user(cmd.result, &ucmd->result))
-			return -EFAULT;
-	}
-
-	return status;
-}
-
-static int nvme_subsys_reset(struct nvme_dev *dev)
-{
-	if (!dev->subsystem)
-		return -ENOTTY;
-
-	writel(0x4E564D65, &dev->bar->nssr); /* "NVMe" */
-	return 0;
-}
-
-static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
unsigned int cmd,
-							unsigned long
arg)
-{
-	struct nvme_ns *ns = bdev->bd_disk->private_data;
-
-	switch (cmd) {
-	case NVME_IOCTL_ID:
-		force_successful_syscall_return();
-		return ns->ns_id;
-	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ns->dev, NULL, (void __user
*)arg);
-	case NVME_IOCTL_IO_CMD:
-		return nvme_user_cmd(ns->dev, ns, (void __user *)arg);
-	case NVME_IOCTL_SUBMIT_IO:
-		return nvme_submit_io(ns, (void __user *)arg);
-	case SG_GET_VERSION_NUM:
-		return nvme_sg_get_version_num((void __user *)arg);
-	case SG_IO:
-		return nvme_sg_io(ns, (void __user *)arg);
-	default:
-		return -ENOTTY;
-	}
-}
-
-#ifdef CONFIG_COMPAT
-static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
-					unsigned int cmd, unsigned
long arg)
-{
-	switch (cmd) {
-	case SG_IO:
-		return -ENOIOCTLCMD;
-	}
-	return nvme_ioctl(bdev, mode, cmd, arg);
-}
-#else
-#define nvme_compat_ioctl	NULL
-#endif
-
-static int nvme_open(struct block_device *bdev, fmode_t mode)
-{
-	int ret = 0;
-	struct nvme_ns *ns;
-
-	spin_lock(&dev_list_lock);
-	ns = bdev->bd_disk->private_data;
-	if (!ns)
-		ret = -ENXIO;
-	else if (!kref_get_unless_zero(&ns->dev->kref))
-		ret = -ENXIO;
-	spin_unlock(&dev_list_lock);
-
-	return ret;
-}
-
-static void nvme_free_dev(struct kref *kref);
-
-static void nvme_release(struct gendisk *disk, fmode_t mode)
-{
-	struct nvme_ns *ns = disk->private_data;
-	struct nvme_dev *dev = ns->dev;
-
-	kref_put(&dev->kref, nvme_free_dev);
-}
-
-static int nvme_getgeo(struct block_device *bd, struct hd_geometry
*geo)
-{
-	/* some standard values */
-	geo->heads = 1 << 6;
-	geo->sectors = 1 << 5;
-	geo->cylinders = get_capacity(bd->bd_disk) >> 11;
-	return 0;
-}
-
-static void nvme_config_discard(struct nvme_ns *ns)
-{
-	u32 logical_block_size = queue_logical_block_size(ns->queue);
-	ns->queue->limits.discard_zeroes_data = 0;
-	ns->queue->limits.discard_alignment = logical_block_size;
-	ns->queue->limits.discard_granularity = logical_block_size;
-	blk_queue_max_discard_sectors(ns->queue, 0xffffffff);
-	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
-}
-
-static int nvme_revalidate_disk(struct gendisk *disk)
-{
-	struct nvme_ns *ns = disk->private_data;
-	struct nvme_dev *dev = ns->dev;
-	struct nvme_id_ns *id;
-	u8 lbaf, pi_type;
-	u16 old_ms;
-	unsigned short bs;
-
-	if (nvme_identify_ns(dev, ns->ns_id, &id)) {
-		dev_warn(dev->dev, "%s: Identify failure nvme%dn%d\n",
__func__,
-						dev->instance, ns
->ns_id);
-		return -ENODEV;
-	}
-	if (id->ncap == 0) {
-		kfree(id);
-		return -ENODEV;
-	}
-
-	old_ms = ns->ms;
-	lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
-	ns->lba_shift = id->lbaf[lbaf].ds;
-	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
-	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
-
-	/*
-	 * If identify namespace failed, use default 512 byte block
size so
-	 * block layer can use before failing read/write for 0
capacity.
-	 */
-	if (ns->lba_shift == 0)
-		ns->lba_shift = 9;
-	bs = 1 << ns->lba_shift;
-
-	/* XXX: PI implementation requires metadata equal t10 pi tuple
size */
-	pi_type = ns->ms == sizeof(struct t10_pi_tuple) ?
-					id->dps & NVME_NS_DPS_PI_MASK
: 0;
-
-	if (blk_get_integrity(disk) && (ns->pi_type != pi_type ||
-				ns->ms != old_ms ||
-				bs != queue_logical_block_size(disk
->queue) ||
-				(ns->ms && ns->ext)))
-		blk_integrity_unregister(disk);
-
-	ns->pi_type = pi_type;
-	blk_queue_logical_block_size(ns->queue, bs);
-
-	if (ns->ms && !blk_get_integrity(disk) && (disk->flags &
GENHD_FL_UP) &&
-								!ns
->ext)
-		nvme_init_integrity(ns);
-
-	if (ns->ms && !(ns->ms == 8 && ns->pi_type) &&
!blk_get_integrity(disk))
-		set_capacity(disk, 0);
-	else
-		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns
->lba_shift - 9));
-
-	if (dev->oncs & NVME_CTRL_ONCS_DSM)
-		nvme_config_discard(ns);
-
-	kfree(id);
-	return 0;
-}
-
-static const struct block_device_operations nvme_fops = {
-	.owner		= THIS_MODULE,
-	.ioctl		= nvme_ioctl,
-	.compat_ioctl	= nvme_compat_ioctl,
-	.open		= nvme_open,
-	.release	= nvme_release,
-	.getgeo		= nvme_getgeo,
-	.revalidate_disk= nvme_revalidate_disk,
-};
-
-static int nvme_kthread(void *data)
-{
-	struct nvme_dev *dev, *next;
-
-	while (!kthread_should_stop()) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		spin_lock(&dev_list_lock);
-		list_for_each_entry_safe(dev, next, &dev_list, node) {
-			int i;
-			u32 csts = readl(&dev->bar->csts);
-
-			if ((dev->subsystem && (csts &
NVME_CSTS_NSSRO)) ||
-							csts &
NVME_CSTS_CFS) {
-				if (work_busy(&dev->reset_work))
-					continue;
-				list_del_init(&dev->node);
-				dev_warn(dev->dev,
-					"Failed status: %x, reset
controller\n",
-					readl(&dev->bar->csts));
-				dev->reset_workfn =
nvme_reset_failed_dev;
-				queue_work(nvme_workq, &dev
->reset_work);
-				continue;
-			}
-			for (i = 0; i < dev->queue_count; i++) {
-				struct nvme_queue *nvmeq = dev
->queues[i];
-				if (!nvmeq)
-					continue;
-				spin_lock_irq(&nvmeq->q_lock);
-				nvme_process_cq(nvmeq);
-
-				while ((i == 0) && (dev->event_limit >
0)) {
-					if
(nvme_submit_async_admin_req(dev))
-						break;
-					dev->event_limit--;
-				}
-				spin_unlock_irq(&nvmeq->q_lock);
-			}
-		}
-		spin_unlock(&dev_list_lock);
-		schedule_timeout(round_jiffies_relative(HZ));
-	}
-	return 0;
-}
-
-static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
-{
-	struct nvme_ns *ns;
-	struct gendisk *disk;
-	int node = dev_to_node(dev->dev);
-
-	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
-	if (!ns)
-		return;
-
-	ns->queue = blk_mq_init_queue(&dev->tagset);
-	if (IS_ERR(ns->queue))
-		goto out_free_ns;
-	queue_flag_set_unlocked(QUEUE_FLAG_NOMERGES, ns->queue);
-	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
-	ns->dev = dev;
-	ns->queue->queuedata = ns;
-
-	disk = alloc_disk_node(0, node);
-	if (!disk)
-		goto out_free_queue;
-
-	ns->ns_id = nsid;
-	ns->disk = disk;
-	ns->lba_shift = 9; /* set to a default value for 512 until
disk is validated */
-	list_add_tail(&ns->list, &dev->namespaces);
-
-	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
-	if (dev->max_hw_sectors) {
-		blk_queue_max_hw_sectors(ns->queue, dev
->max_hw_sectors);
-		blk_queue_max_segments(ns->queue,
-			((dev->max_hw_sectors << 9) / dev->page_size)
+ 1);
-	}
-	if (dev->stripe_size)
-		blk_queue_chunk_sectors(ns->queue, dev->stripe_size >>
9);
-	if (dev->vwc & NVME_CTRL_VWC_PRESENT)
-		blk_queue_flush(ns->queue, REQ_FLUSH | REQ_FUA);
-	blk_queue_virt_boundary(ns->queue, dev->page_size - 1);
-
-	disk->major = nvme_major;
-	disk->first_minor = 0;
-	disk->fops = &nvme_fops;
-	disk->private_data = ns;
-	disk->queue = ns->queue;
-	disk->driverfs_dev = dev->device;
-	disk->flags = GENHD_FL_EXT_DEVT;
-	sprintf(disk->disk_name, "nvme%dn%d", dev->instance, nsid);
-
-	/*
-	 * Initialize capacity to 0 until we establish the namespace
format and
-	 * setup integrity extentions if necessary. The
revalidate_disk after
-	 * add_disk allows the driver to register with integrity if
the format
-	 * requires it.
-	 */
-	set_capacity(disk, 0);
-	if (nvme_revalidate_disk(ns->disk))
-		goto out_free_disk;
-
-	add_disk(ns->disk);
-	if (ns->ms) {
-		struct block_device *bd = bdget_disk(ns->disk, 0);
-		if (!bd)
-			return;
-		if (blkdev_get(bd, FMODE_READ, NULL)) {
-			bdput(bd);
-			return;
-		}
-		blkdev_reread_part(bd);
-		blkdev_put(bd, FMODE_READ);
-	}
-	return;
- out_free_disk:
-	kfree(disk);
-	list_del(&ns->list);
- out_free_queue:
-	blk_cleanup_queue(ns->queue);
- out_free_ns:
-	kfree(ns);
-}
-
-static void nvme_create_io_queues(struct nvme_dev *dev)
-{
-	unsigned i;
-
-	for (i = dev->queue_count; i <= dev->max_qid; i++)
-		if (!nvme_alloc_queue(dev, i, dev->q_depth))
-			break;
-
-	for (i = dev->online_queues; i <= dev->queue_count - 1; i++)
-		if (nvme_create_queue(dev->queues[i], i))
-			break;
-}
-
-static int set_queue_count(struct nvme_dev *dev, int count)
-{
-	int status;
-	u32 result;
-	u32 q_count = (count - 1) | ((count - 1) << 16);
-
-	status = nvme_set_features(dev, NVME_FEAT_NUM_QUEUES, q_count,
0,
-								&resul
t);
-	if (status < 0)
-		return status;
-	if (status > 0) {
-		dev_err(dev->dev, "Could not set queue count (%d)\n",
status);
-		return 0;
-	}
-	return min(result & 0xffff, result >> 16) + 1;
-}
-
-static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
-{
-	u64 szu, size, offset;
-	u32 cmbloc;
-	resource_size_t bar_size;
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	void __iomem *cmb;
-	dma_addr_t dma_addr;
-
-	if (!use_cmb_sqes)
-		return NULL;
-
-	dev->cmbsz = readl(&dev->bar->cmbsz);
-	if (!(NVME_CMB_SZ(dev->cmbsz)))
-		return NULL;
-
-	cmbloc = readl(&dev->bar->cmbloc);
-
-	szu = (u64)1 << (12 + 4 * NVME_CMB_SZU(dev->cmbsz));
-	size = szu * NVME_CMB_SZ(dev->cmbsz);
-	offset = szu * NVME_CMB_OFST(cmbloc);
-	bar_size = pci_resource_len(pdev, NVME_CMB_BIR(cmbloc));
-
-	if (offset > bar_size)
-		return NULL;
-
-	/*
-	 * Controllers may support a CMB size larger than their BAR,
-	 * for example, due to being behind a bridge. Reduce the CMB
to
-	 * the reported size of the BAR
-	 */
-	if (size > bar_size - offset)
-		size = bar_size - offset;
-
-	dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(cmbloc)) +
offset;
-	cmb = ioremap_wc(dma_addr, size);
-	if (!cmb)
-		return NULL;
-
-	dev->cmb_dma_addr = dma_addr;
-	dev->cmb_size = size;
-	return cmb;
-}
-
-static inline void nvme_release_cmb(struct nvme_dev *dev)
-{
-	if (dev->cmb) {
-		iounmap(dev->cmb);
-		dev->cmb = NULL;
-	}
-}
-
-static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
-{
-	return 4096 + ((nr_io_queues + 1) * 8 * dev->db_stride);
-}
-
-static int nvme_setup_io_queues(struct nvme_dev *dev)
-{
-	struct nvme_queue *adminq = dev->queues[0];
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int result, i, vecs, nr_io_queues, size;
-
-	nr_io_queues = num_possible_cpus();
-	result = set_queue_count(dev, nr_io_queues);
-	if (result <= 0)
-		return result;
-	if (result < nr_io_queues)
-		nr_io_queues = result;
-
-	if (dev->cmb && NVME_CMB_SQS(dev->cmbsz)) {
-		result = nvme_cmb_qdepth(dev, nr_io_queues,
-				sizeof(struct nvme_command));
-		if (result > 0)
-			dev->q_depth = result;
-		else
-			nvme_release_cmb(dev);
-	}
-
-	size = db_bar_size(dev, nr_io_queues);
-	if (size > 8192) {
-		iounmap(dev->bar);
-		do {
-			dev->bar = ioremap(pci_resource_start(pdev,
0), size);
-			if (dev->bar)
-				break;
-			if (!--nr_io_queues)
-				return -ENOMEM;
-			size = db_bar_size(dev, nr_io_queues);
-		} while (1);
-		dev->dbs = ((void __iomem *)dev->bar) + 4096;
-		adminq->q_db = dev->dbs;
-	}
-
-	/* Deregister the admin queue's interrupt */
-	free_irq(dev->entry[0].vector, adminq);
-
-	/*
-	 * If we enable msix early due to not intx, disable it again
before
-	 * setting up the full range we need.
-	 */
-	if (!pdev->irq)
-		pci_disable_msix(pdev);
-
-	for (i = 0; i < nr_io_queues; i++)
-		dev->entry[i].entry = i;
-	vecs = pci_enable_msix_range(pdev, dev->entry, 1,
nr_io_queues);
-	if (vecs < 0) {
-		vecs = pci_enable_msi_range(pdev, 1, min(nr_io_queues,
32));
-		if (vecs < 0) {
-			vecs = 1;
-		} else {
-			for (i = 0; i < vecs; i++)
-				dev->entry[i].vector = i + pdev->irq;
-		}
-	}
-
-	/*
-	 * Should investigate if there's a performance win from
allocating
-	 * more queues than interrupt vectors; it might allow the
submission
-	 * path to scale better, even if the receive path is limited
by the
-	 * number of interrupts.
-	 */
-	nr_io_queues = vecs;
-	dev->max_qid = nr_io_queues;
-
-	result = queue_request_irq(dev, adminq, adminq->irqname);
-	if (result) {
-		adminq->cq_vector = -1;
-		goto free_queues;
-	}
-
-	/* Free previously allocated queues that are no longer usable
*/
-	nvme_free_queues(dev, nr_io_queues + 1);
-	nvme_create_io_queues(dev);
-
-	return 0;
-
- free_queues:
-	nvme_free_queues(dev, 1);
-	return result;
-}
-
-static void nvme_free_namespace(struct nvme_ns *ns)
-{
-	list_del(&ns->list);
-
-	spin_lock(&dev_list_lock);
-	ns->disk->private_data = NULL;
-	spin_unlock(&dev_list_lock);
-
-	put_disk(ns->disk);
-	kfree(ns);
-}
-
-static int ns_cmp(void *priv, struct list_head *a, struct list_head
*b)
-{
-	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
-	struct nvme_ns *nsb = container_of(b, struct nvme_ns, list);
-
-	return nsa->ns_id - nsb->ns_id;
-}
-
-static struct nvme_ns *nvme_find_ns(struct nvme_dev *dev, unsigned
nsid)
-{
-	struct nvme_ns *ns;
-
-	list_for_each_entry(ns, &dev->namespaces, list) {
-		if (ns->ns_id == nsid)
-			return ns;
-		if (ns->ns_id > nsid)
-			break;
-	}
-	return NULL;
-}
-
-static inline bool nvme_io_incapable(struct nvme_dev *dev)
-{
-	return (!dev->bar || readl(&dev->bar->csts) & NVME_CSTS_CFS ||
-							dev
->online_queues < 2);
-}
-
-static void nvme_ns_remove(struct nvme_ns *ns)
-{
-	bool kill = nvme_io_incapable(ns->dev) && !blk_queue_dying(ns
->queue);
-
-	if (kill)
-		blk_set_queue_dying(ns->queue);
-	if (ns->disk->flags & GENHD_FL_UP) {
-		if (blk_get_integrity(ns->disk))
-			blk_integrity_unregister(ns->disk);
-		del_gendisk(ns->disk);
-	}
-	if (kill || !blk_queue_dying(ns->queue)) {
-		blk_mq_abort_requeue_list(ns->queue);
-		blk_cleanup_queue(ns->queue);
-        }
-}
-
-static void nvme_scan_namespaces(struct nvme_dev *dev, unsigned nn)
-{
-	struct nvme_ns *ns, *next;
-	unsigned i;
-
-	for (i = 1; i <= nn; i++) {
-		ns = nvme_find_ns(dev, i);
-		if (ns) {
-			if (revalidate_disk(ns->disk)) {
-				nvme_ns_remove(ns);
-				nvme_free_namespace(ns);
-			}
-		} else
-			nvme_alloc_ns(dev, i);
-	}
-	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
-		if (ns->ns_id > nn) {
-			nvme_ns_remove(ns);
-			nvme_free_namespace(ns);
-		}
-	}
-	list_sort(NULL, &dev->namespaces, ns_cmp);
-}
-
-static void nvme_dev_scan(struct work_struct *work)
-{
-	struct nvme_dev *dev = container_of(work, struct nvme_dev,
scan_work);
-	struct nvme_id_ctrl *ctrl;
-
-	if (!dev->tagset.tags)
-		return;
-	if (nvme_identify_ctrl(dev, &ctrl))
-		return;
-	nvme_scan_namespaces(dev, le32_to_cpup(&ctrl->nn));
-	kfree(ctrl);
-}
-
-/*
- * Return: error value if an error occurred setting up the queues or
calling
- * Identify Device.  0 if these succeeded, even if adding some of the
- * namespaces failed.  At the moment, these failures are silent.  TBD
which
- * failures should be reported.
- */
-static int nvme_dev_add(struct nvme_dev *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int res;
-	struct nvme_id_ctrl *ctrl;
-	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
-
-	res = nvme_identify_ctrl(dev, &ctrl);
-	if (res) {
-		dev_err(dev->dev, "Identify Controller failed (%d)\n",
res);
-		return -EIO;
-	}
-
-	dev->oncs = le16_to_cpup(&ctrl->oncs);
-	dev->abort_limit = ctrl->acl + 1;
-	dev->vwc = ctrl->vwc;
-	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
-	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
-	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
-	if (ctrl->mdts)
-		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
-	if ((pdev->vendor == PCI_VENDOR_ID_INTEL) &&
-			(pdev->device == 0x0953) && ctrl->vs[3]) {
-		unsigned int max_hw_sectors;
-
-		dev->stripe_size = 1 << (ctrl->vs[3] + shift);
-		max_hw_sectors = dev->stripe_size >> (shift - 9);
-		if (dev->max_hw_sectors) {
-			dev->max_hw_sectors = min(max_hw_sectors,
-							dev
->max_hw_sectors);
-		} else
-			dev->max_hw_sectors = max_hw_sectors;
-	}
-	kfree(ctrl);
-
-	if (!dev->tagset.tags) {
-		dev->tagset.ops = &nvme_mq_ops;
-		dev->tagset.nr_hw_queues = dev->online_queues - 1;
-		dev->tagset.timeout = NVME_IO_TIMEOUT;
-		dev->tagset.numa_node = dev_to_node(dev->dev);
-		dev->tagset.queue_depth =
-				min_t(int, dev->q_depth,
BLK_MQ_MAX_DEPTH) - 1;
-		dev->tagset.cmd_size = nvme_cmd_size(dev);
-		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
-		dev->tagset.driver_data = dev;
-
-		if (blk_mq_alloc_tag_set(&dev->tagset))
-			return 0;
-	}
-	schedule_work(&dev->scan_work);
-	return 0;
-}
-
-static int nvme_dev_map(struct nvme_dev *dev)
-{
-	u64 cap;
-	int bars, result = -ENOMEM;
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
-
-	if (pci_enable_device_mem(pdev))
-		return result;
-
-	dev->entry[0].vector = pdev->irq;
-	pci_set_master(pdev);
-	bars = pci_select_bars(pdev, IORESOURCE_MEM);
-	if (!bars)
-		goto disable_pci;
-
-	if (pci_request_selected_regions(pdev, bars, "nvme"))
-		goto disable_pci;
-
-	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
-	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32)))
-		goto disable;
-
-	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
-	if (!dev->bar)
-		goto disable;
-
-	if (readl(&dev->bar->csts) == -1) {
-		result = -ENODEV;
-		goto unmap;
-	}
-
-	/*
-	 * Some devices don't advertse INTx interrupts, pre-enable a
single
-	 * MSIX vec for setup. We'll adjust this later.
-	 */
-	if (!pdev->irq) {
-		result = pci_enable_msix(pdev, dev->entry, 1);
-		if (result < 0)
-			goto unmap;
-	}
-
-	cap = readq(&dev->bar->cap);
-	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1,
NVME_Q_DEPTH);
-	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
-	dev->dbs = ((void __iomem *)dev->bar) + 4096;
-	if (readl(&dev->bar->vs) >= NVME_VS(1, 2))
-		dev->cmb = nvme_map_cmb(dev);
-
-	return 0;
-
- unmap:
-	iounmap(dev->bar);
-	dev->bar = NULL;
- disable:
-	pci_release_regions(pdev);
- disable_pci:
-	pci_disable_device(pdev);
-	return result;
-}
-
-static void nvme_dev_unmap(struct nvme_dev *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
-
-	if (pdev->msi_enabled)
-		pci_disable_msi(pdev);
-	else if (pdev->msix_enabled)
-		pci_disable_msix(pdev);
-
-	if (dev->bar) {
-		iounmap(dev->bar);
-		dev->bar = NULL;
-		pci_release_regions(pdev);
-	}
-
-	if (pci_is_enabled(pdev))
-		pci_disable_device(pdev);
-}
-
-struct nvme_delq_ctx {
-	struct task_struct *waiter;
-	struct kthread_worker *worker;
-	atomic_t refcount;
-};
-
-static void nvme_wait_dq(struct nvme_delq_ctx *dq, struct nvme_dev
*dev)
-{
-	dq->waiter = current;
-	mb();
-
-	for (;;) {
-		set_current_state(TASK_KILLABLE);
-		if (!atomic_read(&dq->refcount))
-			break;
-		if (!schedule_timeout(ADMIN_TIMEOUT) ||
-					fatal_signal_pending(current))
{
-			/*
-			 * Disable the controller first since we can't
trust it
-			 * at this point, but leave the admin queue
enabled
-			 * until all queue deletion requests are
flushed.
-			 * FIXME: This may take a while if there are
more h/w
-			 * queues than admin tags.
-			 */
-			set_current_state(TASK_RUNNING);
-			nvme_disable_ctrl(dev, readq(&dev->bar->cap));
-			nvme_clear_queue(dev->queues[0]);
-			flush_kthread_worker(dq->worker);
-			nvme_disable_queue(dev, 0);
-			return;
-		}
-	}
-	set_current_state(TASK_RUNNING);
-}
-
-static void nvme_put_dq(struct nvme_delq_ctx *dq)
-{
-	atomic_dec(&dq->refcount);
-	if (dq->waiter)
-		wake_up_process(dq->waiter);
-}
-
-static struct nvme_delq_ctx *nvme_get_dq(struct nvme_delq_ctx *dq)
-{
-	atomic_inc(&dq->refcount);
-	return dq;
-}
-
-static void nvme_del_queue_end(struct nvme_queue *nvmeq)
-{
-	struct nvme_delq_ctx *dq = nvmeq->cmdinfo.ctx;
-	nvme_put_dq(dq);
-}
-
-static int adapter_async_del_queue(struct nvme_queue *nvmeq, u8
opcode,
-						kthread_work_func_t
fn)
-{
-	struct nvme_command c;
-
-	memset(&c, 0, sizeof(c));
-	c.delete_queue.opcode = opcode;
-	c.delete_queue.qid = cpu_to_le16(nvmeq->qid);
-
-	init_kthread_work(&nvmeq->cmdinfo.work, fn);
-	return nvme_submit_admin_async_cmd(nvmeq->dev, &c, &nvmeq
->cmdinfo,
-								ADMIN_
TIMEOUT);
-}
-
-static void nvme_del_cq_work_handler(struct kthread_work *work)
-{
-	struct nvme_queue *nvmeq = container_of(work, struct
nvme_queue,
-							cmdinfo.work);
-	nvme_del_queue_end(nvmeq);
-}
-
-static int nvme_delete_cq(struct nvme_queue *nvmeq)
-{
-	return adapter_async_del_queue(nvmeq, nvme_admin_delete_cq,
-						nvme_del_cq_work_handl
er);
-}
-
-static void nvme_del_sq_work_handler(struct kthread_work *work)
-{
-	struct nvme_queue *nvmeq = container_of(work, struct
nvme_queue,
-							cmdinfo.work);
-	int status = nvmeq->cmdinfo.status;
-
-	if (!status)
-		status = nvme_delete_cq(nvmeq);
-	if (status)
-		nvme_del_queue_end(nvmeq);
-}
-
-static int nvme_delete_sq(struct nvme_queue *nvmeq)
-{
-	return adapter_async_del_queue(nvmeq, nvme_admin_delete_sq,
-						nvme_del_sq_work_handl
er);
-}
-
-static void nvme_del_queue_start(struct kthread_work *work)
-{
-	struct nvme_queue *nvmeq = container_of(work, struct
nvme_queue,
-							cmdinfo.work);
-	if (nvme_delete_sq(nvmeq))
-		nvme_del_queue_end(nvmeq);
-}
-
-static void nvme_disable_io_queues(struct nvme_dev *dev)
-{
-	int i;
-	DEFINE_KTHREAD_WORKER_ONSTACK(worker);
-	struct nvme_delq_ctx dq;
-	struct task_struct *kworker_task =
kthread_run(kthread_worker_fn,
-					&worker, "nvme%d", dev
->instance);
-
-	if (IS_ERR(kworker_task)) {
-		dev_err(dev->dev,
-			"Failed to create queue del task\n");
-		for (i = dev->queue_count - 1; i > 0; i--)
-			nvme_disable_queue(dev, i);
-		return;
-	}
-
-	dq.waiter = NULL;
-	atomic_set(&dq.refcount, 0);
-	dq.worker = &worker;
-	for (i = dev->queue_count - 1; i > 0; i--) {
-		struct nvme_queue *nvmeq = dev->queues[i];
-
-		if (nvme_suspend_queue(nvmeq))
-			continue;
-		nvmeq->cmdinfo.ctx = nvme_get_dq(&dq);
-		nvmeq->cmdinfo.worker = dq.worker;
-		init_kthread_work(&nvmeq->cmdinfo.work,
nvme_del_queue_start);
-		queue_kthread_work(dq.worker, &nvmeq->cmdinfo.work);
-	}
-	nvme_wait_dq(&dq, dev);
-	kthread_stop(kworker_task);
-}
-
-/*
-* Remove the node from the device list and check
-* for whether or not we need to stop the nvme_thread.
-*/
-static void nvme_dev_list_remove(struct nvme_dev *dev)
-{
-	struct task_struct *tmp = NULL;
-
-	spin_lock(&dev_list_lock);
-	list_del_init(&dev->node);
-	if (list_empty(&dev_list) && !IS_ERR_OR_NULL(nvme_thread)) {
-		tmp = nvme_thread;
-		nvme_thread = NULL;
-	}
-	spin_unlock(&dev_list_lock);
-
-	if (tmp)
-		kthread_stop(tmp);
-}
-
-static void nvme_freeze_queues(struct nvme_dev *dev)
-{
-	struct nvme_ns *ns;
-
-	list_for_each_entry(ns, &dev->namespaces, list) {
-		blk_mq_freeze_queue_start(ns->queue);
-
-		spin_lock_irq(ns->queue->queue_lock);
-		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
-		spin_unlock_irq(ns->queue->queue_lock);
-
-		blk_mq_cancel_requeue_work(ns->queue);
-		blk_mq_stop_hw_queues(ns->queue);
-	}
-}
-
-static void nvme_unfreeze_queues(struct nvme_dev *dev)
-{
-	struct nvme_ns *ns;
-
-	list_for_each_entry(ns, &dev->namespaces, list) {
-		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns
->queue);
-		blk_mq_unfreeze_queue(ns->queue);
-		blk_mq_start_stopped_hw_queues(ns->queue, true);
-		blk_mq_kick_requeue_list(ns->queue);
-	}
-}
-
-static void nvme_dev_shutdown(struct nvme_dev *dev)
-{
-	int i;
-	u32 csts = -1;
-
-	nvme_dev_list_remove(dev);
-
-	if (dev->bar) {
-		nvme_freeze_queues(dev);
-		csts = readl(&dev->bar->csts);
-	}
-	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
-		for (i = dev->queue_count - 1; i >= 0; i--) {
-			struct nvme_queue *nvmeq = dev->queues[i];
-			nvme_suspend_queue(nvmeq);
-		}
-	} else {
-		nvme_disable_io_queues(dev);
-		nvme_shutdown_ctrl(dev);
-		nvme_disable_queue(dev, 0);
-	}
-	nvme_dev_unmap(dev);
-
-	for (i = dev->queue_count - 1; i >= 0; i--)
-		nvme_clear_queue(dev->queues[i]);
-}
-
-static void nvme_dev_remove(struct nvme_dev *dev)
-{
-	struct nvme_ns *ns;
-
-	list_for_each_entry(ns, &dev->namespaces, list)
-		nvme_ns_remove(ns);
-}
-
-static int nvme_setup_prp_pools(struct nvme_dev *dev)
-{
-	dev->prp_page_pool = dma_pool_create("prp list page", dev
->dev,
-						PAGE_SIZE, PAGE_SIZE,
0);
-	if (!dev->prp_page_pool)
-		return -ENOMEM;
-
-	/* Optimisation for I/Os between 4k and 128k */
-	dev->prp_small_pool = dma_pool_create("prp list 256", dev
->dev,
-						256, 256, 0);
-	if (!dev->prp_small_pool) {
-		dma_pool_destroy(dev->prp_page_pool);
-		return -ENOMEM;
-	}
-	return 0;
-}
-
-static void nvme_release_prp_pools(struct nvme_dev *dev)
-{
-	dma_pool_destroy(dev->prp_page_pool);
-	dma_pool_destroy(dev->prp_small_pool);
-}
-
-static DEFINE_IDA(nvme_instance_ida);
-
-static int nvme_set_instance(struct nvme_dev *dev)
-{
-	int instance, error;
-
-	do {
-		if (!ida_pre_get(&nvme_instance_ida, GFP_KERNEL))
-			return -ENODEV;
-
-		spin_lock(&dev_list_lock);
-		error = ida_get_new(&nvme_instance_ida, &instance);
-		spin_unlock(&dev_list_lock);
-	} while (error == -EAGAIN);
-
-	if (error)
-		return -ENODEV;
-
-	dev->instance = instance;
-	return 0;
-}
-
-static void nvme_release_instance(struct nvme_dev *dev)
-{
-	spin_lock(&dev_list_lock);
-	ida_remove(&nvme_instance_ida, dev->instance);
-	spin_unlock(&dev_list_lock);
-}
-
-static void nvme_free_namespaces(struct nvme_dev *dev)
-{
-	struct nvme_ns *ns, *next;
-
-	list_for_each_entry_safe(ns, next, &dev->namespaces, list)
-		nvme_free_namespace(ns);
-}
-
-static void nvme_free_dev(struct kref *kref)
-{
-	struct nvme_dev *dev = container_of(kref, struct nvme_dev,
kref);
-
-	put_device(dev->dev);
-	put_device(dev->device);
-	nvme_free_namespaces(dev);
-	nvme_release_instance(dev);
-	if (dev->tagset.tags)
-		blk_mq_free_tag_set(&dev->tagset);
-	if (dev->admin_q)
-		blk_put_queue(dev->admin_q);
-	kfree(dev->queues);
-	kfree(dev->entry);
-	kfree(dev);
-}
-
-static int nvme_dev_open(struct inode *inode, struct file *f)
-{
-	struct nvme_dev *dev;
-	int instance = iminor(inode);
-	int ret = -ENODEV;
-
-	spin_lock(&dev_list_lock);
-	list_for_each_entry(dev, &dev_list, node) {
-		if (dev->instance == instance) {
-			if (!dev->admin_q) {
-				ret = -EWOULDBLOCK;
-				break;
-			}
-			if (!kref_get_unless_zero(&dev->kref))
-				break;
-			f->private_data = dev;
-			ret = 0;
-			break;
-		}
-	}
-	spin_unlock(&dev_list_lock);
-
-	return ret;
-}
-
-static int nvme_dev_release(struct inode *inode, struct file *f)
-{
-	struct nvme_dev *dev = f->private_data;
-	kref_put(&dev->kref, nvme_free_dev);
-	return 0;
-}
-
-static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned
long arg)
-{
-	struct nvme_dev *dev = f->private_data;
-	struct nvme_ns *ns;
-
-	switch (cmd) {
-	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(dev, NULL, (void __user *)arg);
-	case NVME_IOCTL_IO_CMD:
-		if (list_empty(&dev->namespaces))
-			return -ENOTTY;
-		ns = list_first_entry(&dev->namespaces, struct
nvme_ns, list);
-		return nvme_user_cmd(dev, ns, (void __user *)arg);
-	case NVME_IOCTL_RESET:
-		dev_warn(dev->dev, "resetting controller\n");
-		return nvme_reset(dev);
-	case NVME_IOCTL_SUBSYS_RESET:
-		return nvme_subsys_reset(dev);
-	default:
-		return -ENOTTY;
-	}
-}
-
-static const struct file_operations nvme_dev_fops = {
-	.owner		= THIS_MODULE,
-	.open		= nvme_dev_open,
-	.release	= nvme_dev_release,
-	.unlocked_ioctl	= nvme_dev_ioctl,
-	.compat_ioctl	= nvme_dev_ioctl,
-};
-
-static void nvme_set_irq_hints(struct nvme_dev *dev)
-{
-	struct nvme_queue *nvmeq;
-	int i;
-
-	for (i = 0; i < dev->online_queues; i++) {
-		nvmeq = dev->queues[i];
-
-		if (!nvmeq->tags || !(*nvmeq->tags))
-			continue;
-
-		irq_set_affinity_hint(dev->entry[nvmeq
->cq_vector].vector,
-					blk_mq_tags_cpumask(*nvmeq
->tags));
-	}
-}
-
-static int nvme_dev_start(struct nvme_dev *dev)
-{
-	int result;
-	bool start_thread = false;
-
-	result = nvme_dev_map(dev);
-	if (result)
-		return result;
-
-	result = nvme_configure_admin_queue(dev);
-	if (result)
-		goto unmap;
-
-	spin_lock(&dev_list_lock);
-	if (list_empty(&dev_list) && IS_ERR_OR_NULL(nvme_thread)) {
-		start_thread = true;
-		nvme_thread = NULL;
-	}
-	list_add(&dev->node, &dev_list);
-	spin_unlock(&dev_list_lock);
-
-	if (start_thread) {
-		nvme_thread = kthread_run(nvme_kthread, NULL, "nvme");
-		wake_up_all(&nvme_kthread_wait);
-	} else
-		wait_event_killable(nvme_kthread_wait, nvme_thread);
-
-	if (IS_ERR_OR_NULL(nvme_thread)) {
-		result = nvme_thread ? PTR_ERR(nvme_thread) : -EINTR;
-		goto disable;
-	}
-
-	nvme_init_queue(dev->queues[0], 0);
-	result = nvme_alloc_admin_tags(dev);
-	if (result)
-		goto disable;
-
-	result = nvme_setup_io_queues(dev);
-	if (result)
-		goto free_tags;
-
-	nvme_set_irq_hints(dev);
-
-	dev->event_limit = 1;
-	return result;
-
- free_tags:
-	nvme_dev_remove_admin(dev);
-	blk_put_queue(dev->admin_q);
-	dev->admin_q = NULL;
-	dev->queues[0]->tags = NULL;
- disable:
-	nvme_disable_queue(dev, 0);
-	nvme_dev_list_remove(dev);
- unmap:
-	nvme_dev_unmap(dev);
-	return result;
-}
-
-static int nvme_remove_dead_ctrl(void *arg)
-{
-	struct nvme_dev *dev = (struct nvme_dev *)arg;
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
-
-	if (pci_get_drvdata(pdev))
-		pci_stop_and_remove_bus_device_locked(pdev);
-	kref_put(&dev->kref, nvme_free_dev);
-	return 0;
-}
-
-static void nvme_remove_disks(struct work_struct *ws)
-{
-	struct nvme_dev *dev = container_of(ws, struct nvme_dev,
reset_work);
-
-	nvme_free_queues(dev, 1);
-	nvme_dev_remove(dev);
-}
-
-static int nvme_dev_resume(struct nvme_dev *dev)
-{
-	int ret;
-
-	ret = nvme_dev_start(dev);
-	if (ret)
-		return ret;
-	if (dev->online_queues < 2) {
-		spin_lock(&dev_list_lock);
-		dev->reset_workfn = nvme_remove_disks;
-		queue_work(nvme_workq, &dev->reset_work);
-		spin_unlock(&dev_list_lock);
-	} else {
-		nvme_unfreeze_queues(dev);
-		nvme_dev_add(dev);
-		nvme_set_irq_hints(dev);
-	}
-	return 0;
-}
-
-static void nvme_dead_ctrl(struct nvme_dev *dev)
-{
-	dev_warn(dev->dev, "Device failed to resume\n");
-	kref_get(&dev->kref);
-	if (IS_ERR(kthread_run(nvme_remove_dead_ctrl, dev, "nvme%d",
-						dev->instance))) {
-		dev_err(dev->dev,
-			"Failed to start controller remove task\n");
-		kref_put(&dev->kref, nvme_free_dev);
-	}
-}
-
-static void nvme_dev_reset(struct nvme_dev *dev)
-{
-	bool in_probe = work_busy(&dev->probe_work);
-
-	nvme_dev_shutdown(dev);
-
-	/* Synchronize with device probe so that work will see failure
status
-	 * and exit gracefully without trying to schedule another
reset */
-	flush_work(&dev->probe_work);
-
-	/* Fail this device if reset occured during probe to avoid
-	 * infinite initialization loops. */
-	if (in_probe) {
-		nvme_dead_ctrl(dev);
-		return;
-	}
-	/* Schedule device resume asynchronously so the reset work is
available
-	 * to cleanup errors that may occur during reinitialization */
-	schedule_work(&dev->probe_work);
-}
-
-static void nvme_reset_failed_dev(struct work_struct *ws)
-{
-	struct nvme_dev *dev = container_of(ws, struct nvme_dev,
reset_work);
-	nvme_dev_reset(dev);
-}
-
-static void nvme_reset_workfn(struct work_struct *work)
-{
-	struct nvme_dev *dev = container_of(work, struct nvme_dev,
reset_work);
-	dev->reset_workfn(work);
-}
-
-static int nvme_reset(struct nvme_dev *dev)
-{
-	int ret = -EBUSY;
-
-	if (!dev->admin_q || blk_queue_dying(dev->admin_q))
-		return -ENODEV;
-
-	spin_lock(&dev_list_lock);
-	if (!work_pending(&dev->reset_work)) {
-		dev->reset_workfn = nvme_reset_failed_dev;
-		queue_work(nvme_workq, &dev->reset_work);
-		ret = 0;
-	}
-	spin_unlock(&dev_list_lock);
-
-	if (!ret) {
-		flush_work(&dev->reset_work);
-		flush_work(&dev->probe_work);
-		return 0;
-	}
-
-	return ret;
-}
-
-static ssize_t nvme_sysfs_reset(struct device *dev,
-				struct device_attribute *attr, const
char *buf,
-				size_t count)
-{
-	struct nvme_dev *ndev = dev_get_drvdata(dev);
-	int ret;
-
-	ret = nvme_reset(ndev);
-	if (ret < 0)
-		return ret;
-
-	return count;
-}
-static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
-
-static void nvme_async_probe(struct work_struct *work);
-static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id
*id)
-{
-	int node, result = -ENOMEM;
-	struct nvme_dev *dev;
-
-	node = dev_to_node(&pdev->dev);
-	if (node == NUMA_NO_NODE)
-		set_dev_node(&pdev->dev, 0);
-
-	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
-	if (!dev)
-		return -ENOMEM;
-	dev->entry = kzalloc_node(num_possible_cpus() * sizeof(*dev
->entry),
-							GFP_KERNEL,
node);
-	if (!dev->entry)
-		goto free;
-	dev->queues = kzalloc_node((num_possible_cpus() + 1) *
sizeof(void *),
-							GFP_KERNEL,
node);
-	if (!dev->queues)
-		goto free;
-
-	INIT_LIST_HEAD(&dev->namespaces);
-	dev->reset_workfn = nvme_reset_failed_dev;
-	INIT_WORK(&dev->reset_work, nvme_reset_workfn);
-	dev->dev = get_device(&pdev->dev);
-	pci_set_drvdata(pdev, dev);
-	result = nvme_set_instance(dev);
-	if (result)
-		goto put_pci;
-
-	result = nvme_setup_prp_pools(dev);
-	if (result)
-		goto release;
-
-	kref_init(&dev->kref);
-	dev->device = device_create(nvme_class, &pdev->dev,
-				MKDEV(nvme_char_major, dev->instance),
-				dev, "nvme%d", dev->instance);
-	if (IS_ERR(dev->device)) {
-		result = PTR_ERR(dev->device);
-		goto release_pools;
-	}
-	get_device(dev->device);
-	dev_set_drvdata(dev->device, dev);
-
-	result = device_create_file(dev->device,
&dev_attr_reset_controller);
-	if (result)
-		goto put_dev;
-
-	INIT_LIST_HEAD(&dev->node);
-	INIT_WORK(&dev->scan_work, nvme_dev_scan);
-	INIT_WORK(&dev->probe_work, nvme_async_probe);
-	schedule_work(&dev->probe_work);
-	return 0;
-
- put_dev:
-	device_destroy(nvme_class, MKDEV(nvme_char_major, dev
->instance));
-	put_device(dev->device);
- release_pools:
-	nvme_release_prp_pools(dev);
- release:
-	nvme_release_instance(dev);
- put_pci:
-	put_device(dev->dev);
- free:
-	kfree(dev->queues);
-	kfree(dev->entry);
-	kfree(dev);
-	return result;
-}
-
-static void nvme_async_probe(struct work_struct *work)
-{
-	struct nvme_dev *dev = container_of(work, struct nvme_dev,
probe_work);
-
-	if (nvme_dev_resume(dev) && !work_busy(&dev->reset_work))
-		nvme_dead_ctrl(dev);
-}
-
-static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
-{
-	struct nvme_dev *dev = pci_get_drvdata(pdev);
-
-	if (prepare)
-		nvme_dev_shutdown(dev);
-	else
-		nvme_dev_resume(dev);
-}
-
-static void nvme_shutdown(struct pci_dev *pdev)
-{
-	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_shutdown(dev);
-}
-
-static void nvme_remove(struct pci_dev *pdev)
-{
-	struct nvme_dev *dev = pci_get_drvdata(pdev);
-
-	spin_lock(&dev_list_lock);
-	list_del_init(&dev->node);
-	spin_unlock(&dev_list_lock);
-
-	pci_set_drvdata(pdev, NULL);
-	flush_work(&dev->probe_work);
-	flush_work(&dev->reset_work);
-	flush_work(&dev->scan_work);
-	device_remove_file(dev->device, &dev_attr_reset_controller);
-	nvme_dev_remove(dev);
-	nvme_dev_shutdown(dev);
-	nvme_dev_remove_admin(dev);
-	device_destroy(nvme_class, MKDEV(nvme_char_major, dev
->instance));
-	nvme_free_queues(dev, 0);
-	nvme_release_cmb(dev);
-	nvme_release_prp_pools(dev);
-	kref_put(&dev->kref, nvme_free_dev);
-}
-
-/* These functions are yet to be implemented */
-#define nvme_error_detected NULL
-#define nvme_dump_registers NULL
-#define nvme_link_reset NULL
-#define nvme_slot_reset NULL
-#define nvme_error_resume NULL
-
-#ifdef CONFIG_PM_SLEEP
-static int nvme_suspend(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct nvme_dev *ndev = pci_get_drvdata(pdev);
-
-	nvme_dev_shutdown(ndev);
-	return 0;
-}
-
-static int nvme_resume(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct nvme_dev *ndev = pci_get_drvdata(pdev);
-
-	if (nvme_dev_resume(ndev) && !work_busy(&ndev->reset_work)) {
-		ndev->reset_workfn = nvme_reset_failed_dev;
-		queue_work(nvme_workq, &ndev->reset_work);
-	}
-	return 0;
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
-
-static const struct pci_error_handlers nvme_err_handler = {
-	.error_detected	= nvme_error_detected,
-	.mmio_enabled	= nvme_dump_registers,
-	.link_reset	= nvme_link_reset,
-	.slot_reset	= nvme_slot_reset,
-	.resume		= nvme_error_resume,
-	.reset_notify	= nvme_reset_notify,
-};
-
-/* Move to pci_ids.h later */
-#define PCI_CLASS_STORAGE_EXPRESS	0x010802
-
-static const struct pci_device_id nvme_id_table[] = {
-	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
-	{ 0, }
-};
-MODULE_DEVICE_TABLE(pci, nvme_id_table);
-
-static struct pci_driver nvme_driver = {
-	.name		= "nvme",
-	.id_table	= nvme_id_table,
-	.probe		= nvme_probe,
-	.remove		= nvme_remove,
-	.shutdown	= nvme_shutdown,
-	.driver		= {
-		.pm	= &nvme_dev_pm_ops,
-	},
-	.err_handler	= &nvme_err_handler,
-};
-
-static int __init nvme_init(void)
-{
-	int result;
-
-	init_waitqueue_head(&nvme_kthread_wait);
-
-	nvme_workq = create_singlethread_workqueue("nvme");
-	if (!nvme_workq)
-		return -ENOMEM;
-
-	result = register_blkdev(nvme_major, "nvme");
-	if (result < 0)
-		goto kill_workq;
-	else if (result > 0)
-		nvme_major = result;
-
-	result = __register_chrdev(nvme_char_major, 0, NVME_MINORS,
"nvme",
-							&nvme_dev_fops
);
-	if (result < 0)
-		goto unregister_blkdev;
-	else if (result > 0)
-		nvme_char_major = result;
-
-	nvme_class = class_create(THIS_MODULE, "nvme");
-	if (IS_ERR(nvme_class)) {
-		result = PTR_ERR(nvme_class);
-		goto unregister_chrdev;
-	}
-
-	result = pci_register_driver(&nvme_driver);
-	if (result)
-		goto destroy_class;
-	return 0;
-
- destroy_class:
-	class_destroy(nvme_class);
- unregister_chrdev:
-	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
- unregister_blkdev:
-	unregister_blkdev(nvme_major, "nvme");
- kill_workq:
-	destroy_workqueue(nvme_workq);
-	return result;
-}
-
-static void __exit nvme_exit(void)
-{
-	pci_unregister_driver(&nvme_driver);
-	unregister_blkdev(nvme_major, "nvme");
-	destroy_workqueue(nvme_workq);
-	class_destroy(nvme_class);
-	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
-	BUG_ON(nvme_thread && !IS_ERR(nvme_thread));
-	_nvme_check_size();
-}
-
-MODULE_AUTHOR("Matthew Wilcox <willy at linux.intel.com>");
-MODULE_LICENSE("GPL");
-MODULE_VERSION("1.0");
-module_init(nvme_init);
-module_exit(nvme_exit);
diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
deleted file mode 100644
index e5a63f0..0000000
--- a/drivers/block/nvme-scsi.c
+++ /dev/null
@@ -1,2556 +0,0 @@
-/*
- * NVM Express device driver
- * Copyright (c) 2011-2014, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or
modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but
WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
License for
- * more details.
- */
-
-/*
- * Refer to the SCSI-NVMe Translation spec for details on how
- * each command is translated.
- */
-
-#include <linux/nvme.h>
-#include <linux/bio.h>
-#include <linux/bitops.h>
-#include <linux/blkdev.h>
-#include <linux/compat.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/genhd.h>
-#include <linux/idr.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/kdev_t.h>
-#include <linux/kthread.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/pci.h>
-#include <linux/poison.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <asm/unaligned.h>
-#include <scsi/sg.h>
-#include <scsi/scsi.h>
-
-
-static int sg_version_num = 30534;	/* 2 digits for each component
*/
-
-/* VPD Page Codes */
-#define VPD_SUPPORTED_PAGES				0x00
-#define VPD_SERIAL_NUMBER				0x80
-#define VPD_DEVICE_IDENTIFIERS				0x83
-#define VPD_EXTENDED_INQUIRY				0x86
-#define VPD_BLOCK_LIMITS				0xB0
-#define VPD_BLOCK_DEV_CHARACTERISTICS			0xB1
-
-/* format unit paramter list offsets */
-#define FORMAT_UNIT_SHORT_PARM_LIST_LEN			4
-#define FORMAT_UNIT_LONG_PARM_LIST_LEN			8
-#define FORMAT_UNIT_PROT_INT_OFFSET			3
-#define FORMAT_UNIT_PROT_FIELD_USAGE_OFFSET		0
-#define FORMAT_UNIT_PROT_FIELD_USAGE_MASK		0x07
-
-/* Misc. defines */
-#define FIXED_SENSE_DATA				0x70
-#define DESC_FORMAT_SENSE_DATA				0x72
-#define FIXED_SENSE_DATA_ADD_LENGTH			10
-#define LUN_ENTRY_SIZE					8
-#define LUN_DATA_HEADER_SIZE				8
-#define ALL_LUNS_RETURNED				0x02
-#define ALL_WELL_KNOWN_LUNS_RETURNED			0x01
-#define RESTRICTED_LUNS_RETURNED			0x00
-#define NVME_POWER_STATE_START_VALID			0x00
-#define NVME_POWER_STATE_ACTIVE				0x01
-#define NVME_POWER_STATE_IDLE				0x02
-#define NVME_POWER_STATE_STANDBY			0x03
-#define NVME_POWER_STATE_LU_CONTROL			0x07
-#define POWER_STATE_0					0
-#define POWER_STATE_1					1
-#define POWER_STATE_2					2
-#define POWER_STATE_3					3
-#define DOWNLOAD_SAVE_ACTIVATE				0x05
-#define DOWNLOAD_SAVE_DEFER_ACTIVATE			0x0E
-#define ACTIVATE_DEFERRED_MICROCODE			0x0F
-#define FORMAT_UNIT_IMMED_MASK				0x2
-#define FORMAT_UNIT_IMMED_OFFSET			1
-#define KELVIN_TEMP_FACTOR				273
-#define FIXED_FMT_SENSE_DATA_SIZE			18
-#define DESC_FMT_SENSE_DATA_SIZE			8
-
-/* SCSI/NVMe defines and bit masks */
-#define INQ_STANDARD_INQUIRY_PAGE			0x00
-#define INQ_SUPPORTED_VPD_PAGES_PAGE			0x00
-#define INQ_UNIT_SERIAL_NUMBER_PAGE			0x80
-#define INQ_DEVICE_IDENTIFICATION_PAGE			0x83
-#define INQ_EXTENDED_INQUIRY_DATA_PAGE			0x86
-#define INQ_BDEV_LIMITS_PAGE				0xB0
-#define INQ_BDEV_CHARACTERISTICS_PAGE			0xB1
-#define INQ_SERIAL_NUMBER_LENGTH			0x14
-#define INQ_NUM_SUPPORTED_VPD_PAGES			6
-#define VERSION_SPC_4					0x06
-#define ACA_UNSUPPORTED					0
-#define STANDARD_INQUIRY_LENGTH				36
-#define ADDITIONAL_STD_INQ_LENGTH			31
-#define EXTENDED_INQUIRY_DATA_PAGE_LENGTH		0x3C
-#define RESERVED_FIELD					0
-
-/* Mode Sense/Select defines */
-#define MODE_PAGE_INFO_EXCEP				0x1C
-#define MODE_PAGE_CACHING				0x08
-#define MODE_PAGE_CONTROL				0x0A
-#define MODE_PAGE_POWER_CONDITION			0x1A
-#define MODE_PAGE_RETURN_ALL				0x3F
-#define MODE_PAGE_BLK_DES_LEN				0x08
-#define MODE_PAGE_LLBAA_BLK_DES_LEN			0x10
-#define MODE_PAGE_CACHING_LEN				0x14
-#define MODE_PAGE_CONTROL_LEN				0x0C
-#define MODE_PAGE_POW_CND_LEN				0x28
-#define MODE_PAGE_INF_EXC_LEN				0x0C
-#define MODE_PAGE_ALL_LEN				0x54
-#define MODE_SENSE6_MPH_SIZE				4
-#define MODE_SENSE_PAGE_CONTROL_MASK			0xC0
-#define MODE_SENSE_PAGE_CODE_OFFSET			2
-#define MODE_SENSE_PAGE_CODE_MASK			0x3F
-#define MODE_SENSE_LLBAA_MASK				0x10
-#define MODE_SENSE_LLBAA_SHIFT				4
-#define MODE_SENSE_DBD_MASK				8
-#define MODE_SENSE_DBD_SHIFT				3
-#define MODE_SENSE10_MPH_SIZE				8
-#define MODE_SELECT_CDB_PAGE_FORMAT_MASK		0x10
-#define MODE_SELECT_CDB_SAVE_PAGES_MASK			0x1
-#define MODE_SELECT_6_BD_OFFSET				3
-#define MODE_SELECT_10_BD_OFFSET			6
-#define MODE_SELECT_10_LLBAA_OFFSET			4
-#define MODE_SELECT_10_LLBAA_MASK			1
-#define MODE_SELECT_6_MPH_SIZE				4
-#define MODE_SELECT_10_MPH_SIZE				8
-#define CACHING_MODE_PAGE_WCE_MASK			0x04
-#define MODE_SENSE_BLK_DESC_ENABLED			0
-#define MODE_SENSE_BLK_DESC_COUNT			1
-#define MODE_SELECT_PAGE_CODE_MASK			0x3F
-#define SHORT_DESC_BLOCK				8
-#define LONG_DESC_BLOCK					16
-#define MODE_PAGE_POW_CND_LEN_FIELD			0x26
-#define MODE_PAGE_INF_EXC_LEN_FIELD			0x0A
-#define MODE_PAGE_CACHING_LEN_FIELD			0x12
-#define MODE_PAGE_CONTROL_LEN_FIELD			0x0A
-#define MODE_SENSE_PC_CURRENT_VALUES			0
-
-/* Log Sense defines */
-#define LOG_PAGE_SUPPORTED_LOG_PAGES_PAGE		0x00
-#define LOG_PAGE_SUPPORTED_LOG_PAGES_LENGTH		0x07
-#define LOG_PAGE_INFORMATIONAL_EXCEPTIONS_PAGE		0x2F
-#define LOG_PAGE_TEMPERATURE_PAGE			0x0D
-#define LOG_SENSE_CDB_SP_NOT_ENABLED			0
-#define LOG_SENSE_CDB_PC_MASK				0xC0
-#define LOG_SENSE_CDB_PC_SHIFT				6
-#define LOG_SENSE_CDB_PC_CUMULATIVE_VALUES		1
-#define LOG_SENSE_CDB_PAGE_CODE_MASK			0x3F
-#define REMAINING_INFO_EXCP_PAGE_LENGTH			0x8
-#define LOG_INFO_EXCP_PAGE_LENGTH			0xC
-#define REMAINING_TEMP_PAGE_LENGTH			0xC
-#define LOG_TEMP_PAGE_LENGTH				0x10
-#define LOG_TEMP_UNKNOWN				0xFF
-#define SUPPORTED_LOG_PAGES_PAGE_LENGTH			0x3
-
-/* Read Capacity defines */
-#define READ_CAP_10_RESP_SIZE				8
-#define READ_CAP_16_RESP_SIZE				32
-
-/* NVMe Namespace and Command Defines */
-#define BYTES_TO_DWORDS					4
-#define NVME_MAX_FIRMWARE_SLOT				7
-
-/* Report LUNs defines */
-#define REPORT_LUNS_FIRST_LUN_OFFSET			8
-
-/* SCSI ADDITIONAL SENSE Codes */
-
-#define SCSI_ASC_NO_SENSE				0x00
-#define SCSI_ASC_PERIPHERAL_DEV_WRITE_FAULT		0x03
-#define SCSI_ASC_LUN_NOT_READY				0x04
-#define SCSI_ASC_WARNING				0x0B
-#define SCSI_ASC_LOG_BLOCK_GUARD_CHECK_FAILED		0x10
-#define SCSI_ASC_LOG_BLOCK_APPTAG_CHECK_FAILED		0x10
-#define SCSI_ASC_LOG_BLOCK_REFTAG_CHECK_FAILED		0x10
-#define SCSI_ASC_UNRECOVERED_READ_ERROR			0x11
-#define SCSI_ASC_MISCOMPARE_DURING_VERIFY		0x1D
-#define SCSI_ASC_ACCESS_DENIED_INVALID_LUN_ID		0x20
-#define SCSI_ASC_ILLEGAL_COMMAND			0x20
-#define SCSI_ASC_ILLEGAL_BLOCK				0x21
-#define SCSI_ASC_INVALID_CDB				0x24
-#define SCSI_ASC_INVALID_LUN				0x25
-#define SCSI_ASC_INVALID_PARAMETER			0x26
-#define SCSI_ASC_FORMAT_COMMAND_FAILED			0x31
-#define SCSI_ASC_INTERNAL_TARGET_FAILURE		0x44
-
-/* SCSI ADDITIONAL SENSE Code Qualifiers */
-
-#define SCSI_ASCQ_CAUSE_NOT_REPORTABLE			0x00
-#define SCSI_ASCQ_FORMAT_COMMAND_FAILED			0x01
-#define SCSI_ASCQ_LOG_BLOCK_GUARD_CHECK_FAILED		0x01
-#define SCSI_ASCQ_LOG_BLOCK_APPTAG_CHECK_FAILED		0x02
-#define SCSI_ASCQ_LOG_BLOCK_REFTAG_CHECK_FAILED		0x03
-#define SCSI_ASCQ_FORMAT_IN_PROGRESS			0x04
-#define SCSI_ASCQ_POWER_LOSS_EXPECTED			0x08
-#define SCSI_ASCQ_INVALID_LUN_ID			0x09
-
-/* copied from drivers/usb/gadget/function/storage_common.h */
-static inline u32 get_unaligned_be24(u8 *buf)
-{
-	return 0xffffff & (u32) get_unaligned_be32(buf - 1);
-}
-
-/* Struct to gather data that needs to be extracted from a SCSI CDB.
-   Not conforming to any particular CDB variant, but compatible with
all. */
-
-struct nvme_trans_io_cdb {
-	u8 fua;
-	u8 prot_info;
-	u64 lba;
-	u32 xfer_len;
-};
-
-
-/* Internal Helper Functions */
-
-
-/* Copy data to userspace memory */
-
-static int nvme_trans_copy_to_user(struct sg_io_hdr *hdr, void *from,
-								unsign
ed long n)
-{
-	int i;
-	void *index = from;
-	size_t remaining = n;
-	size_t xfer_len;
-
-	if (hdr->iovec_count > 0) {
-		struct sg_iovec sgl;
-
-		for (i = 0; i < hdr->iovec_count; i++) {
-			if (copy_from_user(&sgl, hdr->dxferp +
-						i * sizeof(struct
sg_iovec),
-						sizeof(struct
sg_iovec)))
-				return -EFAULT;
-			xfer_len = min(remaining, sgl.iov_len);
-			if (copy_to_user(sgl.iov_base, index,
xfer_len))
-				return -EFAULT;
-
-			index += xfer_len;
-			remaining -= xfer_len;
-			if (remaining == 0)
-				break;
-		}
-		return 0;
-	}
-
-	if (copy_to_user(hdr->dxferp, from, n))
-		return -EFAULT;
-	return 0;
-}
-
-/* Copy data from userspace memory */
-
-static int nvme_trans_copy_from_user(struct sg_io_hdr *hdr, void *to,
-								unsign
ed long n)
-{
-	int i;
-	void *index = to;
-	size_t remaining = n;
-	size_t xfer_len;
-
-	if (hdr->iovec_count > 0) {
-		struct sg_iovec sgl;
-
-		for (i = 0; i < hdr->iovec_count; i++) {
-			if (copy_from_user(&sgl, hdr->dxferp +
-						i * sizeof(struct
sg_iovec),
-						sizeof(struct
sg_iovec)))
-				return -EFAULT;
-			xfer_len = min(remaining, sgl.iov_len);
-			if (copy_from_user(index, sgl.iov_base,
xfer_len))
-				return -EFAULT;
-			index += xfer_len;
-			remaining -= xfer_len;
-			if (remaining == 0)
-				break;
-		}
-		return 0;
-	}
-
-	if (copy_from_user(to, hdr->dxferp, n))
-		return -EFAULT;
-	return 0;
-}
-
-/* Status/Sense Buffer Writeback */
-
-static int nvme_trans_completion(struct sg_io_hdr *hdr, u8 status, u8
sense_key,
-				 u8 asc, u8 ascq)
-{
-	u8 xfer_len;
-	u8 resp[DESC_FMT_SENSE_DATA_SIZE];
-
-	if (scsi_status_is_good(status)) {
-		hdr->status = SAM_STAT_GOOD;
-		hdr->masked_status = GOOD;
-		hdr->host_status = DID_OK;
-		hdr->driver_status = DRIVER_OK;
-		hdr->sb_len_wr = 0;
-	} else {
-		hdr->status = status;
-		hdr->masked_status = status >> 1;
-		hdr->host_status = DID_OK;
-		hdr->driver_status = DRIVER_OK;
-
-		memset(resp, 0, DESC_FMT_SENSE_DATA_SIZE);
-		resp[0] = DESC_FORMAT_SENSE_DATA;
-		resp[1] = sense_key;
-		resp[2] = asc;
-		resp[3] = ascq;
-
-		xfer_len = min_t(u8, hdr->mx_sb_len,
DESC_FMT_SENSE_DATA_SIZE);
-		hdr->sb_len_wr = xfer_len;
-		if (copy_to_user(hdr->sbp, resp, xfer_len) > 0)
-			return -EFAULT;
-	}
-
-	return 0;
-}
-
-/*
- * Take a status code from a lowlevel routine, and if it was a
positive NVMe
- * error code update the sense data based on it.  In either case the
passed
- * in value is returned again, unless an -EFAULT from copy_to_user
overrides
- * it.
- */
-static int nvme_trans_status_code(struct sg_io_hdr *hdr, int nvme_sc)
-{
-	u8 status, sense_key, asc, ascq;
-	int res;
-
-	/* For non-nvme (Linux) errors, simply return the error code
*/
-	if (nvme_sc < 0)
-		return nvme_sc;
-
-	/* Mask DNR, More, and reserved fields */
-	switch (nvme_sc & 0x7FF) {
-	/* Generic Command Status */
-	case NVME_SC_SUCCESS:
-		status = SAM_STAT_GOOD;
-		sense_key = NO_SENSE;
-		asc = SCSI_ASC_NO_SENSE;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	case NVME_SC_INVALID_OPCODE:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = ILLEGAL_REQUEST;
-		asc = SCSI_ASC_ILLEGAL_COMMAND;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	case NVME_SC_INVALID_FIELD:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = ILLEGAL_REQUEST;
-		asc = SCSI_ASC_INVALID_CDB;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	case NVME_SC_DATA_XFER_ERROR:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = MEDIUM_ERROR;
-		asc = SCSI_ASC_NO_SENSE;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	case NVME_SC_POWER_LOSS:
-		status = SAM_STAT_TASK_ABORTED;
-		sense_key = ABORTED_COMMAND;
-		asc = SCSI_ASC_WARNING;
-		ascq = SCSI_ASCQ_POWER_LOSS_EXPECTED;
-		break;
-	case NVME_SC_INTERNAL:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = HARDWARE_ERROR;
-		asc = SCSI_ASC_INTERNAL_TARGET_FAILURE;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	case NVME_SC_ABORT_REQ:
-		status = SAM_STAT_TASK_ABORTED;
-		sense_key = ABORTED_COMMAND;
-		asc = SCSI_ASC_NO_SENSE;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	case NVME_SC_ABORT_QUEUE:
-		status = SAM_STAT_TASK_ABORTED;
-		sense_key = ABORTED_COMMAND;
-		asc = SCSI_ASC_NO_SENSE;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	case NVME_SC_FUSED_FAIL:
-		status = SAM_STAT_TASK_ABORTED;
-		sense_key = ABORTED_COMMAND;
-		asc = SCSI_ASC_NO_SENSE;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	case NVME_SC_FUSED_MISSING:
-		status = SAM_STAT_TASK_ABORTED;
-		sense_key = ABORTED_COMMAND;
-		asc = SCSI_ASC_NO_SENSE;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	case NVME_SC_INVALID_NS:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = ILLEGAL_REQUEST;
-		asc = SCSI_ASC_ACCESS_DENIED_INVALID_LUN_ID;
-		ascq = SCSI_ASCQ_INVALID_LUN_ID;
-		break;
-	case NVME_SC_LBA_RANGE:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = ILLEGAL_REQUEST;
-		asc = SCSI_ASC_ILLEGAL_BLOCK;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	case NVME_SC_CAP_EXCEEDED:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = MEDIUM_ERROR;
-		asc = SCSI_ASC_NO_SENSE;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	case NVME_SC_NS_NOT_READY:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = NOT_READY;
-		asc = SCSI_ASC_LUN_NOT_READY;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-
-	/* Command Specific Status */
-	case NVME_SC_INVALID_FORMAT:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = ILLEGAL_REQUEST;
-		asc = SCSI_ASC_FORMAT_COMMAND_FAILED;
-		ascq = SCSI_ASCQ_FORMAT_COMMAND_FAILED;
-		break;
-	case NVME_SC_BAD_ATTRIBUTES:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = ILLEGAL_REQUEST;
-		asc = SCSI_ASC_INVALID_CDB;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-
-	/* Media Errors */
-	case NVME_SC_WRITE_FAULT:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = MEDIUM_ERROR;
-		asc = SCSI_ASC_PERIPHERAL_DEV_WRITE_FAULT;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	case NVME_SC_READ_ERROR:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = MEDIUM_ERROR;
-		asc = SCSI_ASC_UNRECOVERED_READ_ERROR;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	case NVME_SC_GUARD_CHECK:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = MEDIUM_ERROR;
-		asc = SCSI_ASC_LOG_BLOCK_GUARD_CHECK_FAILED;
-		ascq = SCSI_ASCQ_LOG_BLOCK_GUARD_CHECK_FAILED;
-		break;
-	case NVME_SC_APPTAG_CHECK:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = MEDIUM_ERROR;
-		asc = SCSI_ASC_LOG_BLOCK_APPTAG_CHECK_FAILED;
-		ascq = SCSI_ASCQ_LOG_BLOCK_APPTAG_CHECK_FAILED;
-		break;
-	case NVME_SC_REFTAG_CHECK:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = MEDIUM_ERROR;
-		asc = SCSI_ASC_LOG_BLOCK_REFTAG_CHECK_FAILED;
-		ascq = SCSI_ASCQ_LOG_BLOCK_REFTAG_CHECK_FAILED;
-		break;
-	case NVME_SC_COMPARE_FAILED:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = MISCOMPARE;
-		asc = SCSI_ASC_MISCOMPARE_DURING_VERIFY;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	case NVME_SC_ACCESS_DENIED:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = ILLEGAL_REQUEST;
-		asc = SCSI_ASC_ACCESS_DENIED_INVALID_LUN_ID;
-		ascq = SCSI_ASCQ_INVALID_LUN_ID;
-		break;
-
-	/* Unspecified/Default */
-	case NVME_SC_CMDID_CONFLICT:
-	case NVME_SC_CMD_SEQ_ERROR:
-	case NVME_SC_CQ_INVALID:
-	case NVME_SC_QID_INVALID:
-	case NVME_SC_QUEUE_SIZE:
-	case NVME_SC_ABORT_LIMIT:
-	case NVME_SC_ABORT_MISSING:
-	case NVME_SC_ASYNC_LIMIT:
-	case NVME_SC_FIRMWARE_SLOT:
-	case NVME_SC_FIRMWARE_IMAGE:
-	case NVME_SC_INVALID_VECTOR:
-	case NVME_SC_INVALID_LOG_PAGE:
-	default:
-		status = SAM_STAT_CHECK_CONDITION;
-		sense_key = ILLEGAL_REQUEST;
-		asc = SCSI_ASC_NO_SENSE;
-		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		break;
-	}
-
-	res = nvme_trans_completion(hdr, status, sense_key, asc,
ascq);
-	return res ? res : nvme_sc;
-}
-
-/* INQUIRY Helper Functions */
-
-static int nvme_trans_standard_inquiry_page(struct nvme_ns *ns,
-					struct sg_io_hdr *hdr, u8
*inq_response,
-					int alloc_len)
-{
-	struct nvme_dev *dev = ns->dev;
-	struct nvme_id_ns *id_ns;
-	int res;
-	int nvme_sc;
-	int xfer_len;
-	u8 resp_data_format = 0x02;
-	u8 protect;
-	u8 cmdque = 0x01 << 1;
-	u8 fw_offset = sizeof(dev->firmware_rev);
-
-	/* nvme ns identify - use DPS value for PROTECT field */
-	nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
-	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		return res;
-
-	if (id_ns->dps)
-		protect = 0x01;
-	else
-		protect = 0;
-	kfree(id_ns);
-
-	memset(inq_response, 0, STANDARD_INQUIRY_LENGTH);
-	inq_response[2] = VERSION_SPC_4;
-	inq_response[3] = resp_data_format;	/*normaca=0 | hisup=0
*/
-	inq_response[4] = ADDITIONAL_STD_INQ_LENGTH;
-	inq_response[5] = protect;	/* sccs=0 | acc=0 | tpgs=0 |
pc3=0 */
-	inq_response[7] = cmdque;	/* wbus16=0 | sync=0 | vs=0 */
-	strncpy(&inq_response[8], "NVMe    ", 8);
-	strncpy(&inq_response[16], dev->model, 16);
-
-	while (dev->firmware_rev[fw_offset - 1] == ' ' && fw_offset >
4)
-		fw_offset--;
-	fw_offset -= 4;
-	strncpy(&inq_response[32], dev->firmware_rev + fw_offset, 4);
-
-	xfer_len = min(alloc_len, STANDARD_INQUIRY_LENGTH);
-	return nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
-}
-
-static int nvme_trans_supported_vpd_pages(struct nvme_ns *ns,
-					struct sg_io_hdr *hdr, u8
*inq_response,
-					int alloc_len)
-{
-	int xfer_len;
-
-	memset(inq_response, 0, STANDARD_INQUIRY_LENGTH);
-	inq_response[1] = INQ_SUPPORTED_VPD_PAGES_PAGE;   /* Page Code
*/
-	inq_response[3] = INQ_NUM_SUPPORTED_VPD_PAGES;    /* Page
Length */
-	inq_response[4] = INQ_SUPPORTED_VPD_PAGES_PAGE;
-	inq_response[5] = INQ_UNIT_SERIAL_NUMBER_PAGE;
-	inq_response[6] = INQ_DEVICE_IDENTIFICATION_PAGE;
-	inq_response[7] = INQ_EXTENDED_INQUIRY_DATA_PAGE;
-	inq_response[8] = INQ_BDEV_CHARACTERISTICS_PAGE;
-	inq_response[9] = INQ_BDEV_LIMITS_PAGE;
-
-	xfer_len = min(alloc_len, STANDARD_INQUIRY_LENGTH);
-	return nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
-}
-
-static int nvme_trans_unit_serial_page(struct nvme_ns *ns,
-					struct sg_io_hdr *hdr, u8
*inq_response,
-					int alloc_len)
-{
-	struct nvme_dev *dev = ns->dev;
-	int xfer_len;
-
-	memset(inq_response, 0, STANDARD_INQUIRY_LENGTH);
-	inq_response[1] = INQ_UNIT_SERIAL_NUMBER_PAGE; /* Page Code */
-	inq_response[3] = INQ_SERIAL_NUMBER_LENGTH;    /* Page Length
*/
-	strncpy(&inq_response[4], dev->serial,
INQ_SERIAL_NUMBER_LENGTH);
-
-	xfer_len = min(alloc_len, STANDARD_INQUIRY_LENGTH);
-	return nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
-}
-
-static int nvme_trans_device_id_page(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-					u8 *inq_response, int
alloc_len)
-{
-	struct nvme_dev *dev = ns->dev;
-	int res;
-	int nvme_sc;
-	int xfer_len;
-	__be32 tmp_id = cpu_to_be32(ns->ns_id);
-
-	memset(inq_response, 0, alloc_len);
-	inq_response[1] = INQ_DEVICE_IDENTIFICATION_PAGE;    /* Page
Code */
-	if (readl(&dev->bar->vs) >= NVME_VS(1, 1)) {
-		struct nvme_id_ns *id_ns;
-		void *eui;
-		int len;
-
-		nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
-		res = nvme_trans_status_code(hdr, nvme_sc);
-		if (res)
-			return res;
-
-		eui = id_ns->eui64;
-		len = sizeof(id_ns->eui64);
-		if (readl(&dev->bar->vs) >= NVME_VS(1, 2)) {
-			if (bitmap_empty(eui, len * 8)) {
-				eui = id_ns->nguid;
-				len = sizeof(id_ns->nguid);
-			}
-		}
-		if (bitmap_empty(eui, len * 8)) {
-			kfree(id_ns);
-			goto scsi_string;
-		}
-
-		inq_response[3] = 4 + len; /* Page Length */
-		/* Designation Descriptor start */
-		inq_response[4] = 0x01;    /* Proto ID=0h | Code
set=1h */
-		inq_response[5] = 0x02;    /* PIV=0b | Asso=00b |
Designator Type=2h */
-		inq_response[6] = 0x00;    /* Rsvd */
-		inq_response[7] = len;     /* Designator Length */
-		memcpy(&inq_response[8], eui, len);
-		kfree(id_ns);
-	} else {
- scsi_string:
-		if (alloc_len < 72) {
-			return nvme_trans_completion(hdr,
-					SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		}
-		inq_response[3] = 0x48;    /* Page Length */
-		/* Designation Descriptor start */
-		inq_response[4] = 0x03;    /* Proto ID=0h | Code
set=3h */
-		inq_response[5] = 0x08;    /* PIV=0b | Asso=00b |
Designator Type=8h */
-		inq_response[6] = 0x00;    /* Rsvd */
-		inq_response[7] = 0x44;    /* Designator Length */
-
-		sprintf(&inq_response[8], "%04x", to_pci_dev(dev->dev)
->vendor);
-		memcpy(&inq_response[12], dev->model, sizeof(dev
->model));
-		sprintf(&inq_response[52], "%04x", tmp_id);
-		memcpy(&inq_response[56], dev->serial, sizeof(dev
->serial));
-	}
-	xfer_len = alloc_len;
-	return nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
-}
-
-static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-					int alloc_len)
-{
-	u8 *inq_response;
-	int res;
-	int nvme_sc;
-	struct nvme_dev *dev = ns->dev;
-	struct nvme_id_ctrl *id_ctrl;
-	struct nvme_id_ns *id_ns;
-	int xfer_len;
-	u8 microcode = 0x80;
-	u8 spt;
-	u8 spt_lut[8] = {0, 0, 2, 1, 4, 6, 5, 7};
-	u8 grd_chk, app_chk, ref_chk, protect;
-	u8 uask_sup = 0x20;
-	u8 v_sup;
-	u8 luiclr = 0x01;
-
-	inq_response = kmalloc(EXTENDED_INQUIRY_DATA_PAGE_LENGTH,
GFP_KERNEL);
-	if (inq_response == NULL)
-		return -ENOMEM;
-
-	nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
-	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		goto out_free_inq;
-
-	spt = spt_lut[id_ns->dpc & 0x07] << 3;
-	if (id_ns->dps)
-		protect = 0x01;
-	else
-		protect = 0;
-	kfree(id_ns);
-
-	grd_chk = protect << 2;
-	app_chk = protect << 1;
-	ref_chk = protect;
-
-	nvme_sc = nvme_identify_ctrl(dev, &id_ctrl);
-	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		goto out_free_inq;
-
-	v_sup = id_ctrl->vwc;
-	kfree(id_ctrl);
-
-	memset(inq_response, 0, EXTENDED_INQUIRY_DATA_PAGE_LENGTH);
-	inq_response[1] = INQ_EXTENDED_INQUIRY_DATA_PAGE;    /* Page
Code */
-	inq_response[2] = 0x00;    /* Page Length MSB */
-	inq_response[3] = 0x3C;    /* Page Length LSB */
-	inq_response[4] = microcode | spt | grd_chk | app_chk |
ref_chk;
-	inq_response[5] = uask_sup;
-	inq_response[6] = v_sup;
-	inq_response[7] = luiclr;
-	inq_response[8] = 0;
-	inq_response[9] = 0;
-
-	xfer_len = min(alloc_len, EXTENDED_INQUIRY_DATA_PAGE_LENGTH);
-	res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
-
- out_free_inq:
-	kfree(inq_response);
-	return res;
-}
-
-static int nvme_trans_bdev_limits_page(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-					u8 *inq_response, int
alloc_len)
-{
-	__be32 max_sectors = cpu_to_be32(
-		nvme_block_nr(ns, queue_max_hw_sectors(ns->queue)));
-	__be32 max_discard = cpu_to_be32(ns->queue
->limits.max_discard_sectors);
-	__be32 discard_desc_count = cpu_to_be32(0x100);
-
-	memset(inq_response, 0, STANDARD_INQUIRY_LENGTH);
-	inq_response[1] = VPD_BLOCK_LIMITS;
-	inq_response[3] = 0x3c; /* Page Length */
-	memcpy(&inq_response[8], &max_sectors, sizeof(u32));
-	memcpy(&inq_response[20], &max_discard, sizeof(u32));
-
-	if (max_discard)
-		memcpy(&inq_response[24], &discard_desc_count,
sizeof(u32));
-
-	return nvme_trans_copy_to_user(hdr, inq_response, 0x3c);
-}
-
-static int nvme_trans_bdev_char_page(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-					int alloc_len)
-{
-	u8 *inq_response;
-	int res;
-	int xfer_len;
-
-	inq_response = kzalloc(EXTENDED_INQUIRY_DATA_PAGE_LENGTH,
GFP_KERNEL);
-	if (inq_response == NULL) {
-		res = -ENOMEM;
-		goto out_mem;
-	}
-
-	inq_response[1] = INQ_BDEV_CHARACTERISTICS_PAGE;    /* Page
Code */
-	inq_response[2] = 0x00;    /* Page Length MSB */
-	inq_response[3] = 0x3C;    /* Page Length LSB */
-	inq_response[4] = 0x00;    /* Medium Rotation Rate MSB */
-	inq_response[5] = 0x01;    /* Medium Rotation Rate LSB */
-	inq_response[6] = 0x00;    /* Form Factor */
-
-	xfer_len = min(alloc_len, EXTENDED_INQUIRY_DATA_PAGE_LENGTH);
-	res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
-
-	kfree(inq_response);
- out_mem:
-	return res;
-}
-
-/* LOG SENSE Helper Functions */
-
-static int nvme_trans_log_supp_pages(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-					int alloc_len)
-{
-	int res;
-	int xfer_len;
-	u8 *log_response;
-
-	log_response = kzalloc(LOG_PAGE_SUPPORTED_LOG_PAGES_LENGTH,
GFP_KERNEL);
-	if (log_response == NULL) {
-		res = -ENOMEM;
-		goto out_mem;
-	}
-
-	log_response[0] = LOG_PAGE_SUPPORTED_LOG_PAGES_PAGE;
-	/* Subpage=0x00, Page Length MSB=0 */
-	log_response[3] = SUPPORTED_LOG_PAGES_PAGE_LENGTH;
-	log_response[4] = LOG_PAGE_SUPPORTED_LOG_PAGES_PAGE;
-	log_response[5] = LOG_PAGE_INFORMATIONAL_EXCEPTIONS_PAGE;
-	log_response[6] = LOG_PAGE_TEMPERATURE_PAGE;
-
-	xfer_len = min(alloc_len,
LOG_PAGE_SUPPORTED_LOG_PAGES_LENGTH);
-	res = nvme_trans_copy_to_user(hdr, log_response, xfer_len);
-
-	kfree(log_response);
- out_mem:
-	return res;
-}
-
-static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
-					struct sg_io_hdr *hdr, int
alloc_len)
-{
-	int res;
-	int xfer_len;
-	u8 *log_response;
-	struct nvme_dev *dev = ns->dev;
-	struct nvme_smart_log *smart_log;
-	u8 temp_c;
-	u16 temp_k;
-
-	log_response = kzalloc(LOG_INFO_EXCP_PAGE_LENGTH, GFP_KERNEL);
-	if (log_response == NULL)
-		return -ENOMEM;
-
-	res = nvme_get_log_page(dev, &smart_log);
-	if (res < 0)
-		goto out_free_response;
-
-	if (res != NVME_SC_SUCCESS) {
-		temp_c = LOG_TEMP_UNKNOWN;
-	} else {
-		temp_k = (smart_log->temperature[1] << 8) +
-				(smart_log->temperature[0]);
-		temp_c = temp_k - KELVIN_TEMP_FACTOR;
-	}
-	kfree(smart_log);
-
-	log_response[0] = LOG_PAGE_INFORMATIONAL_EXCEPTIONS_PAGE;
-	/* Subpage=0x00, Page Length MSB=0 */
-	log_response[3] = REMAINING_INFO_EXCP_PAGE_LENGTH;
-	/* Informational Exceptions Log Parameter 1 Start */
-	/* Parameter Code=0x0000 bytes 4,5 */
-	log_response[6] = 0x23; /* DU=0, TSD=1, ETC=0, TMC=0,
FMT_AND_LNK=11b */
-	log_response[7] = 0x04; /* PARAMETER LENGTH */
-	/* Add sense Code and qualifier = 0x00 each */
-	/* Use Temperature from NVMe Get Log Page, convert to C from K
*/
-	log_response[10] = temp_c;
-
-	xfer_len = min(alloc_len, LOG_INFO_EXCP_PAGE_LENGTH);
-	res = nvme_trans_copy_to_user(hdr, log_response, xfer_len);
-
- out_free_response:
-	kfree(log_response);
-	return res;
-}
-
-static int nvme_trans_log_temperature(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-					int alloc_len)
-{
-	int res;
-	int xfer_len;
-	u8 *log_response;
-	struct nvme_dev *dev = ns->dev;
-	struct nvme_smart_log *smart_log;
-	u32 feature_resp;
-	u8 temp_c_cur, temp_c_thresh;
-	u16 temp_k;
-
-	log_response = kzalloc(LOG_TEMP_PAGE_LENGTH, GFP_KERNEL);
-	if (log_response == NULL)
-		return -ENOMEM;
-
-	res = nvme_get_log_page(dev, &smart_log);
-	if (res < 0)
-		goto out_free_response;
-
-	if (res != NVME_SC_SUCCESS) {
-		temp_c_cur = LOG_TEMP_UNKNOWN;
-	} else {
-		temp_k = (smart_log->temperature[1] << 8) +
-				(smart_log->temperature[0]);
-		temp_c_cur = temp_k - KELVIN_TEMP_FACTOR;
-	}
-	kfree(smart_log);
-
-	/* Get Features for Temp Threshold */
-	res = nvme_get_features(dev, NVME_FEAT_TEMP_THRESH, 0, 0,
-								&featu
re_resp);
-	if (res != NVME_SC_SUCCESS)
-		temp_c_thresh = LOG_TEMP_UNKNOWN;
-	else
-		temp_c_thresh = (feature_resp & 0xFFFF) -
KELVIN_TEMP_FACTOR;
-
-	log_response[0] = LOG_PAGE_TEMPERATURE_PAGE;
-	/* Subpage=0x00, Page Length MSB=0 */
-	log_response[3] = REMAINING_TEMP_PAGE_LENGTH;
-	/* Temperature Log Parameter 1 (Temperature) Start */
-	/* Parameter Code = 0x0000 */
-	log_response[6] = 0x01;		/* Format and Linking
= 01b */
-	log_response[7] = 0x02;		/* Parameter Length */
-	/* Use Temperature from NVMe Get Log Page, convert to C from K
*/
-	log_response[9] = temp_c_cur;
-	/* Temperature Log Parameter 2 (Reference Temperature) Start
*/
-	log_response[11] = 0x01;	/* Parameter Code = 0x0001 */
-	log_response[12] = 0x01;	/* Format and Linking = 01b */
-	log_response[13] = 0x02;	/* Parameter Length */
-	/* Use Temperature Thresh from NVMe Get Log Page, convert to C
from K */
-	log_response[15] = temp_c_thresh;
-
-	xfer_len = min(alloc_len, LOG_TEMP_PAGE_LENGTH);
-	res = nvme_trans_copy_to_user(hdr, log_response, xfer_len);
-
- out_free_response:
-	kfree(log_response);
-	return res;
-}
-
-/* MODE SENSE Helper Functions */
-
-static int nvme_trans_fill_mode_parm_hdr(u8 *resp, int len, u8 cdb10,
u8 llbaa,
-					u16 mode_data_length, u16
blk_desc_len)
-{
-	/* Quick check to make sure I don't stomp on my own memory...
*/
-	if ((cdb10 && len < 8) || (!cdb10 && len < 4))
-		return -EINVAL;
-
-	if (cdb10) {
-		resp[0] = (mode_data_length & 0xFF00) >> 8;
-		resp[1] = (mode_data_length & 0x00FF);
-		resp[3] = 0x10 /* DPOFUA */;
-		resp[4] = llbaa;
-		resp[5] = RESERVED_FIELD;
-		resp[6] = (blk_desc_len & 0xFF00) >> 8;
-		resp[7] = (blk_desc_len & 0x00FF);
-	} else {
-		resp[0] = (mode_data_length & 0x00FF);
-		resp[2] = 0x10 /* DPOFUA */;
-		resp[3] = (blk_desc_len & 0x00FF);
-	}
-
-	return 0;
-}
-
-static int nvme_trans_fill_blk_desc(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-				    u8 *resp, int len, u8 llbaa)
-{
-	int res;
-	int nvme_sc;
-	struct nvme_dev *dev = ns->dev;
-	struct nvme_id_ns *id_ns;
-	u8 flbas;
-	u32 lba_length;
-
-	if (llbaa == 0 && len < MODE_PAGE_BLK_DES_LEN)
-		return -EINVAL;
-	else if (llbaa > 0 && len < MODE_PAGE_LLBAA_BLK_DES_LEN)
-		return -EINVAL;
-
-	nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
-	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		return res;
-
-	flbas = (id_ns->flbas) & 0x0F;
-	lba_length = (1 << (id_ns->lbaf[flbas].ds));
-
-	if (llbaa == 0) {
-		__be32 tmp_cap = cpu_to_be32(le64_to_cpu(id_ns
->ncap));
-		/* Byte 4 is reserved */
-		__be32 tmp_len = cpu_to_be32(lba_length & 0x00FFFFFF);
-
-		memcpy(resp, &tmp_cap, sizeof(u32));
-		memcpy(&resp[4], &tmp_len, sizeof(u32));
-	} else {
-		__be64 tmp_cap = cpu_to_be64(le64_to_cpu(id_ns
->ncap));
-		__be32 tmp_len = cpu_to_be32(lba_length);
-
-		memcpy(resp, &tmp_cap, sizeof(u64));
-		/* Bytes 8, 9, 10, 11 are reserved */
-		memcpy(&resp[12], &tmp_len, sizeof(u32));
-	}
-
-	kfree(id_ns);
-	return res;
-}
-
-static int nvme_trans_fill_control_page(struct nvme_ns *ns,
-					struct sg_io_hdr *hdr, u8
*resp,
-					int len)
-{
-	if (len < MODE_PAGE_CONTROL_LEN)
-		return -EINVAL;
-
-	resp[0] = MODE_PAGE_CONTROL;
-	resp[1] = MODE_PAGE_CONTROL_LEN_FIELD;
-	resp[2] = 0x0E;		/* TST=000b, TMF_ONLY=0,
DPICZ=1,
-				 * D_SENSE=1, GLTSD=1, RLEC=0 */
-	resp[3] = 0x12;		/* Q_ALGO_MODIFIER=1h, NUAR=0,
QERR=01b */
-	/* Byte 4:  VS=0, RAC=0, UA_INT=0, SWP=0 */
-	resp[5] = 0x40;		/* ATO=0, TAS=1, ATMPE=0,
RWWP=0, AUTOLOAD=0 */
-	/* resp[6] and [7] are obsolete, thus zero */
-	resp[8] = 0xFF;		/* Busy timeout period =
0xffff */
-	resp[9] = 0xFF;
-	/* Bytes 10,11: Extended selftest completion time = 0x0000 */
-
-	return 0;
-}
-
-static int nvme_trans_fill_caching_page(struct nvme_ns *ns,
-					struct sg_io_hdr *hdr,
-					u8 *resp, int len)
-{
-	int res = 0;
-	int nvme_sc;
-	struct nvme_dev *dev = ns->dev;
-	u32 feature_resp;
-	u8 vwc;
-
-	if (len < MODE_PAGE_CACHING_LEN)
-		return -EINVAL;
-
-	nvme_sc = nvme_get_features(dev, NVME_FEAT_VOLATILE_WC, 0, 0,
-								&featu
re_resp);
-	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		return res;
-
-	vwc = feature_resp & 0x00000001;
-
-	resp[0] = MODE_PAGE_CACHING;
-	resp[1] = MODE_PAGE_CACHING_LEN_FIELD;
-	resp[2] = vwc << 2;
-	return 0;
-}
-
-static int nvme_trans_fill_pow_cnd_page(struct nvme_ns *ns,
-					struct sg_io_hdr *hdr, u8
*resp,
-					int len)
-{
-	if (len < MODE_PAGE_POW_CND_LEN)
-		return -EINVAL;
-
-	resp[0] = MODE_PAGE_POWER_CONDITION;
-	resp[1] = MODE_PAGE_POW_CND_LEN_FIELD;
-	/* All other bytes are zero */
-
-	return 0;
-}
-
-static int nvme_trans_fill_inf_exc_page(struct nvme_ns *ns,
-					struct sg_io_hdr *hdr, u8
*resp,
-					int len)
-{
-	if (len < MODE_PAGE_INF_EXC_LEN)
-		return -EINVAL;
-
-	resp[0] = MODE_PAGE_INFO_EXCEP;
-	resp[1] = MODE_PAGE_INF_EXC_LEN_FIELD;
-	resp[2] = 0x88;
-	/* All other bytes are zero */
-
-	return 0;
-}
-
-static int nvme_trans_fill_all_pages(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-				     u8 *resp, int len)
-{
-	int res;
-	u16 mode_pages_offset_1 = 0;
-	u16 mode_pages_offset_2, mode_pages_offset_3,
mode_pages_offset_4;
-
-	mode_pages_offset_2 = mode_pages_offset_1 +
MODE_PAGE_CACHING_LEN;
-	mode_pages_offset_3 = mode_pages_offset_2 +
MODE_PAGE_CONTROL_LEN;
-	mode_pages_offset_4 = mode_pages_offset_3 +
MODE_PAGE_POW_CND_LEN;
-
-	res = nvme_trans_fill_caching_page(ns, hdr,
&resp[mode_pages_offset_1],
-					MODE_PAGE_CACHING_LEN);
-	if (res)
-		return res;
-	res = nvme_trans_fill_control_page(ns, hdr,
&resp[mode_pages_offset_2],
-					MODE_PAGE_CONTROL_LEN);
-	if (res)
-		return res;
-	res = nvme_trans_fill_pow_cnd_page(ns, hdr,
&resp[mode_pages_offset_3],
-					MODE_PAGE_POW_CND_LEN);
-	if (res)
-		return res;
-	return nvme_trans_fill_inf_exc_page(ns, hdr,
&resp[mode_pages_offset_4],
-					MODE_PAGE_INF_EXC_LEN);
-}
-
-static inline int nvme_trans_get_blk_desc_len(u8 dbd, u8 llbaa)
-{
-	if (dbd == MODE_SENSE_BLK_DESC_ENABLED) {
-		/* SPC-4: len = 8 x Num_of_descriptors if llbaa = 0,
16x if 1 */
-		return 8 * (llbaa + 1) * MODE_SENSE_BLK_DESC_COUNT;
-	} else {
-		return 0;
-	}
-}
-
-static int nvme_trans_mode_page_create(struct nvme_ns *ns,
-					struct sg_io_hdr *hdr, u8
*cmd,
-					u16 alloc_len, u8 cdb10,
-					int (*mode_page_fill_func)
-					(struct nvme_ns *,
-					struct sg_io_hdr *hdr, u8 *,
int),
-					u16 mode_pages_tot_len)
-{
-	int res;
-	int xfer_len;
-	u8 *response;
-	u8 dbd, llbaa;
-	u16 resp_size;
-	int mph_size;
-	u16 mode_pages_offset_1;
-	u16 blk_desc_len, blk_desc_offset, mode_data_length;
-
-	dbd = (cmd[1] & MODE_SENSE_DBD_MASK) >> MODE_SENSE_DBD_SHIFT;
-	llbaa = (cmd[1] & MODE_SENSE_LLBAA_MASK) >>
MODE_SENSE_LLBAA_SHIFT;
-	mph_size = cdb10 ? MODE_SENSE10_MPH_SIZE :
MODE_SENSE6_MPH_SIZE;
-
-	blk_desc_len = nvme_trans_get_blk_desc_len(dbd, llbaa);
-
-	resp_size = mph_size + blk_desc_len + mode_pages_tot_len;
-	/* Refer spc4r34 Table 440 for calculation of Mode data Length
field */
-	mode_data_length = 3 + (3 * cdb10) + blk_desc_len +
mode_pages_tot_len;
-
-	blk_desc_offset = mph_size;
-	mode_pages_offset_1 = blk_desc_offset + blk_desc_len;
-
-	response = kzalloc(resp_size, GFP_KERNEL);
-	if (response == NULL) {
-		res = -ENOMEM;
-		goto out_mem;
-	}
-
-	res = nvme_trans_fill_mode_parm_hdr(&response[0], mph_size,
cdb10,
-					llbaa, mode_data_length,
blk_desc_len);
-	if (res)
-		goto out_free;
-	if (blk_desc_len > 0) {
-		res = nvme_trans_fill_blk_desc(ns, hdr,
-					      
 &response[blk_desc_offset],
-					       blk_desc_len, llbaa);
-		if (res)
-			goto out_free;
-	}
-	res = mode_page_fill_func(ns, hdr,
&response[mode_pages_offset_1],
-					mode_pages_tot_len);
-	if (res)
-		goto out_free;
-
-	xfer_len = min(alloc_len, resp_size);
-	res = nvme_trans_copy_to_user(hdr, response, xfer_len);
-
- out_free:
-	kfree(response);
- out_mem:
-	return res;
-}
-
-/* Read Capacity Helper Functions */
-
-static void nvme_trans_fill_read_cap(u8 *response, struct nvme_id_ns
*id_ns,
-								u8
cdb16)
-{
-	u8 flbas;
-	u32 lba_length;
-	u64 rlba;
-	u8 prot_en;
-	u8 p_type_lut[4] = {0, 0, 1, 2};
-	__be64 tmp_rlba;
-	__be32 tmp_rlba_32;
-	__be32 tmp_len;
-
-	flbas = (id_ns->flbas) & 0x0F;
-	lba_length = (1 << (id_ns->lbaf[flbas].ds));
-	rlba = le64_to_cpup(&id_ns->nsze) - 1;
-	(id_ns->dps) ? (prot_en = 0x01) : (prot_en = 0);
-
-	if (!cdb16) {
-		if (rlba > 0xFFFFFFFF)
-			rlba = 0xFFFFFFFF;
-		tmp_rlba_32 = cpu_to_be32(rlba);
-		tmp_len = cpu_to_be32(lba_length);
-		memcpy(response, &tmp_rlba_32, sizeof(u32));
-		memcpy(&response[4], &tmp_len, sizeof(u32));
-	} else {
-		tmp_rlba = cpu_to_be64(rlba);
-		tmp_len = cpu_to_be32(lba_length);
-		memcpy(response, &tmp_rlba, sizeof(u64));
-		memcpy(&response[8], &tmp_len, sizeof(u32));
-		response[12] = (p_type_lut[id_ns->dps & 0x3] << 1) |
prot_en;
-		/* P_I_Exponent = 0x0 | LBPPBE = 0x0 */
-		/* LBPME = 0 | LBPRZ = 0 | LALBA = 0x00 */
-		/* Bytes 16-31 - Reserved */
-	}
-}
-
-/* Start Stop Unit Helper Functions */
-
-static int nvme_trans_power_state(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
-						u8 pc, u8 pcmod, u8
start)
-{
-	int res;
-	int nvme_sc;
-	struct nvme_dev *dev = ns->dev;
-	struct nvme_id_ctrl *id_ctrl;
-	int lowest_pow_st;	/* max npss = lowest power consumption
*/
-	unsigned ps_desired = 0;
-
-	nvme_sc = nvme_identify_ctrl(dev, &id_ctrl);
-	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		return res;
-
-	lowest_pow_st = max(POWER_STATE_0, (int)(id_ctrl->npss - 1));
-	kfree(id_ctrl);
-
-	switch (pc) {
-	case NVME_POWER_STATE_START_VALID:
-		/* Action unspecified if POWER CONDITION MODIFIER != 0
*/
-		if (pcmod == 0 && start == 0x1)
-			ps_desired = POWER_STATE_0;
-		if (pcmod == 0 && start == 0x0)
-			ps_desired = lowest_pow_st;
-		break;
-	case NVME_POWER_STATE_ACTIVE:
-		/* Action unspecified if POWER CONDITION MODIFIER != 0
*/
-		if (pcmod == 0)
-			ps_desired = POWER_STATE_0;
-		break;
-	case NVME_POWER_STATE_IDLE:
-		/* Action unspecified if POWER CONDITION MODIFIER !=
[0,1,2] */
-		if (pcmod == 0x0)
-			ps_desired = POWER_STATE_1;
-		else if (pcmod == 0x1)
-			ps_desired = POWER_STATE_2;
-		else if (pcmod == 0x2)
-			ps_desired = POWER_STATE_3;
-		break;
-	case NVME_POWER_STATE_STANDBY:
-		/* Action unspecified if POWER CONDITION MODIFIER !=
[0,1] */
-		if (pcmod == 0x0)
-			ps_desired = max(POWER_STATE_0, (lowest_pow_st
- 2));
-		else if (pcmod == 0x1)
-			ps_desired = max(POWER_STATE_0, (lowest_pow_st
- 1));
-		break;
-	case NVME_POWER_STATE_LU_CONTROL:
-	default:
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-				ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
-				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-		break;
-	}
-	nvme_sc = nvme_set_features(dev, NVME_FEAT_POWER_MGMT,
ps_desired, 0,
-				    NULL);
-	return nvme_trans_status_code(hdr, nvme_sc);
-}
-
-static int nvme_trans_send_activate_fw_cmd(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-					u8 buffer_id)
-{
-	struct nvme_command c;
-	int nvme_sc;
-
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = nvme_admin_activate_fw;
-	c.common.cdw10[0] = cpu_to_le32(buffer_id |
NVME_FWACT_REPL_ACTV);
-
-	nvme_sc = nvme_submit_sync_cmd(ns->queue, &c, NULL, 0);
-	return nvme_trans_status_code(hdr, nvme_sc);
-}
-
-static int nvme_trans_send_download_fw_cmd(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-					u8 opcode, u32 tot_len, u32
offset,
-					u8 buffer_id)
-{
-	int nvme_sc;
-	struct nvme_dev *dev = ns->dev;
-	struct nvme_command c;
-
-	if (hdr->iovec_count > 0) {
-		/* Assuming SGL is not allowed for this command */
-		return nvme_trans_completion(hdr,
-					SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
-					SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-	}
-
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = nvme_admin_download_fw;
-	c.dlfw.numd = cpu_to_le32((tot_len/BYTES_TO_DWORDS) - 1);
-	c.dlfw.offset = cpu_to_le32(offset/BYTES_TO_DWORDS);
-
-	nvme_sc = __nvme_submit_sync_cmd(dev->admin_q, &c, NULL,
-			hdr->dxferp, tot_len, NULL, 0);
-	return nvme_trans_status_code(hdr, nvme_sc);
-}
-
-/* Mode Select Helper Functions */
-
-static inline void nvme_trans_modesel_get_bd_len(u8 *parm_list, u8
cdb10,
-						u16 *bd_len, u8
*llbaa)
-{
-	if (cdb10) {
-		/* 10 Byte CDB */
-		*bd_len = (parm_list[MODE_SELECT_10_BD_OFFSET] << 8) +
-			parm_list[MODE_SELECT_10_BD_OFFSET + 1];
-		*llbaa = parm_list[MODE_SELECT_10_LLBAA_OFFSET] &
-				MODE_SELECT_10_LLBAA_MASK;
-	} else {
-		/* 6 Byte CDB */
-		*bd_len = parm_list[MODE_SELECT_6_BD_OFFSET];
-	}
-}
-
-static void nvme_trans_modesel_save_bd(struct nvme_ns *ns, u8
*parm_list,
-					u16 idx, u16 bd_len, u8 llbaa)
-{
-	u16 bd_num;
-
-	bd_num = bd_len / ((llbaa == 0) ?
-			SHORT_DESC_BLOCK : LONG_DESC_BLOCK);
-	/* Store block descriptor info if a FORMAT UNIT comes later */
-	/* TODO Saving 1st BD info; what to do if multiple BD
received? */
-	if (llbaa == 0) {
-		/* Standard Block Descriptor - spc4r34 7.5.5.1 */
-		ns->mode_select_num_blocks =
-				(parm_list[idx + 1] << 16) +
-				(parm_list[idx + 2] << 8) +
-				(parm_list[idx + 3]);
-
-		ns->mode_select_block_len =
-				(parm_list[idx + 5] << 16) +
-				(parm_list[idx + 6] << 8) +
-				(parm_list[idx + 7]);
-	} else {
-		/* Long LBA Block Descriptor - sbc3r27 6.4.2.3 */
-		ns->mode_select_num_blocks =
-				(((u64)parm_list[idx + 0]) << 56) +
-				(((u64)parm_list[idx + 1]) << 48) +
-				(((u64)parm_list[idx + 2]) << 40) +
-				(((u64)parm_list[idx + 3]) << 32) +
-				(((u64)parm_list[idx + 4]) << 24) +
-				(((u64)parm_list[idx + 5]) << 16) +
-				(((u64)parm_list[idx + 6]) << 8) +
-				((u64)parm_list[idx + 7]);
-
-		ns->mode_select_block_len =
-				(parm_list[idx + 12] << 24) +
-				(parm_list[idx + 13] << 16) +
-				(parm_list[idx + 14] << 8) +
-				(parm_list[idx + 15]);
-	}
-}
-
-static int nvme_trans_modesel_get_mp(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-					u8 *mode_page, u8 page_code)
-{
-	int res = 0;
-	int nvme_sc;
-	struct nvme_dev *dev = ns->dev;
-	unsigned dword11;
-
-	switch (page_code) {
-	case MODE_PAGE_CACHING:
-		dword11 = ((mode_page[2] & CACHING_MODE_PAGE_WCE_MASK)
? 1 : 0);
-		nvme_sc = nvme_set_features(dev,
NVME_FEAT_VOLATILE_WC, dword11,
-					    0, NULL);
-		res = nvme_trans_status_code(hdr, nvme_sc);
-		break;
-	case MODE_PAGE_CONTROL:
-		break;
-	case MODE_PAGE_POWER_CONDITION:
-		/* Verify the OS is not trying to set timers */
-		if ((mode_page[2] & 0x01) != 0 || (mode_page[3] &
0x0F) != 0) {
-			res = nvme_trans_completion(hdr,
-						SAM_STAT_CHECK_CONDITI
ON,
-						ILLEGAL_REQUEST,
-						SCSI_ASC_INVALID_PARAM
ETER,
-						SCSI_ASCQ_CAUSE_NOT_RE
PORTABLE);
-			break;
-		}
-		break;
-	default:
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		break;
-	}
-
-	return res;
-}
-
-static int nvme_trans_modesel_data(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-					u8 *cmd, u16 parm_list_len, u8
pf,
-					u8 sp, u8 cdb10)
-{
-	int res;
-	u8 *parm_list;
-	u16 bd_len;
-	u8 llbaa = 0;
-	u16 index, saved_index;
-	u8 page_code;
-	u16 mp_size;
-
-	/* Get parm list from data-in/out buffer */
-	parm_list = kmalloc(parm_list_len, GFP_KERNEL);
-	if (parm_list == NULL) {
-		res = -ENOMEM;
-		goto out;
-	}
-
-	res = nvme_trans_copy_from_user(hdr, parm_list,
parm_list_len);
-	if (res)
-		goto out_mem;
-
-	nvme_trans_modesel_get_bd_len(parm_list, cdb10, &bd_len,
&llbaa);
-	index = (cdb10) ? (MODE_SELECT_10_MPH_SIZE) :
(MODE_SELECT_6_MPH_SIZE);
-
-	if (bd_len != 0) {
-		/* Block Descriptors present, parse */
-		nvme_trans_modesel_save_bd(ns, parm_list, index,
bd_len, llbaa);
-		index += bd_len;
-	}
-	saved_index = index;
-
-	/* Multiple mode pages may be present; iterate through all */
-	/* In 1st Iteration, don't do NVME Command, only check for CDB
errors */
-	do {
-		page_code = parm_list[index] &
MODE_SELECT_PAGE_CODE_MASK;
-		mp_size = parm_list[index + 1] + 2;
-		if ((page_code != MODE_PAGE_CACHING) &&
-		    (page_code != MODE_PAGE_CONTROL) &&
-		    (page_code != MODE_PAGE_POWER_CONDITION)) {
-			res = nvme_trans_completion(hdr,
-						SAM_STAT_CHECK_CONDITI
ON,
-						ILLEGAL_REQUEST,
-						SCSI_ASC_INVALID_CDB,
-						SCSI_ASCQ_CAUSE_NOT_RE
PORTABLE);
-			goto out_mem;
-		}
-		index += mp_size;
-	} while (index < parm_list_len);
-
-	/* In 2nd Iteration, do the NVME Commands */
-	index = saved_index;
-	do {
-		page_code = parm_list[index] &
MODE_SELECT_PAGE_CODE_MASK;
-		mp_size = parm_list[index + 1] + 2;
-		res = nvme_trans_modesel_get_mp(ns, hdr,
&parm_list[index],
-								page_c
ode);
-		if (res)
-			break;
-		index += mp_size;
-	} while (index < parm_list_len);
-
- out_mem:
-	kfree(parm_list);
- out:
-	return res;
-}
-
-/* Format Unit Helper Functions */
-
-static int nvme_trans_fmt_set_blk_size_count(struct nvme_ns *ns,
-					     struct sg_io_hdr *hdr)
-{
-	int res = 0;
-	int nvme_sc;
-	struct nvme_dev *dev = ns->dev;
-	u8 flbas;
-
-	/*
-	 * SCSI Expects a MODE SELECT would have been issued prior to
-	 * a FORMAT UNIT, and the block size and number would be used
-	 * from the block descriptor in it. If a MODE SELECT had not
-	 * been issued, FORMAT shall use the current values for both.
-	 */
-
-	if (ns->mode_select_num_blocks == 0 || ns
->mode_select_block_len == 0) {
-		struct nvme_id_ns *id_ns;
-
-		nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
-		res = nvme_trans_status_code(hdr, nvme_sc);
-		if (res)
-			return res;
-
-		if (ns->mode_select_num_blocks == 0)
-			ns->mode_select_num_blocks = le64_to_cpu(id_ns
->ncap);
-		if (ns->mode_select_block_len == 0) {
-			flbas = (id_ns->flbas) & 0x0F;
-			ns->mode_select_block_len =
-						(1 << (id_ns
->lbaf[flbas].ds));
-		}
-
-		kfree(id_ns);
-	}
-
-	return 0;
-}
-
-static int nvme_trans_fmt_get_parm_header(struct sg_io_hdr *hdr, u8
len,
-					u8 format_prot_info, u8
*nvme_pf_code)
-{
-	int res;
-	u8 *parm_list;
-	u8 pf_usage, pf_code;
-
-	parm_list = kmalloc(len, GFP_KERNEL);
-	if (parm_list == NULL) {
-		res = -ENOMEM;
-		goto out;
-	}
-	res = nvme_trans_copy_from_user(hdr, parm_list, len);
-	if (res)
-		goto out_mem;
-
-	if ((parm_list[FORMAT_UNIT_IMMED_OFFSET] &
-				FORMAT_UNIT_IMMED_MASK) != 0) {
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		goto out_mem;
-	}
-
-	if (len == FORMAT_UNIT_LONG_PARM_LIST_LEN &&
-	    (parm_list[FORMAT_UNIT_PROT_INT_OFFSET] & 0x0F) != 0) {
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		goto out_mem;
-	}
-	pf_usage = parm_list[FORMAT_UNIT_PROT_FIELD_USAGE_OFFSET] &
-			FORMAT_UNIT_PROT_FIELD_USAGE_MASK;
-	pf_code = (pf_usage << 2) | format_prot_info;
-	switch (pf_code) {
-	case 0:
-		*nvme_pf_code = 0;
-		break;
-	case 2:
-		*nvme_pf_code = 1;
-		break;
-	case 3:
-		*nvme_pf_code = 2;
-		break;
-	case 7:
-		*nvme_pf_code = 3;
-		break;
-	default:
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		break;
-	}
-
- out_mem:
-	kfree(parm_list);
- out:
-	return res;
-}
-
-static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-				   u8 prot_info)
-{
-	int res;
-	int nvme_sc;
-	struct nvme_dev *dev = ns->dev;
-	struct nvme_id_ns *id_ns;
-	u8 i;
-	u8 flbas, nlbaf;
-	u8 selected_lbaf = 0xFF;
-	u32 cdw10 = 0;
-	struct nvme_command c;
-
-	/* Loop thru LBAF's in id_ns to match reqd lbaf, put in cdw10
*/
-	nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
-	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		return res;
-
-	flbas = (id_ns->flbas) & 0x0F;
-	nlbaf = id_ns->nlbaf;
-
-	for (i = 0; i < nlbaf; i++) {
-		if (ns->mode_select_block_len == (1 << (id_ns
->lbaf[i].ds))) {
-			selected_lbaf = i;
-			break;
-		}
-	}
-	if (selected_lbaf > 0x0F) {
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-				ILLEGAL_REQUEST,
SCSI_ASC_INVALID_PARAMETER,
-				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-	}
-	if (ns->mode_select_num_blocks != le64_to_cpu(id_ns->ncap)) {
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-				ILLEGAL_REQUEST,
SCSI_ASC_INVALID_PARAMETER,
-				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-	}
-
-	cdw10 |= prot_info << 5;
-	cdw10 |= selected_lbaf & 0x0F;
-	memset(&c, 0, sizeof(c));
-	c.format.opcode = nvme_admin_format_nvm;
-	c.format.nsid = cpu_to_le32(ns->ns_id);
-	c.format.cdw10 = cpu_to_le32(cdw10);
-
-	nvme_sc = nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0);
-	res = nvme_trans_status_code(hdr, nvme_sc);
-
-	kfree(id_ns);
-	return res;
-}
-
-static inline u32 nvme_trans_io_get_num_cmds(struct sg_io_hdr *hdr,
-					struct nvme_trans_io_cdb
*cdb_info,
-					u32 max_blocks)
-{
-	/* If using iovecs, send one nvme command per vector */
-	if (hdr->iovec_count > 0)
-		return hdr->iovec_count;
-	else if (cdb_info->xfer_len > max_blocks)
-		return ((cdb_info->xfer_len - 1) / max_blocks) + 1;
-	else
-		return 1;
-}
-
-static u16 nvme_trans_io_get_control(struct nvme_ns *ns,
-					struct nvme_trans_io_cdb
*cdb_info)
-{
-	u16 control = 0;
-
-	/* When Protection information support is added, implement
here */
-
-	if (cdb_info->fua > 0)
-		control |= NVME_RW_FUA;
-
-	return control;
-}
-
-static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
-				struct nvme_trans_io_cdb *cdb_info, u8
is_write)
-{
-	int nvme_sc = NVME_SC_SUCCESS;
-	u32 num_cmds;
-	u64 unit_len;
-	u64 unit_num_blocks;	/* Number of blocks to xfer in each
nvme cmd */
-	u32 retcode;
-	u32 i = 0;
-	u64 nvme_offset = 0;
-	void __user *next_mapping_addr;
-	struct nvme_command c;
-	u8 opcode = (is_write ? nvme_cmd_write : nvme_cmd_read);
-	u16 control;
-	u32 max_blocks = queue_max_hw_sectors(ns->queue);
-
-	num_cmds = nvme_trans_io_get_num_cmds(hdr, cdb_info,
max_blocks);
-
-	/*
-	 * This loop handles two cases.
-	 * First, when an SGL is used in the form of an iovec list:
-	 *   - Use iov_base as the next mapping address for the nvme
command_id
-	 *   - Use iov_len as the data transfer length for the
command.
-	 * Second, when we have a single buffer
-	 *   - If larger than max_blocks, split into chunks, offset
-	 *        each nvme command accordingly.
-	 */
-	for (i = 0; i < num_cmds; i++) {
-		memset(&c, 0, sizeof(c));
-		if (hdr->iovec_count > 0) {
-			struct sg_iovec sgl;
-
-			retcode = copy_from_user(&sgl, hdr->dxferp +
-					i * sizeof(struct sg_iovec),
-					sizeof(struct sg_iovec));
-			if (retcode)
-				return -EFAULT;
-			unit_len = sgl.iov_len;
-			unit_num_blocks = unit_len >> ns->lba_shift;
-			next_mapping_addr = sgl.iov_base;
-		} else {
-			unit_num_blocks = min((u64)max_blocks,
-					(cdb_info->xfer_len -
nvme_offset));
-			unit_len = unit_num_blocks << ns->lba_shift;
-			next_mapping_addr = hdr->dxferp +
-					((1 << ns->lba_shift) *
nvme_offset);
-		}
-
-		c.rw.opcode = opcode;
-		c.rw.nsid = cpu_to_le32(ns->ns_id);
-		c.rw.slba = cpu_to_le64(cdb_info->lba + nvme_offset);
-		c.rw.length = cpu_to_le16(unit_num_blocks - 1);
-		control = nvme_trans_io_get_control(ns, cdb_info);
-		c.rw.control = cpu_to_le16(control);
-
-		if (get_capacity(ns->disk) - unit_num_blocks <
-				cdb_info->lba + nvme_offset) {
-			nvme_sc = NVME_SC_LBA_RANGE;
-			break;
-		}
-		nvme_sc = __nvme_submit_sync_cmd(ns->queue, &c, NULL,
-				next_mapping_addr, unit_len, NULL, 0);
-		if (nvme_sc)
-			break;
-
-		nvme_offset += unit_num_blocks;
-	}
-
-	return nvme_trans_status_code(hdr, nvme_sc);
-}
-
-
-/* SCSI Command Translation Functions */
-
-static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8
is_write,
-							u8 *cmd)
-{
-	int res = 0;
-	struct nvme_trans_io_cdb cdb_info = { 0, };
-	u8 opcode = cmd[0];
-	u64 xfer_bytes;
-	u64 sum_iov_len = 0;
-	struct sg_iovec sgl;
-	int i;
-	size_t not_copied;
-
-	/*
-	 * The FUA and WPROTECT fields are not supported in 6-byte
CDBs,
-	 * but always in the same place for all others.
-	 */
-	switch (opcode) {
-	case WRITE_6:
-	case READ_6:
-		break;
-	default:
-		cdb_info.fua = cmd[1] & 0x8;
-		cdb_info.prot_info = (cmd[1] & 0xe0) >> 5;
-		if (cdb_info.prot_info && !ns->pi_type) {
-			return nvme_trans_completion(hdr,
-					SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
-					SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		}
-	}
-
-	switch (opcode) {
-	case WRITE_6:
-	case READ_6:
-		cdb_info.lba = get_unaligned_be24(&cmd[1]);
-		cdb_info.xfer_len = cmd[4];
-		if (cdb_info.xfer_len == 0)
-			cdb_info.xfer_len = 256;
-		break;
-	case WRITE_10:
-	case READ_10:
-		cdb_info.lba = get_unaligned_be32(&cmd[2]);
-		cdb_info.xfer_len = get_unaligned_be16(&cmd[7]);
-		break;
-	case WRITE_12:
-	case READ_12:
-		cdb_info.lba = get_unaligned_be32(&cmd[2]);
-		cdb_info.xfer_len = get_unaligned_be32(&cmd[6]);
-		break;
-	case WRITE_16:
-	case READ_16:
-		cdb_info.lba = get_unaligned_be64(&cmd[2]);
-		cdb_info.xfer_len = get_unaligned_be32(&cmd[10]);
-		break;
-	default:
-		/* Will never really reach here */
-		res = -EIO;
-		goto out;
-	}
-
-	/* Calculate total length of transfer (in bytes) */
-	if (hdr->iovec_count > 0) {
-		for (i = 0; i < hdr->iovec_count; i++) {
-			not_copied = copy_from_user(&sgl, hdr->dxferp
+
-						i * sizeof(struct
sg_iovec),
-						sizeof(struct
sg_iovec));
-			if (not_copied)
-				return -EFAULT;
-			sum_iov_len += sgl.iov_len;
-			/* IO vector sizes should be multiples of
block size */
-			if (sgl.iov_len % (1 << ns->lba_shift) != 0) {
-				res = nvme_trans_completion(hdr,
-						SAM_STAT_CHECK_CONDITI
ON,
-						ILLEGAL_REQUEST,
-						SCSI_ASC_INVALID_PARAM
ETER,
-						SCSI_ASCQ_CAUSE_NOT_RE
PORTABLE);
-				goto out;
-			}
-		}
-	} else {
-		sum_iov_len = hdr->dxfer_len;
-	}
-
-	/* As Per sg ioctl howto, if the lengths differ, use the lower
one */
-	xfer_bytes = min(((u64)hdr->dxfer_len), sum_iov_len);
-
-	/* If block count and actual data buffer size dont match,
error out */
-	if (xfer_bytes != (cdb_info.xfer_len << ns->lba_shift)) {
-		res = -EINVAL;
-		goto out;
-	}
-
-	/* Check for 0 length transfer - it is not illegal */
-	if (cdb_info.xfer_len == 0)
-		goto out;
-
-	/* Send NVMe IO Command(s) */
-	res = nvme_trans_do_nvme_io(ns, hdr, &cdb_info, is_write);
-	if (res)
-		goto out;
-
- out:
-	return res;
-}
-
-static int nvme_trans_inquiry(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
-							u8 *cmd)
-{
-	int res = 0;
-	u8 evpd;
-	u8 page_code;
-	int alloc_len;
-	u8 *inq_response;
-
-	evpd = cmd[1] & 0x01;
-	page_code = cmd[2];
-	alloc_len = get_unaligned_be16(&cmd[3]);
-
-	inq_response = kmalloc(max(alloc_len,
STANDARD_INQUIRY_LENGTH),
-				GFP_KERNEL);
-	if (inq_response == NULL) {
-		res = -ENOMEM;
-		goto out_mem;
-	}
-
-	if (evpd == 0) {
-		if (page_code == INQ_STANDARD_INQUIRY_PAGE) {
-			res = nvme_trans_standard_inquiry_page(ns,
hdr,
-						inq_response,
alloc_len);
-		} else {
-			res = nvme_trans_completion(hdr,
-						SAM_STAT_CHECK_CONDITI
ON,
-						ILLEGAL_REQUEST,
-						SCSI_ASC_INVALID_CDB,
-						SCSI_ASCQ_CAUSE_NOT_RE
PORTABLE);
-		}
-	} else {
-		switch (page_code) {
-		case VPD_SUPPORTED_PAGES:
-			res = nvme_trans_supported_vpd_pages(ns, hdr,
-						inq_response,
alloc_len);
-			break;
-		case VPD_SERIAL_NUMBER:
-			res = nvme_trans_unit_serial_page(ns, hdr,
inq_response,
-								alloc_
len);
-			break;
-		case VPD_DEVICE_IDENTIFIERS:
-			res = nvme_trans_device_id_page(ns, hdr,
inq_response,
-								alloc_
len);
-			break;
-		case VPD_EXTENDED_INQUIRY:
-			res = nvme_trans_ext_inq_page(ns, hdr,
alloc_len);
-			break;
-		case VPD_BLOCK_LIMITS:
-			res = nvme_trans_bdev_limits_page(ns, hdr,
inq_response,
-								alloc_
len);
-			break;
-		case VPD_BLOCK_DEV_CHARACTERISTICS:
-			res = nvme_trans_bdev_char_page(ns, hdr,
alloc_len);
-			break;
-		default:
-			res = nvme_trans_completion(hdr,
-						SAM_STAT_CHECK_CONDITI
ON,
-						ILLEGAL_REQUEST,
-						SCSI_ASC_INVALID_CDB,
-						SCSI_ASCQ_CAUSE_NOT_RE
PORTABLE);
-			break;
-		}
-	}
-	kfree(inq_response);
- out_mem:
-	return res;
-}
-
-static int nvme_trans_log_sense(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
-							u8 *cmd)
-{
-	int res;
-	u16 alloc_len;
-	u8 pc;
-	u8 page_code;
-
-	if (cmd[1] != LOG_SENSE_CDB_SP_NOT_ENABLED) {
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		goto out;
-	}
-
-	page_code = cmd[2] & LOG_SENSE_CDB_PAGE_CODE_MASK;
-	pc = (cmd[2] & LOG_SENSE_CDB_PC_MASK) >>
LOG_SENSE_CDB_PC_SHIFT;
-	if (pc != LOG_SENSE_CDB_PC_CUMULATIVE_VALUES) {
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		goto out;
-	}
-	alloc_len = get_unaligned_be16(&cmd[7]);
-	switch (page_code) {
-	case LOG_PAGE_SUPPORTED_LOG_PAGES_PAGE:
-		res = nvme_trans_log_supp_pages(ns, hdr, alloc_len);
-		break;
-	case LOG_PAGE_INFORMATIONAL_EXCEPTIONS_PAGE:
-		res = nvme_trans_log_info_exceptions(ns, hdr,
alloc_len);
-		break;
-	case LOG_PAGE_TEMPERATURE_PAGE:
-		res = nvme_trans_log_temperature(ns, hdr, alloc_len);
-		break;
-	default:
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		break;
-	}
-
- out:
-	return res;
-}
-
-static int nvme_trans_mode_select(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
-							u8 *cmd)
-{
-	u8 cdb10 = 0;
-	u16 parm_list_len;
-	u8 page_format;
-	u8 save_pages;
-
-	page_format = cmd[1] & MODE_SELECT_CDB_PAGE_FORMAT_MASK;
-	save_pages = cmd[1] & MODE_SELECT_CDB_SAVE_PAGES_MASK;
-
-	if (cmd[0] == MODE_SELECT) {
-		parm_list_len = cmd[4];
-	} else {
-		parm_list_len = cmd[7];
-		cdb10 = 1;
-	}
-
-	if (parm_list_len != 0) {
-		/*
-		 * According to SPC-4 r24, a paramter list length
field of 0
-		 * shall not be considered an error
-		 */
-		return nvme_trans_modesel_data(ns, hdr, cmd,
parm_list_len,
-						page_format,
save_pages, cdb10);
-	}
-
-	return 0;
-}
-
-static int nvme_trans_mode_sense(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
-							u8 *cmd)
-{
-	int res = 0;
-	u16 alloc_len;
-	u8 cdb10 = 0;
-
-	if (cmd[0] == MODE_SENSE) {
-		alloc_len = cmd[4];
-	} else {
-		alloc_len = get_unaligned_be16(&cmd[7]);
-		cdb10 = 1;
-	}
-
-	if ((cmd[2] & MODE_SENSE_PAGE_CONTROL_MASK) !=
-			MODE_SENSE_PC_CURRENT_VALUES) {
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		goto out;
-	}
-
-	switch (cmd[2] & MODE_SENSE_PAGE_CODE_MASK) {
-	case MODE_PAGE_CACHING:
-		res = nvme_trans_mode_page_create(ns, hdr, cmd,
alloc_len,
-						cdb10,
-						&nvme_trans_fill_cachi
ng_page,
-						MODE_PAGE_CACHING_LEN)
;
-		break;
-	case MODE_PAGE_CONTROL:
-		res = nvme_trans_mode_page_create(ns, hdr, cmd,
alloc_len,
-						cdb10,
-						&nvme_trans_fill_contr
ol_page,
-						MODE_PAGE_CONTROL_LEN)
;
-		break;
-	case MODE_PAGE_POWER_CONDITION:
-		res = nvme_trans_mode_page_create(ns, hdr, cmd,
alloc_len,
-						cdb10,
-						&nvme_trans_fill_pow_c
nd_page,
-						MODE_PAGE_POW_CND_LEN)
;
-		break;
-	case MODE_PAGE_INFO_EXCEP:
-		res = nvme_trans_mode_page_create(ns, hdr, cmd,
alloc_len,
-						cdb10,
-						&nvme_trans_fill_inf_e
xc_page,
-						MODE_PAGE_INF_EXC_LEN)
;
-		break;
-	case MODE_PAGE_RETURN_ALL:
-		res = nvme_trans_mode_page_create(ns, hdr, cmd,
alloc_len,
-						cdb10,
-						&nvme_trans_fill_all_p
ages,
-						MODE_PAGE_ALL_LEN);
-		break;
-	default:
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		break;
-	}
-
- out:
-	return res;
-}
-
-static int nvme_trans_read_capacity(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-							u8 *cmd, u8
cdb16)
-{
-	int res;
-	int nvme_sc;
-	u32 alloc_len;
-	u32 resp_size;
-	u32 xfer_len;
-	struct nvme_dev *dev = ns->dev;
-	struct nvme_id_ns *id_ns;
-	u8 *response;
-
-	if (cdb16) {
-		alloc_len = get_unaligned_be32(&cmd[10]);
-		resp_size = READ_CAP_16_RESP_SIZE;
-	} else {
-		alloc_len = READ_CAP_10_RESP_SIZE;
-		resp_size = READ_CAP_10_RESP_SIZE;
-	}
-
-	nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
-	res = nvme_trans_status_code(hdr, nvme_sc);
-	if (res)
-		return res;	
-
-	response = kzalloc(resp_size, GFP_KERNEL);
-	if (response == NULL) {
-		res = -ENOMEM;
-		goto out_free_id;
-	}
-	nvme_trans_fill_read_cap(response, id_ns, cdb16);
-
-	xfer_len = min(alloc_len, resp_size);
-	res = nvme_trans_copy_to_user(hdr, response, xfer_len);
-
-	kfree(response);
- out_free_id:
-	kfree(id_ns);
-	return res;
-}
-
-static int nvme_trans_report_luns(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
-							u8 *cmd)
-{
-	int res;
-	int nvme_sc;
-	u32 alloc_len, xfer_len, resp_size;
-	u8 *response;
-	struct nvme_dev *dev = ns->dev;
-	struct nvme_id_ctrl *id_ctrl;
-	u32 ll_length, lun_id;
-	u8 lun_id_offset = REPORT_LUNS_FIRST_LUN_OFFSET;
-	__be32 tmp_len;
-
-	switch (cmd[2]) {
-	default:
-		return nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-	case ALL_LUNS_RETURNED:
-	case ALL_WELL_KNOWN_LUNS_RETURNED:
-	case RESTRICTED_LUNS_RETURNED:
-		nvme_sc = nvme_identify_ctrl(dev, &id_ctrl);
-		res = nvme_trans_status_code(hdr, nvme_sc);
-		if (res)
-			return res;
-
-		ll_length = le32_to_cpu(id_ctrl->nn) * LUN_ENTRY_SIZE;
-		resp_size = ll_length + LUN_DATA_HEADER_SIZE;
-
-		alloc_len = get_unaligned_be32(&cmd[6]);
-		if (alloc_len < resp_size) {
-			res = nvme_trans_completion(hdr,
-					SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-			goto out_free_id;
-		}
-
-		response = kzalloc(resp_size, GFP_KERNEL);
-		if (response == NULL) {
-			res = -ENOMEM;
-			goto out_free_id;
-		}
-
-		/* The first LUN ID will always be 0 per the SAM spec
*/
-		for (lun_id = 0; lun_id < le32_to_cpu(id_ctrl->nn);
lun_id++) {
-			/*
-			 * Set the LUN Id and then increment to the
next LUN
-			 * location in the parameter data.
-			 */
-			__be64 tmp_id = cpu_to_be64(lun_id);
-			memcpy(&response[lun_id_offset], &tmp_id,
sizeof(u64));
-			lun_id_offset += LUN_ENTRY_SIZE;
-		}
-		tmp_len = cpu_to_be32(ll_length);
-		memcpy(response, &tmp_len, sizeof(u32));
-	}
-
-	xfer_len = min(alloc_len, resp_size);
-	res = nvme_trans_copy_to_user(hdr, response, xfer_len);
-
-	kfree(response);
- out_free_id:
-	kfree(id_ctrl);
-	return res;
-}
-
-static int nvme_trans_request_sense(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-							u8 *cmd)
-{
-	int res;
-	u8 alloc_len, xfer_len, resp_size;
-	u8 desc_format;
-	u8 *response;
-
-	desc_format = cmd[1] & 0x01;
-	alloc_len = cmd[4];
-
-	resp_size = ((desc_format) ? (DESC_FMT_SENSE_DATA_SIZE) :
-					(FIXED_FMT_SENSE_DATA_SIZE));
-	response = kzalloc(resp_size, GFP_KERNEL);
-	if (response == NULL) {
-		res = -ENOMEM;
-		goto out;
-	}
-
-	if (desc_format) {
-		/* Descriptor Format Sense Data */
-		response[0] = DESC_FORMAT_SENSE_DATA;
-		response[1] = NO_SENSE;
-		/* TODO How is LOW POWER CONDITION ON handled? (byte
2) */
-		response[2] = SCSI_ASC_NO_SENSE;
-		response[3] = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		/* SDAT_OVFL = 0 | Additional Sense Length = 0 */
-	} else {
-		/* Fixed Format Sense Data */
-		response[0] = FIXED_SENSE_DATA;
-		/* Byte 1 = Obsolete */
-		response[2] = NO_SENSE; /* FM, EOM, ILI, SDAT_OVFL = 0
*/
-		/* Bytes 3-6 - Information - set to zero */
-		response[7] = FIXED_SENSE_DATA_ADD_LENGTH;
-		/* Bytes 8-11 - Cmd Specific Information - set to zero
*/
-		response[12] = SCSI_ASC_NO_SENSE;
-		response[13] = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
-		/* Byte 14 = Field Replaceable Unit Code = 0 */
-		/* Bytes 15-17 - SKSV=0; Sense Key Specific = 0 */
-	}
-
-	xfer_len = min(alloc_len, resp_size);
-	res = nvme_trans_copy_to_user(hdr, response, xfer_len);
-
-	kfree(response);
- out:
-	return res;
-}
-
-static int nvme_trans_security_protocol(struct nvme_ns *ns,
-					struct sg_io_hdr *hdr,
-					u8 *cmd)
-{
-	return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-				ILLEGAL_REQUEST,
SCSI_ASC_ILLEGAL_COMMAND,
-				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-}
-
-static int nvme_trans_synchronize_cache(struct nvme_ns *ns,
-					struct sg_io_hdr *hdr)
-{
-	int nvme_sc;
-	struct nvme_command c;
-
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = nvme_cmd_flush;
-	c.common.nsid = cpu_to_le32(ns->ns_id);
-
-	nvme_sc = nvme_submit_sync_cmd(ns->queue, &c, NULL, 0);
-	return nvme_trans_status_code(hdr, nvme_sc);
-}
-
-static int nvme_trans_start_stop(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
-							u8 *cmd)
-{
-	u8 immed, pcmod, pc, no_flush, start;
-
-	immed = cmd[1] & 0x01;
-	pcmod = cmd[3] & 0x0f;
-	pc = (cmd[4] & 0xf0) >> 4;
-	no_flush = cmd[4] & 0x04;
-	start = cmd[4] & 0x01;
-
-	if (immed != 0) {
-		return nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-	} else {
-		if (no_flush == 0) {
-			/* Issue NVME FLUSH command prior to START
STOP UNIT */
-			int res = nvme_trans_synchronize_cache(ns,
hdr);
-			if (res)
-				return res;
-		}
-		/* Setup the expected power state transition */
-		return nvme_trans_power_state(ns, hdr, pc, pcmod,
start);
-	}
-}
-
-static int nvme_trans_format_unit(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
-							u8 *cmd)
-{
-	int res;
-	u8 parm_hdr_len = 0;
-	u8 nvme_pf_code = 0;
-	u8 format_prot_info, long_list, format_data;
-
-	format_prot_info = (cmd[1] & 0xc0) >> 6;
-	long_list = cmd[1] & 0x20;
-	format_data = cmd[1] & 0x10;
-
-	if (format_data != 0) {
-		if (format_prot_info != 0) {
-			if (long_list == 0)
-				parm_hdr_len =
FORMAT_UNIT_SHORT_PARM_LIST_LEN;
-			else
-				parm_hdr_len =
FORMAT_UNIT_LONG_PARM_LIST_LEN;
-		}
-	} else if (format_data == 0 && format_prot_info != 0) {
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		goto out;
-	}
-
-	/* Get parm header from data-in/out buffer */
-	/*
-	 * According to the translation spec, the only fields in the
parameter
-	 * list we are concerned with are in the header. So allocate
only that.
-	 */
-	if (parm_hdr_len > 0) {
-		res = nvme_trans_fmt_get_parm_header(hdr,
parm_hdr_len,
-					format_prot_info,
&nvme_pf_code);
-		if (res)
-			goto out;
-	}
-
-	/* Attempt to activate any previously downloaded firmware
image */
-	res = nvme_trans_send_activate_fw_cmd(ns, hdr, 0);
-
-	/* Determine Block size and count and send format command */
-	res = nvme_trans_fmt_set_blk_size_count(ns, hdr);
-	if (res)
-		goto out;
-
-	res = nvme_trans_fmt_send_cmd(ns, hdr, nvme_pf_code);
-
- out:
-	return res;
-}
-
-static int nvme_trans_test_unit_ready(struct nvme_ns *ns,
-					struct sg_io_hdr *hdr,
-					u8 *cmd)
-{
-	struct nvme_dev *dev = ns->dev;
-
-	if (!(readl(&dev->bar->csts) & NVME_CSTS_RDY))
-		return nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					    NOT_READY,
SCSI_ASC_LUN_NOT_READY,
-					   
 SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-	else
-		return nvme_trans_completion(hdr, SAM_STAT_GOOD,
NO_SENSE, 0, 0);
-}
-
-static int nvme_trans_write_buffer(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
-							u8 *cmd)
-{
-	int res = 0;
-	u32 buffer_offset, parm_list_length;
-	u8 buffer_id, mode;
-
-	parm_list_length = get_unaligned_be24(&cmd[6]);
-	if (parm_list_length % BYTES_TO_DWORDS != 0) {
-		/* NVMe expects Firmware file to be a whole number of
DWORDS */
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		goto out;
-	}
-	buffer_id = cmd[2];
-	if (buffer_id > NVME_MAX_FIRMWARE_SLOT) {
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		goto out;
-	}
-	mode = cmd[1] & 0x1f;
-	buffer_offset = get_unaligned_be24(&cmd[3]);
-
-	switch (mode) {
-	case DOWNLOAD_SAVE_ACTIVATE:
-		res = nvme_trans_send_download_fw_cmd(ns, hdr,
nvme_admin_download_fw,
-						parm_list_length,
buffer_offset,
-						buffer_id);
-		if (res)
-			goto out;
-		res = nvme_trans_send_activate_fw_cmd(ns, hdr,
buffer_id);
-		break;
-	case DOWNLOAD_SAVE_DEFER_ACTIVATE:
-		res = nvme_trans_send_download_fw_cmd(ns, hdr,
nvme_admin_download_fw,
-						parm_list_length,
buffer_offset,
-						buffer_id);
-		break;
-	case ACTIVATE_DEFERRED_MICROCODE:
-		res = nvme_trans_send_activate_fw_cmd(ns, hdr,
buffer_id);
-		break;
-	default:
-		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
-					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
-		break;
-	}
-
- out:
-	return res;
-}
-
-struct scsi_unmap_blk_desc {
-	__be64	slba;
-	__be32	nlb;
-	u32	resv;
-};
-
-struct scsi_unmap_parm_list {
-	__be16	unmap_data_len;
-	__be16	unmap_blk_desc_data_len;
-	u32	resv;
-	struct scsi_unmap_blk_desc desc[0];
-};
-
-static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
-							u8 *cmd)
-{
-	struct scsi_unmap_parm_list *plist;
-	struct nvme_dsm_range *range;
-	struct nvme_command c;
-	int i, nvme_sc, res;
-	u16 ndesc, list_len;
-
-	list_len = get_unaligned_be16(&cmd[7]);
-	if (!list_len)
-		return -EINVAL;
-
-	plist = kmalloc(list_len, GFP_KERNEL);
-	if (!plist)
-		return -ENOMEM;
-
-	res = nvme_trans_copy_from_user(hdr, plist, list_len);
-	if (res)
-		goto out;
-
-	ndesc = be16_to_cpu(plist->unmap_blk_desc_data_len) >> 4;
-	if (!ndesc || ndesc > 256) {
-		res = -EINVAL;
-		goto out;
-	}
-
-	range = kcalloc(ndesc, sizeof(*range), GFP_KERNEL);
-	if (!range) {
-		res = -ENOMEM;
-		goto out;
-	}
-
-	for (i = 0; i < ndesc; i++) {
-		range[i].nlb = cpu_to_le32(be32_to_cpu(plist
->desc[i].nlb));
-		range[i].slba = cpu_to_le64(be64_to_cpu(plist
->desc[i].slba));
-		range[i].cattr = 0;
-	}
-
-	memset(&c, 0, sizeof(c));
-	c.dsm.opcode = nvme_cmd_dsm;
-	c.dsm.nsid = cpu_to_le32(ns->ns_id);
-	c.dsm.nr = cpu_to_le32(ndesc - 1);
-	c.dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
-
-	nvme_sc = nvme_submit_sync_cmd(ns->queue, &c, range,
-			ndesc * sizeof(*range));
-	res = nvme_trans_status_code(hdr, nvme_sc);
-
-	kfree(range);
- out:
-	kfree(plist);
-	return res;
-}
-
-static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr
*hdr)
-{
-	u8 cmd[BLK_MAX_CDB];
-	int retcode;
-	unsigned int opcode;
-
-	if (hdr->cmdp == NULL)
-		return -EMSGSIZE;
-	if (copy_from_user(cmd, hdr->cmdp, hdr->cmd_len))
-		return -EFAULT;
-
-	/*
-	 * Prime the hdr with good status for scsi commands that don't
require
-	 * an nvme command for translation.
-	 */
-	retcode = nvme_trans_status_code(hdr, NVME_SC_SUCCESS);
-	if (retcode)
-		return retcode;
-
-	opcode = cmd[0];
-
-	switch (opcode) {
-	case READ_6:
-	case READ_10:
-	case READ_12:
-	case READ_16:
-		retcode = nvme_trans_io(ns, hdr, 0, cmd);
-		break;
-	case WRITE_6:
-	case WRITE_10:
-	case WRITE_12:
-	case WRITE_16:
-		retcode = nvme_trans_io(ns, hdr, 1, cmd);
-		break;
-	case INQUIRY:
-		retcode = nvme_trans_inquiry(ns, hdr, cmd);
-		break;
-	case LOG_SENSE:
-		retcode = nvme_trans_log_sense(ns, hdr, cmd);
-		break;
-	case MODE_SELECT:
-	case MODE_SELECT_10:
-		retcode = nvme_trans_mode_select(ns, hdr, cmd);
-		break;
-	case MODE_SENSE:
-	case MODE_SENSE_10:
-		retcode = nvme_trans_mode_sense(ns, hdr, cmd);
-		break;
-	case READ_CAPACITY:
-		retcode = nvme_trans_read_capacity(ns, hdr, cmd, 0);
-		break;
-	case SERVICE_ACTION_IN_16:
-		switch (cmd[1]) {
-		case SAI_READ_CAPACITY_16:
-			retcode = nvme_trans_read_capacity(ns, hdr,
cmd, 1);
-			break;
-		default:
-			goto out;
-		}
-		break;
-	case REPORT_LUNS:
-		retcode = nvme_trans_report_luns(ns, hdr, cmd);
-		break;
-	case REQUEST_SENSE:
-		retcode = nvme_trans_request_sense(ns, hdr, cmd);
-		break;
-	case SECURITY_PROTOCOL_IN:
-	case SECURITY_PROTOCOL_OUT:
-		retcode = nvme_trans_security_protocol(ns, hdr, cmd);
-		break;
-	case START_STOP:
-		retcode = nvme_trans_start_stop(ns, hdr, cmd);
-		break;
-	case SYNCHRONIZE_CACHE:
-		retcode = nvme_trans_synchronize_cache(ns, hdr);
-		break;
-	case FORMAT_UNIT:
-		retcode = nvme_trans_format_unit(ns, hdr, cmd);
-		break;
-	case TEST_UNIT_READY:
-		retcode = nvme_trans_test_unit_ready(ns, hdr, cmd);
-		break;
-	case WRITE_BUFFER:
-		retcode = nvme_trans_write_buffer(ns, hdr, cmd);
-		break;
-	case UNMAP:
-		retcode = nvme_trans_unmap(ns, hdr, cmd);
-		break;
-	default:
- out:
-		retcode = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
-				ILLEGAL_REQUEST,
SCSI_ASC_ILLEGAL_COMMAND,
-				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-		break;
-	}
-	return retcode;
-}
-
-int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr)
-{
-	struct sg_io_hdr hdr;
-	int retcode;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-	if (copy_from_user(&hdr, u_hdr, sizeof(hdr)))
-		return -EFAULT;
-	if (hdr.interface_id != 'S')
-		return -EINVAL;
-	if (hdr.cmd_len > BLK_MAX_CDB)
-		return -EINVAL;
-
-	/*
-	 * A positive return code means a NVMe status, which has been
-	 * translated to sense data.
-	 */
-	retcode = nvme_scsi_translate(ns, &hdr);
-	if (retcode < 0)
-		return retcode;
-	if (copy_to_user(u_hdr, &hdr, sizeof(sg_io_hdr_t)) > 0)
-		return -EFAULT;
-	return 0;
-}
-
-int nvme_sg_get_version_num(int __user *ip)
-{
-	return put_user(sg_version_num, ip);
-}
diff --git a/drivers/block/nvme/Kconfig b/drivers/block/nvme/Kconfig
new file mode 100644
index 0000000..0089f78
--- /dev/null
+++ b/drivers/block/nvme/Kconfig
@@ -0,0 +1,10 @@
+config BLK_DEV_NVME
+	tristate "NVM Express block device"
+	depends on PCI
+	---help---
+	  The NVM Express driver is for solid state drives directly
+	  connected to the PCI or PCI Express bus.  If you know you
+	  don't have one of these, it is safe to answer N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called nvme.
diff --git a/drivers/block/nvme/Makefile b/drivers/block/nvme/Makefile
new file mode 100644
index 0000000..52e1310
--- /dev/null
+++ b/drivers/block/nvme/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_BLK_DEV_NVME)	+= nvme.o
+
+nvme-y				:= core.o scsi.o
diff --git a/drivers/block/nvme/core.c b/drivers/block/nvme/core.c
new file mode 100644
index 0000000..b97fc3f
--- /dev/null
+++ b/drivers/block/nvme/core.c
@@ -0,0 +1,3395 @@
+/*
+ * NVM Express device driver
+ * Copyright (c) 2011-2014, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but
WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
License for
+ * more details.
+ */
+
+#include <linux/nvme.h>
+#include <linux/bitops.h>
+#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/hdreg.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kdev_t.h>
+#include <linux/kthread.h>
+#include <linux/kernel.h>
+#include <linux/list_sort.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/pci.h>
+#include <linux/poison.h>
+#include <linux/ptrace.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/t10-pi.h>
+#include <linux/types.h>
+#include <scsi/sg.h>
+#include <asm-generic/io-64-nonatomic-lo-hi.h>
+
+#define NVME_MINORS		(1U << MINORBITS)
+#define NVME_Q_DEPTH		1024
+#define NVME_AQ_DEPTH		256
+#define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
+#define CQ_SIZE(depth)		(depth * sizeof(struct
nvme_completion))
+#define ADMIN_TIMEOUT		(admin_timeout * HZ)
+#define SHUTDOWN_TIMEOUT	(shutdown_timeout * HZ)
+
+static unsigned char admin_timeout = 60;
+module_param(admin_timeout, byte, 0644);
+MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin
commands");
+
+unsigned char nvme_io_timeout = 30;
+module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
+MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
+
+static unsigned char shutdown_timeout = 5;
+module_param(shutdown_timeout, byte, 0644);
+MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller
shutdown");
+
+static int nvme_major;
+module_param(nvme_major, int, 0);
+
+static int nvme_char_major;
+module_param(nvme_char_major, int, 0);
+
+static int use_threaded_interrupts;
+module_param(use_threaded_interrupts, int, 0);
+
+static bool use_cmb_sqes = true;
+module_param(use_cmb_sqes, bool, 0644);
+MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O
SQes");
+
+static DEFINE_SPINLOCK(dev_list_lock);
+static LIST_HEAD(dev_list);
+static struct task_struct *nvme_thread;
+static struct workqueue_struct *nvme_workq;
+static wait_queue_head_t nvme_kthread_wait;
+
+static struct class *nvme_class;
+
+static void nvme_reset_failed_dev(struct work_struct *ws);
+static int nvme_reset(struct nvme_dev *dev);
+static int nvme_process_cq(struct nvme_queue *nvmeq);
+
+struct async_cmd_info {
+	struct kthread_work work;
+	struct kthread_worker *worker;
+	struct request *req;
+	u32 result;
+	int status;
+	void *ctx;
+};
+
+/*
+ * An NVM Express queue.  Each device has at least two (one for admin
+ * commands and one for I/O commands).
+ */
+struct nvme_queue {
+	struct device *q_dmadev;
+	struct nvme_dev *dev;
+	char irqname[24];	/* nvme4294967295-65535\0 */
+	spinlock_t q_lock;
+	struct nvme_command *sq_cmds;
+	struct nvme_command __iomem *sq_cmds_io;
+	volatile struct nvme_completion *cqes;
+	struct blk_mq_tags **tags;
+	dma_addr_t sq_dma_addr;
+	dma_addr_t cq_dma_addr;
+	u32 __iomem *q_db;
+	u16 q_depth;
+	s16 cq_vector;
+	u16 sq_head;
+	u16 sq_tail;
+	u16 cq_head;
+	u16 qid;
+	u8 cq_phase;
+	u8 cqe_seen;
+	struct async_cmd_info cmdinfo;
+};
+
+/*
+ * Check we didin't inadvertently grow the command struct
+ */
+static inline void _nvme_check_size(void)
+{
+	BUILD_BUG_ON(sizeof(struct nvme_rw_command) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_create_cq) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_create_sq) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_features) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_command) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != 4096);
+	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
+	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
+}
+
+typedef void (*nvme_completion_fn)(struct nvme_queue *, void *,
+						struct nvme_completion
*);
+
+struct nvme_cmd_info {
+	nvme_completion_fn fn;
+	void *ctx;
+	int aborted;
+	struct nvme_queue *nvmeq;
+	struct nvme_iod iod[0];
+};
+
+/*
+ * Max size of iod being embedded in the request payload
+ */
+#define NVME_INT_PAGES		2
+#define NVME_INT_BYTES(dev)	(NVME_INT_PAGES * (dev)->page_size)
+#define NVME_INT_MASK		0x01
+
+/*
+ * Will slightly overestimate the number of pages needed.  This is OK
+ * as it only leads to a small amount of wasted memory for the
lifetime of
+ * the I/O.
+ */
+static int nvme_npages(unsigned size, struct nvme_dev *dev)
+{
+	unsigned nprps = DIV_ROUND_UP(size + dev->page_size, dev
->page_size);
+	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
+}
+
+static unsigned int nvme_cmd_size(struct nvme_dev *dev)
+{
+	unsigned int ret = sizeof(struct nvme_cmd_info);
+
+	ret += sizeof(struct nvme_iod);
+	ret += sizeof(__le64 *) * nvme_npages(NVME_INT_BYTES(dev),
dev);
+	ret += sizeof(struct scatterlist) * NVME_INT_PAGES;
+
+	return ret;
+}
+
+static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void
*data,
+				unsigned int hctx_idx)
+{
+	struct nvme_dev *dev = data;
+	struct nvme_queue *nvmeq = dev->queues[0];
+
+	WARN_ON(hctx_idx != 0);
+	WARN_ON(dev->admin_tagset.tags[0] != hctx->tags);
+	WARN_ON(nvmeq->tags);
+
+	hctx->driver_data = nvmeq;
+	nvmeq->tags = &dev->admin_tagset.tags[0];
+	return 0;
+}
+
+static void nvme_admin_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned
int hctx_idx)
+{
+	struct nvme_queue *nvmeq = hctx->driver_data;
+
+	nvmeq->tags = NULL;
+}
+
+static int nvme_admin_init_request(void *data, struct request *req,
+				unsigned int hctx_idx, unsigned int
rq_idx,
+				unsigned int numa_node)
+{
+	struct nvme_dev *dev = data;
+	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = dev->queues[0];
+
+	BUG_ON(!nvmeq);
+	cmd->nvmeq = nvmeq;
+	return 0;
+}
+
+static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
+			  unsigned int hctx_idx)
+{
+	struct nvme_dev *dev = data;
+	struct nvme_queue *nvmeq = dev->queues[hctx_idx + 1];
+
+	if (!nvmeq->tags)
+		nvmeq->tags = &dev->tagset.tags[hctx_idx];
+
+	WARN_ON(dev->tagset.tags[hctx_idx] != hctx->tags);
+	hctx->driver_data = nvmeq;
+	return 0;
+}
+
+static int nvme_init_request(void *data, struct request *req,
+				unsigned int hctx_idx, unsigned int
rq_idx,
+				unsigned int numa_node)
+{
+	struct nvme_dev *dev = data;
+	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = dev->queues[hctx_idx + 1];
+
+	BUG_ON(!nvmeq);
+	cmd->nvmeq = nvmeq;
+	return 0;
+}
+
+static void nvme_set_info(struct nvme_cmd_info *cmd, void *ctx,
+				nvme_completion_fn handler)
+{
+	cmd->fn = handler;
+	cmd->ctx = ctx;
+	cmd->aborted = 0;
+	blk_mq_start_request(blk_mq_rq_from_pdu(cmd));
+}
+
+static void *iod_get_private(struct nvme_iod *iod)
+{
+	return (void *) (iod->private & ~0x1UL);
+}
+
+/*
+ * If bit 0 is set, the iod is embedded in the request payload.
+ */
+static bool iod_should_kfree(struct nvme_iod *iod)
+{
+	return (iod->private & NVME_INT_MASK) == 0;
+}
+
+/* Special values must be less than 0x1000 */
+#define CMD_CTX_BASE		((void *)POISON_POINTER_DELTA)
+#define CMD_CTX_CANCELLED	(0x30C + CMD_CTX_BASE)
+#define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
+#define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
+
+static void special_completion(struct nvme_queue *nvmeq, void *ctx,
+						struct nvme_completion
*cqe)
+{
+	if (ctx == CMD_CTX_CANCELLED)
+		return;
+	if (ctx == CMD_CTX_COMPLETED) {
+		dev_warn(nvmeq->q_dmadev,
+				"completed id %d twice on queue %d\n",
+				cqe->command_id, le16_to_cpup(&cqe
->sq_id));
+		return;
+	}
+	if (ctx == CMD_CTX_INVALID) {
+		dev_warn(nvmeq->q_dmadev,
+				"invalid id %d completed on queue
%d\n",
+				cqe->command_id, le16_to_cpup(&cqe
->sq_id));
+		return;
+	}
+	dev_warn(nvmeq->q_dmadev, "Unknown special completion %p\n",
ctx);
+}
+
+static void *cancel_cmd_info(struct nvme_cmd_info *cmd,
nvme_completion_fn *fn)
+{
+	void *ctx;
+
+	if (fn)
+		*fn = cmd->fn;
+	ctx = cmd->ctx;
+	cmd->fn = special_completion;
+	cmd->ctx = CMD_CTX_CANCELLED;
+	return ctx;
+}
+
+static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
+						struct nvme_completion
*cqe)
+{
+	u32 result = le32_to_cpup(&cqe->result);
+	u16 status = le16_to_cpup(&cqe->status) >> 1;
+
+	if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ)
+		++nvmeq->dev->event_limit;
+	if (status != NVME_SC_SUCCESS)
+		return;
+
+	switch (result & 0xff07) {
+	case NVME_AER_NOTICE_NS_CHANGED:
+		dev_info(nvmeq->q_dmadev, "rescanning\n");
+		schedule_work(&nvmeq->dev->scan_work);
+	default:
+		dev_warn(nvmeq->q_dmadev, "async event result %08x\n",
result);
+	}
+}
+
+static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
+						struct nvme_completion
*cqe)
+{
+	struct request *req = ctx;
+
+	u16 status = le16_to_cpup(&cqe->status) >> 1;
+	u32 result = le32_to_cpup(&cqe->result);
+
+	blk_mq_free_request(req);
+
+	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x", status,
result);
+	++nvmeq->dev->abort_limit;
+}
+
+static void async_completion(struct nvme_queue *nvmeq, void *ctx,
+						struct nvme_completion
*cqe)
+{
+	struct async_cmd_info *cmdinfo = ctx;
+	cmdinfo->result = le32_to_cpup(&cqe->result);
+	cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
+	queue_kthread_work(cmdinfo->worker, &cmdinfo->work);
+	blk_mq_free_request(cmdinfo->req);
+}
+
+static inline struct nvme_cmd_info *get_cmd_from_tag(struct nvme_queue
*nvmeq,
+				  unsigned int tag)
+{
+	struct request *req = blk_mq_tag_to_rq(*nvmeq->tags, tag);
+
+	return blk_mq_rq_to_pdu(req);
+}
+
+/*
+ * Called with local interrupts disabled and the q_lock held.  May not
sleep.
+ */
+static void *nvme_finish_cmd(struct nvme_queue *nvmeq, int tag,
+						nvme_completion_fn
*fn)
+{
+	struct nvme_cmd_info *cmd = get_cmd_from_tag(nvmeq, tag);
+	void *ctx;
+	if (tag >= nvmeq->q_depth) {
+		*fn = special_completion;
+		return CMD_CTX_INVALID;
+	}
+	if (fn)
+		*fn = cmd->fn;
+	ctx = cmd->ctx;
+	cmd->fn = special_completion;
+	cmd->ctx = CMD_CTX_COMPLETED;
+	return ctx;
+}
+
+/**
+ * nvme_submit_cmd() - Copy a command into a queue and ring the
doorbell
+ * @nvmeq: The queue to use
+ * @cmd: The command to send
+ *
+ * Safe to use from interrupt context
+ */
+static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
+						struct nvme_command
*cmd)
+{
+	u16 tail = nvmeq->sq_tail;
+
+	if (nvmeq->sq_cmds_io)
+		memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd,
sizeof(*cmd));
+	else
+		memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
+
+	if (++tail == nvmeq->q_depth)
+		tail = 0;
+	writel(tail, nvmeq->q_db);
+	nvmeq->sq_tail = tail;
+}
+
+static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct
nvme_command *cmd)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&nvmeq->q_lock, flags);
+	__nvme_submit_cmd(nvmeq, cmd);
+	spin_unlock_irqrestore(&nvmeq->q_lock, flags);
+}
+
+static __le64 **iod_list(struct nvme_iod *iod)
+{
+	return ((void *)iod) + iod->offset;
+}
+
+static inline void iod_init(struct nvme_iod *iod, unsigned nbytes,
+			    unsigned nseg, unsigned long private)
+{
+	iod->private = private;
+	iod->offset = offsetof(struct nvme_iod, sg[nseg]);
+	iod->npages = -1;
+	iod->length = nbytes;
+	iod->nents = 0;
+}
+
+static struct nvme_iod *
+__nvme_alloc_iod(unsigned nseg, unsigned bytes, struct nvme_dev *dev,
+		 unsigned long priv, gfp_t gfp)
+{
+	struct nvme_iod *iod = kmalloc(sizeof(struct nvme_iod) +
+				sizeof(__le64 *) * nvme_npages(bytes,
dev) +
+				sizeof(struct scatterlist) * nseg,
gfp);
+
+	if (iod)
+		iod_init(iod, bytes, nseg, priv);
+
+	return iod;
+}
+
+static struct nvme_iod *nvme_alloc_iod(struct request *rq, struct
nvme_dev *dev,
+			               gfp_t gfp)
+{
+	unsigned size = !(rq->cmd_flags & REQ_DISCARD) ?
blk_rq_bytes(rq) :
+                                                sizeof(struct
nvme_dsm_range);
+	struct nvme_iod *iod;
+
+	if (rq->nr_phys_segments <= NVME_INT_PAGES &&
+	    size <= NVME_INT_BYTES(dev)) {
+		struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(rq);
+
+		iod = cmd->iod;
+		iod_init(iod, size, rq->nr_phys_segments,
+				(unsigned long) rq | NVME_INT_MASK);
+		return iod;
+	}
+
+	return __nvme_alloc_iod(rq->nr_phys_segments, size, dev,
+				(unsigned long) rq, gfp);
+}
+
+static void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
+{
+	const int last_prp = dev->page_size / 8 - 1;
+	int i;
+	__le64 **list = iod_list(iod);
+	dma_addr_t prp_dma = iod->first_dma;
+
+	if (iod->npages == 0)
+		dma_pool_free(dev->prp_small_pool, list[0], prp_dma);
+	for (i = 0; i < iod->npages; i++) {
+		__le64 *prp_list = list[i];
+		dma_addr_t next_prp_dma =
le64_to_cpu(prp_list[last_prp]);
+		dma_pool_free(dev->prp_page_pool, prp_list, prp_dma);
+		prp_dma = next_prp_dma;
+	}
+
+	if (iod_should_kfree(iod))
+		kfree(iod);
+}
+
+static int nvme_error_status(u16 status)
+{
+	switch (status & 0x7ff) {
+	case NVME_SC_SUCCESS:
+		return 0;
+	case NVME_SC_CAP_EXCEEDED:
+		return -ENOSPC;
+	default:
+		return -EIO;
+	}
+}
+
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static void nvme_dif_prep(u32 p, u32 v, struct t10_pi_tuple *pi)
+{
+	if (be32_to_cpu(pi->ref_tag) == v)
+		pi->ref_tag = cpu_to_be32(p);
+}
+
+static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
+{
+	if (be32_to_cpu(pi->ref_tag) == p)
+		pi->ref_tag = cpu_to_be32(v);
+}
+
+/**
+ * nvme_dif_remap - remaps ref tags to bip seed and physical lba
+ *
+ * The virtual start sector is the one that was originally submitted
by the
+ * block layer.	Due to partitioning, MD/DM cloning, etc. the
actual physical
+ * start sector may be different. Remap protection information to
match the
+ * physical LBA on writes, and back to the original seed on reads.
+ *
+ * Type 0 and 3 do not have a ref tag, so no remapping required.
+ */
+static void nvme_dif_remap(struct request *req,
+			void (*dif_swap)(u32 p, u32 v, struct
t10_pi_tuple *pi))
+{
+	struct nvme_ns *ns = req->rq_disk->private_data;
+	struct bio_integrity_payload *bip;
+	struct t10_pi_tuple *pi;
+	void *p, *pmap;
+	u32 i, nlb, ts, phys, virt;
+
+	if (!ns->pi_type || ns->pi_type == NVME_NS_DPS_PI_TYPE3)
+		return;
+
+	bip = bio_integrity(req->bio);
+	if (!bip)
+		return;
+
+	pmap = kmap_atomic(bip->bip_vec->bv_page) + bip->bip_vec
->bv_offset;
+
+	p = pmap;
+	virt = bip_get_seed(bip);
+	phys = nvme_block_nr(ns, blk_rq_pos(req));
+	nlb = (blk_rq_bytes(req) >> ns->lba_shift);
+	ts = ns->disk->integrity->tuple_size;
+
+	for (i = 0; i < nlb; i++, virt++, phys++) {
+		pi = (struct t10_pi_tuple *)p;
+		dif_swap(phys, virt, pi);
+		p += ts;
+	}
+	kunmap_atomic(pmap);
+}
+
+static int nvme_noop_verify(struct blk_integrity_iter *iter)
+{
+	return 0;
+}
+
+static int nvme_noop_generate(struct blk_integrity_iter *iter)
+{
+	return 0;
+}
+
+struct blk_integrity nvme_meta_noop = {
+	.name			= "NVME_META_NOOP",
+	.generate_fn		= nvme_noop_generate,
+	.verify_fn		= nvme_noop_verify,
+};
+
+static void nvme_init_integrity(struct nvme_ns *ns)
+{
+	struct blk_integrity integrity;
+
+	switch (ns->pi_type) {
+	case NVME_NS_DPS_PI_TYPE3:
+		integrity = t10_pi_type3_crc;
+		break;
+	case NVME_NS_DPS_PI_TYPE1:
+	case NVME_NS_DPS_PI_TYPE2:
+		integrity = t10_pi_type1_crc;
+		break;
+	default:
+		integrity = nvme_meta_noop;
+		break;
+	}
+	integrity.tuple_size = ns->ms;
+	blk_integrity_register(ns->disk, &integrity);
+	blk_queue_max_integrity_segments(ns->queue, 1);
+}
+#else /* CONFIG_BLK_DEV_INTEGRITY */
+static void nvme_dif_remap(struct request *req,
+			void (*dif_swap)(u32 p, u32 v, struct
t10_pi_tuple *pi))
+{
+}
+static void nvme_dif_prep(u32 p, u32 v, struct t10_pi_tuple *pi)
+{
+}
+static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
+{
+}
+static void nvme_init_integrity(struct nvme_ns *ns)
+{
+}
+#endif
+
+static void req_completion(struct nvme_queue *nvmeq, void *ctx,
+						struct nvme_completion
*cqe)
+{
+	struct nvme_iod *iod = ctx;
+	struct request *req = iod_get_private(iod);
+	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
+
+	u16 status = le16_to_cpup(&cqe->status) >> 1;
+
+	if (unlikely(status)) {
+		if (!(status & NVME_SC_DNR ||
blk_noretry_request(req))
+		    && (jiffies - req->start_time) < req->timeout) {
+			unsigned long flags;
+
+			blk_mq_requeue_request(req);
+			spin_lock_irqsave(req->q->queue_lock, flags);
+			if (!blk_queue_stopped(req->q))
+				blk_mq_kick_requeue_list(req->q);
+			spin_unlock_irqrestore(req->q->queue_lock,
flags);
+			return;
+		}
+		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
+			if (cmd_rq->ctx == CMD_CTX_CANCELLED)
+				req->errors = -EINTR;
+			else
+				req->errors = status;
+		} else {
+			req->errors = nvme_error_status(status);
+		}
+	} else
+		req->errors = 0;
+	if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
+		u32 result = le32_to_cpup(&cqe->result);
+		req->special = (void *)(uintptr_t)result;
+	}
+
+	if (cmd_rq->aborted)
+		dev_warn(nvmeq->dev->dev,
+			"completing aborted command with
status:%04x\n",
+			status);
+
+	if (iod->nents) {
+		dma_unmap_sg(nvmeq->dev->dev, iod->sg, iod->nents,
+			rq_data_dir(req) ? DMA_TO_DEVICE :
DMA_FROM_DEVICE);
+		if (blk_integrity_rq(req)) {
+			if (!rq_data_dir(req))
+				nvme_dif_remap(req,
nvme_dif_complete);
+			dma_unmap_sg(nvmeq->dev->dev, iod->meta_sg, 1,
+				rq_data_dir(req) ? DMA_TO_DEVICE :
DMA_FROM_DEVICE);
+		}
+	}
+	nvme_free_iod(nvmeq->dev, iod);
+
+	blk_mq_complete_request(req);
+}
+
+/* length is in bytes.  gfp flags indicates whether we may sleep. */
+static int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
+		int total_len, gfp_t gfp)
+{
+	struct dma_pool *pool;
+	int length = total_len;
+	struct scatterlist *sg = iod->sg;
+	int dma_len = sg_dma_len(sg);
+	u64 dma_addr = sg_dma_address(sg);
+	u32 page_size = dev->page_size;
+	int offset = dma_addr & (page_size - 1);
+	__le64 *prp_list;
+	__le64 **list = iod_list(iod);
+	dma_addr_t prp_dma;
+	int nprps, i;
+
+	length -= (page_size - offset);
+	if (length <= 0)
+		return total_len;
+
+	dma_len -= (page_size - offset);
+	if (dma_len) {
+		dma_addr += (page_size - offset);
+	} else {
+		sg = sg_next(sg);
+		dma_addr = sg_dma_address(sg);
+		dma_len = sg_dma_len(sg);
+	}
+
+	if (length <= page_size) {
+		iod->first_dma = dma_addr;
+		return total_len;
+	}
+
+	nprps = DIV_ROUND_UP(length, page_size);
+	if (nprps <= (256 / 8)) {
+		pool = dev->prp_small_pool;
+		iod->npages = 0;
+	} else {
+		pool = dev->prp_page_pool;
+		iod->npages = 1;
+	}
+
+	prp_list = dma_pool_alloc(pool, gfp, &prp_dma);
+	if (!prp_list) {
+		iod->first_dma = dma_addr;
+		iod->npages = -1;
+		return (total_len - length) + page_size;
+	}
+	list[0] = prp_list;
+	iod->first_dma = prp_dma;
+	i = 0;
+	for (;;) {
+		if (i == page_size >> 3) {
+			__le64 *old_prp_list = prp_list;
+			prp_list = dma_pool_alloc(pool, gfp,
&prp_dma);
+			if (!prp_list)
+				return total_len - length;
+			list[iod->npages++] = prp_list;
+			prp_list[0] = old_prp_list[i - 1];
+			old_prp_list[i - 1] = cpu_to_le64(prp_dma);
+			i = 1;
+		}
+		prp_list[i++] = cpu_to_le64(dma_addr);
+		dma_len -= page_size;
+		dma_addr += page_size;
+		length -= page_size;
+		if (length <= 0)
+			break;
+		if (dma_len > 0)
+			continue;
+		BUG_ON(dma_len < 0);
+		sg = sg_next(sg);
+		dma_addr = sg_dma_address(sg);
+		dma_len = sg_dma_len(sg);
+	}
+
+	return total_len;
+}
+
+static void nvme_submit_priv(struct nvme_queue *nvmeq, struct request
*req,
+		struct nvme_iod *iod)
+{
+	struct nvme_command cmnd;
+
+	memcpy(&cmnd, req->cmd, sizeof(cmnd));
+	cmnd.rw.command_id = req->tag;
+	if (req->nr_phys_segments) {
+		cmnd.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+		cmnd.rw.prp2 = cpu_to_le64(iod->first_dma);
+	}
+
+	__nvme_submit_cmd(nvmeq, &cmnd);
+}
+
+/*
+ * We reuse the small pool to allocate the 16-byte range here as it is
not
+ * worth having a special pool for these or additional cases to handle
freeing
+ * the iod.
+ */
+static void nvme_submit_discard(struct nvme_queue *nvmeq, struct
nvme_ns *ns,
+		struct request *req, struct nvme_iod *iod)
+{
+	struct nvme_dsm_range *range =
+				(struct nvme_dsm_range
*)iod_list(iod)[0];
+	struct nvme_command cmnd;
+
+	range->cattr = cpu_to_le32(0);
+	range->nlb = cpu_to_le32(blk_rq_bytes(req) >> ns->lba_shift);
+	range->slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+
+	memset(&cmnd, 0, sizeof(cmnd));
+	cmnd.dsm.opcode = nvme_cmd_dsm;
+	cmnd.dsm.command_id = req->tag;
+	cmnd.dsm.nsid = cpu_to_le32(ns->ns_id);
+	cmnd.dsm.prp1 = cpu_to_le64(iod->first_dma);
+	cmnd.dsm.nr = 0;
+	cmnd.dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
+
+	__nvme_submit_cmd(nvmeq, &cmnd);
+}
+
+static void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns
*ns,
+								int
cmdid)
+{
+	struct nvme_command cmnd;
+
+	memset(&cmnd, 0, sizeof(cmnd));
+	cmnd.common.opcode = nvme_cmd_flush;
+	cmnd.common.command_id = cmdid;
+	cmnd.common.nsid = cpu_to_le32(ns->ns_id);
+
+	__nvme_submit_cmd(nvmeq, &cmnd);
+}
+
+static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod
*iod,
+							struct nvme_ns
*ns)
+{
+	struct request *req = iod_get_private(iod);
+	struct nvme_command cmnd;
+	u16 control = 0;
+	u32 dsmgmt = 0;
+
+	if (req->cmd_flags & REQ_FUA)
+		control |= NVME_RW_FUA;
+	if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
+		control |= NVME_RW_LR;
+
+	if (req->cmd_flags & REQ_RAHEAD)
+		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
+
+	memset(&cmnd, 0, sizeof(cmnd));
+	cmnd.rw.opcode = (rq_data_dir(req) ? nvme_cmd_write :
nvme_cmd_read);
+	cmnd.rw.command_id = req->tag;
+	cmnd.rw.nsid = cpu_to_le32(ns->ns_id);
+	cmnd.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+	cmnd.rw.prp2 = cpu_to_le64(iod->first_dma);
+	cmnd.rw.slba = cpu_to_le64(nvme_block_nr(ns,
blk_rq_pos(req)));
+	cmnd.rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns
->lba_shift) - 1);
+
+	if (ns->ms) {
+		switch (ns->pi_type) {
+		case NVME_NS_DPS_PI_TYPE3:
+			control |= NVME_RW_PRINFO_PRCHK_GUARD;
+			break;
+		case NVME_NS_DPS_PI_TYPE1:
+		case NVME_NS_DPS_PI_TYPE2:
+			control |= NVME_RW_PRINFO_PRCHK_GUARD |
+					NVME_RW_PRINFO_PRCHK_REF;
+			cmnd.rw.reftag = cpu_to_le32(
+					nvme_block_nr(ns,
blk_rq_pos(req)));
+			break;
+		}
+		if (blk_integrity_rq(req))
+			cmnd.rw.metadata =
+				cpu_to_le64(sg_dma_address(iod
->meta_sg));
+		else
+			control |= NVME_RW_PRINFO_PRACT;
+	}
+
+	cmnd.rw.control = cpu_to_le16(control);
+	cmnd.rw.dsmgmt = cpu_to_le32(dsmgmt);
+
+	__nvme_submit_cmd(nvmeq, &cmnd);
+
+	return 0;
+}
+
+/*
+ * NOTE: ns is NULL when called on the admin queue.
+ */
+static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
+			 const struct blk_mq_queue_data *bd)
+{
+	struct nvme_ns *ns = hctx->queue->queuedata;
+	struct nvme_queue *nvmeq = hctx->driver_data;
+	struct nvme_dev *dev = nvmeq->dev;
+	struct request *req = bd->rq;
+	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
+	struct nvme_iod *iod;
+	enum dma_data_direction dma_dir;
+
+	/*
+	 * If formated with metadata, require the block layer provide
a buffer
+	 * unless this namespace is formated such that the metadata
can be
+	 * stripped/generated by the controller with PRACT=1.
+	 */
+	if (ns && ns->ms && !blk_integrity_rq(req)) {
+		if (!(ns->pi_type && ns->ms == 8) &&
+					req->cmd_type !=
REQ_TYPE_DRV_PRIV) {
+			req->errors = -EFAULT;
+			blk_mq_complete_request(req);
+			return BLK_MQ_RQ_QUEUE_OK;
+		}
+	}
+
+	iod = nvme_alloc_iod(req, dev, GFP_ATOMIC);
+	if (!iod)
+		return BLK_MQ_RQ_QUEUE_BUSY;
+
+	if (req->cmd_flags & REQ_DISCARD) {
+		void *range;
+		/*
+		 * We reuse the small pool to allocate the 16-byte
range here
+		 * as it is not worth having a special pool for these
or
+		 * additional cases to handle freeing the iod.
+		 */
+		range = dma_pool_alloc(dev->prp_small_pool,
GFP_ATOMIC,
+						&iod->first_dma);
+		if (!range)
+			goto retry_cmd;
+		iod_list(iod)[0] = (__le64 *)range;
+		iod->npages = 0;
+	} else if (req->nr_phys_segments) {
+		dma_dir = rq_data_dir(req) ? DMA_TO_DEVICE :
DMA_FROM_DEVICE;
+
+		sg_init_table(iod->sg, req->nr_phys_segments);
+		iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
+		if (!iod->nents)
+			goto error_cmd;
+
+		if (!dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents,
dma_dir))
+			goto retry_cmd;
+
+		if (blk_rq_bytes(req) !=
+                    nvme_setup_prps(dev, iod, blk_rq_bytes(req),
GFP_ATOMIC)) {
+			dma_unmap_sg(dev->dev, iod->sg, iod->nents,
dma_dir);
+			goto retry_cmd;
+		}
+		if (blk_integrity_rq(req)) {
+			if (blk_rq_count_integrity_sg(req->q, req
->bio) != 1)
+				goto error_cmd;
+
+			sg_init_table(iod->meta_sg, 1);
+			if (blk_rq_map_integrity_sg(
+					req->q, req->bio, iod
->meta_sg) != 1)
+				goto error_cmd;
+
+			if (rq_data_dir(req))
+				nvme_dif_remap(req, nvme_dif_prep);
+
+			if (!dma_map_sg(nvmeq->q_dmadev, iod->meta_sg,
1, dma_dir))
+				goto error_cmd;
+		}
+	}
+
+	nvme_set_info(cmd, iod, req_completion);
+	spin_lock_irq(&nvmeq->q_lock);
+	if (req->cmd_type == REQ_TYPE_DRV_PRIV)
+		nvme_submit_priv(nvmeq, req, iod);
+	else if (req->cmd_flags & REQ_DISCARD)
+		nvme_submit_discard(nvmeq, ns, req, iod);
+	else if (req->cmd_flags & REQ_FLUSH)
+		nvme_submit_flush(nvmeq, ns, req->tag);
+	else
+		nvme_submit_iod(nvmeq, iod, ns);
+
+	nvme_process_cq(nvmeq);
+	spin_unlock_irq(&nvmeq->q_lock);
+	return BLK_MQ_RQ_QUEUE_OK;
+
+ error_cmd:
+	nvme_free_iod(dev, iod);
+	return BLK_MQ_RQ_QUEUE_ERROR;
+ retry_cmd:
+	nvme_free_iod(dev, iod);
+	return BLK_MQ_RQ_QUEUE_BUSY;
+}
+
+static int nvme_process_cq(struct nvme_queue *nvmeq)
+{
+	u16 head, phase;
+
+	head = nvmeq->cq_head;
+	phase = nvmeq->cq_phase;
+
+	for (;;) {
+		void *ctx;
+		nvme_completion_fn fn;
+		struct nvme_completion cqe = nvmeq->cqes[head];
+		if ((le16_to_cpu(cqe.status) & 1) != phase)
+			break;
+		nvmeq->sq_head = le16_to_cpu(cqe.sq_head);
+		if (++head == nvmeq->q_depth) {
+			head = 0;
+			phase = !phase;
+		}
+		ctx = nvme_finish_cmd(nvmeq, cqe.command_id, &fn);
+		fn(nvmeq, ctx, &cqe);
+	}
+
+	/* If the controller ignores the cq head doorbell and
continuously
+	 * writes to the queue, it is theoretically possible to wrap
around
+	 * the queue twice and mistakenly return IRQ_NONE.  Linux only
+	 * requires that 0.1% of your interrupts are handled, so this
isn't
+	 * a big problem.
+	 */
+	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
+		return 0;
+
+	writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+	nvmeq->cq_head = head;
+	nvmeq->cq_phase = phase;
+
+	nvmeq->cqe_seen = 1;
+	return 1;
+}
+
+static irqreturn_t nvme_irq(int irq, void *data)
+{
+	irqreturn_t result;
+	struct nvme_queue *nvmeq = data;
+	spin_lock(&nvmeq->q_lock);
+	nvme_process_cq(nvmeq);
+	result = nvmeq->cqe_seen ? IRQ_HANDLED : IRQ_NONE;
+	nvmeq->cqe_seen = 0;
+	spin_unlock(&nvmeq->q_lock);
+	return result;
+}
+
+static irqreturn_t nvme_irq_check(int irq, void *data)
+{
+	struct nvme_queue *nvmeq = data;
+	struct nvme_completion cqe = nvmeq->cqes[nvmeq->cq_head];
+	if ((le16_to_cpu(cqe.status) & 1) != nvmeq->cq_phase)
+		return IRQ_NONE;
+	return IRQ_WAKE_THREAD;
+}
+
+/*
+ * Returns 0 on success.  If the result is negative, it's a Linux
error code;
+ * if the result is positive, it's an NVM Express status code
+ */
+int __nvme_submit_sync_cmd(struct request_queue *q, struct
nvme_command *cmd,
+		void *buffer, void __user *ubuffer, unsigned bufflen,
+		u32 *result, unsigned timeout)
+{
+	bool write = cmd->common.opcode & 1;
+	struct bio *bio = NULL;
+	struct request *req;
+	int ret;
+
+	req = blk_mq_alloc_request(q, write, GFP_KERNEL, false);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	req->cmd_type = REQ_TYPE_DRV_PRIV;
+	req->cmd_flags |= REQ_FAILFAST_DRIVER;
+	req->__data_len = 0;
+	req->__sector = (sector_t) -1;
+	req->bio = req->biotail = NULL;
+
+	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+
+	req->cmd = (unsigned char *)cmd;
+	req->cmd_len = sizeof(struct nvme_command);
+	req->special = (void *)0;
+
+	if (buffer && bufflen) {
+		ret = blk_rq_map_kern(q, req, buffer, bufflen,
__GFP_WAIT);
+		if (ret)
+			goto out;
+	} else if (ubuffer && bufflen) {
+		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
__GFP_WAIT);
+		if (ret)
+			goto out;
+		bio = req->bio;
+	}
+
+	blk_execute_rq(req->q, NULL, req, 0);
+	if (bio)
+		blk_rq_unmap_user(bio);
+	if (result)
+		*result = (u32)(uintptr_t)req->special;
+	ret = req->errors;
+ out:
+	blk_mq_free_request(req);
+	return ret;
+}
+
+int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command
*cmd,
+		void *buffer, unsigned bufflen)
+{
+	return __nvme_submit_sync_cmd(q, cmd, buffer, NULL, bufflen,
NULL, 0);
+}
+
+static int nvme_submit_async_admin_req(struct nvme_dev *dev)
+{
+	struct nvme_queue *nvmeq = dev->queues[0];
+	struct nvme_command c;
+	struct nvme_cmd_info *cmd_info;
+	struct request *req;
+
+	req = blk_mq_alloc_request(dev->admin_q, WRITE, GFP_ATOMIC,
true);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	req->cmd_flags |= REQ_NO_TIMEOUT;
+	cmd_info = blk_mq_rq_to_pdu(req);
+	nvme_set_info(cmd_info, NULL, async_req_completion);
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_admin_async_event;
+	c.common.command_id = req->tag;
+
+	blk_mq_free_request(req);
+	__nvme_submit_cmd(nvmeq, &c);
+	return 0;
+}
+
+static int nvme_submit_admin_async_cmd(struct nvme_dev *dev,
+			struct nvme_command *cmd,
+			struct async_cmd_info *cmdinfo, unsigned
timeout)
+{
+	struct nvme_queue *nvmeq = dev->queues[0];
+	struct request *req;
+	struct nvme_cmd_info *cmd_rq;
+
+	req = blk_mq_alloc_request(dev->admin_q, WRITE, GFP_KERNEL,
false);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	req->timeout = timeout;
+	cmd_rq = blk_mq_rq_to_pdu(req);
+	cmdinfo->req = req;
+	nvme_set_info(cmd_rq, cmdinfo, async_completion);
+	cmdinfo->status = -EINTR;
+
+	cmd->common.command_id = req->tag;
+
+	nvme_submit_cmd(nvmeq, cmd);
+	return 0;
+}
+
+static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16
id)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	c.delete_queue.opcode = opcode;
+	c.delete_queue.qid = cpu_to_le16(id);
+
+	return nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0);
+}
+
+static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
+						struct nvme_queue
*nvmeq)
+{
+	struct nvme_command c;
+	int flags = NVME_QUEUE_PHYS_CONTIG | NVME_CQ_IRQ_ENABLED;
+
+	/*
+	 * Note: we (ab)use the fact the the prp fields survive if no
data
+	 * is attached to the request.
+	 */
+	memset(&c, 0, sizeof(c));
+	c.create_cq.opcode = nvme_admin_create_cq;
+	c.create_cq.prp1 = cpu_to_le64(nvmeq->cq_dma_addr);
+	c.create_cq.cqid = cpu_to_le16(qid);
+	c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
+	c.create_cq.cq_flags = cpu_to_le16(flags);
+	c.create_cq.irq_vector = cpu_to_le16(nvmeq->cq_vector);
+
+	return nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0);
+}
+
+static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
+						struct nvme_queue
*nvmeq)
+{
+	struct nvme_command c;
+	int flags = NVME_QUEUE_PHYS_CONTIG | NVME_SQ_PRIO_MEDIUM;
+
+	/*
+	 * Note: we (ab)use the fact the the prp fields survive if no
data
+	 * is attached to the request.
+	 */
+	memset(&c, 0, sizeof(c));
+	c.create_sq.opcode = nvme_admin_create_sq;
+	c.create_sq.prp1 = cpu_to_le64(nvmeq->sq_dma_addr);
+	c.create_sq.sqid = cpu_to_le16(qid);
+	c.create_sq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
+	c.create_sq.sq_flags = cpu_to_le16(flags);
+	c.create_sq.cqid = cpu_to_le16(qid);
+
+	return nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0);
+}
+
+static int adapter_delete_cq(struct nvme_dev *dev, u16 cqid)
+{
+	return adapter_delete_queue(dev, nvme_admin_delete_cq, cqid);
+}
+
+static int adapter_delete_sq(struct nvme_dev *dev, u16 sqid)
+{
+	return adapter_delete_queue(dev, nvme_admin_delete_sq, sqid);
+}
+
+int nvme_identify_ctrl(struct nvme_dev *dev, struct nvme_id_ctrl **id)
+{
+	struct nvme_command c = { };
+	int error;
+
+	/* gcc-4.4.4 (at least) has issues with initializers and anon
unions */
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.cns = cpu_to_le32(1);
+
+	*id = kmalloc(sizeof(struct nvme_id_ctrl), GFP_KERNEL);
+	if (!*id)
+		return -ENOMEM;
+
+	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
+			sizeof(struct nvme_id_ctrl));
+	if (error)
+		kfree(*id);
+	return error;
+}
+
+int nvme_identify_ns(struct nvme_dev *dev, unsigned nsid,
+		struct nvme_id_ns **id)
+{
+	struct nvme_command c = { };
+	int error;
+
+	/* gcc-4.4.4 (at least) has issues with initializers and anon
unions */
+	c.identify.opcode = nvme_admin_identify,
+	c.identify.nsid = cpu_to_le32(nsid),
+
+	*id = kmalloc(sizeof(struct nvme_id_ns), GFP_KERNEL);
+	if (!*id)
+		return -ENOMEM;
+
+	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
+			sizeof(struct nvme_id_ns));
+	if (error)
+		kfree(*id);
+	return error;
+}
+
+int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned
nsid,
+					dma_addr_t dma_addr, u32
*result)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	c.features.opcode = nvme_admin_get_features;
+	c.features.nsid = cpu_to_le32(nsid);
+	c.features.prp1 = cpu_to_le64(dma_addr);
+	c.features.fid = cpu_to_le32(fid);
+
+	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, NULL, 0,
+			result, 0);
+}
+
+int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned
dword11,
+					dma_addr_t dma_addr, u32
*result)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	c.features.opcode = nvme_admin_set_features;
+	c.features.prp1 = cpu_to_le64(dma_addr);
+	c.features.fid = cpu_to_le32(fid);
+	c.features.dword11 = cpu_to_le32(dword11);
+
+	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, NULL, 0,
+			result, 0);
+}
+
+int nvme_get_log_page(struct nvme_dev *dev, struct nvme_smart_log
**log)
+{
+	struct nvme_command c = { };
+	int error;
+
+	c.common.opcode = nvme_admin_get_log_page,
+	c.common.nsid = cpu_to_le32(0xFFFFFFFF),
+	c.common.cdw10[0] = cpu_to_le32(
+			(((sizeof(struct nvme_smart_log) / 4) - 1) <<
16) |
+			 NVME_LOG_SMART),
+
+	*log = kmalloc(sizeof(struct nvme_smart_log), GFP_KERNEL);
+	if (!*log)
+		return -ENOMEM;
+
+	error = nvme_submit_sync_cmd(dev->admin_q, &c, *log,
+			sizeof(struct nvme_smart_log));
+	if (error)
+		kfree(*log);
+	return error;
+}
+
+/**
+ * nvme_abort_req - Attempt aborting a request
+ *
+ * Schedule controller reset if the command was already aborted once
before and
+ * still hasn't been returned to the driver, or if this is the admin
queue.
+ */
+static void nvme_abort_req(struct request *req)
+{
+	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = cmd_rq->nvmeq;
+	struct nvme_dev *dev = nvmeq->dev;
+	struct request *abort_req;
+	struct nvme_cmd_info *abort_cmd;
+	struct nvme_command cmd;
+
+	if (!nvmeq->qid || cmd_rq->aborted) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&dev_list_lock, flags);
+		if (work_busy(&dev->reset_work))
+			goto out;
+		list_del_init(&dev->node);
+		dev_warn(dev->dev, "I/O %d QID %d timeout, reset
controller\n",
+							req->tag,
nvmeq->qid);
+		dev->reset_workfn = nvme_reset_failed_dev;
+		queue_work(nvme_workq, &dev->reset_work);
+ out:
+		spin_unlock_irqrestore(&dev_list_lock, flags);
+		return;
+	}
+
+	if (!dev->abort_limit)
+		return;
+
+	abort_req = blk_mq_alloc_request(dev->admin_q, WRITE,
GFP_ATOMIC,
+									false);
+	if (IS_ERR(abort_req))
+		return;
+
+	abort_cmd = blk_mq_rq_to_pdu(abort_req);
+	nvme_set_info(abort_cmd, abort_req, abort_completion);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abort.opcode = nvme_admin_abort_cmd;
+	cmd.abort.cid = req->tag;
+	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
+	cmd.abort.command_id = abort_req->tag;
+
+	--dev->abort_limit;
+	cmd_rq->aborted = 1;
+
+	dev_warn(nvmeq->q_dmadev, "Aborting I/O %d QID %d\n", req
->tag,
+							nvmeq->qid);
+	nvme_submit_cmd(dev->queues[0], &cmd);
+}
+
+static void nvme_cancel_queue_ios(struct request *req, void *data,
bool reserved)
+{
+	struct nvme_queue *nvmeq = data;
+	void *ctx;
+	nvme_completion_fn fn;
+	struct nvme_cmd_info *cmd;
+	struct nvme_completion cqe;
+
+	if (!blk_mq_request_started(req))
+		return;
+
+	cmd = blk_mq_rq_to_pdu(req);
+
+	if (cmd->ctx == CMD_CTX_CANCELLED)
+		return;
+
+	if (blk_queue_dying(req->q))
+		cqe.status = cpu_to_le16((NVME_SC_ABORT_REQ |
NVME_SC_DNR) << 1);
+	else
+		cqe.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1);
+
+
+	dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d QID %d\n",
+						req->tag, nvmeq->qid);
+	ctx = cancel_cmd_info(cmd, &fn);
+	fn(nvmeq, ctx, &cqe);
+}
+
+static enum blk_eh_timer_return nvme_timeout(struct request *req, bool
reserved)
+{
+	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = cmd->nvmeq;
+
+	dev_warn(nvmeq->q_dmadev, "Timeout I/O %d QID %d\n", req->tag,
+							nvmeq->qid);
+	spin_lock_irq(&nvmeq->q_lock);
+	nvme_abort_req(req);
+	spin_unlock_irq(&nvmeq->q_lock);
+
+	/*
+	 * The aborted req will be completed on receiving the abort
req.
+	 * We enable the timer again. If hit twice, it'll cause a
device reset,
+	 * as the device then is in a faulty state.
+	 */
+	return BLK_EH_RESET_TIMER;
+}
+
+static void nvme_free_queue(struct nvme_queue *nvmeq)
+{
+	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
+				(void *)nvmeq->cqes, nvmeq
->cq_dma_addr);
+	if (nvmeq->sq_cmds)
+		dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq
->q_depth),
+					nvmeq->sq_cmds, nvmeq
->sq_dma_addr);
+	kfree(nvmeq);
+}
+
+static void nvme_free_queues(struct nvme_dev *dev, int lowest)
+{
+	int i;
+
+	for (i = dev->queue_count - 1; i >= lowest; i--) {
+		struct nvme_queue *nvmeq = dev->queues[i];
+		dev->queue_count--;
+		dev->queues[i] = NULL;
+		nvme_free_queue(nvmeq);
+	}
+}
+
+/**
+ * nvme_suspend_queue - put queue into suspended state
+ * @nvmeq - queue to suspend
+ */
+static int nvme_suspend_queue(struct nvme_queue *nvmeq)
+{
+	int vector;
+
+	spin_lock_irq(&nvmeq->q_lock);
+	if (nvmeq->cq_vector == -1) {
+		spin_unlock_irq(&nvmeq->q_lock);
+		return 1;
+	}
+	vector = nvmeq->dev->entry[nvmeq->cq_vector].vector;
+	nvmeq->dev->online_queues--;
+	nvmeq->cq_vector = -1;
+	spin_unlock_irq(&nvmeq->q_lock);
+
+	if (!nvmeq->qid && nvmeq->dev->admin_q)
+		blk_mq_freeze_queue_start(nvmeq->dev->admin_q);
+
+	irq_set_affinity_hint(vector, NULL);
+	free_irq(vector, nvmeq);
+
+	return 0;
+}
+
+static void nvme_clear_queue(struct nvme_queue *nvmeq)
+{
+	spin_lock_irq(&nvmeq->q_lock);
+	if (nvmeq->tags && *nvmeq->tags)
+		blk_mq_all_tag_busy_iter(*nvmeq->tags,
nvme_cancel_queue_ios, nvmeq);
+	spin_unlock_irq(&nvmeq->q_lock);
+}
+
+static void nvme_disable_queue(struct nvme_dev *dev, int qid)
+{
+	struct nvme_queue *nvmeq = dev->queues[qid];
+
+	if (!nvmeq)
+		return;
+	if (nvme_suspend_queue(nvmeq))
+		return;
+
+	/* Don't tell the adapter to delete the admin queue.
+	 * Don't tell a removed adapter to delete IO queues. */
+	if (qid && readl(&dev->bar->csts) != -1) {
+		adapter_delete_sq(dev, qid);
+		adapter_delete_cq(dev, qid);
+	}
+
+	spin_lock_irq(&nvmeq->q_lock);
+	nvme_process_cq(nvmeq);
+	spin_unlock_irq(&nvmeq->q_lock);
+}
+
+static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
+				int entry_size)
+{
+	int q_depth = dev->q_depth;
+	unsigned q_size_aligned = roundup(q_depth * entry_size, dev
->page_size);
+
+	if (q_size_aligned * nr_io_queues > dev->cmb_size) {
+		u64 mem_per_q = div_u64(dev->cmb_size, nr_io_queues);
+		mem_per_q = round_down(mem_per_q, dev->page_size);
+		q_depth = div_u64(mem_per_q, entry_size);
+
+		/*
+		 * Ensure the reduced q_depth is above some threshold
where it
+		 * would be better to map queues in system memory with
the
+		 * original depth
+		 */
+		if (q_depth < 64)
+			return -ENOMEM;
+	}
+
+	return q_depth;
+}
+
+static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue
*nvmeq,
+				int qid, int depth)
+{
+	if (qid && dev->cmb && use_cmb_sqes && NVME_CMB_SQS(dev
->cmbsz)) {
+		unsigned offset = (qid - 1) *
+					roundup(SQ_SIZE(depth), dev
->page_size);
+		nvmeq->sq_dma_addr = dev->cmb_dma_addr + offset;
+		nvmeq->sq_cmds_io = dev->cmb + offset;
+	} else {
+		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev,
SQ_SIZE(depth),
+					&nvmeq->sq_dma_addr,
GFP_KERNEL);
+		if (!nvmeq->sq_cmds)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int
qid,
+							int depth)
+{
+	struct nvme_queue *nvmeq = kzalloc(sizeof(*nvmeq),
GFP_KERNEL);
+	if (!nvmeq)
+		return NULL;
+
+	nvmeq->cqes = dma_zalloc_coherent(dev->dev, CQ_SIZE(depth),
+					  &nvmeq->cq_dma_addr,
GFP_KERNEL);
+	if (!nvmeq->cqes)
+		goto free_nvmeq;
+
+	if (nvme_alloc_sq_cmds(dev, nvmeq, qid, depth))
+		goto free_cqdma;
+
+	nvmeq->q_dmadev = dev->dev;
+	nvmeq->dev = dev;
+	snprintf(nvmeq->irqname, sizeof(nvmeq->irqname), "nvme%dq%d",
+			dev->instance, qid);
+	spin_lock_init(&nvmeq->q_lock);
+	nvmeq->cq_head = 0;
+	nvmeq->cq_phase = 1;
+	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
+	nvmeq->q_depth = depth;
+	nvmeq->qid = qid;
+	nvmeq->cq_vector = -1;
+	dev->queues[qid] = nvmeq;
+
+	/* make sure queue descriptor is set before queue count, for
kthread */
+	mb();
+	dev->queue_count++;
+
+	return nvmeq;
+
+ free_cqdma:
+	dma_free_coherent(dev->dev, CQ_SIZE(depth), (void *)nvmeq
->cqes,
+							nvmeq
->cq_dma_addr);
+ free_nvmeq:
+	kfree(nvmeq);
+	return NULL;
+}
+
+static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue
*nvmeq,
+							const char
*name)
+{
+	if (use_threaded_interrupts)
+		return request_threaded_irq(dev->entry[nvmeq
->cq_vector].vector,
+					nvme_irq_check, nvme_irq,
IRQF_SHARED,
+					name, nvmeq);
+	return request_irq(dev->entry[nvmeq->cq_vector].vector,
nvme_irq,
+				IRQF_SHARED, name, nvmeq);
+}
+
+static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
+{
+	struct nvme_dev *dev = nvmeq->dev;
+
+	spin_lock_irq(&nvmeq->q_lock);
+	nvmeq->sq_tail = 0;
+	nvmeq->cq_head = 0;
+	nvmeq->cq_phase = 1;
+	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
+	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
+	dev->online_queues++;
+	spin_unlock_irq(&nvmeq->q_lock);
+}
+
+static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
+{
+	struct nvme_dev *dev = nvmeq->dev;
+	int result;
+
+	nvmeq->cq_vector = qid - 1;
+	result = adapter_alloc_cq(dev, qid, nvmeq);
+	if (result < 0)
+		return result;
+
+	result = adapter_alloc_sq(dev, qid, nvmeq);
+	if (result < 0)
+		goto release_cq;
+
+	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
+	if (result < 0)
+		goto release_sq;
+
+	nvme_init_queue(nvmeq, qid);
+	return result;
+
+ release_sq:
+	adapter_delete_sq(dev, qid);
+ release_cq:
+	adapter_delete_cq(dev, qid);
+	return result;
+}
+
+static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool
enabled)
+{
+	unsigned long timeout;
+	u32 bit = enabled ? NVME_CSTS_RDY : 0;
+
+	timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
+
+	while ((readl(&dev->bar->csts) & NVME_CSTS_RDY) != bit) {
+		msleep(100);
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		if (time_after(jiffies, timeout)) {
+			dev_err(dev->dev,
+				"Device not ready; aborting %s\n",
enabled ?
+						"initialisation" :
"reset");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * If the device has been passed off to us in an enabled state, just
clear
+ * the enabled bit.  The spec says we should set the 'shutdown
notification
+ * bits', but doing so may cause the device to complete commands to
the
+ * admin queue ... and we don't know what memory that might be
pointing at!
+ */
+static int nvme_disable_ctrl(struct nvme_dev *dev, u64 cap)
+{
+	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
+	dev->ctrl_config &= ~NVME_CC_ENABLE;
+	writel(dev->ctrl_config, &dev->bar->cc);
+
+	return nvme_wait_ready(dev, cap, false);
+}
+
+static int nvme_enable_ctrl(struct nvme_dev *dev, u64 cap)
+{
+	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
+	dev->ctrl_config |= NVME_CC_ENABLE;
+	writel(dev->ctrl_config, &dev->bar->cc);
+
+	return nvme_wait_ready(dev, cap, true);
+}
+
+static int nvme_shutdown_ctrl(struct nvme_dev *dev)
+{
+	unsigned long timeout;
+
+	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
+	dev->ctrl_config |= NVME_CC_SHN_NORMAL;
+
+	writel(dev->ctrl_config, &dev->bar->cc);
+
+	timeout = SHUTDOWN_TIMEOUT + jiffies;
+	while ((readl(&dev->bar->csts) & NVME_CSTS_SHST_MASK) !=
+							NVME_CSTS_SHST
_CMPLT) {
+		msleep(100);
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		if (time_after(jiffies, timeout)) {
+			dev_err(dev->dev,
+				"Device shutdown incomplete; abort
shutdown\n");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+static struct blk_mq_ops nvme_mq_admin_ops = {
+	.queue_rq	= nvme_queue_rq,
+	.map_queue	= blk_mq_map_queue,
+	.init_hctx	= nvme_admin_init_hctx,
+	.exit_hctx      = nvme_admin_exit_hctx,
+	.init_request	= nvme_admin_init_request,
+	.timeout	= nvme_timeout,
+};
+
+static struct blk_mq_ops nvme_mq_ops = {
+	.queue_rq	= nvme_queue_rq,
+	.map_queue	= blk_mq_map_queue,
+	.init_hctx	= nvme_init_hctx,
+	.init_request	= nvme_init_request,
+	.timeout	= nvme_timeout,
+};
+
+static void nvme_dev_remove_admin(struct nvme_dev *dev)
+{
+	if (dev->admin_q && !blk_queue_dying(dev->admin_q)) {
+		blk_cleanup_queue(dev->admin_q);
+		blk_mq_free_tag_set(&dev->admin_tagset);
+	}
+}
+
+static int nvme_alloc_admin_tags(struct nvme_dev *dev)
+{
+	if (!dev->admin_q) {
+		dev->admin_tagset.ops = &nvme_mq_admin_ops;
+		dev->admin_tagset.nr_hw_queues = 1;
+		dev->admin_tagset.queue_depth = NVME_AQ_DEPTH - 1;
+		dev->admin_tagset.reserved_tags = 1;
+		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
+		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
+		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
+		dev->admin_tagset.driver_data = dev;
+
+		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
+			return -ENOMEM;
+
+		dev->admin_q = blk_mq_init_queue(&dev->admin_tagset);
+		if (IS_ERR(dev->admin_q)) {
+			blk_mq_free_tag_set(&dev->admin_tagset);
+			return -ENOMEM;
+		}
+		if (!blk_get_queue(dev->admin_q)) {
+			nvme_dev_remove_admin(dev);
+			dev->admin_q = NULL;
+			return -ENODEV;
+		}
+	} else
+		blk_mq_unfreeze_queue(dev->admin_q);
+
+	return 0;
+}
+
+static int nvme_configure_admin_queue(struct nvme_dev *dev)
+{
+	int result;
+	u32 aqa;
+	u64 cap = readq(&dev->bar->cap);
+	struct nvme_queue *nvmeq;
+	unsigned page_shift = PAGE_SHIFT;
+	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
+	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
+
+	if (page_shift < dev_page_min) {
+		dev_err(dev->dev,
+				"Minimum device page size (%u) too
large for "
+				"host (%u)\n", 1 << dev_page_min,
+				1 << page_shift);
+		return -ENODEV;
+	}
+	if (page_shift > dev_page_max) {
+		dev_info(dev->dev,
+				"Device maximum page size (%u) smaller
than "
+				"host (%u); enabling work-around\n",
+				1 << dev_page_max, 1 << page_shift);
+		page_shift = dev_page_max;
+	}
+
+	dev->subsystem = readl(&dev->bar->vs) >= NVME_VS(1, 1) ?
+						NVME_CAP_NSSRC(cap) :
0;
+
+	if (dev->subsystem && (readl(&dev->bar->csts) &
NVME_CSTS_NSSRO))
+		writel(NVME_CSTS_NSSRO, &dev->bar->csts);
+
+	result = nvme_disable_ctrl(dev, cap);
+	if (result < 0)
+		return result;
+
+	nvmeq = dev->queues[0];
+	if (!nvmeq) {
+		nvmeq = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH);
+		if (!nvmeq)
+			return -ENOMEM;
+	}
+
+	aqa = nvmeq->q_depth - 1;
+	aqa |= aqa << 16;
+
+	dev->page_size = 1 << page_shift;
+
+	dev->ctrl_config = NVME_CC_CSS_NVM;
+	dev->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
+	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
+	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
+
+	writel(aqa, &dev->bar->aqa);
+	writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
+	writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
+
+	result = nvme_enable_ctrl(dev, cap);
+	if (result)
+		goto free_nvmeq;
+
+	nvmeq->cq_vector = 0;
+	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
+	if (result) {
+		nvmeq->cq_vector = -1;
+		goto free_nvmeq;
+	}
+
+	return result;
+
+ free_nvmeq:
+	nvme_free_queues(dev, 0);
+	return result;
+}
+
+static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io
__user *uio)
+{
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_user_io io;
+	struct nvme_command c;
+	unsigned length, meta_len;
+	int status, write;
+	dma_addr_t meta_dma = 0;
+	void *meta = NULL;
+	void __user *metadata;
+
+	if (copy_from_user(&io, uio, sizeof(io)))
+		return -EFAULT;
+
+	switch (io.opcode) {
+	case nvme_cmd_write:
+	case nvme_cmd_read:
+	case nvme_cmd_compare:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	length = (io.nblocks + 1) << ns->lba_shift;
+	meta_len = (io.nblocks + 1) * ns->ms;
+	metadata = (void __user *)(unsigned long)io.metadata;
+	write = io.opcode & 1;
+
+	if (ns->ext) {
+		length += meta_len;
+		meta_len = 0;
+	}
+	if (meta_len) {
+		if (((io.metadata & 3) || !io.metadata) && !ns->ext)
+			return -EINVAL;
+
+		meta = dma_alloc_coherent(dev->dev, meta_len,
+						&meta_dma,
GFP_KERNEL);
+
+		if (!meta) {
+			status = -ENOMEM;
+			goto unmap;
+		}
+		if (write) {
+			if (copy_from_user(meta, metadata, meta_len))
{
+				status = -EFAULT;
+				goto unmap;
+			}
+		}
+	}
+
+	memset(&c, 0, sizeof(c));
+	c.rw.opcode = io.opcode;
+	c.rw.flags = io.flags;
+	c.rw.nsid = cpu_to_le32(ns->ns_id);
+	c.rw.slba = cpu_to_le64(io.slba);
+	c.rw.length = cpu_to_le16(io.nblocks);
+	c.rw.control = cpu_to_le16(io.control);
+	c.rw.dsmgmt = cpu_to_le32(io.dsmgmt);
+	c.rw.reftag = cpu_to_le32(io.reftag);
+	c.rw.apptag = cpu_to_le16(io.apptag);
+	c.rw.appmask = cpu_to_le16(io.appmask);
+	c.rw.metadata = cpu_to_le64(meta_dma);
+
+	status = __nvme_submit_sync_cmd(ns->queue, &c, NULL,
+			(void __user *)io.addr, length, NULL, 0);
+ unmap:
+	if (meta) {
+		if (status == NVME_SC_SUCCESS && !write) {
+			if (copy_to_user(metadata, meta, meta_len))
+				status = -EFAULT;
+		}
+		dma_free_coherent(dev->dev, meta_len, meta, meta_dma);
+	}
+	return status;
+}
+
+static int nvme_user_cmd(struct nvme_dev *dev, struct nvme_ns *ns,
+			struct nvme_passthru_cmd __user *ucmd)
+{
+	struct nvme_passthru_cmd cmd;
+	struct nvme_command c;
+	unsigned timeout = 0;
+	int status;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
+		return -EFAULT;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = cmd.opcode;
+	c.common.flags = cmd.flags;
+	c.common.nsid = cpu_to_le32(cmd.nsid);
+	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
+	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
+	c.common.cdw10[0] = cpu_to_le32(cmd.cdw10);
+	c.common.cdw10[1] = cpu_to_le32(cmd.cdw11);
+	c.common.cdw10[2] = cpu_to_le32(cmd.cdw12);
+	c.common.cdw10[3] = cpu_to_le32(cmd.cdw13);
+	c.common.cdw10[4] = cpu_to_le32(cmd.cdw14);
+	c.common.cdw10[5] = cpu_to_le32(cmd.cdw15);
+
+	if (cmd.timeout_ms)
+		timeout = msecs_to_jiffies(cmd.timeout_ms);
+
+	status = __nvme_submit_sync_cmd(ns ? ns->queue : dev->admin_q,
&c,
+			NULL, (void __user *)cmd.addr, cmd.data_len,
+			&cmd.result, timeout);
+	if (status >= 0) {
+		if (put_user(cmd.result, &ucmd->result))
+			return -EFAULT;
+	}
+
+	return status;
+}
+
+static int nvme_subsys_reset(struct nvme_dev *dev)
+{
+	if (!dev->subsystem)
+		return -ENOTTY;
+
+	writel(0x4E564D65, &dev->bar->nssr); /* "NVMe" */
+	return 0;
+}
+
+static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
unsigned int cmd,
+							unsigned long
arg)
+{
+	struct nvme_ns *ns = bdev->bd_disk->private_data;
+
+	switch (cmd) {
+	case NVME_IOCTL_ID:
+		force_successful_syscall_return();
+		return ns->ns_id;
+	case NVME_IOCTL_ADMIN_CMD:
+		return nvme_user_cmd(ns->dev, NULL, (void __user
*)arg);
+	case NVME_IOCTL_IO_CMD:
+		return nvme_user_cmd(ns->dev, ns, (void __user *)arg);
+	case NVME_IOCTL_SUBMIT_IO:
+		return nvme_submit_io(ns, (void __user *)arg);
+	case SG_GET_VERSION_NUM:
+		return nvme_sg_get_version_num((void __user *)arg);
+	case SG_IO:
+		return nvme_sg_io(ns, (void __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
+					unsigned int cmd, unsigned
long arg)
+{
+	switch (cmd) {
+	case SG_IO:
+		return -ENOIOCTLCMD;
+	}
+	return nvme_ioctl(bdev, mode, cmd, arg);
+}
+#else
+#define nvme_compat_ioctl	NULL
+#endif
+
+static int nvme_open(struct block_device *bdev, fmode_t mode)
+{
+	int ret = 0;
+	struct nvme_ns *ns;
+
+	spin_lock(&dev_list_lock);
+	ns = bdev->bd_disk->private_data;
+	if (!ns)
+		ret = -ENXIO;
+	else if (!kref_get_unless_zero(&ns->dev->kref))
+		ret = -ENXIO;
+	spin_unlock(&dev_list_lock);
+
+	return ret;
+}
+
+static void nvme_free_dev(struct kref *kref);
+
+static void nvme_release(struct gendisk *disk, fmode_t mode)
+{
+	struct nvme_ns *ns = disk->private_data;
+	struct nvme_dev *dev = ns->dev;
+
+	kref_put(&dev->kref, nvme_free_dev);
+}
+
+static int nvme_getgeo(struct block_device *bd, struct hd_geometry
*geo)
+{
+	/* some standard values */
+	geo->heads = 1 << 6;
+	geo->sectors = 1 << 5;
+	geo->cylinders = get_capacity(bd->bd_disk) >> 11;
+	return 0;
+}
+
+static void nvme_config_discard(struct nvme_ns *ns)
+{
+	u32 logical_block_size = queue_logical_block_size(ns->queue);
+	ns->queue->limits.discard_zeroes_data = 0;
+	ns->queue->limits.discard_alignment = logical_block_size;
+	ns->queue->limits.discard_granularity = logical_block_size;
+	blk_queue_max_discard_sectors(ns->queue, 0xffffffff);
+	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
+}
+
+static int nvme_revalidate_disk(struct gendisk *disk)
+{
+	struct nvme_ns *ns = disk->private_data;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_id_ns *id;
+	u8 lbaf, pi_type;
+	u16 old_ms;
+	unsigned short bs;
+
+	if (nvme_identify_ns(dev, ns->ns_id, &id)) {
+		dev_warn(dev->dev, "%s: Identify failure nvme%dn%d\n",
__func__,
+						dev->instance, ns
->ns_id);
+		return -ENODEV;
+	}
+	if (id->ncap == 0) {
+		kfree(id);
+		return -ENODEV;
+	}
+
+	old_ms = ns->ms;
+	lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
+	ns->lba_shift = id->lbaf[lbaf].ds;
+	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
+	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
+
+	/*
+	 * If identify namespace failed, use default 512 byte block
size so
+	 * block layer can use before failing read/write for 0
capacity.
+	 */
+	if (ns->lba_shift == 0)
+		ns->lba_shift = 9;
+	bs = 1 << ns->lba_shift;
+
+	/* XXX: PI implementation requires metadata equal t10 pi tuple
size */
+	pi_type = ns->ms == sizeof(struct t10_pi_tuple) ?
+					id->dps & NVME_NS_DPS_PI_MASK
: 0;
+
+	if (blk_get_integrity(disk) && (ns->pi_type != pi_type ||
+				ns->ms != old_ms ||
+				bs != queue_logical_block_size(disk
->queue) ||
+				(ns->ms && ns->ext)))
+		blk_integrity_unregister(disk);
+
+	ns->pi_type = pi_type;
+	blk_queue_logical_block_size(ns->queue, bs);
+
+	if (ns->ms && !blk_get_integrity(disk) && (disk->flags &
GENHD_FL_UP) &&
+								!ns
->ext)
+		nvme_init_integrity(ns);
+
+	if (ns->ms && !(ns->ms == 8 && ns->pi_type) &&
!blk_get_integrity(disk))
+		set_capacity(disk, 0);
+	else
+		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns
->lba_shift - 9));
+
+	if (dev->oncs & NVME_CTRL_ONCS_DSM)
+		nvme_config_discard(ns);
+
+	kfree(id);
+	return 0;
+}
+
+static const struct block_device_operations nvme_fops = {
+	.owner		= THIS_MODULE,
+	.ioctl		= nvme_ioctl,
+	.compat_ioctl	= nvme_compat_ioctl,
+	.open		= nvme_open,
+	.release	= nvme_release,
+	.getgeo		= nvme_getgeo,
+	.revalidate_disk= nvme_revalidate_disk,
+};
+
+static int nvme_kthread(void *data)
+{
+	struct nvme_dev *dev, *next;
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		spin_lock(&dev_list_lock);
+		list_for_each_entry_safe(dev, next, &dev_list, node) {
+			int i;
+			u32 csts = readl(&dev->bar->csts);
+
+			if ((dev->subsystem && (csts &
NVME_CSTS_NSSRO)) ||
+							csts &
NVME_CSTS_CFS) {
+				if (work_busy(&dev->reset_work))
+					continue;
+				list_del_init(&dev->node);
+				dev_warn(dev->dev,
+					"Failed status: %x, reset
controller\n",
+					readl(&dev->bar->csts));
+				dev->reset_workfn =
nvme_reset_failed_dev;
+				queue_work(nvme_workq, &dev
->reset_work);
+				continue;
+			}
+			for (i = 0; i < dev->queue_count; i++) {
+				struct nvme_queue *nvmeq = dev
->queues[i];
+				if (!nvmeq)
+					continue;
+				spin_lock_irq(&nvmeq->q_lock);
+				nvme_process_cq(nvmeq);
+
+				while ((i == 0) && (dev->event_limit >
0)) {
+					if
(nvme_submit_async_admin_req(dev))
+						break;
+					dev->event_limit--;
+				}
+				spin_unlock_irq(&nvmeq->q_lock);
+			}
+		}
+		spin_unlock(&dev_list_lock);
+		schedule_timeout(round_jiffies_relative(HZ));
+	}
+	return 0;
+}
+
+static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
+{
+	struct nvme_ns *ns;
+	struct gendisk *disk;
+	int node = dev_to_node(dev->dev);
+
+	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
+	if (!ns)
+		return;
+
+	ns->queue = blk_mq_init_queue(&dev->tagset);
+	if (IS_ERR(ns->queue))
+		goto out_free_ns;
+	queue_flag_set_unlocked(QUEUE_FLAG_NOMERGES, ns->queue);
+	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
+	ns->dev = dev;
+	ns->queue->queuedata = ns;
+
+	disk = alloc_disk_node(0, node);
+	if (!disk)
+		goto out_free_queue;
+
+	ns->ns_id = nsid;
+	ns->disk = disk;
+	ns->lba_shift = 9; /* set to a default value for 512 until
disk is validated */
+	list_add_tail(&ns->list, &dev->namespaces);
+
+	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
+	if (dev->max_hw_sectors) {
+		blk_queue_max_hw_sectors(ns->queue, dev
->max_hw_sectors);
+		blk_queue_max_segments(ns->queue,
+			((dev->max_hw_sectors << 9) / dev->page_size)
+ 1);
+	}
+	if (dev->stripe_size)
+		blk_queue_chunk_sectors(ns->queue, dev->stripe_size >>
9);
+	if (dev->vwc & NVME_CTRL_VWC_PRESENT)
+		blk_queue_flush(ns->queue, REQ_FLUSH | REQ_FUA);
+	blk_queue_virt_boundary(ns->queue, dev->page_size - 1);
+
+	disk->major = nvme_major;
+	disk->first_minor = 0;
+	disk->fops = &nvme_fops;
+	disk->private_data = ns;
+	disk->queue = ns->queue;
+	disk->driverfs_dev = dev->device;
+	disk->flags = GENHD_FL_EXT_DEVT;
+	sprintf(disk->disk_name, "nvme%dn%d", dev->instance, nsid);
+
+	/*
+	 * Initialize capacity to 0 until we establish the namespace
format and
+	 * setup integrity extentions if necessary. The
revalidate_disk after
+	 * add_disk allows the driver to register with integrity if
the format
+	 * requires it.
+	 */
+	set_capacity(disk, 0);
+	if (nvme_revalidate_disk(ns->disk))
+		goto out_free_disk;
+
+	add_disk(ns->disk);
+	if (ns->ms) {
+		struct block_device *bd = bdget_disk(ns->disk, 0);
+		if (!bd)
+			return;
+		if (blkdev_get(bd, FMODE_READ, NULL)) {
+			bdput(bd);
+			return;
+		}
+		blkdev_reread_part(bd);
+		blkdev_put(bd, FMODE_READ);
+	}
+	return;
+ out_free_disk:
+	kfree(disk);
+	list_del(&ns->list);
+ out_free_queue:
+	blk_cleanup_queue(ns->queue);
+ out_free_ns:
+	kfree(ns);
+}
+
+static void nvme_create_io_queues(struct nvme_dev *dev)
+{
+	unsigned i;
+
+	for (i = dev->queue_count; i <= dev->max_qid; i++)
+		if (!nvme_alloc_queue(dev, i, dev->q_depth))
+			break;
+
+	for (i = dev->online_queues; i <= dev->queue_count - 1; i++)
+		if (nvme_create_queue(dev->queues[i], i))
+			break;
+}
+
+static int set_queue_count(struct nvme_dev *dev, int count)
+{
+	int status;
+	u32 result;
+	u32 q_count = (count - 1) | ((count - 1) << 16);
+
+	status = nvme_set_features(dev, NVME_FEAT_NUM_QUEUES, q_count,
0,
+								&resul
t);
+	if (status < 0)
+		return status;
+	if (status > 0) {
+		dev_err(dev->dev, "Could not set queue count (%d)\n",
status);
+		return 0;
+	}
+	return min(result & 0xffff, result >> 16) + 1;
+}
+
+static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
+{
+	u64 szu, size, offset;
+	u32 cmbloc;
+	resource_size_t bar_size;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	void __iomem *cmb;
+	dma_addr_t dma_addr;
+
+	if (!use_cmb_sqes)
+		return NULL;
+
+	dev->cmbsz = readl(&dev->bar->cmbsz);
+	if (!(NVME_CMB_SZ(dev->cmbsz)))
+		return NULL;
+
+	cmbloc = readl(&dev->bar->cmbloc);
+
+	szu = (u64)1 << (12 + 4 * NVME_CMB_SZU(dev->cmbsz));
+	size = szu * NVME_CMB_SZ(dev->cmbsz);
+	offset = szu * NVME_CMB_OFST(cmbloc);
+	bar_size = pci_resource_len(pdev, NVME_CMB_BIR(cmbloc));
+
+	if (offset > bar_size)
+		return NULL;
+
+	/*
+	 * Controllers may support a CMB size larger than their BAR,
+	 * for example, due to being behind a bridge. Reduce the CMB
to
+	 * the reported size of the BAR
+	 */
+	if (size > bar_size - offset)
+		size = bar_size - offset;
+
+	dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(cmbloc)) +
offset;
+	cmb = ioremap_wc(dma_addr, size);
+	if (!cmb)
+		return NULL;
+
+	dev->cmb_dma_addr = dma_addr;
+	dev->cmb_size = size;
+	return cmb;
+}
+
+static inline void nvme_release_cmb(struct nvme_dev *dev)
+{
+	if (dev->cmb) {
+		iounmap(dev->cmb);
+		dev->cmb = NULL;
+	}
+}
+
+static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
+{
+	return 4096 + ((nr_io_queues + 1) * 8 * dev->db_stride);
+}
+
+static int nvme_setup_io_queues(struct nvme_dev *dev)
+{
+	struct nvme_queue *adminq = dev->queues[0];
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	int result, i, vecs, nr_io_queues, size;
+
+	nr_io_queues = num_possible_cpus();
+	result = set_queue_count(dev, nr_io_queues);
+	if (result <= 0)
+		return result;
+	if (result < nr_io_queues)
+		nr_io_queues = result;
+
+	if (dev->cmb && NVME_CMB_SQS(dev->cmbsz)) {
+		result = nvme_cmb_qdepth(dev, nr_io_queues,
+				sizeof(struct nvme_command));
+		if (result > 0)
+			dev->q_depth = result;
+		else
+			nvme_release_cmb(dev);
+	}
+
+	size = db_bar_size(dev, nr_io_queues);
+	if (size > 8192) {
+		iounmap(dev->bar);
+		do {
+			dev->bar = ioremap(pci_resource_start(pdev,
0), size);
+			if (dev->bar)
+				break;
+			if (!--nr_io_queues)
+				return -ENOMEM;
+			size = db_bar_size(dev, nr_io_queues);
+		} while (1);
+		dev->dbs = ((void __iomem *)dev->bar) + 4096;
+		adminq->q_db = dev->dbs;
+	}
+
+	/* Deregister the admin queue's interrupt */
+	free_irq(dev->entry[0].vector, adminq);
+
+	/*
+	 * If we enable msix early due to not intx, disable it again
before
+	 * setting up the full range we need.
+	 */
+	if (!pdev->irq)
+		pci_disable_msix(pdev);
+
+	for (i = 0; i < nr_io_queues; i++)
+		dev->entry[i].entry = i;
+	vecs = pci_enable_msix_range(pdev, dev->entry, 1,
nr_io_queues);
+	if (vecs < 0) {
+		vecs = pci_enable_msi_range(pdev, 1, min(nr_io_queues,
32));
+		if (vecs < 0) {
+			vecs = 1;
+		} else {
+			for (i = 0; i < vecs; i++)
+				dev->entry[i].vector = i + pdev->irq;
+		}
+	}
+
+	/*
+	 * Should investigate if there's a performance win from
allocating
+	 * more queues than interrupt vectors; it might allow the
submission
+	 * path to scale better, even if the receive path is limited
by the
+	 * number of interrupts.
+	 */
+	nr_io_queues = vecs;
+	dev->max_qid = nr_io_queues;
+
+	result = queue_request_irq(dev, adminq, adminq->irqname);
+	if (result) {
+		adminq->cq_vector = -1;
+		goto free_queues;
+	}
+
+	/* Free previously allocated queues that are no longer usable
*/
+	nvme_free_queues(dev, nr_io_queues + 1);
+	nvme_create_io_queues(dev);
+
+	return 0;
+
+ free_queues:
+	nvme_free_queues(dev, 1);
+	return result;
+}
+
+static void nvme_free_namespace(struct nvme_ns *ns)
+{
+	list_del(&ns->list);
+
+	spin_lock(&dev_list_lock);
+	ns->disk->private_data = NULL;
+	spin_unlock(&dev_list_lock);
+
+	put_disk(ns->disk);
+	kfree(ns);
+}
+
+static int ns_cmp(void *priv, struct list_head *a, struct list_head
*b)
+{
+	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
+	struct nvme_ns *nsb = container_of(b, struct nvme_ns, list);
+
+	return nsa->ns_id - nsb->ns_id;
+}
+
+static struct nvme_ns *nvme_find_ns(struct nvme_dev *dev, unsigned
nsid)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &dev->namespaces, list) {
+		if (ns->ns_id == nsid)
+			return ns;
+		if (ns->ns_id > nsid)
+			break;
+	}
+	return NULL;
+}
+
+static inline bool nvme_io_incapable(struct nvme_dev *dev)
+{
+	return (!dev->bar || readl(&dev->bar->csts) & NVME_CSTS_CFS ||
+							dev
->online_queues < 2);
+}
+
+static void nvme_ns_remove(struct nvme_ns *ns)
+{
+	bool kill = nvme_io_incapable(ns->dev) && !blk_queue_dying(ns
->queue);
+
+	if (kill)
+		blk_set_queue_dying(ns->queue);
+	if (ns->disk->flags & GENHD_FL_UP) {
+		if (blk_get_integrity(ns->disk))
+			blk_integrity_unregister(ns->disk);
+		del_gendisk(ns->disk);
+	}
+	if (kill || !blk_queue_dying(ns->queue)) {
+		blk_mq_abort_requeue_list(ns->queue);
+		blk_cleanup_queue(ns->queue);
+        }
+}
+
+static void nvme_scan_namespaces(struct nvme_dev *dev, unsigned nn)
+{
+	struct nvme_ns *ns, *next;
+	unsigned i;
+
+	for (i = 1; i <= nn; i++) {
+		ns = nvme_find_ns(dev, i);
+		if (ns) {
+			if (revalidate_disk(ns->disk)) {
+				nvme_ns_remove(ns);
+				nvme_free_namespace(ns);
+			}
+		} else
+			nvme_alloc_ns(dev, i);
+	}
+	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
+		if (ns->ns_id > nn) {
+			nvme_ns_remove(ns);
+			nvme_free_namespace(ns);
+		}
+	}
+	list_sort(NULL, &dev->namespaces, ns_cmp);
+}
+
+static void nvme_dev_scan(struct work_struct *work)
+{
+	struct nvme_dev *dev = container_of(work, struct nvme_dev,
scan_work);
+	struct nvme_id_ctrl *ctrl;
+
+	if (!dev->tagset.tags)
+		return;
+	if (nvme_identify_ctrl(dev, &ctrl))
+		return;
+	nvme_scan_namespaces(dev, le32_to_cpup(&ctrl->nn));
+	kfree(ctrl);
+}
+
+/*
+ * Return: error value if an error occurred setting up the queues or
calling
+ * Identify Device.  0 if these succeeded, even if adding some of the
+ * namespaces failed.  At the moment, these failures are silent.  TBD
which
+ * failures should be reported.
+ */
+static int nvme_dev_add(struct nvme_dev *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	int res;
+	struct nvme_id_ctrl *ctrl;
+	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
+
+	res = nvme_identify_ctrl(dev, &ctrl);
+	if (res) {
+		dev_err(dev->dev, "Identify Controller failed (%d)\n",
res);
+		return -EIO;
+	}
+
+	dev->oncs = le16_to_cpup(&ctrl->oncs);
+	dev->abort_limit = ctrl->acl + 1;
+	dev->vwc = ctrl->vwc;
+	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
+	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
+	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
+	if (ctrl->mdts)
+		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
+	if ((pdev->vendor == PCI_VENDOR_ID_INTEL) &&
+			(pdev->device == 0x0953) && ctrl->vs[3]) {
+		unsigned int max_hw_sectors;
+
+		dev->stripe_size = 1 << (ctrl->vs[3] + shift);
+		max_hw_sectors = dev->stripe_size >> (shift - 9);
+		if (dev->max_hw_sectors) {
+			dev->max_hw_sectors = min(max_hw_sectors,
+							dev
->max_hw_sectors);
+		} else
+			dev->max_hw_sectors = max_hw_sectors;
+	}
+	kfree(ctrl);
+
+	if (!dev->tagset.tags) {
+		dev->tagset.ops = &nvme_mq_ops;
+		dev->tagset.nr_hw_queues = dev->online_queues - 1;
+		dev->tagset.timeout = NVME_IO_TIMEOUT;
+		dev->tagset.numa_node = dev_to_node(dev->dev);
+		dev->tagset.queue_depth =
+				min_t(int, dev->q_depth,
BLK_MQ_MAX_DEPTH) - 1;
+		dev->tagset.cmd_size = nvme_cmd_size(dev);
+		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
+		dev->tagset.driver_data = dev;
+
+		if (blk_mq_alloc_tag_set(&dev->tagset))
+			return 0;
+	}
+	schedule_work(&dev->scan_work);
+	return 0;
+}
+
+static int nvme_dev_map(struct nvme_dev *dev)
+{
+	u64 cap;
+	int bars, result = -ENOMEM;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	if (pci_enable_device_mem(pdev))
+		return result;
+
+	dev->entry[0].vector = pdev->irq;
+	pci_set_master(pdev);
+	bars = pci_select_bars(pdev, IORESOURCE_MEM);
+	if (!bars)
+		goto disable_pci;
+
+	if (pci_request_selected_regions(pdev, bars, "nvme"))
+		goto disable_pci;
+
+	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
+	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32)))
+		goto disable;
+
+	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
+	if (!dev->bar)
+		goto disable;
+
+	if (readl(&dev->bar->csts) == -1) {
+		result = -ENODEV;
+		goto unmap;
+	}
+
+	/*
+	 * Some devices don't advertse INTx interrupts, pre-enable a
single
+	 * MSIX vec for setup. We'll adjust this later.
+	 */
+	if (!pdev->irq) {
+		result = pci_enable_msix(pdev, dev->entry, 1);
+		if (result < 0)
+			goto unmap;
+	}
+
+	cap = readq(&dev->bar->cap);
+	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1,
NVME_Q_DEPTH);
+	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
+	dev->dbs = ((void __iomem *)dev->bar) + 4096;
+	if (readl(&dev->bar->vs) >= NVME_VS(1, 2))
+		dev->cmb = nvme_map_cmb(dev);
+
+	return 0;
+
+ unmap:
+	iounmap(dev->bar);
+	dev->bar = NULL;
+ disable:
+	pci_release_regions(pdev);
+ disable_pci:
+	pci_disable_device(pdev);
+	return result;
+}
+
+static void nvme_dev_unmap(struct nvme_dev *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	if (pdev->msi_enabled)
+		pci_disable_msi(pdev);
+	else if (pdev->msix_enabled)
+		pci_disable_msix(pdev);
+
+	if (dev->bar) {
+		iounmap(dev->bar);
+		dev->bar = NULL;
+		pci_release_regions(pdev);
+	}
+
+	if (pci_is_enabled(pdev))
+		pci_disable_device(pdev);
+}
+
+struct nvme_delq_ctx {
+	struct task_struct *waiter;
+	struct kthread_worker *worker;
+	atomic_t refcount;
+};
+
+static void nvme_wait_dq(struct nvme_delq_ctx *dq, struct nvme_dev
*dev)
+{
+	dq->waiter = current;
+	mb();
+
+	for (;;) {
+		set_current_state(TASK_KILLABLE);
+		if (!atomic_read(&dq->refcount))
+			break;
+		if (!schedule_timeout(ADMIN_TIMEOUT) ||
+					fatal_signal_pending(current))
{
+			/*
+			 * Disable the controller first since we can't
trust it
+			 * at this point, but leave the admin queue
enabled
+			 * until all queue deletion requests are
flushed.
+			 * FIXME: This may take a while if there are
more h/w
+			 * queues than admin tags.
+			 */
+			set_current_state(TASK_RUNNING);
+			nvme_disable_ctrl(dev, readq(&dev->bar->cap));
+			nvme_clear_queue(dev->queues[0]);
+			flush_kthread_worker(dq->worker);
+			nvme_disable_queue(dev, 0);
+			return;
+		}
+	}
+	set_current_state(TASK_RUNNING);
+}
+
+static void nvme_put_dq(struct nvme_delq_ctx *dq)
+{
+	atomic_dec(&dq->refcount);
+	if (dq->waiter)
+		wake_up_process(dq->waiter);
+}
+
+static struct nvme_delq_ctx *nvme_get_dq(struct nvme_delq_ctx *dq)
+{
+	atomic_inc(&dq->refcount);
+	return dq;
+}
+
+static void nvme_del_queue_end(struct nvme_queue *nvmeq)
+{
+	struct nvme_delq_ctx *dq = nvmeq->cmdinfo.ctx;
+	nvme_put_dq(dq);
+}
+
+static int adapter_async_del_queue(struct nvme_queue *nvmeq, u8
opcode,
+						kthread_work_func_t
fn)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	c.delete_queue.opcode = opcode;
+	c.delete_queue.qid = cpu_to_le16(nvmeq->qid);
+
+	init_kthread_work(&nvmeq->cmdinfo.work, fn);
+	return nvme_submit_admin_async_cmd(nvmeq->dev, &c, &nvmeq
->cmdinfo,
+								ADMIN_
TIMEOUT);
+}
+
+static void nvme_del_cq_work_handler(struct kthread_work *work)
+{
+	struct nvme_queue *nvmeq = container_of(work, struct
nvme_queue,
+							cmdinfo.work);
+	nvme_del_queue_end(nvmeq);
+}
+
+static int nvme_delete_cq(struct nvme_queue *nvmeq)
+{
+	return adapter_async_del_queue(nvmeq, nvme_admin_delete_cq,
+						nvme_del_cq_work_handl
er);
+}
+
+static void nvme_del_sq_work_handler(struct kthread_work *work)
+{
+	struct nvme_queue *nvmeq = container_of(work, struct
nvme_queue,
+							cmdinfo.work);
+	int status = nvmeq->cmdinfo.status;
+
+	if (!status)
+		status = nvme_delete_cq(nvmeq);
+	if (status)
+		nvme_del_queue_end(nvmeq);
+}
+
+static int nvme_delete_sq(struct nvme_queue *nvmeq)
+{
+	return adapter_async_del_queue(nvmeq, nvme_admin_delete_sq,
+						nvme_del_sq_work_handl
er);
+}
+
+static void nvme_del_queue_start(struct kthread_work *work)
+{
+	struct nvme_queue *nvmeq = container_of(work, struct
nvme_queue,
+							cmdinfo.work);
+	if (nvme_delete_sq(nvmeq))
+		nvme_del_queue_end(nvmeq);
+}
+
+static void nvme_disable_io_queues(struct nvme_dev *dev)
+{
+	int i;
+	DEFINE_KTHREAD_WORKER_ONSTACK(worker);
+	struct nvme_delq_ctx dq;
+	struct task_struct *kworker_task =
kthread_run(kthread_worker_fn,
+					&worker, "nvme%d", dev
->instance);
+
+	if (IS_ERR(kworker_task)) {
+		dev_err(dev->dev,
+			"Failed to create queue del task\n");
+		for (i = dev->queue_count - 1; i > 0; i--)
+			nvme_disable_queue(dev, i);
+		return;
+	}
+
+	dq.waiter = NULL;
+	atomic_set(&dq.refcount, 0);
+	dq.worker = &worker;
+	for (i = dev->queue_count - 1; i > 0; i--) {
+		struct nvme_queue *nvmeq = dev->queues[i];
+
+		if (nvme_suspend_queue(nvmeq))
+			continue;
+		nvmeq->cmdinfo.ctx = nvme_get_dq(&dq);
+		nvmeq->cmdinfo.worker = dq.worker;
+		init_kthread_work(&nvmeq->cmdinfo.work,
nvme_del_queue_start);
+		queue_kthread_work(dq.worker, &nvmeq->cmdinfo.work);
+	}
+	nvme_wait_dq(&dq, dev);
+	kthread_stop(kworker_task);
+}
+
+/*
+* Remove the node from the device list and check
+* for whether or not we need to stop the nvme_thread.
+*/
+static void nvme_dev_list_remove(struct nvme_dev *dev)
+{
+	struct task_struct *tmp = NULL;
+
+	spin_lock(&dev_list_lock);
+	list_del_init(&dev->node);
+	if (list_empty(&dev_list) && !IS_ERR_OR_NULL(nvme_thread)) {
+		tmp = nvme_thread;
+		nvme_thread = NULL;
+	}
+	spin_unlock(&dev_list_lock);
+
+	if (tmp)
+		kthread_stop(tmp);
+}
+
+static void nvme_freeze_queues(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &dev->namespaces, list) {
+		blk_mq_freeze_queue_start(ns->queue);
+
+		spin_lock_irq(ns->queue->queue_lock);
+		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
+		spin_unlock_irq(ns->queue->queue_lock);
+
+		blk_mq_cancel_requeue_work(ns->queue);
+		blk_mq_stop_hw_queues(ns->queue);
+	}
+}
+
+static void nvme_unfreeze_queues(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &dev->namespaces, list) {
+		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns
->queue);
+		blk_mq_unfreeze_queue(ns->queue);
+		blk_mq_start_stopped_hw_queues(ns->queue, true);
+		blk_mq_kick_requeue_list(ns->queue);
+	}
+}
+
+static void nvme_dev_shutdown(struct nvme_dev *dev)
+{
+	int i;
+	u32 csts = -1;
+
+	nvme_dev_list_remove(dev);
+
+	if (dev->bar) {
+		nvme_freeze_queues(dev);
+		csts = readl(&dev->bar->csts);
+	}
+	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
+		for (i = dev->queue_count - 1; i >= 0; i--) {
+			struct nvme_queue *nvmeq = dev->queues[i];
+			nvme_suspend_queue(nvmeq);
+		}
+	} else {
+		nvme_disable_io_queues(dev);
+		nvme_shutdown_ctrl(dev);
+		nvme_disable_queue(dev, 0);
+	}
+	nvme_dev_unmap(dev);
+
+	for (i = dev->queue_count - 1; i >= 0; i--)
+		nvme_clear_queue(dev->queues[i]);
+}
+
+static void nvme_dev_remove(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &dev->namespaces, list)
+		nvme_ns_remove(ns);
+}
+
+static int nvme_setup_prp_pools(struct nvme_dev *dev)
+{
+	dev->prp_page_pool = dma_pool_create("prp list page", dev
->dev,
+						PAGE_SIZE, PAGE_SIZE,
0);
+	if (!dev->prp_page_pool)
+		return -ENOMEM;
+
+	/* Optimisation for I/Os between 4k and 128k */
+	dev->prp_small_pool = dma_pool_create("prp list 256", dev
->dev,
+						256, 256, 0);
+	if (!dev->prp_small_pool) {
+		dma_pool_destroy(dev->prp_page_pool);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void nvme_release_prp_pools(struct nvme_dev *dev)
+{
+	dma_pool_destroy(dev->prp_page_pool);
+	dma_pool_destroy(dev->prp_small_pool);
+}
+
+static DEFINE_IDA(nvme_instance_ida);
+
+static int nvme_set_instance(struct nvme_dev *dev)
+{
+	int instance, error;
+
+	do {
+		if (!ida_pre_get(&nvme_instance_ida, GFP_KERNEL))
+			return -ENODEV;
+
+		spin_lock(&dev_list_lock);
+		error = ida_get_new(&nvme_instance_ida, &instance);
+		spin_unlock(&dev_list_lock);
+	} while (error == -EAGAIN);
+
+	if (error)
+		return -ENODEV;
+
+	dev->instance = instance;
+	return 0;
+}
+
+static void nvme_release_instance(struct nvme_dev *dev)
+{
+	spin_lock(&dev_list_lock);
+	ida_remove(&nvme_instance_ida, dev->instance);
+	spin_unlock(&dev_list_lock);
+}
+
+static void nvme_free_namespaces(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns, *next;
+
+	list_for_each_entry_safe(ns, next, &dev->namespaces, list)
+		nvme_free_namespace(ns);
+}
+
+static void nvme_free_dev(struct kref *kref)
+{
+	struct nvme_dev *dev = container_of(kref, struct nvme_dev,
kref);
+
+	put_device(dev->dev);
+	put_device(dev->device);
+	nvme_free_namespaces(dev);
+	nvme_release_instance(dev);
+	if (dev->tagset.tags)
+		blk_mq_free_tag_set(&dev->tagset);
+	if (dev->admin_q)
+		blk_put_queue(dev->admin_q);
+	kfree(dev->queues);
+	kfree(dev->entry);
+	kfree(dev);
+}
+
+static int nvme_dev_open(struct inode *inode, struct file *f)
+{
+	struct nvme_dev *dev;
+	int instance = iminor(inode);
+	int ret = -ENODEV;
+
+	spin_lock(&dev_list_lock);
+	list_for_each_entry(dev, &dev_list, node) {
+		if (dev->instance == instance) {
+			if (!dev->admin_q) {
+				ret = -EWOULDBLOCK;
+				break;
+			}
+			if (!kref_get_unless_zero(&dev->kref))
+				break;
+			f->private_data = dev;
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock(&dev_list_lock);
+
+	return ret;
+}
+
+static int nvme_dev_release(struct inode *inode, struct file *f)
+{
+	struct nvme_dev *dev = f->private_data;
+	kref_put(&dev->kref, nvme_free_dev);
+	return 0;
+}
+
+static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned
long arg)
+{
+	struct nvme_dev *dev = f->private_data;
+	struct nvme_ns *ns;
+
+	switch (cmd) {
+	case NVME_IOCTL_ADMIN_CMD:
+		return nvme_user_cmd(dev, NULL, (void __user *)arg);
+	case NVME_IOCTL_IO_CMD:
+		if (list_empty(&dev->namespaces))
+			return -ENOTTY;
+		ns = list_first_entry(&dev->namespaces, struct
nvme_ns, list);
+		return nvme_user_cmd(dev, ns, (void __user *)arg);
+	case NVME_IOCTL_RESET:
+		dev_warn(dev->dev, "resetting controller\n");
+		return nvme_reset(dev);
+	case NVME_IOCTL_SUBSYS_RESET:
+		return nvme_subsys_reset(dev);
+	default:
+		return -ENOTTY;
+	}
+}
+
+static const struct file_operations nvme_dev_fops = {
+	.owner		= THIS_MODULE,
+	.open		= nvme_dev_open,
+	.release	= nvme_dev_release,
+	.unlocked_ioctl	= nvme_dev_ioctl,
+	.compat_ioctl	= nvme_dev_ioctl,
+};
+
+static void nvme_set_irq_hints(struct nvme_dev *dev)
+{
+	struct nvme_queue *nvmeq;
+	int i;
+
+	for (i = 0; i < dev->online_queues; i++) {
+		nvmeq = dev->queues[i];
+
+		if (!nvmeq->tags || !(*nvmeq->tags))
+			continue;
+
+		irq_set_affinity_hint(dev->entry[nvmeq
->cq_vector].vector,
+					blk_mq_tags_cpumask(*nvmeq
->tags));
+	}
+}
+
+static int nvme_dev_start(struct nvme_dev *dev)
+{
+	int result;
+	bool start_thread = false;
+
+	result = nvme_dev_map(dev);
+	if (result)
+		return result;
+
+	result = nvme_configure_admin_queue(dev);
+	if (result)
+		goto unmap;
+
+	spin_lock(&dev_list_lock);
+	if (list_empty(&dev_list) && IS_ERR_OR_NULL(nvme_thread)) {
+		start_thread = true;
+		nvme_thread = NULL;
+	}
+	list_add(&dev->node, &dev_list);
+	spin_unlock(&dev_list_lock);
+
+	if (start_thread) {
+		nvme_thread = kthread_run(nvme_kthread, NULL, "nvme");
+		wake_up_all(&nvme_kthread_wait);
+	} else
+		wait_event_killable(nvme_kthread_wait, nvme_thread);
+
+	if (IS_ERR_OR_NULL(nvme_thread)) {
+		result = nvme_thread ? PTR_ERR(nvme_thread) : -EINTR;
+		goto disable;
+	}
+
+	nvme_init_queue(dev->queues[0], 0);
+	result = nvme_alloc_admin_tags(dev);
+	if (result)
+		goto disable;
+
+	result = nvme_setup_io_queues(dev);
+	if (result)
+		goto free_tags;
+
+	nvme_set_irq_hints(dev);
+
+	dev->event_limit = 1;
+	return result;
+
+ free_tags:
+	nvme_dev_remove_admin(dev);
+	blk_put_queue(dev->admin_q);
+	dev->admin_q = NULL;
+	dev->queues[0]->tags = NULL;
+ disable:
+	nvme_disable_queue(dev, 0);
+	nvme_dev_list_remove(dev);
+ unmap:
+	nvme_dev_unmap(dev);
+	return result;
+}
+
+static int nvme_remove_dead_ctrl(void *arg)
+{
+	struct nvme_dev *dev = (struct nvme_dev *)arg;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	if (pci_get_drvdata(pdev))
+		pci_stop_and_remove_bus_device_locked(pdev);
+	kref_put(&dev->kref, nvme_free_dev);
+	return 0;
+}
+
+static void nvme_remove_disks(struct work_struct *ws)
+{
+	struct nvme_dev *dev = container_of(ws, struct nvme_dev,
reset_work);
+
+	nvme_free_queues(dev, 1);
+	nvme_dev_remove(dev);
+}
+
+static int nvme_dev_resume(struct nvme_dev *dev)
+{
+	int ret;
+
+	ret = nvme_dev_start(dev);
+	if (ret)
+		return ret;
+	if (dev->online_queues < 2) {
+		spin_lock(&dev_list_lock);
+		dev->reset_workfn = nvme_remove_disks;
+		queue_work(nvme_workq, &dev->reset_work);
+		spin_unlock(&dev_list_lock);
+	} else {
+		nvme_unfreeze_queues(dev);
+		nvme_dev_add(dev);
+		nvme_set_irq_hints(dev);
+	}
+	return 0;
+}
+
+static void nvme_dead_ctrl(struct nvme_dev *dev)
+{
+	dev_warn(dev->dev, "Device failed to resume\n");
+	kref_get(&dev->kref);
+	if (IS_ERR(kthread_run(nvme_remove_dead_ctrl, dev, "nvme%d",
+						dev->instance))) {
+		dev_err(dev->dev,
+			"Failed to start controller remove task\n");
+		kref_put(&dev->kref, nvme_free_dev);
+	}
+}
+
+static void nvme_dev_reset(struct nvme_dev *dev)
+{
+	bool in_probe = work_busy(&dev->probe_work);
+
+	nvme_dev_shutdown(dev);
+
+	/* Synchronize with device probe so that work will see failure
status
+	 * and exit gracefully without trying to schedule another
reset */
+	flush_work(&dev->probe_work);
+
+	/* Fail this device if reset occured during probe to avoid
+	 * infinite initialization loops. */
+	if (in_probe) {
+		nvme_dead_ctrl(dev);
+		return;
+	}
+	/* Schedule device resume asynchronously so the reset work is
available
+	 * to cleanup errors that may occur during reinitialization */
+	schedule_work(&dev->probe_work);
+}
+
+static void nvme_reset_failed_dev(struct work_struct *ws)
+{
+	struct nvme_dev *dev = container_of(ws, struct nvme_dev,
reset_work);
+	nvme_dev_reset(dev);
+}
+
+static void nvme_reset_workfn(struct work_struct *work)
+{
+	struct nvme_dev *dev = container_of(work, struct nvme_dev,
reset_work);
+	dev->reset_workfn(work);
+}
+
+static int nvme_reset(struct nvme_dev *dev)
+{
+	int ret = -EBUSY;
+
+	if (!dev->admin_q || blk_queue_dying(dev->admin_q))
+		return -ENODEV;
+
+	spin_lock(&dev_list_lock);
+	if (!work_pending(&dev->reset_work)) {
+		dev->reset_workfn = nvme_reset_failed_dev;
+		queue_work(nvme_workq, &dev->reset_work);
+		ret = 0;
+	}
+	spin_unlock(&dev_list_lock);
+
+	if (!ret) {
+		flush_work(&dev->reset_work);
+		flush_work(&dev->probe_work);
+		return 0;
+	}
+
+	return ret;
+}
+
+static ssize_t nvme_sysfs_reset(struct device *dev,
+				struct device_attribute *attr, const
char *buf,
+				size_t count)
+{
+	struct nvme_dev *ndev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = nvme_reset(ndev);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
+
+static void nvme_async_probe(struct work_struct *work);
+static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id
*id)
+{
+	int node, result = -ENOMEM;
+	struct nvme_dev *dev;
+
+	node = dev_to_node(&pdev->dev);
+	if (node == NUMA_NO_NODE)
+		set_dev_node(&pdev->dev, 0);
+
+	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
+	if (!dev)
+		return -ENOMEM;
+	dev->entry = kzalloc_node(num_possible_cpus() * sizeof(*dev
->entry),
+							GFP_KERNEL,
node);
+	if (!dev->entry)
+		goto free;
+	dev->queues = kzalloc_node((num_possible_cpus() + 1) *
sizeof(void *),
+							GFP_KERNEL,
node);
+	if (!dev->queues)
+		goto free;
+
+	INIT_LIST_HEAD(&dev->namespaces);
+	dev->reset_workfn = nvme_reset_failed_dev;
+	INIT_WORK(&dev->reset_work, nvme_reset_workfn);
+	dev->dev = get_device(&pdev->dev);
+	pci_set_drvdata(pdev, dev);
+	result = nvme_set_instance(dev);
+	if (result)
+		goto put_pci;
+
+	result = nvme_setup_prp_pools(dev);
+	if (result)
+		goto release;
+
+	kref_init(&dev->kref);
+	dev->device = device_create(nvme_class, &pdev->dev,
+				MKDEV(nvme_char_major, dev->instance),
+				dev, "nvme%d", dev->instance);
+	if (IS_ERR(dev->device)) {
+		result = PTR_ERR(dev->device);
+		goto release_pools;
+	}
+	get_device(dev->device);
+	dev_set_drvdata(dev->device, dev);
+
+	result = device_create_file(dev->device,
&dev_attr_reset_controller);
+	if (result)
+		goto put_dev;
+
+	INIT_LIST_HEAD(&dev->node);
+	INIT_WORK(&dev->scan_work, nvme_dev_scan);
+	INIT_WORK(&dev->probe_work, nvme_async_probe);
+	schedule_work(&dev->probe_work);
+	return 0;
+
+ put_dev:
+	device_destroy(nvme_class, MKDEV(nvme_char_major, dev
->instance));
+	put_device(dev->device);
+ release_pools:
+	nvme_release_prp_pools(dev);
+ release:
+	nvme_release_instance(dev);
+ put_pci:
+	put_device(dev->dev);
+ free:
+	kfree(dev->queues);
+	kfree(dev->entry);
+	kfree(dev);
+	return result;
+}
+
+static void nvme_async_probe(struct work_struct *work)
+{
+	struct nvme_dev *dev = container_of(work, struct nvme_dev,
probe_work);
+
+	if (nvme_dev_resume(dev) && !work_busy(&dev->reset_work))
+		nvme_dead_ctrl(dev);
+}
+
+static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	if (prepare)
+		nvme_dev_shutdown(dev);
+	else
+		nvme_dev_resume(dev);
+}
+
+static void nvme_shutdown(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	nvme_dev_shutdown(dev);
+}
+
+static void nvme_remove(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	spin_lock(&dev_list_lock);
+	list_del_init(&dev->node);
+	spin_unlock(&dev_list_lock);
+
+	pci_set_drvdata(pdev, NULL);
+	flush_work(&dev->probe_work);
+	flush_work(&dev->reset_work);
+	flush_work(&dev->scan_work);
+	device_remove_file(dev->device, &dev_attr_reset_controller);
+	nvme_dev_remove(dev);
+	nvme_dev_shutdown(dev);
+	nvme_dev_remove_admin(dev);
+	device_destroy(nvme_class, MKDEV(nvme_char_major, dev
->instance));
+	nvme_free_queues(dev, 0);
+	nvme_release_cmb(dev);
+	nvme_release_prp_pools(dev);
+	kref_put(&dev->kref, nvme_free_dev);
+}
+
+/* These functions are yet to be implemented */
+#define nvme_error_detected NULL
+#define nvme_dump_registers NULL
+#define nvme_link_reset NULL
+#define nvme_slot_reset NULL
+#define nvme_error_resume NULL
+
+#ifdef CONFIG_PM_SLEEP
+static int nvme_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+
+	nvme_dev_shutdown(ndev);
+	return 0;
+}
+
+static int nvme_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+
+	if (nvme_dev_resume(ndev) && !work_busy(&ndev->reset_work)) {
+		ndev->reset_workfn = nvme_reset_failed_dev;
+		queue_work(nvme_workq, &ndev->reset_work);
+	}
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
+
+static const struct pci_error_handlers nvme_err_handler = {
+	.error_detected	= nvme_error_detected,
+	.mmio_enabled	= nvme_dump_registers,
+	.link_reset	= nvme_link_reset,
+	.slot_reset	= nvme_slot_reset,
+	.resume		= nvme_error_resume,
+	.reset_notify	= nvme_reset_notify,
+};
+
+/* Move to pci_ids.h later */
+#define PCI_CLASS_STORAGE_EXPRESS	0x010802
+
+static const struct pci_device_id nvme_id_table[] = {
+	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, nvme_id_table);
+
+static struct pci_driver nvme_driver = {
+	.name		= "nvme",
+	.id_table	= nvme_id_table,
+	.probe		= nvme_probe,
+	.remove		= nvme_remove,
+	.shutdown	= nvme_shutdown,
+	.driver		= {
+		.pm	= &nvme_dev_pm_ops,
+	},
+	.err_handler	= &nvme_err_handler,
+};
+
+static int __init nvme_init(void)
+{
+	int result;
+
+	init_waitqueue_head(&nvme_kthread_wait);
+
+	nvme_workq = create_singlethread_workqueue("nvme");
+	if (!nvme_workq)
+		return -ENOMEM;
+
+	result = register_blkdev(nvme_major, "nvme");
+	if (result < 0)
+		goto kill_workq;
+	else if (result > 0)
+		nvme_major = result;
+
+	result = __register_chrdev(nvme_char_major, 0, NVME_MINORS,
"nvme",
+							&nvme_dev_fops
);
+	if (result < 0)
+		goto unregister_blkdev;
+	else if (result > 0)
+		nvme_char_major = result;
+
+	nvme_class = class_create(THIS_MODULE, "nvme");
+	if (IS_ERR(nvme_class)) {
+		result = PTR_ERR(nvme_class);
+		goto unregister_chrdev;
+	}
+
+	result = pci_register_driver(&nvme_driver);
+	if (result)
+		goto destroy_class;
+	return 0;
+
+ destroy_class:
+	class_destroy(nvme_class);
+ unregister_chrdev:
+	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
+ unregister_blkdev:
+	unregister_blkdev(nvme_major, "nvme");
+ kill_workq:
+	destroy_workqueue(nvme_workq);
+	return result;
+}
+
+static void __exit nvme_exit(void)
+{
+	pci_unregister_driver(&nvme_driver);
+	unregister_blkdev(nvme_major, "nvme");
+	destroy_workqueue(nvme_workq);
+	class_destroy(nvme_class);
+	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
+	BUG_ON(nvme_thread && !IS_ERR(nvme_thread));
+	_nvme_check_size();
+}
+
+MODULE_AUTHOR("Matthew Wilcox <willy at linux.intel.com>");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");
+module_init(nvme_init);
+module_exit(nvme_exit);
diff --git a/drivers/block/nvme/scsi.c b/drivers/block/nvme/scsi.c
new file mode 100644
index 0000000..e5a63f0
--- /dev/null
+++ b/drivers/block/nvme/scsi.c
@@ -0,0 +1,2556 @@
+/*
+ * NVM Express device driver
+ * Copyright (c) 2011-2014, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but
WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
License for
+ * more details.
+ */
+
+/*
+ * Refer to the SCSI-NVMe Translation spec for details on how
+ * each command is translated.
+ */
+
+#include <linux/nvme.h>
+#include <linux/bio.h>
+#include <linux/bitops.h>
+#include <linux/blkdev.h>
+#include <linux/compat.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kdev_t.h>
+#include <linux/kthread.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/pci.h>
+#include <linux/poison.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <asm/unaligned.h>
+#include <scsi/sg.h>
+#include <scsi/scsi.h>
+
+
+static int sg_version_num = 30534;	/* 2 digits for each component
*/
+
+/* VPD Page Codes */
+#define VPD_SUPPORTED_PAGES				0x00
+#define VPD_SERIAL_NUMBER				0x80
+#define VPD_DEVICE_IDENTIFIERS				0x83
+#define VPD_EXTENDED_INQUIRY				0x86
+#define VPD_BLOCK_LIMITS				0xB0
+#define VPD_BLOCK_DEV_CHARACTERISTICS			0xB1
+
+/* format unit paramter list offsets */
+#define FORMAT_UNIT_SHORT_PARM_LIST_LEN			4
+#define FORMAT_UNIT_LONG_PARM_LIST_LEN			8
+#define FORMAT_UNIT_PROT_INT_OFFSET			3
+#define FORMAT_UNIT_PROT_FIELD_USAGE_OFFSET		0
+#define FORMAT_UNIT_PROT_FIELD_USAGE_MASK		0x07
+
+/* Misc. defines */
+#define FIXED_SENSE_DATA				0x70
+#define DESC_FORMAT_SENSE_DATA				0x72
+#define FIXED_SENSE_DATA_ADD_LENGTH			10
+#define LUN_ENTRY_SIZE					8
+#define LUN_DATA_HEADER_SIZE				8
+#define ALL_LUNS_RETURNED				0x02
+#define ALL_WELL_KNOWN_LUNS_RETURNED			0x01
+#define RESTRICTED_LUNS_RETURNED			0x00
+#define NVME_POWER_STATE_START_VALID			0x00
+#define NVME_POWER_STATE_ACTIVE				0x01
+#define NVME_POWER_STATE_IDLE				0x02
+#define NVME_POWER_STATE_STANDBY			0x03
+#define NVME_POWER_STATE_LU_CONTROL			0x07
+#define POWER_STATE_0					0
+#define POWER_STATE_1					1
+#define POWER_STATE_2					2
+#define POWER_STATE_3					3
+#define DOWNLOAD_SAVE_ACTIVATE				0x05
+#define DOWNLOAD_SAVE_DEFER_ACTIVATE			0x0E
+#define ACTIVATE_DEFERRED_MICROCODE			0x0F
+#define FORMAT_UNIT_IMMED_MASK				0x2
+#define FORMAT_UNIT_IMMED_OFFSET			1
+#define KELVIN_TEMP_FACTOR				273
+#define FIXED_FMT_SENSE_DATA_SIZE			18
+#define DESC_FMT_SENSE_DATA_SIZE			8
+
+/* SCSI/NVMe defines and bit masks */
+#define INQ_STANDARD_INQUIRY_PAGE			0x00
+#define INQ_SUPPORTED_VPD_PAGES_PAGE			0x00
+#define INQ_UNIT_SERIAL_NUMBER_PAGE			0x80
+#define INQ_DEVICE_IDENTIFICATION_PAGE			0x83
+#define INQ_EXTENDED_INQUIRY_DATA_PAGE			0x86
+#define INQ_BDEV_LIMITS_PAGE				0xB0
+#define INQ_BDEV_CHARACTERISTICS_PAGE			0xB1
+#define INQ_SERIAL_NUMBER_LENGTH			0x14
+#define INQ_NUM_SUPPORTED_VPD_PAGES			6
+#define VERSION_SPC_4					0x06
+#define ACA_UNSUPPORTED					0
+#define STANDARD_INQUIRY_LENGTH				36
+#define ADDITIONAL_STD_INQ_LENGTH			31
+#define EXTENDED_INQUIRY_DATA_PAGE_LENGTH		0x3C
+#define RESERVED_FIELD					0
+
+/* Mode Sense/Select defines */
+#define MODE_PAGE_INFO_EXCEP				0x1C
+#define MODE_PAGE_CACHING				0x08
+#define MODE_PAGE_CONTROL				0x0A
+#define MODE_PAGE_POWER_CONDITION			0x1A
+#define MODE_PAGE_RETURN_ALL				0x3F
+#define MODE_PAGE_BLK_DES_LEN				0x08
+#define MODE_PAGE_LLBAA_BLK_DES_LEN			0x10
+#define MODE_PAGE_CACHING_LEN				0x14
+#define MODE_PAGE_CONTROL_LEN				0x0C
+#define MODE_PAGE_POW_CND_LEN				0x28
+#define MODE_PAGE_INF_EXC_LEN				0x0C
+#define MODE_PAGE_ALL_LEN				0x54
+#define MODE_SENSE6_MPH_SIZE				4
+#define MODE_SENSE_PAGE_CONTROL_MASK			0xC0
+#define MODE_SENSE_PAGE_CODE_OFFSET			2
+#define MODE_SENSE_PAGE_CODE_MASK			0x3F
+#define MODE_SENSE_LLBAA_MASK				0x10
+#define MODE_SENSE_LLBAA_SHIFT				4
+#define MODE_SENSE_DBD_MASK				8
+#define MODE_SENSE_DBD_SHIFT				3
+#define MODE_SENSE10_MPH_SIZE				8
+#define MODE_SELECT_CDB_PAGE_FORMAT_MASK		0x10
+#define MODE_SELECT_CDB_SAVE_PAGES_MASK			0x1
+#define MODE_SELECT_6_BD_OFFSET				3
+#define MODE_SELECT_10_BD_OFFSET			6
+#define MODE_SELECT_10_LLBAA_OFFSET			4
+#define MODE_SELECT_10_LLBAA_MASK			1
+#define MODE_SELECT_6_MPH_SIZE				4
+#define MODE_SELECT_10_MPH_SIZE				8
+#define CACHING_MODE_PAGE_WCE_MASK			0x04
+#define MODE_SENSE_BLK_DESC_ENABLED			0
+#define MODE_SENSE_BLK_DESC_COUNT			1
+#define MODE_SELECT_PAGE_CODE_MASK			0x3F
+#define SHORT_DESC_BLOCK				8
+#define LONG_DESC_BLOCK					16
+#define MODE_PAGE_POW_CND_LEN_FIELD			0x26
+#define MODE_PAGE_INF_EXC_LEN_FIELD			0x0A
+#define MODE_PAGE_CACHING_LEN_FIELD			0x12
+#define MODE_PAGE_CONTROL_LEN_FIELD			0x0A
+#define MODE_SENSE_PC_CURRENT_VALUES			0
+
+/* Log Sense defines */
+#define LOG_PAGE_SUPPORTED_LOG_PAGES_PAGE		0x00
+#define LOG_PAGE_SUPPORTED_LOG_PAGES_LENGTH		0x07
+#define LOG_PAGE_INFORMATIONAL_EXCEPTIONS_PAGE		0x2F
+#define LOG_PAGE_TEMPERATURE_PAGE			0x0D
+#define LOG_SENSE_CDB_SP_NOT_ENABLED			0
+#define LOG_SENSE_CDB_PC_MASK				0xC0
+#define LOG_SENSE_CDB_PC_SHIFT				6
+#define LOG_SENSE_CDB_PC_CUMULATIVE_VALUES		1
+#define LOG_SENSE_CDB_PAGE_CODE_MASK			0x3F
+#define REMAINING_INFO_EXCP_PAGE_LENGTH			0x8
+#define LOG_INFO_EXCP_PAGE_LENGTH			0xC
+#define REMAINING_TEMP_PAGE_LENGTH			0xC
+#define LOG_TEMP_PAGE_LENGTH				0x10
+#define LOG_TEMP_UNKNOWN				0xFF
+#define SUPPORTED_LOG_PAGES_PAGE_LENGTH			0x3
+
+/* Read Capacity defines */
+#define READ_CAP_10_RESP_SIZE				8
+#define READ_CAP_16_RESP_SIZE				32
+
+/* NVMe Namespace and Command Defines */
+#define BYTES_TO_DWORDS					4
+#define NVME_MAX_FIRMWARE_SLOT				7
+
+/* Report LUNs defines */
+#define REPORT_LUNS_FIRST_LUN_OFFSET			8
+
+/* SCSI ADDITIONAL SENSE Codes */
+
+#define SCSI_ASC_NO_SENSE				0x00
+#define SCSI_ASC_PERIPHERAL_DEV_WRITE_FAULT		0x03
+#define SCSI_ASC_LUN_NOT_READY				0x04
+#define SCSI_ASC_WARNING				0x0B
+#define SCSI_ASC_LOG_BLOCK_GUARD_CHECK_FAILED		0x10
+#define SCSI_ASC_LOG_BLOCK_APPTAG_CHECK_FAILED		0x10
+#define SCSI_ASC_LOG_BLOCK_REFTAG_CHECK_FAILED		0x10
+#define SCSI_ASC_UNRECOVERED_READ_ERROR			0x11
+#define SCSI_ASC_MISCOMPARE_DURING_VERIFY		0x1D
+#define SCSI_ASC_ACCESS_DENIED_INVALID_LUN_ID		0x20
+#define SCSI_ASC_ILLEGAL_COMMAND			0x20
+#define SCSI_ASC_ILLEGAL_BLOCK				0x21
+#define SCSI_ASC_INVALID_CDB				0x24
+#define SCSI_ASC_INVALID_LUN				0x25
+#define SCSI_ASC_INVALID_PARAMETER			0x26
+#define SCSI_ASC_FORMAT_COMMAND_FAILED			0x31
+#define SCSI_ASC_INTERNAL_TARGET_FAILURE		0x44
+
+/* SCSI ADDITIONAL SENSE Code Qualifiers */
+
+#define SCSI_ASCQ_CAUSE_NOT_REPORTABLE			0x00
+#define SCSI_ASCQ_FORMAT_COMMAND_FAILED			0x01
+#define SCSI_ASCQ_LOG_BLOCK_GUARD_CHECK_FAILED		0x01
+#define SCSI_ASCQ_LOG_BLOCK_APPTAG_CHECK_FAILED		0x02
+#define SCSI_ASCQ_LOG_BLOCK_REFTAG_CHECK_FAILED		0x03
+#define SCSI_ASCQ_FORMAT_IN_PROGRESS			0x04
+#define SCSI_ASCQ_POWER_LOSS_EXPECTED			0x08
+#define SCSI_ASCQ_INVALID_LUN_ID			0x09
+
+/* copied from drivers/usb/gadget/function/storage_common.h */
+static inline u32 get_unaligned_be24(u8 *buf)
+{
+	return 0xffffff & (u32) get_unaligned_be32(buf - 1);
+}
+
+/* Struct to gather data that needs to be extracted from a SCSI CDB.
+   Not conforming to any particular CDB variant, but compatible with
all. */
+
+struct nvme_trans_io_cdb {
+	u8 fua;
+	u8 prot_info;
+	u64 lba;
+	u32 xfer_len;
+};
+
+
+/* Internal Helper Functions */
+
+
+/* Copy data to userspace memory */
+
+static int nvme_trans_copy_to_user(struct sg_io_hdr *hdr, void *from,
+								unsign
ed long n)
+{
+	int i;
+	void *index = from;
+	size_t remaining = n;
+	size_t xfer_len;
+
+	if (hdr->iovec_count > 0) {
+		struct sg_iovec sgl;
+
+		for (i = 0; i < hdr->iovec_count; i++) {
+			if (copy_from_user(&sgl, hdr->dxferp +
+						i * sizeof(struct
sg_iovec),
+						sizeof(struct
sg_iovec)))
+				return -EFAULT;
+			xfer_len = min(remaining, sgl.iov_len);
+			if (copy_to_user(sgl.iov_base, index,
xfer_len))
+				return -EFAULT;
+
+			index += xfer_len;
+			remaining -= xfer_len;
+			if (remaining == 0)
+				break;
+		}
+		return 0;
+	}
+
+	if (copy_to_user(hdr->dxferp, from, n))
+		return -EFAULT;
+	return 0;
+}
+
+/* Copy data from userspace memory */
+
+static int nvme_trans_copy_from_user(struct sg_io_hdr *hdr, void *to,
+								unsign
ed long n)
+{
+	int i;
+	void *index = to;
+	size_t remaining = n;
+	size_t xfer_len;
+
+	if (hdr->iovec_count > 0) {
+		struct sg_iovec sgl;
+
+		for (i = 0; i < hdr->iovec_count; i++) {
+			if (copy_from_user(&sgl, hdr->dxferp +
+						i * sizeof(struct
sg_iovec),
+						sizeof(struct
sg_iovec)))
+				return -EFAULT;
+			xfer_len = min(remaining, sgl.iov_len);
+			if (copy_from_user(index, sgl.iov_base,
xfer_len))
+				return -EFAULT;
+			index += xfer_len;
+			remaining -= xfer_len;
+			if (remaining == 0)
+				break;
+		}
+		return 0;
+	}
+
+	if (copy_from_user(to, hdr->dxferp, n))
+		return -EFAULT;
+	return 0;
+}
+
+/* Status/Sense Buffer Writeback */
+
+static int nvme_trans_completion(struct sg_io_hdr *hdr, u8 status, u8
sense_key,
+				 u8 asc, u8 ascq)
+{
+	u8 xfer_len;
+	u8 resp[DESC_FMT_SENSE_DATA_SIZE];
+
+	if (scsi_status_is_good(status)) {
+		hdr->status = SAM_STAT_GOOD;
+		hdr->masked_status = GOOD;
+		hdr->host_status = DID_OK;
+		hdr->driver_status = DRIVER_OK;
+		hdr->sb_len_wr = 0;
+	} else {
+		hdr->status = status;
+		hdr->masked_status = status >> 1;
+		hdr->host_status = DID_OK;
+		hdr->driver_status = DRIVER_OK;
+
+		memset(resp, 0, DESC_FMT_SENSE_DATA_SIZE);
+		resp[0] = DESC_FORMAT_SENSE_DATA;
+		resp[1] = sense_key;
+		resp[2] = asc;
+		resp[3] = ascq;
+
+		xfer_len = min_t(u8, hdr->mx_sb_len,
DESC_FMT_SENSE_DATA_SIZE);
+		hdr->sb_len_wr = xfer_len;
+		if (copy_to_user(hdr->sbp, resp, xfer_len) > 0)
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+/*
+ * Take a status code from a lowlevel routine, and if it was a
positive NVMe
+ * error code update the sense data based on it.  In either case the
passed
+ * in value is returned again, unless an -EFAULT from copy_to_user
overrides
+ * it.
+ */
+static int nvme_trans_status_code(struct sg_io_hdr *hdr, int nvme_sc)
+{
+	u8 status, sense_key, asc, ascq;
+	int res;
+
+	/* For non-nvme (Linux) errors, simply return the error code
*/
+	if (nvme_sc < 0)
+		return nvme_sc;
+
+	/* Mask DNR, More, and reserved fields */
+	switch (nvme_sc & 0x7FF) {
+	/* Generic Command Status */
+	case NVME_SC_SUCCESS:
+		status = SAM_STAT_GOOD;
+		sense_key = NO_SENSE;
+		asc = SCSI_ASC_NO_SENSE;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	case NVME_SC_INVALID_OPCODE:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = ILLEGAL_REQUEST;
+		asc = SCSI_ASC_ILLEGAL_COMMAND;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	case NVME_SC_INVALID_FIELD:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = ILLEGAL_REQUEST;
+		asc = SCSI_ASC_INVALID_CDB;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	case NVME_SC_DATA_XFER_ERROR:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = MEDIUM_ERROR;
+		asc = SCSI_ASC_NO_SENSE;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	case NVME_SC_POWER_LOSS:
+		status = SAM_STAT_TASK_ABORTED;
+		sense_key = ABORTED_COMMAND;
+		asc = SCSI_ASC_WARNING;
+		ascq = SCSI_ASCQ_POWER_LOSS_EXPECTED;
+		break;
+	case NVME_SC_INTERNAL:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = HARDWARE_ERROR;
+		asc = SCSI_ASC_INTERNAL_TARGET_FAILURE;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	case NVME_SC_ABORT_REQ:
+		status = SAM_STAT_TASK_ABORTED;
+		sense_key = ABORTED_COMMAND;
+		asc = SCSI_ASC_NO_SENSE;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	case NVME_SC_ABORT_QUEUE:
+		status = SAM_STAT_TASK_ABORTED;
+		sense_key = ABORTED_COMMAND;
+		asc = SCSI_ASC_NO_SENSE;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	case NVME_SC_FUSED_FAIL:
+		status = SAM_STAT_TASK_ABORTED;
+		sense_key = ABORTED_COMMAND;
+		asc = SCSI_ASC_NO_SENSE;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	case NVME_SC_FUSED_MISSING:
+		status = SAM_STAT_TASK_ABORTED;
+		sense_key = ABORTED_COMMAND;
+		asc = SCSI_ASC_NO_SENSE;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	case NVME_SC_INVALID_NS:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = ILLEGAL_REQUEST;
+		asc = SCSI_ASC_ACCESS_DENIED_INVALID_LUN_ID;
+		ascq = SCSI_ASCQ_INVALID_LUN_ID;
+		break;
+	case NVME_SC_LBA_RANGE:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = ILLEGAL_REQUEST;
+		asc = SCSI_ASC_ILLEGAL_BLOCK;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	case NVME_SC_CAP_EXCEEDED:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = MEDIUM_ERROR;
+		asc = SCSI_ASC_NO_SENSE;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	case NVME_SC_NS_NOT_READY:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = NOT_READY;
+		asc = SCSI_ASC_LUN_NOT_READY;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+
+	/* Command Specific Status */
+	case NVME_SC_INVALID_FORMAT:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = ILLEGAL_REQUEST;
+		asc = SCSI_ASC_FORMAT_COMMAND_FAILED;
+		ascq = SCSI_ASCQ_FORMAT_COMMAND_FAILED;
+		break;
+	case NVME_SC_BAD_ATTRIBUTES:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = ILLEGAL_REQUEST;
+		asc = SCSI_ASC_INVALID_CDB;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+
+	/* Media Errors */
+	case NVME_SC_WRITE_FAULT:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = MEDIUM_ERROR;
+		asc = SCSI_ASC_PERIPHERAL_DEV_WRITE_FAULT;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	case NVME_SC_READ_ERROR:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = MEDIUM_ERROR;
+		asc = SCSI_ASC_UNRECOVERED_READ_ERROR;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	case NVME_SC_GUARD_CHECK:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = MEDIUM_ERROR;
+		asc = SCSI_ASC_LOG_BLOCK_GUARD_CHECK_FAILED;
+		ascq = SCSI_ASCQ_LOG_BLOCK_GUARD_CHECK_FAILED;
+		break;
+	case NVME_SC_APPTAG_CHECK:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = MEDIUM_ERROR;
+		asc = SCSI_ASC_LOG_BLOCK_APPTAG_CHECK_FAILED;
+		ascq = SCSI_ASCQ_LOG_BLOCK_APPTAG_CHECK_FAILED;
+		break;
+	case NVME_SC_REFTAG_CHECK:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = MEDIUM_ERROR;
+		asc = SCSI_ASC_LOG_BLOCK_REFTAG_CHECK_FAILED;
+		ascq = SCSI_ASCQ_LOG_BLOCK_REFTAG_CHECK_FAILED;
+		break;
+	case NVME_SC_COMPARE_FAILED:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = MISCOMPARE;
+		asc = SCSI_ASC_MISCOMPARE_DURING_VERIFY;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	case NVME_SC_ACCESS_DENIED:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = ILLEGAL_REQUEST;
+		asc = SCSI_ASC_ACCESS_DENIED_INVALID_LUN_ID;
+		ascq = SCSI_ASCQ_INVALID_LUN_ID;
+		break;
+
+	/* Unspecified/Default */
+	case NVME_SC_CMDID_CONFLICT:
+	case NVME_SC_CMD_SEQ_ERROR:
+	case NVME_SC_CQ_INVALID:
+	case NVME_SC_QID_INVALID:
+	case NVME_SC_QUEUE_SIZE:
+	case NVME_SC_ABORT_LIMIT:
+	case NVME_SC_ABORT_MISSING:
+	case NVME_SC_ASYNC_LIMIT:
+	case NVME_SC_FIRMWARE_SLOT:
+	case NVME_SC_FIRMWARE_IMAGE:
+	case NVME_SC_INVALID_VECTOR:
+	case NVME_SC_INVALID_LOG_PAGE:
+	default:
+		status = SAM_STAT_CHECK_CONDITION;
+		sense_key = ILLEGAL_REQUEST;
+		asc = SCSI_ASC_NO_SENSE;
+		ascq = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		break;
+	}
+
+	res = nvme_trans_completion(hdr, status, sense_key, asc,
ascq);
+	return res ? res : nvme_sc;
+}
+
+/* INQUIRY Helper Functions */
+
+static int nvme_trans_standard_inquiry_page(struct nvme_ns *ns,
+					struct sg_io_hdr *hdr, u8
*inq_response,
+					int alloc_len)
+{
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_id_ns *id_ns;
+	int res;
+	int nvme_sc;
+	int xfer_len;
+	u8 resp_data_format = 0x02;
+	u8 protect;
+	u8 cmdque = 0x01 << 1;
+	u8 fw_offset = sizeof(dev->firmware_rev);
+
+	/* nvme ns identify - use DPS value for PROTECT field */
+	nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (res)
+		return res;
+
+	if (id_ns->dps)
+		protect = 0x01;
+	else
+		protect = 0;
+	kfree(id_ns);
+
+	memset(inq_response, 0, STANDARD_INQUIRY_LENGTH);
+	inq_response[2] = VERSION_SPC_4;
+	inq_response[3] = resp_data_format;	/*normaca=0 | hisup=0
*/
+	inq_response[4] = ADDITIONAL_STD_INQ_LENGTH;
+	inq_response[5] = protect;	/* sccs=0 | acc=0 | tpgs=0 |
pc3=0 */
+	inq_response[7] = cmdque;	/* wbus16=0 | sync=0 | vs=0 */
+	strncpy(&inq_response[8], "NVMe    ", 8);
+	strncpy(&inq_response[16], dev->model, 16);
+
+	while (dev->firmware_rev[fw_offset - 1] == ' ' && fw_offset >
4)
+		fw_offset--;
+	fw_offset -= 4;
+	strncpy(&inq_response[32], dev->firmware_rev + fw_offset, 4);
+
+	xfer_len = min(alloc_len, STANDARD_INQUIRY_LENGTH);
+	return nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
+}
+
+static int nvme_trans_supported_vpd_pages(struct nvme_ns *ns,
+					struct sg_io_hdr *hdr, u8
*inq_response,
+					int alloc_len)
+{
+	int xfer_len;
+
+	memset(inq_response, 0, STANDARD_INQUIRY_LENGTH);
+	inq_response[1] = INQ_SUPPORTED_VPD_PAGES_PAGE;   /* Page Code
*/
+	inq_response[3] = INQ_NUM_SUPPORTED_VPD_PAGES;    /* Page
Length */
+	inq_response[4] = INQ_SUPPORTED_VPD_PAGES_PAGE;
+	inq_response[5] = INQ_UNIT_SERIAL_NUMBER_PAGE;
+	inq_response[6] = INQ_DEVICE_IDENTIFICATION_PAGE;
+	inq_response[7] = INQ_EXTENDED_INQUIRY_DATA_PAGE;
+	inq_response[8] = INQ_BDEV_CHARACTERISTICS_PAGE;
+	inq_response[9] = INQ_BDEV_LIMITS_PAGE;
+
+	xfer_len = min(alloc_len, STANDARD_INQUIRY_LENGTH);
+	return nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
+}
+
+static int nvme_trans_unit_serial_page(struct nvme_ns *ns,
+					struct sg_io_hdr *hdr, u8
*inq_response,
+					int alloc_len)
+{
+	struct nvme_dev *dev = ns->dev;
+	int xfer_len;
+
+	memset(inq_response, 0, STANDARD_INQUIRY_LENGTH);
+	inq_response[1] = INQ_UNIT_SERIAL_NUMBER_PAGE; /* Page Code */
+	inq_response[3] = INQ_SERIAL_NUMBER_LENGTH;    /* Page Length
*/
+	strncpy(&inq_response[4], dev->serial,
INQ_SERIAL_NUMBER_LENGTH);
+
+	xfer_len = min(alloc_len, STANDARD_INQUIRY_LENGTH);
+	return nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
+}
+
+static int nvme_trans_device_id_page(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+					u8 *inq_response, int
alloc_len)
+{
+	struct nvme_dev *dev = ns->dev;
+	int res;
+	int nvme_sc;
+	int xfer_len;
+	__be32 tmp_id = cpu_to_be32(ns->ns_id);
+
+	memset(inq_response, 0, alloc_len);
+	inq_response[1] = INQ_DEVICE_IDENTIFICATION_PAGE;    /* Page
Code */
+	if (readl(&dev->bar->vs) >= NVME_VS(1, 1)) {
+		struct nvme_id_ns *id_ns;
+		void *eui;
+		int len;
+
+		nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
+		res = nvme_trans_status_code(hdr, nvme_sc);
+		if (res)
+			return res;
+
+		eui = id_ns->eui64;
+		len = sizeof(id_ns->eui64);
+		if (readl(&dev->bar->vs) >= NVME_VS(1, 2)) {
+			if (bitmap_empty(eui, len * 8)) {
+				eui = id_ns->nguid;
+				len = sizeof(id_ns->nguid);
+			}
+		}
+		if (bitmap_empty(eui, len * 8)) {
+			kfree(id_ns);
+			goto scsi_string;
+		}
+
+		inq_response[3] = 4 + len; /* Page Length */
+		/* Designation Descriptor start */
+		inq_response[4] = 0x01;    /* Proto ID=0h | Code
set=1h */
+		inq_response[5] = 0x02;    /* PIV=0b | Asso=00b |
Designator Type=2h */
+		inq_response[6] = 0x00;    /* Rsvd */
+		inq_response[7] = len;     /* Designator Length */
+		memcpy(&inq_response[8], eui, len);
+		kfree(id_ns);
+	} else {
+ scsi_string:
+		if (alloc_len < 72) {
+			return nvme_trans_completion(hdr,
+					SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		}
+		inq_response[3] = 0x48;    /* Page Length */
+		/* Designation Descriptor start */
+		inq_response[4] = 0x03;    /* Proto ID=0h | Code
set=3h */
+		inq_response[5] = 0x08;    /* PIV=0b | Asso=00b |
Designator Type=8h */
+		inq_response[6] = 0x00;    /* Rsvd */
+		inq_response[7] = 0x44;    /* Designator Length */
+
+		sprintf(&inq_response[8], "%04x", to_pci_dev(dev->dev)
->vendor);
+		memcpy(&inq_response[12], dev->model, sizeof(dev
->model));
+		sprintf(&inq_response[52], "%04x", tmp_id);
+		memcpy(&inq_response[56], dev->serial, sizeof(dev
->serial));
+	}
+	xfer_len = alloc_len;
+	return nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
+}
+
+static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+					int alloc_len)
+{
+	u8 *inq_response;
+	int res;
+	int nvme_sc;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_id_ctrl *id_ctrl;
+	struct nvme_id_ns *id_ns;
+	int xfer_len;
+	u8 microcode = 0x80;
+	u8 spt;
+	u8 spt_lut[8] = {0, 0, 2, 1, 4, 6, 5, 7};
+	u8 grd_chk, app_chk, ref_chk, protect;
+	u8 uask_sup = 0x20;
+	u8 v_sup;
+	u8 luiclr = 0x01;
+
+	inq_response = kmalloc(EXTENDED_INQUIRY_DATA_PAGE_LENGTH,
GFP_KERNEL);
+	if (inq_response == NULL)
+		return -ENOMEM;
+
+	nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (res)
+		goto out_free_inq;
+
+	spt = spt_lut[id_ns->dpc & 0x07] << 3;
+	if (id_ns->dps)
+		protect = 0x01;
+	else
+		protect = 0;
+	kfree(id_ns);
+
+	grd_chk = protect << 2;
+	app_chk = protect << 1;
+	ref_chk = protect;
+
+	nvme_sc = nvme_identify_ctrl(dev, &id_ctrl);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (res)
+		goto out_free_inq;
+
+	v_sup = id_ctrl->vwc;
+	kfree(id_ctrl);
+
+	memset(inq_response, 0, EXTENDED_INQUIRY_DATA_PAGE_LENGTH);
+	inq_response[1] = INQ_EXTENDED_INQUIRY_DATA_PAGE;    /* Page
Code */
+	inq_response[2] = 0x00;    /* Page Length MSB */
+	inq_response[3] = 0x3C;    /* Page Length LSB */
+	inq_response[4] = microcode | spt | grd_chk | app_chk |
ref_chk;
+	inq_response[5] = uask_sup;
+	inq_response[6] = v_sup;
+	inq_response[7] = luiclr;
+	inq_response[8] = 0;
+	inq_response[9] = 0;
+
+	xfer_len = min(alloc_len, EXTENDED_INQUIRY_DATA_PAGE_LENGTH);
+	res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
+
+ out_free_inq:
+	kfree(inq_response);
+	return res;
+}
+
+static int nvme_trans_bdev_limits_page(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+					u8 *inq_response, int
alloc_len)
+{
+	__be32 max_sectors = cpu_to_be32(
+		nvme_block_nr(ns, queue_max_hw_sectors(ns->queue)));
+	__be32 max_discard = cpu_to_be32(ns->queue
->limits.max_discard_sectors);
+	__be32 discard_desc_count = cpu_to_be32(0x100);
+
+	memset(inq_response, 0, STANDARD_INQUIRY_LENGTH);
+	inq_response[1] = VPD_BLOCK_LIMITS;
+	inq_response[3] = 0x3c; /* Page Length */
+	memcpy(&inq_response[8], &max_sectors, sizeof(u32));
+	memcpy(&inq_response[20], &max_discard, sizeof(u32));
+
+	if (max_discard)
+		memcpy(&inq_response[24], &discard_desc_count,
sizeof(u32));
+
+	return nvme_trans_copy_to_user(hdr, inq_response, 0x3c);
+}
+
+static int nvme_trans_bdev_char_page(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+					int alloc_len)
+{
+	u8 *inq_response;
+	int res;
+	int xfer_len;
+
+	inq_response = kzalloc(EXTENDED_INQUIRY_DATA_PAGE_LENGTH,
GFP_KERNEL);
+	if (inq_response == NULL) {
+		res = -ENOMEM;
+		goto out_mem;
+	}
+
+	inq_response[1] = INQ_BDEV_CHARACTERISTICS_PAGE;    /* Page
Code */
+	inq_response[2] = 0x00;    /* Page Length MSB */
+	inq_response[3] = 0x3C;    /* Page Length LSB */
+	inq_response[4] = 0x00;    /* Medium Rotation Rate MSB */
+	inq_response[5] = 0x01;    /* Medium Rotation Rate LSB */
+	inq_response[6] = 0x00;    /* Form Factor */
+
+	xfer_len = min(alloc_len, EXTENDED_INQUIRY_DATA_PAGE_LENGTH);
+	res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
+
+	kfree(inq_response);
+ out_mem:
+	return res;
+}
+
+/* LOG SENSE Helper Functions */
+
+static int nvme_trans_log_supp_pages(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+					int alloc_len)
+{
+	int res;
+	int xfer_len;
+	u8 *log_response;
+
+	log_response = kzalloc(LOG_PAGE_SUPPORTED_LOG_PAGES_LENGTH,
GFP_KERNEL);
+	if (log_response == NULL) {
+		res = -ENOMEM;
+		goto out_mem;
+	}
+
+	log_response[0] = LOG_PAGE_SUPPORTED_LOG_PAGES_PAGE;
+	/* Subpage=0x00, Page Length MSB=0 */
+	log_response[3] = SUPPORTED_LOG_PAGES_PAGE_LENGTH;
+	log_response[4] = LOG_PAGE_SUPPORTED_LOG_PAGES_PAGE;
+	log_response[5] = LOG_PAGE_INFORMATIONAL_EXCEPTIONS_PAGE;
+	log_response[6] = LOG_PAGE_TEMPERATURE_PAGE;
+
+	xfer_len = min(alloc_len,
LOG_PAGE_SUPPORTED_LOG_PAGES_LENGTH);
+	res = nvme_trans_copy_to_user(hdr, log_response, xfer_len);
+
+	kfree(log_response);
+ out_mem:
+	return res;
+}
+
+static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
+					struct sg_io_hdr *hdr, int
alloc_len)
+{
+	int res;
+	int xfer_len;
+	u8 *log_response;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_smart_log *smart_log;
+	u8 temp_c;
+	u16 temp_k;
+
+	log_response = kzalloc(LOG_INFO_EXCP_PAGE_LENGTH, GFP_KERNEL);
+	if (log_response == NULL)
+		return -ENOMEM;
+
+	res = nvme_get_log_page(dev, &smart_log);
+	if (res < 0)
+		goto out_free_response;
+
+	if (res != NVME_SC_SUCCESS) {
+		temp_c = LOG_TEMP_UNKNOWN;
+	} else {
+		temp_k = (smart_log->temperature[1] << 8) +
+				(smart_log->temperature[0]);
+		temp_c = temp_k - KELVIN_TEMP_FACTOR;
+	}
+	kfree(smart_log);
+
+	log_response[0] = LOG_PAGE_INFORMATIONAL_EXCEPTIONS_PAGE;
+	/* Subpage=0x00, Page Length MSB=0 */
+	log_response[3] = REMAINING_INFO_EXCP_PAGE_LENGTH;
+	/* Informational Exceptions Log Parameter 1 Start */
+	/* Parameter Code=0x0000 bytes 4,5 */
+	log_response[6] = 0x23; /* DU=0, TSD=1, ETC=0, TMC=0,
FMT_AND_LNK=11b */
+	log_response[7] = 0x04; /* PARAMETER LENGTH */
+	/* Add sense Code and qualifier = 0x00 each */
+	/* Use Temperature from NVMe Get Log Page, convert to C from K
*/
+	log_response[10] = temp_c;
+
+	xfer_len = min(alloc_len, LOG_INFO_EXCP_PAGE_LENGTH);
+	res = nvme_trans_copy_to_user(hdr, log_response, xfer_len);
+
+ out_free_response:
+	kfree(log_response);
+	return res;
+}
+
+static int nvme_trans_log_temperature(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+					int alloc_len)
+{
+	int res;
+	int xfer_len;
+	u8 *log_response;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_smart_log *smart_log;
+	u32 feature_resp;
+	u8 temp_c_cur, temp_c_thresh;
+	u16 temp_k;
+
+	log_response = kzalloc(LOG_TEMP_PAGE_LENGTH, GFP_KERNEL);
+	if (log_response == NULL)
+		return -ENOMEM;
+
+	res = nvme_get_log_page(dev, &smart_log);
+	if (res < 0)
+		goto out_free_response;
+
+	if (res != NVME_SC_SUCCESS) {
+		temp_c_cur = LOG_TEMP_UNKNOWN;
+	} else {
+		temp_k = (smart_log->temperature[1] << 8) +
+				(smart_log->temperature[0]);
+		temp_c_cur = temp_k - KELVIN_TEMP_FACTOR;
+	}
+	kfree(smart_log);
+
+	/* Get Features for Temp Threshold */
+	res = nvme_get_features(dev, NVME_FEAT_TEMP_THRESH, 0, 0,
+								&featu
re_resp);
+	if (res != NVME_SC_SUCCESS)
+		temp_c_thresh = LOG_TEMP_UNKNOWN;
+	else
+		temp_c_thresh = (feature_resp & 0xFFFF) -
KELVIN_TEMP_FACTOR;
+
+	log_response[0] = LOG_PAGE_TEMPERATURE_PAGE;
+	/* Subpage=0x00, Page Length MSB=0 */
+	log_response[3] = REMAINING_TEMP_PAGE_LENGTH;
+	/* Temperature Log Parameter 1 (Temperature) Start */
+	/* Parameter Code = 0x0000 */
+	log_response[6] = 0x01;		/* Format and Linking
= 01b */
+	log_response[7] = 0x02;		/* Parameter Length */
+	/* Use Temperature from NVMe Get Log Page, convert to C from K
*/
+	log_response[9] = temp_c_cur;
+	/* Temperature Log Parameter 2 (Reference Temperature) Start
*/
+	log_response[11] = 0x01;	/* Parameter Code = 0x0001 */
+	log_response[12] = 0x01;	/* Format and Linking = 01b */
+	log_response[13] = 0x02;	/* Parameter Length */
+	/* Use Temperature Thresh from NVMe Get Log Page, convert to C
from K */
+	log_response[15] = temp_c_thresh;
+
+	xfer_len = min(alloc_len, LOG_TEMP_PAGE_LENGTH);
+	res = nvme_trans_copy_to_user(hdr, log_response, xfer_len);
+
+ out_free_response:
+	kfree(log_response);
+	return res;
+}
+
+/* MODE SENSE Helper Functions */
+
+static int nvme_trans_fill_mode_parm_hdr(u8 *resp, int len, u8 cdb10,
u8 llbaa,
+					u16 mode_data_length, u16
blk_desc_len)
+{
+	/* Quick check to make sure I don't stomp on my own memory...
*/
+	if ((cdb10 && len < 8) || (!cdb10 && len < 4))
+		return -EINVAL;
+
+	if (cdb10) {
+		resp[0] = (mode_data_length & 0xFF00) >> 8;
+		resp[1] = (mode_data_length & 0x00FF);
+		resp[3] = 0x10 /* DPOFUA */;
+		resp[4] = llbaa;
+		resp[5] = RESERVED_FIELD;
+		resp[6] = (blk_desc_len & 0xFF00) >> 8;
+		resp[7] = (blk_desc_len & 0x00FF);
+	} else {
+		resp[0] = (mode_data_length & 0x00FF);
+		resp[2] = 0x10 /* DPOFUA */;
+		resp[3] = (blk_desc_len & 0x00FF);
+	}
+
+	return 0;
+}
+
+static int nvme_trans_fill_blk_desc(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+				    u8 *resp, int len, u8 llbaa)
+{
+	int res;
+	int nvme_sc;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_id_ns *id_ns;
+	u8 flbas;
+	u32 lba_length;
+
+	if (llbaa == 0 && len < MODE_PAGE_BLK_DES_LEN)
+		return -EINVAL;
+	else if (llbaa > 0 && len < MODE_PAGE_LLBAA_BLK_DES_LEN)
+		return -EINVAL;
+
+	nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (res)
+		return res;
+
+	flbas = (id_ns->flbas) & 0x0F;
+	lba_length = (1 << (id_ns->lbaf[flbas].ds));
+
+	if (llbaa == 0) {
+		__be32 tmp_cap = cpu_to_be32(le64_to_cpu(id_ns
->ncap));
+		/* Byte 4 is reserved */
+		__be32 tmp_len = cpu_to_be32(lba_length & 0x00FFFFFF);
+
+		memcpy(resp, &tmp_cap, sizeof(u32));
+		memcpy(&resp[4], &tmp_len, sizeof(u32));
+	} else {
+		__be64 tmp_cap = cpu_to_be64(le64_to_cpu(id_ns
->ncap));
+		__be32 tmp_len = cpu_to_be32(lba_length);
+
+		memcpy(resp, &tmp_cap, sizeof(u64));
+		/* Bytes 8, 9, 10, 11 are reserved */
+		memcpy(&resp[12], &tmp_len, sizeof(u32));
+	}
+
+	kfree(id_ns);
+	return res;
+}
+
+static int nvme_trans_fill_control_page(struct nvme_ns *ns,
+					struct sg_io_hdr *hdr, u8
*resp,
+					int len)
+{
+	if (len < MODE_PAGE_CONTROL_LEN)
+		return -EINVAL;
+
+	resp[0] = MODE_PAGE_CONTROL;
+	resp[1] = MODE_PAGE_CONTROL_LEN_FIELD;
+	resp[2] = 0x0E;		/* TST=000b, TMF_ONLY=0,
DPICZ=1,
+				 * D_SENSE=1, GLTSD=1, RLEC=0 */
+	resp[3] = 0x12;		/* Q_ALGO_MODIFIER=1h, NUAR=0,
QERR=01b */
+	/* Byte 4:  VS=0, RAC=0, UA_INT=0, SWP=0 */
+	resp[5] = 0x40;		/* ATO=0, TAS=1, ATMPE=0,
RWWP=0, AUTOLOAD=0 */
+	/* resp[6] and [7] are obsolete, thus zero */
+	resp[8] = 0xFF;		/* Busy timeout period =
0xffff */
+	resp[9] = 0xFF;
+	/* Bytes 10,11: Extended selftest completion time = 0x0000 */
+
+	return 0;
+}
+
+static int nvme_trans_fill_caching_page(struct nvme_ns *ns,
+					struct sg_io_hdr *hdr,
+					u8 *resp, int len)
+{
+	int res = 0;
+	int nvme_sc;
+	struct nvme_dev *dev = ns->dev;
+	u32 feature_resp;
+	u8 vwc;
+
+	if (len < MODE_PAGE_CACHING_LEN)
+		return -EINVAL;
+
+	nvme_sc = nvme_get_features(dev, NVME_FEAT_VOLATILE_WC, 0, 0,
+								&featu
re_resp);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (res)
+		return res;
+
+	vwc = feature_resp & 0x00000001;
+
+	resp[0] = MODE_PAGE_CACHING;
+	resp[1] = MODE_PAGE_CACHING_LEN_FIELD;
+	resp[2] = vwc << 2;
+	return 0;
+}
+
+static int nvme_trans_fill_pow_cnd_page(struct nvme_ns *ns,
+					struct sg_io_hdr *hdr, u8
*resp,
+					int len)
+{
+	if (len < MODE_PAGE_POW_CND_LEN)
+		return -EINVAL;
+
+	resp[0] = MODE_PAGE_POWER_CONDITION;
+	resp[1] = MODE_PAGE_POW_CND_LEN_FIELD;
+	/* All other bytes are zero */
+
+	return 0;
+}
+
+static int nvme_trans_fill_inf_exc_page(struct nvme_ns *ns,
+					struct sg_io_hdr *hdr, u8
*resp,
+					int len)
+{
+	if (len < MODE_PAGE_INF_EXC_LEN)
+		return -EINVAL;
+
+	resp[0] = MODE_PAGE_INFO_EXCEP;
+	resp[1] = MODE_PAGE_INF_EXC_LEN_FIELD;
+	resp[2] = 0x88;
+	/* All other bytes are zero */
+
+	return 0;
+}
+
+static int nvme_trans_fill_all_pages(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+				     u8 *resp, int len)
+{
+	int res;
+	u16 mode_pages_offset_1 = 0;
+	u16 mode_pages_offset_2, mode_pages_offset_3,
mode_pages_offset_4;
+
+	mode_pages_offset_2 = mode_pages_offset_1 +
MODE_PAGE_CACHING_LEN;
+	mode_pages_offset_3 = mode_pages_offset_2 +
MODE_PAGE_CONTROL_LEN;
+	mode_pages_offset_4 = mode_pages_offset_3 +
MODE_PAGE_POW_CND_LEN;
+
+	res = nvme_trans_fill_caching_page(ns, hdr,
&resp[mode_pages_offset_1],
+					MODE_PAGE_CACHING_LEN);
+	if (res)
+		return res;
+	res = nvme_trans_fill_control_page(ns, hdr,
&resp[mode_pages_offset_2],
+					MODE_PAGE_CONTROL_LEN);
+	if (res)
+		return res;
+	res = nvme_trans_fill_pow_cnd_page(ns, hdr,
&resp[mode_pages_offset_3],
+					MODE_PAGE_POW_CND_LEN);
+	if (res)
+		return res;
+	return nvme_trans_fill_inf_exc_page(ns, hdr,
&resp[mode_pages_offset_4],
+					MODE_PAGE_INF_EXC_LEN);
+}
+
+static inline int nvme_trans_get_blk_desc_len(u8 dbd, u8 llbaa)
+{
+	if (dbd == MODE_SENSE_BLK_DESC_ENABLED) {
+		/* SPC-4: len = 8 x Num_of_descriptors if llbaa = 0,
16x if 1 */
+		return 8 * (llbaa + 1) * MODE_SENSE_BLK_DESC_COUNT;
+	} else {
+		return 0;
+	}
+}
+
+static int nvme_trans_mode_page_create(struct nvme_ns *ns,
+					struct sg_io_hdr *hdr, u8
*cmd,
+					u16 alloc_len, u8 cdb10,
+					int (*mode_page_fill_func)
+					(struct nvme_ns *,
+					struct sg_io_hdr *hdr, u8 *,
int),
+					u16 mode_pages_tot_len)
+{
+	int res;
+	int xfer_len;
+	u8 *response;
+	u8 dbd, llbaa;
+	u16 resp_size;
+	int mph_size;
+	u16 mode_pages_offset_1;
+	u16 blk_desc_len, blk_desc_offset, mode_data_length;
+
+	dbd = (cmd[1] & MODE_SENSE_DBD_MASK) >> MODE_SENSE_DBD_SHIFT;
+	llbaa = (cmd[1] & MODE_SENSE_LLBAA_MASK) >>
MODE_SENSE_LLBAA_SHIFT;
+	mph_size = cdb10 ? MODE_SENSE10_MPH_SIZE :
MODE_SENSE6_MPH_SIZE;
+
+	blk_desc_len = nvme_trans_get_blk_desc_len(dbd, llbaa);
+
+	resp_size = mph_size + blk_desc_len + mode_pages_tot_len;
+	/* Refer spc4r34 Table 440 for calculation of Mode data Length
field */
+	mode_data_length = 3 + (3 * cdb10) + blk_desc_len +
mode_pages_tot_len;
+
+	blk_desc_offset = mph_size;
+	mode_pages_offset_1 = blk_desc_offset + blk_desc_len;
+
+	response = kzalloc(resp_size, GFP_KERNEL);
+	if (response == NULL) {
+		res = -ENOMEM;
+		goto out_mem;
+	}
+
+	res = nvme_trans_fill_mode_parm_hdr(&response[0], mph_size,
cdb10,
+					llbaa, mode_data_length,
blk_desc_len);
+	if (res)
+		goto out_free;
+	if (blk_desc_len > 0) {
+		res = nvme_trans_fill_blk_desc(ns, hdr,
+					      
 &response[blk_desc_offset],
+					       blk_desc_len, llbaa);
+		if (res)
+			goto out_free;
+	}
+	res = mode_page_fill_func(ns, hdr,
&response[mode_pages_offset_1],
+					mode_pages_tot_len);
+	if (res)
+		goto out_free;
+
+	xfer_len = min(alloc_len, resp_size);
+	res = nvme_trans_copy_to_user(hdr, response, xfer_len);
+
+ out_free:
+	kfree(response);
+ out_mem:
+	return res;
+}
+
+/* Read Capacity Helper Functions */
+
+static void nvme_trans_fill_read_cap(u8 *response, struct nvme_id_ns
*id_ns,
+								u8
cdb16)
+{
+	u8 flbas;
+	u32 lba_length;
+	u64 rlba;
+	u8 prot_en;
+	u8 p_type_lut[4] = {0, 0, 1, 2};
+	__be64 tmp_rlba;
+	__be32 tmp_rlba_32;
+	__be32 tmp_len;
+
+	flbas = (id_ns->flbas) & 0x0F;
+	lba_length = (1 << (id_ns->lbaf[flbas].ds));
+	rlba = le64_to_cpup(&id_ns->nsze) - 1;
+	(id_ns->dps) ? (prot_en = 0x01) : (prot_en = 0);
+
+	if (!cdb16) {
+		if (rlba > 0xFFFFFFFF)
+			rlba = 0xFFFFFFFF;
+		tmp_rlba_32 = cpu_to_be32(rlba);
+		tmp_len = cpu_to_be32(lba_length);
+		memcpy(response, &tmp_rlba_32, sizeof(u32));
+		memcpy(&response[4], &tmp_len, sizeof(u32));
+	} else {
+		tmp_rlba = cpu_to_be64(rlba);
+		tmp_len = cpu_to_be32(lba_length);
+		memcpy(response, &tmp_rlba, sizeof(u64));
+		memcpy(&response[8], &tmp_len, sizeof(u32));
+		response[12] = (p_type_lut[id_ns->dps & 0x3] << 1) |
prot_en;
+		/* P_I_Exponent = 0x0 | LBPPBE = 0x0 */
+		/* LBPME = 0 | LBPRZ = 0 | LALBA = 0x00 */
+		/* Bytes 16-31 - Reserved */
+	}
+}
+
+/* Start Stop Unit Helper Functions */
+
+static int nvme_trans_power_state(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
+						u8 pc, u8 pcmod, u8
start)
+{
+	int res;
+	int nvme_sc;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_id_ctrl *id_ctrl;
+	int lowest_pow_st;	/* max npss = lowest power consumption
*/
+	unsigned ps_desired = 0;
+
+	nvme_sc = nvme_identify_ctrl(dev, &id_ctrl);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (res)
+		return res;
+
+	lowest_pow_st = max(POWER_STATE_0, (int)(id_ctrl->npss - 1));
+	kfree(id_ctrl);
+
+	switch (pc) {
+	case NVME_POWER_STATE_START_VALID:
+		/* Action unspecified if POWER CONDITION MODIFIER != 0
*/
+		if (pcmod == 0 && start == 0x1)
+			ps_desired = POWER_STATE_0;
+		if (pcmod == 0 && start == 0x0)
+			ps_desired = lowest_pow_st;
+		break;
+	case NVME_POWER_STATE_ACTIVE:
+		/* Action unspecified if POWER CONDITION MODIFIER != 0
*/
+		if (pcmod == 0)
+			ps_desired = POWER_STATE_0;
+		break;
+	case NVME_POWER_STATE_IDLE:
+		/* Action unspecified if POWER CONDITION MODIFIER !=
[0,1,2] */
+		if (pcmod == 0x0)
+			ps_desired = POWER_STATE_1;
+		else if (pcmod == 0x1)
+			ps_desired = POWER_STATE_2;
+		else if (pcmod == 0x2)
+			ps_desired = POWER_STATE_3;
+		break;
+	case NVME_POWER_STATE_STANDBY:
+		/* Action unspecified if POWER CONDITION MODIFIER !=
[0,1] */
+		if (pcmod == 0x0)
+			ps_desired = max(POWER_STATE_0, (lowest_pow_st
- 2));
+		else if (pcmod == 0x1)
+			ps_desired = max(POWER_STATE_0, (lowest_pow_st
- 1));
+		break;
+	case NVME_POWER_STATE_LU_CONTROL:
+	default:
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+				ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
+				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+		break;
+	}
+	nvme_sc = nvme_set_features(dev, NVME_FEAT_POWER_MGMT,
ps_desired, 0,
+				    NULL);
+	return nvme_trans_status_code(hdr, nvme_sc);
+}
+
+static int nvme_trans_send_activate_fw_cmd(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+					u8 buffer_id)
+{
+	struct nvme_command c;
+	int nvme_sc;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_admin_activate_fw;
+	c.common.cdw10[0] = cpu_to_le32(buffer_id |
NVME_FWACT_REPL_ACTV);
+
+	nvme_sc = nvme_submit_sync_cmd(ns->queue, &c, NULL, 0);
+	return nvme_trans_status_code(hdr, nvme_sc);
+}
+
+static int nvme_trans_send_download_fw_cmd(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+					u8 opcode, u32 tot_len, u32
offset,
+					u8 buffer_id)
+{
+	int nvme_sc;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_command c;
+
+	if (hdr->iovec_count > 0) {
+		/* Assuming SGL is not allowed for this command */
+		return nvme_trans_completion(hdr,
+					SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
+					SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+	}
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_admin_download_fw;
+	c.dlfw.numd = cpu_to_le32((tot_len/BYTES_TO_DWORDS) - 1);
+	c.dlfw.offset = cpu_to_le32(offset/BYTES_TO_DWORDS);
+
+	nvme_sc = __nvme_submit_sync_cmd(dev->admin_q, &c, NULL,
+			hdr->dxferp, tot_len, NULL, 0);
+	return nvme_trans_status_code(hdr, nvme_sc);
+}
+
+/* Mode Select Helper Functions */
+
+static inline void nvme_trans_modesel_get_bd_len(u8 *parm_list, u8
cdb10,
+						u16 *bd_len, u8
*llbaa)
+{
+	if (cdb10) {
+		/* 10 Byte CDB */
+		*bd_len = (parm_list[MODE_SELECT_10_BD_OFFSET] << 8) +
+			parm_list[MODE_SELECT_10_BD_OFFSET + 1];
+		*llbaa = parm_list[MODE_SELECT_10_LLBAA_OFFSET] &
+				MODE_SELECT_10_LLBAA_MASK;
+	} else {
+		/* 6 Byte CDB */
+		*bd_len = parm_list[MODE_SELECT_6_BD_OFFSET];
+	}
+}
+
+static void nvme_trans_modesel_save_bd(struct nvme_ns *ns, u8
*parm_list,
+					u16 idx, u16 bd_len, u8 llbaa)
+{
+	u16 bd_num;
+
+	bd_num = bd_len / ((llbaa == 0) ?
+			SHORT_DESC_BLOCK : LONG_DESC_BLOCK);
+	/* Store block descriptor info if a FORMAT UNIT comes later */
+	/* TODO Saving 1st BD info; what to do if multiple BD
received? */
+	if (llbaa == 0) {
+		/* Standard Block Descriptor - spc4r34 7.5.5.1 */
+		ns->mode_select_num_blocks =
+				(parm_list[idx + 1] << 16) +
+				(parm_list[idx + 2] << 8) +
+				(parm_list[idx + 3]);
+
+		ns->mode_select_block_len =
+				(parm_list[idx + 5] << 16) +
+				(parm_list[idx + 6] << 8) +
+				(parm_list[idx + 7]);
+	} else {
+		/* Long LBA Block Descriptor - sbc3r27 6.4.2.3 */
+		ns->mode_select_num_blocks =
+				(((u64)parm_list[idx + 0]) << 56) +
+				(((u64)parm_list[idx + 1]) << 48) +
+				(((u64)parm_list[idx + 2]) << 40) +
+				(((u64)parm_list[idx + 3]) << 32) +
+				(((u64)parm_list[idx + 4]) << 24) +
+				(((u64)parm_list[idx + 5]) << 16) +
+				(((u64)parm_list[idx + 6]) << 8) +
+				((u64)parm_list[idx + 7]);
+
+		ns->mode_select_block_len =
+				(parm_list[idx + 12] << 24) +
+				(parm_list[idx + 13] << 16) +
+				(parm_list[idx + 14] << 8) +
+				(parm_list[idx + 15]);
+	}
+}
+
+static int nvme_trans_modesel_get_mp(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+					u8 *mode_page, u8 page_code)
+{
+	int res = 0;
+	int nvme_sc;
+	struct nvme_dev *dev = ns->dev;
+	unsigned dword11;
+
+	switch (page_code) {
+	case MODE_PAGE_CACHING:
+		dword11 = ((mode_page[2] & CACHING_MODE_PAGE_WCE_MASK)
? 1 : 0);
+		nvme_sc = nvme_set_features(dev,
NVME_FEAT_VOLATILE_WC, dword11,
+					    0, NULL);
+		res = nvme_trans_status_code(hdr, nvme_sc);
+		break;
+	case MODE_PAGE_CONTROL:
+		break;
+	case MODE_PAGE_POWER_CONDITION:
+		/* Verify the OS is not trying to set timers */
+		if ((mode_page[2] & 0x01) != 0 || (mode_page[3] &
0x0F) != 0) {
+			res = nvme_trans_completion(hdr,
+						SAM_STAT_CHECK_CONDITI
ON,
+						ILLEGAL_REQUEST,
+						SCSI_ASC_INVALID_PARAM
ETER,
+						SCSI_ASCQ_CAUSE_NOT_RE
PORTABLE);
+			break;
+		}
+		break;
+	default:
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		break;
+	}
+
+	return res;
+}
+
+static int nvme_trans_modesel_data(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+					u8 *cmd, u16 parm_list_len, u8
pf,
+					u8 sp, u8 cdb10)
+{
+	int res;
+	u8 *parm_list;
+	u16 bd_len;
+	u8 llbaa = 0;
+	u16 index, saved_index;
+	u8 page_code;
+	u16 mp_size;
+
+	/* Get parm list from data-in/out buffer */
+	parm_list = kmalloc(parm_list_len, GFP_KERNEL);
+	if (parm_list == NULL) {
+		res = -ENOMEM;
+		goto out;
+	}
+
+	res = nvme_trans_copy_from_user(hdr, parm_list,
parm_list_len);
+	if (res)
+		goto out_mem;
+
+	nvme_trans_modesel_get_bd_len(parm_list, cdb10, &bd_len,
&llbaa);
+	index = (cdb10) ? (MODE_SELECT_10_MPH_SIZE) :
(MODE_SELECT_6_MPH_SIZE);
+
+	if (bd_len != 0) {
+		/* Block Descriptors present, parse */
+		nvme_trans_modesel_save_bd(ns, parm_list, index,
bd_len, llbaa);
+		index += bd_len;
+	}
+	saved_index = index;
+
+	/* Multiple mode pages may be present; iterate through all */
+	/* In 1st Iteration, don't do NVME Command, only check for CDB
errors */
+	do {
+		page_code = parm_list[index] &
MODE_SELECT_PAGE_CODE_MASK;
+		mp_size = parm_list[index + 1] + 2;
+		if ((page_code != MODE_PAGE_CACHING) &&
+		    (page_code != MODE_PAGE_CONTROL) &&
+		    (page_code != MODE_PAGE_POWER_CONDITION)) {
+			res = nvme_trans_completion(hdr,
+						SAM_STAT_CHECK_CONDITI
ON,
+						ILLEGAL_REQUEST,
+						SCSI_ASC_INVALID_CDB,
+						SCSI_ASCQ_CAUSE_NOT_RE
PORTABLE);
+			goto out_mem;
+		}
+		index += mp_size;
+	} while (index < parm_list_len);
+
+	/* In 2nd Iteration, do the NVME Commands */
+	index = saved_index;
+	do {
+		page_code = parm_list[index] &
MODE_SELECT_PAGE_CODE_MASK;
+		mp_size = parm_list[index + 1] + 2;
+		res = nvme_trans_modesel_get_mp(ns, hdr,
&parm_list[index],
+								page_c
ode);
+		if (res)
+			break;
+		index += mp_size;
+	} while (index < parm_list_len);
+
+ out_mem:
+	kfree(parm_list);
+ out:
+	return res;
+}
+
+/* Format Unit Helper Functions */
+
+static int nvme_trans_fmt_set_blk_size_count(struct nvme_ns *ns,
+					     struct sg_io_hdr *hdr)
+{
+	int res = 0;
+	int nvme_sc;
+	struct nvme_dev *dev = ns->dev;
+	u8 flbas;
+
+	/*
+	 * SCSI Expects a MODE SELECT would have been issued prior to
+	 * a FORMAT UNIT, and the block size and number would be used
+	 * from the block descriptor in it. If a MODE SELECT had not
+	 * been issued, FORMAT shall use the current values for both.
+	 */
+
+	if (ns->mode_select_num_blocks == 0 || ns
->mode_select_block_len == 0) {
+		struct nvme_id_ns *id_ns;
+
+		nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
+		res = nvme_trans_status_code(hdr, nvme_sc);
+		if (res)
+			return res;
+
+		if (ns->mode_select_num_blocks == 0)
+			ns->mode_select_num_blocks = le64_to_cpu(id_ns
->ncap);
+		if (ns->mode_select_block_len == 0) {
+			flbas = (id_ns->flbas) & 0x0F;
+			ns->mode_select_block_len =
+						(1 << (id_ns
->lbaf[flbas].ds));
+		}
+
+		kfree(id_ns);
+	}
+
+	return 0;
+}
+
+static int nvme_trans_fmt_get_parm_header(struct sg_io_hdr *hdr, u8
len,
+					u8 format_prot_info, u8
*nvme_pf_code)
+{
+	int res;
+	u8 *parm_list;
+	u8 pf_usage, pf_code;
+
+	parm_list = kmalloc(len, GFP_KERNEL);
+	if (parm_list == NULL) {
+		res = -ENOMEM;
+		goto out;
+	}
+	res = nvme_trans_copy_from_user(hdr, parm_list, len);
+	if (res)
+		goto out_mem;
+
+	if ((parm_list[FORMAT_UNIT_IMMED_OFFSET] &
+				FORMAT_UNIT_IMMED_MASK) != 0) {
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		goto out_mem;
+	}
+
+	if (len == FORMAT_UNIT_LONG_PARM_LIST_LEN &&
+	    (parm_list[FORMAT_UNIT_PROT_INT_OFFSET] & 0x0F) != 0) {
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		goto out_mem;
+	}
+	pf_usage = parm_list[FORMAT_UNIT_PROT_FIELD_USAGE_OFFSET] &
+			FORMAT_UNIT_PROT_FIELD_USAGE_MASK;
+	pf_code = (pf_usage << 2) | format_prot_info;
+	switch (pf_code) {
+	case 0:
+		*nvme_pf_code = 0;
+		break;
+	case 2:
+		*nvme_pf_code = 1;
+		break;
+	case 3:
+		*nvme_pf_code = 2;
+		break;
+	case 7:
+		*nvme_pf_code = 3;
+		break;
+	default:
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		break;
+	}
+
+ out_mem:
+	kfree(parm_list);
+ out:
+	return res;
+}
+
+static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+				   u8 prot_info)
+{
+	int res;
+	int nvme_sc;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_id_ns *id_ns;
+	u8 i;
+	u8 flbas, nlbaf;
+	u8 selected_lbaf = 0xFF;
+	u32 cdw10 = 0;
+	struct nvme_command c;
+
+	/* Loop thru LBAF's in id_ns to match reqd lbaf, put in cdw10
*/
+	nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (res)
+		return res;
+
+	flbas = (id_ns->flbas) & 0x0F;
+	nlbaf = id_ns->nlbaf;
+
+	for (i = 0; i < nlbaf; i++) {
+		if (ns->mode_select_block_len == (1 << (id_ns
->lbaf[i].ds))) {
+			selected_lbaf = i;
+			break;
+		}
+	}
+	if (selected_lbaf > 0x0F) {
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+				ILLEGAL_REQUEST,
SCSI_ASC_INVALID_PARAMETER,
+				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+	}
+	if (ns->mode_select_num_blocks != le64_to_cpu(id_ns->ncap)) {
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+				ILLEGAL_REQUEST,
SCSI_ASC_INVALID_PARAMETER,
+				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+	}
+
+	cdw10 |= prot_info << 5;
+	cdw10 |= selected_lbaf & 0x0F;
+	memset(&c, 0, sizeof(c));
+	c.format.opcode = nvme_admin_format_nvm;
+	c.format.nsid = cpu_to_le32(ns->ns_id);
+	c.format.cdw10 = cpu_to_le32(cdw10);
+
+	nvme_sc = nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+
+	kfree(id_ns);
+	return res;
+}
+
+static inline u32 nvme_trans_io_get_num_cmds(struct sg_io_hdr *hdr,
+					struct nvme_trans_io_cdb
*cdb_info,
+					u32 max_blocks)
+{
+	/* If using iovecs, send one nvme command per vector */
+	if (hdr->iovec_count > 0)
+		return hdr->iovec_count;
+	else if (cdb_info->xfer_len > max_blocks)
+		return ((cdb_info->xfer_len - 1) / max_blocks) + 1;
+	else
+		return 1;
+}
+
+static u16 nvme_trans_io_get_control(struct nvme_ns *ns,
+					struct nvme_trans_io_cdb
*cdb_info)
+{
+	u16 control = 0;
+
+	/* When Protection information support is added, implement
here */
+
+	if (cdb_info->fua > 0)
+		control |= NVME_RW_FUA;
+
+	return control;
+}
+
+static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
+				struct nvme_trans_io_cdb *cdb_info, u8
is_write)
+{
+	int nvme_sc = NVME_SC_SUCCESS;
+	u32 num_cmds;
+	u64 unit_len;
+	u64 unit_num_blocks;	/* Number of blocks to xfer in each
nvme cmd */
+	u32 retcode;
+	u32 i = 0;
+	u64 nvme_offset = 0;
+	void __user *next_mapping_addr;
+	struct nvme_command c;
+	u8 opcode = (is_write ? nvme_cmd_write : nvme_cmd_read);
+	u16 control;
+	u32 max_blocks = queue_max_hw_sectors(ns->queue);
+
+	num_cmds = nvme_trans_io_get_num_cmds(hdr, cdb_info,
max_blocks);
+
+	/*
+	 * This loop handles two cases.
+	 * First, when an SGL is used in the form of an iovec list:
+	 *   - Use iov_base as the next mapping address for the nvme
command_id
+	 *   - Use iov_len as the data transfer length for the
command.
+	 * Second, when we have a single buffer
+	 *   - If larger than max_blocks, split into chunks, offset
+	 *        each nvme command accordingly.
+	 */
+	for (i = 0; i < num_cmds; i++) {
+		memset(&c, 0, sizeof(c));
+		if (hdr->iovec_count > 0) {
+			struct sg_iovec sgl;
+
+			retcode = copy_from_user(&sgl, hdr->dxferp +
+					i * sizeof(struct sg_iovec),
+					sizeof(struct sg_iovec));
+			if (retcode)
+				return -EFAULT;
+			unit_len = sgl.iov_len;
+			unit_num_blocks = unit_len >> ns->lba_shift;
+			next_mapping_addr = sgl.iov_base;
+		} else {
+			unit_num_blocks = min((u64)max_blocks,
+					(cdb_info->xfer_len -
nvme_offset));
+			unit_len = unit_num_blocks << ns->lba_shift;
+			next_mapping_addr = hdr->dxferp +
+					((1 << ns->lba_shift) *
nvme_offset);
+		}
+
+		c.rw.opcode = opcode;
+		c.rw.nsid = cpu_to_le32(ns->ns_id);
+		c.rw.slba = cpu_to_le64(cdb_info->lba + nvme_offset);
+		c.rw.length = cpu_to_le16(unit_num_blocks - 1);
+		control = nvme_trans_io_get_control(ns, cdb_info);
+		c.rw.control = cpu_to_le16(control);
+
+		if (get_capacity(ns->disk) - unit_num_blocks <
+				cdb_info->lba + nvme_offset) {
+			nvme_sc = NVME_SC_LBA_RANGE;
+			break;
+		}
+		nvme_sc = __nvme_submit_sync_cmd(ns->queue, &c, NULL,
+				next_mapping_addr, unit_len, NULL, 0);
+		if (nvme_sc)
+			break;
+
+		nvme_offset += unit_num_blocks;
+	}
+
+	return nvme_trans_status_code(hdr, nvme_sc);
+}
+
+
+/* SCSI Command Translation Functions */
+
+static int nvme_trans_io(struct nvme_ns *ns, struct sg_io_hdr *hdr, u8
is_write,
+							u8 *cmd)
+{
+	int res = 0;
+	struct nvme_trans_io_cdb cdb_info = { 0, };
+	u8 opcode = cmd[0];
+	u64 xfer_bytes;
+	u64 sum_iov_len = 0;
+	struct sg_iovec sgl;
+	int i;
+	size_t not_copied;
+
+	/*
+	 * The FUA and WPROTECT fields are not supported in 6-byte
CDBs,
+	 * but always in the same place for all others.
+	 */
+	switch (opcode) {
+	case WRITE_6:
+	case READ_6:
+		break;
+	default:
+		cdb_info.fua = cmd[1] & 0x8;
+		cdb_info.prot_info = (cmd[1] & 0xe0) >> 5;
+		if (cdb_info.prot_info && !ns->pi_type) {
+			return nvme_trans_completion(hdr,
+					SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
+					SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		}
+	}
+
+	switch (opcode) {
+	case WRITE_6:
+	case READ_6:
+		cdb_info.lba = get_unaligned_be24(&cmd[1]);
+		cdb_info.xfer_len = cmd[4];
+		if (cdb_info.xfer_len == 0)
+			cdb_info.xfer_len = 256;
+		break;
+	case WRITE_10:
+	case READ_10:
+		cdb_info.lba = get_unaligned_be32(&cmd[2]);
+		cdb_info.xfer_len = get_unaligned_be16(&cmd[7]);
+		break;
+	case WRITE_12:
+	case READ_12:
+		cdb_info.lba = get_unaligned_be32(&cmd[2]);
+		cdb_info.xfer_len = get_unaligned_be32(&cmd[6]);
+		break;
+	case WRITE_16:
+	case READ_16:
+		cdb_info.lba = get_unaligned_be64(&cmd[2]);
+		cdb_info.xfer_len = get_unaligned_be32(&cmd[10]);
+		break;
+	default:
+		/* Will never really reach here */
+		res = -EIO;
+		goto out;
+	}
+
+	/* Calculate total length of transfer (in bytes) */
+	if (hdr->iovec_count > 0) {
+		for (i = 0; i < hdr->iovec_count; i++) {
+			not_copied = copy_from_user(&sgl, hdr->dxferp
+
+						i * sizeof(struct
sg_iovec),
+						sizeof(struct
sg_iovec));
+			if (not_copied)
+				return -EFAULT;
+			sum_iov_len += sgl.iov_len;
+			/* IO vector sizes should be multiples of
block size */
+			if (sgl.iov_len % (1 << ns->lba_shift) != 0) {
+				res = nvme_trans_completion(hdr,
+						SAM_STAT_CHECK_CONDITI
ON,
+						ILLEGAL_REQUEST,
+						SCSI_ASC_INVALID_PARAM
ETER,
+						SCSI_ASCQ_CAUSE_NOT_RE
PORTABLE);
+				goto out;
+			}
+		}
+	} else {
+		sum_iov_len = hdr->dxfer_len;
+	}
+
+	/* As Per sg ioctl howto, if the lengths differ, use the lower
one */
+	xfer_bytes = min(((u64)hdr->dxfer_len), sum_iov_len);
+
+	/* If block count and actual data buffer size dont match,
error out */
+	if (xfer_bytes != (cdb_info.xfer_len << ns->lba_shift)) {
+		res = -EINVAL;
+		goto out;
+	}
+
+	/* Check for 0 length transfer - it is not illegal */
+	if (cdb_info.xfer_len == 0)
+		goto out;
+
+	/* Send NVMe IO Command(s) */
+	res = nvme_trans_do_nvme_io(ns, hdr, &cdb_info, is_write);
+	if (res)
+		goto out;
+
+ out:
+	return res;
+}
+
+static int nvme_trans_inquiry(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
+							u8 *cmd)
+{
+	int res = 0;
+	u8 evpd;
+	u8 page_code;
+	int alloc_len;
+	u8 *inq_response;
+
+	evpd = cmd[1] & 0x01;
+	page_code = cmd[2];
+	alloc_len = get_unaligned_be16(&cmd[3]);
+
+	inq_response = kmalloc(max(alloc_len,
STANDARD_INQUIRY_LENGTH),
+				GFP_KERNEL);
+	if (inq_response == NULL) {
+		res = -ENOMEM;
+		goto out_mem;
+	}
+
+	if (evpd == 0) {
+		if (page_code == INQ_STANDARD_INQUIRY_PAGE) {
+			res = nvme_trans_standard_inquiry_page(ns,
hdr,
+						inq_response,
alloc_len);
+		} else {
+			res = nvme_trans_completion(hdr,
+						SAM_STAT_CHECK_CONDITI
ON,
+						ILLEGAL_REQUEST,
+						SCSI_ASC_INVALID_CDB,
+						SCSI_ASCQ_CAUSE_NOT_RE
PORTABLE);
+		}
+	} else {
+		switch (page_code) {
+		case VPD_SUPPORTED_PAGES:
+			res = nvme_trans_supported_vpd_pages(ns, hdr,
+						inq_response,
alloc_len);
+			break;
+		case VPD_SERIAL_NUMBER:
+			res = nvme_trans_unit_serial_page(ns, hdr,
inq_response,
+								alloc_
len);
+			break;
+		case VPD_DEVICE_IDENTIFIERS:
+			res = nvme_trans_device_id_page(ns, hdr,
inq_response,
+								alloc_
len);
+			break;
+		case VPD_EXTENDED_INQUIRY:
+			res = nvme_trans_ext_inq_page(ns, hdr,
alloc_len);
+			break;
+		case VPD_BLOCK_LIMITS:
+			res = nvme_trans_bdev_limits_page(ns, hdr,
inq_response,
+								alloc_
len);
+			break;
+		case VPD_BLOCK_DEV_CHARACTERISTICS:
+			res = nvme_trans_bdev_char_page(ns, hdr,
alloc_len);
+			break;
+		default:
+			res = nvme_trans_completion(hdr,
+						SAM_STAT_CHECK_CONDITI
ON,
+						ILLEGAL_REQUEST,
+						SCSI_ASC_INVALID_CDB,
+						SCSI_ASCQ_CAUSE_NOT_RE
PORTABLE);
+			break;
+		}
+	}
+	kfree(inq_response);
+ out_mem:
+	return res;
+}
+
+static int nvme_trans_log_sense(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
+							u8 *cmd)
+{
+	int res;
+	u16 alloc_len;
+	u8 pc;
+	u8 page_code;
+
+	if (cmd[1] != LOG_SENSE_CDB_SP_NOT_ENABLED) {
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		goto out;
+	}
+
+	page_code = cmd[2] & LOG_SENSE_CDB_PAGE_CODE_MASK;
+	pc = (cmd[2] & LOG_SENSE_CDB_PC_MASK) >>
LOG_SENSE_CDB_PC_SHIFT;
+	if (pc != LOG_SENSE_CDB_PC_CUMULATIVE_VALUES) {
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		goto out;
+	}
+	alloc_len = get_unaligned_be16(&cmd[7]);
+	switch (page_code) {
+	case LOG_PAGE_SUPPORTED_LOG_PAGES_PAGE:
+		res = nvme_trans_log_supp_pages(ns, hdr, alloc_len);
+		break;
+	case LOG_PAGE_INFORMATIONAL_EXCEPTIONS_PAGE:
+		res = nvme_trans_log_info_exceptions(ns, hdr,
alloc_len);
+		break;
+	case LOG_PAGE_TEMPERATURE_PAGE:
+		res = nvme_trans_log_temperature(ns, hdr, alloc_len);
+		break;
+	default:
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		break;
+	}
+
+ out:
+	return res;
+}
+
+static int nvme_trans_mode_select(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
+							u8 *cmd)
+{
+	u8 cdb10 = 0;
+	u16 parm_list_len;
+	u8 page_format;
+	u8 save_pages;
+
+	page_format = cmd[1] & MODE_SELECT_CDB_PAGE_FORMAT_MASK;
+	save_pages = cmd[1] & MODE_SELECT_CDB_SAVE_PAGES_MASK;
+
+	if (cmd[0] == MODE_SELECT) {
+		parm_list_len = cmd[4];
+	} else {
+		parm_list_len = cmd[7];
+		cdb10 = 1;
+	}
+
+	if (parm_list_len != 0) {
+		/*
+		 * According to SPC-4 r24, a paramter list length
field of 0
+		 * shall not be considered an error
+		 */
+		return nvme_trans_modesel_data(ns, hdr, cmd,
parm_list_len,
+						page_format,
save_pages, cdb10);
+	}
+
+	return 0;
+}
+
+static int nvme_trans_mode_sense(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
+							u8 *cmd)
+{
+	int res = 0;
+	u16 alloc_len;
+	u8 cdb10 = 0;
+
+	if (cmd[0] == MODE_SENSE) {
+		alloc_len = cmd[4];
+	} else {
+		alloc_len = get_unaligned_be16(&cmd[7]);
+		cdb10 = 1;
+	}
+
+	if ((cmd[2] & MODE_SENSE_PAGE_CONTROL_MASK) !=
+			MODE_SENSE_PC_CURRENT_VALUES) {
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		goto out;
+	}
+
+	switch (cmd[2] & MODE_SENSE_PAGE_CODE_MASK) {
+	case MODE_PAGE_CACHING:
+		res = nvme_trans_mode_page_create(ns, hdr, cmd,
alloc_len,
+						cdb10,
+						&nvme_trans_fill_cachi
ng_page,
+						MODE_PAGE_CACHING_LEN)
;
+		break;
+	case MODE_PAGE_CONTROL:
+		res = nvme_trans_mode_page_create(ns, hdr, cmd,
alloc_len,
+						cdb10,
+						&nvme_trans_fill_contr
ol_page,
+						MODE_PAGE_CONTROL_LEN)
;
+		break;
+	case MODE_PAGE_POWER_CONDITION:
+		res = nvme_trans_mode_page_create(ns, hdr, cmd,
alloc_len,
+						cdb10,
+						&nvme_trans_fill_pow_c
nd_page,
+						MODE_PAGE_POW_CND_LEN)
;
+		break;
+	case MODE_PAGE_INFO_EXCEP:
+		res = nvme_trans_mode_page_create(ns, hdr, cmd,
alloc_len,
+						cdb10,
+						&nvme_trans_fill_inf_e
xc_page,
+						MODE_PAGE_INF_EXC_LEN)
;
+		break;
+	case MODE_PAGE_RETURN_ALL:
+		res = nvme_trans_mode_page_create(ns, hdr, cmd,
alloc_len,
+						cdb10,
+						&nvme_trans_fill_all_p
ages,
+						MODE_PAGE_ALL_LEN);
+		break;
+	default:
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		break;
+	}
+
+ out:
+	return res;
+}
+
+static int nvme_trans_read_capacity(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+							u8 *cmd, u8
cdb16)
+{
+	int res;
+	int nvme_sc;
+	u32 alloc_len;
+	u32 resp_size;
+	u32 xfer_len;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_id_ns *id_ns;
+	u8 *response;
+
+	if (cdb16) {
+		alloc_len = get_unaligned_be32(&cmd[10]);
+		resp_size = READ_CAP_16_RESP_SIZE;
+	} else {
+		alloc_len = READ_CAP_10_RESP_SIZE;
+		resp_size = READ_CAP_10_RESP_SIZE;
+	}
+
+	nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
+	res = nvme_trans_status_code(hdr, nvme_sc);
+	if (res)
+		return res;	
+
+	response = kzalloc(resp_size, GFP_KERNEL);
+	if (response == NULL) {
+		res = -ENOMEM;
+		goto out_free_id;
+	}
+	nvme_trans_fill_read_cap(response, id_ns, cdb16);
+
+	xfer_len = min(alloc_len, resp_size);
+	res = nvme_trans_copy_to_user(hdr, response, xfer_len);
+
+	kfree(response);
+ out_free_id:
+	kfree(id_ns);
+	return res;
+}
+
+static int nvme_trans_report_luns(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
+							u8 *cmd)
+{
+	int res;
+	int nvme_sc;
+	u32 alloc_len, xfer_len, resp_size;
+	u8 *response;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_id_ctrl *id_ctrl;
+	u32 ll_length, lun_id;
+	u8 lun_id_offset = REPORT_LUNS_FIRST_LUN_OFFSET;
+	__be32 tmp_len;
+
+	switch (cmd[2]) {
+	default:
+		return nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+	case ALL_LUNS_RETURNED:
+	case ALL_WELL_KNOWN_LUNS_RETURNED:
+	case RESTRICTED_LUNS_RETURNED:
+		nvme_sc = nvme_identify_ctrl(dev, &id_ctrl);
+		res = nvme_trans_status_code(hdr, nvme_sc);
+		if (res)
+			return res;
+
+		ll_length = le32_to_cpu(id_ctrl->nn) * LUN_ENTRY_SIZE;
+		resp_size = ll_length + LUN_DATA_HEADER_SIZE;
+
+		alloc_len = get_unaligned_be32(&cmd[6]);
+		if (alloc_len < resp_size) {
+			res = nvme_trans_completion(hdr,
+					SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+			goto out_free_id;
+		}
+
+		response = kzalloc(resp_size, GFP_KERNEL);
+		if (response == NULL) {
+			res = -ENOMEM;
+			goto out_free_id;
+		}
+
+		/* The first LUN ID will always be 0 per the SAM spec
*/
+		for (lun_id = 0; lun_id < le32_to_cpu(id_ctrl->nn);
lun_id++) {
+			/*
+			 * Set the LUN Id and then increment to the
next LUN
+			 * location in the parameter data.
+			 */
+			__be64 tmp_id = cpu_to_be64(lun_id);
+			memcpy(&response[lun_id_offset], &tmp_id,
sizeof(u64));
+			lun_id_offset += LUN_ENTRY_SIZE;
+		}
+		tmp_len = cpu_to_be32(ll_length);
+		memcpy(response, &tmp_len, sizeof(u32));
+	}
+
+	xfer_len = min(alloc_len, resp_size);
+	res = nvme_trans_copy_to_user(hdr, response, xfer_len);
+
+	kfree(response);
+ out_free_id:
+	kfree(id_ctrl);
+	return res;
+}
+
+static int nvme_trans_request_sense(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+							u8 *cmd)
+{
+	int res;
+	u8 alloc_len, xfer_len, resp_size;
+	u8 desc_format;
+	u8 *response;
+
+	desc_format = cmd[1] & 0x01;
+	alloc_len = cmd[4];
+
+	resp_size = ((desc_format) ? (DESC_FMT_SENSE_DATA_SIZE) :
+					(FIXED_FMT_SENSE_DATA_SIZE));
+	response = kzalloc(resp_size, GFP_KERNEL);
+	if (response == NULL) {
+		res = -ENOMEM;
+		goto out;
+	}
+
+	if (desc_format) {
+		/* Descriptor Format Sense Data */
+		response[0] = DESC_FORMAT_SENSE_DATA;
+		response[1] = NO_SENSE;
+		/* TODO How is LOW POWER CONDITION ON handled? (byte
2) */
+		response[2] = SCSI_ASC_NO_SENSE;
+		response[3] = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		/* SDAT_OVFL = 0 | Additional Sense Length = 0 */
+	} else {
+		/* Fixed Format Sense Data */
+		response[0] = FIXED_SENSE_DATA;
+		/* Byte 1 = Obsolete */
+		response[2] = NO_SENSE; /* FM, EOM, ILI, SDAT_OVFL = 0
*/
+		/* Bytes 3-6 - Information - set to zero */
+		response[7] = FIXED_SENSE_DATA_ADD_LENGTH;
+		/* Bytes 8-11 - Cmd Specific Information - set to zero
*/
+		response[12] = SCSI_ASC_NO_SENSE;
+		response[13] = SCSI_ASCQ_CAUSE_NOT_REPORTABLE;
+		/* Byte 14 = Field Replaceable Unit Code = 0 */
+		/* Bytes 15-17 - SKSV=0; Sense Key Specific = 0 */
+	}
+
+	xfer_len = min(alloc_len, resp_size);
+	res = nvme_trans_copy_to_user(hdr, response, xfer_len);
+
+	kfree(response);
+ out:
+	return res;
+}
+
+static int nvme_trans_security_protocol(struct nvme_ns *ns,
+					struct sg_io_hdr *hdr,
+					u8 *cmd)
+{
+	return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
+				ILLEGAL_REQUEST,
SCSI_ASC_ILLEGAL_COMMAND,
+				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+}
+
+static int nvme_trans_synchronize_cache(struct nvme_ns *ns,
+					struct sg_io_hdr *hdr)
+{
+	int nvme_sc;
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_cmd_flush;
+	c.common.nsid = cpu_to_le32(ns->ns_id);
+
+	nvme_sc = nvme_submit_sync_cmd(ns->queue, &c, NULL, 0);
+	return nvme_trans_status_code(hdr, nvme_sc);
+}
+
+static int nvme_trans_start_stop(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
+							u8 *cmd)
+{
+	u8 immed, pcmod, pc, no_flush, start;
+
+	immed = cmd[1] & 0x01;
+	pcmod = cmd[3] & 0x0f;
+	pc = (cmd[4] & 0xf0) >> 4;
+	no_flush = cmd[4] & 0x04;
+	start = cmd[4] & 0x01;
+
+	if (immed != 0) {
+		return nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+	} else {
+		if (no_flush == 0) {
+			/* Issue NVME FLUSH command prior to START
STOP UNIT */
+			int res = nvme_trans_synchronize_cache(ns,
hdr);
+			if (res)
+				return res;
+		}
+		/* Setup the expected power state transition */
+		return nvme_trans_power_state(ns, hdr, pc, pcmod,
start);
+	}
+}
+
+static int nvme_trans_format_unit(struct nvme_ns *ns, struct sg_io_hdr
*hdr,
+							u8 *cmd)
+{
+	int res;
+	u8 parm_hdr_len = 0;
+	u8 nvme_pf_code = 0;
+	u8 format_prot_info, long_list, format_data;
+
+	format_prot_info = (cmd[1] & 0xc0) >> 6;
+	long_list = cmd[1] & 0x20;
+	format_data = cmd[1] & 0x10;
+
+	if (format_data != 0) {
+		if (format_prot_info != 0) {
+			if (long_list == 0)
+				parm_hdr_len =
FORMAT_UNIT_SHORT_PARM_LIST_LEN;
+			else
+				parm_hdr_len =
FORMAT_UNIT_LONG_PARM_LIST_LEN;
+		}
+	} else if (format_data == 0 && format_prot_info != 0) {
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		goto out;
+	}
+
+	/* Get parm header from data-in/out buffer */
+	/*
+	 * According to the translation spec, the only fields in the
parameter
+	 * list we are concerned with are in the header. So allocate
only that.
+	 */
+	if (parm_hdr_len > 0) {
+		res = nvme_trans_fmt_get_parm_header(hdr,
parm_hdr_len,
+					format_prot_info,
&nvme_pf_code);
+		if (res)
+			goto out;
+	}
+
+	/* Attempt to activate any previously downloaded firmware
image */
+	res = nvme_trans_send_activate_fw_cmd(ns, hdr, 0);
+
+	/* Determine Block size and count and send format command */
+	res = nvme_trans_fmt_set_blk_size_count(ns, hdr);
+	if (res)
+		goto out;
+
+	res = nvme_trans_fmt_send_cmd(ns, hdr, nvme_pf_code);
+
+ out:
+	return res;
+}
+
+static int nvme_trans_test_unit_ready(struct nvme_ns *ns,
+					struct sg_io_hdr *hdr,
+					u8 *cmd)
+{
+	struct nvme_dev *dev = ns->dev;
+
+	if (!(readl(&dev->bar->csts) & NVME_CSTS_RDY))
+		return nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					    NOT_READY,
SCSI_ASC_LUN_NOT_READY,
+					   
 SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+	else
+		return nvme_trans_completion(hdr, SAM_STAT_GOOD,
NO_SENSE, 0, 0);
+}
+
+static int nvme_trans_write_buffer(struct nvme_ns *ns, struct
sg_io_hdr *hdr,
+							u8 *cmd)
+{
+	int res = 0;
+	u32 buffer_offset, parm_list_length;
+	u8 buffer_id, mode;
+
+	parm_list_length = get_unaligned_be24(&cmd[6]);
+	if (parm_list_length % BYTES_TO_DWORDS != 0) {
+		/* NVMe expects Firmware file to be a whole number of
DWORDS */
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		goto out;
+	}
+	buffer_id = cmd[2];
+	if (buffer_id > NVME_MAX_FIRMWARE_SLOT) {
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		goto out;
+	}
+	mode = cmd[1] & 0x1f;
+	buffer_offset = get_unaligned_be24(&cmd[3]);
+
+	switch (mode) {
+	case DOWNLOAD_SAVE_ACTIVATE:
+		res = nvme_trans_send_download_fw_cmd(ns, hdr,
nvme_admin_download_fw,
+						parm_list_length,
buffer_offset,
+						buffer_id);
+		if (res)
+			goto out;
+		res = nvme_trans_send_activate_fw_cmd(ns, hdr,
buffer_id);
+		break;
+	case DOWNLOAD_SAVE_DEFER_ACTIVATE:
+		res = nvme_trans_send_download_fw_cmd(ns, hdr,
nvme_admin_download_fw,
+						parm_list_length,
buffer_offset,
+						buffer_id);
+		break;
+	case ACTIVATE_DEFERRED_MICROCODE:
+		res = nvme_trans_send_activate_fw_cmd(ns, hdr,
buffer_id);
+		break;
+	default:
+		res = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+					ILLEGAL_REQUEST,
SCSI_ASC_INVALID_CDB,
+					SCSI_ASCQ_CAUSE_NOT_REPORTABLE
);
+		break;
+	}
+
+ out:
+	return res;
+}
+
+struct scsi_unmap_blk_desc {
+	__be64	slba;
+	__be32	nlb;
+	u32	resv;
+};
+
+struct scsi_unmap_parm_list {
+	__be16	unmap_data_len;
+	__be16	unmap_blk_desc_data_len;
+	u32	resv;
+	struct scsi_unmap_blk_desc desc[0];
+};
+
+static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
+							u8 *cmd)
+{
+	struct scsi_unmap_parm_list *plist;
+	struct nvme_dsm_range *range;
+	struct nvme_command c;
+	int i, nvme_sc, res;
+	u16 ndesc, list_len;
+
+	list_len = get_unaligned_be16(&cmd[7]);
+	if (!list_len)
+		return -EINVAL;
+
+	plist = kmalloc(list_len, GFP_KERNEL);
+	if (!plist)
+		return -ENOMEM;
+
+	res = nvme_trans_copy_from_user(hdr, plist, list_len);
+	if (res)
+		goto out;
+
+	ndesc = be16_to_cpu(plist->unmap_blk_desc_data_len) >> 4;
+	if (!ndesc || ndesc > 256) {
+		res = -EINVAL;
+		goto out;
+	}
+
+	range = kcalloc(ndesc, sizeof(*range), GFP_KERNEL);
+	if (!range) {
+		res = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < ndesc; i++) {
+		range[i].nlb = cpu_to_le32(be32_to_cpu(plist
->desc[i].nlb));
+		range[i].slba = cpu_to_le64(be64_to_cpu(plist
->desc[i].slba));
+		range[i].cattr = 0;
+	}
+
+	memset(&c, 0, sizeof(c));
+	c.dsm.opcode = nvme_cmd_dsm;
+	c.dsm.nsid = cpu_to_le32(ns->ns_id);
+	c.dsm.nr = cpu_to_le32(ndesc - 1);
+	c.dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
+
+	nvme_sc = nvme_submit_sync_cmd(ns->queue, &c, range,
+			ndesc * sizeof(*range));
+	res = nvme_trans_status_code(hdr, nvme_sc);
+
+	kfree(range);
+ out:
+	kfree(plist);
+	return res;
+}
+
+static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr
*hdr)
+{
+	u8 cmd[BLK_MAX_CDB];
+	int retcode;
+	unsigned int opcode;
+
+	if (hdr->cmdp == NULL)
+		return -EMSGSIZE;
+	if (copy_from_user(cmd, hdr->cmdp, hdr->cmd_len))
+		return -EFAULT;
+
+	/*
+	 * Prime the hdr with good status for scsi commands that don't
require
+	 * an nvme command for translation.
+	 */
+	retcode = nvme_trans_status_code(hdr, NVME_SC_SUCCESS);
+	if (retcode)
+		return retcode;
+
+	opcode = cmd[0];
+
+	switch (opcode) {
+	case READ_6:
+	case READ_10:
+	case READ_12:
+	case READ_16:
+		retcode = nvme_trans_io(ns, hdr, 0, cmd);
+		break;
+	case WRITE_6:
+	case WRITE_10:
+	case WRITE_12:
+	case WRITE_16:
+		retcode = nvme_trans_io(ns, hdr, 1, cmd);
+		break;
+	case INQUIRY:
+		retcode = nvme_trans_inquiry(ns, hdr, cmd);
+		break;
+	case LOG_SENSE:
+		retcode = nvme_trans_log_sense(ns, hdr, cmd);
+		break;
+	case MODE_SELECT:
+	case MODE_SELECT_10:
+		retcode = nvme_trans_mode_select(ns, hdr, cmd);
+		break;
+	case MODE_SENSE:
+	case MODE_SENSE_10:
+		retcode = nvme_trans_mode_sense(ns, hdr, cmd);
+		break;
+	case READ_CAPACITY:
+		retcode = nvme_trans_read_capacity(ns, hdr, cmd, 0);
+		break;
+	case SERVICE_ACTION_IN_16:
+		switch (cmd[1]) {
+		case SAI_READ_CAPACITY_16:
+			retcode = nvme_trans_read_capacity(ns, hdr,
cmd, 1);
+			break;
+		default:
+			goto out;
+		}
+		break;
+	case REPORT_LUNS:
+		retcode = nvme_trans_report_luns(ns, hdr, cmd);
+		break;
+	case REQUEST_SENSE:
+		retcode = nvme_trans_request_sense(ns, hdr, cmd);
+		break;
+	case SECURITY_PROTOCOL_IN:
+	case SECURITY_PROTOCOL_OUT:
+		retcode = nvme_trans_security_protocol(ns, hdr, cmd);
+		break;
+	case START_STOP:
+		retcode = nvme_trans_start_stop(ns, hdr, cmd);
+		break;
+	case SYNCHRONIZE_CACHE:
+		retcode = nvme_trans_synchronize_cache(ns, hdr);
+		break;
+	case FORMAT_UNIT:
+		retcode = nvme_trans_format_unit(ns, hdr, cmd);
+		break;
+	case TEST_UNIT_READY:
+		retcode = nvme_trans_test_unit_ready(ns, hdr, cmd);
+		break;
+	case WRITE_BUFFER:
+		retcode = nvme_trans_write_buffer(ns, hdr, cmd);
+		break;
+	case UNMAP:
+		retcode = nvme_trans_unmap(ns, hdr, cmd);
+		break;
+	default:
+ out:
+		retcode = nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
+				ILLEGAL_REQUEST,
SCSI_ASC_ILLEGAL_COMMAND,
+				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+		break;
+	}
+	return retcode;
+}
+
+int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr)
+{
+	struct sg_io_hdr hdr;
+	int retcode;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (copy_from_user(&hdr, u_hdr, sizeof(hdr)))
+		return -EFAULT;
+	if (hdr.interface_id != 'S')
+		return -EINVAL;
+	if (hdr.cmd_len > BLK_MAX_CDB)
+		return -EINVAL;
+
+	/*
+	 * A positive return code means a NVMe status, which has been
+	 * translated to sense data.
+	 */
+	retcode = nvme_scsi_translate(ns, &hdr);
+	if (retcode < 0)
+		return retcode;
+	if (copy_to_user(u_hdr, &hdr, sizeof(sg_io_hdr_t)) > 0)
+		return -EFAULT;
+	return 0;
+}
+
+int nvme_sg_get_version_num(int __user *ip)
+{
+	return put_user(sg_version_num, ip);
+}
-- 
1.7.1
