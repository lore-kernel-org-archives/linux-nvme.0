From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 15 Apr 2015 14:34:41 +0200
Subject: [PATCH 2/5 v2] blk-mq: Support for Open-Channel SSDs
In-Reply-To: <1429101284-19490-1-git-send-email-m@bjorling.me>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
Message-ID: <1429101284-19490-3-git-send-email-m@bjorling.me>

Open-channel SSDs are devices that share responsibilities with the host
in order to implement and maintain features that typical SSDs keep
strictly in firmware. These include (i) the Flash Translation Layer
(FTL), (ii) bad block management, and (iii) hardware units such as the
flash controller, the interface controller, and large amounts of flash
chips. In this way, Open-channels SSDs exposes direct access to their
physical flash storage, while keeping a subset of the internal features
of SSDs.

LightNVM is a specification that gives support to Open-channel SSDs
LightNVM allows the host to manage data placement, garbage collection,
and parallelism. Device specific responsibilities such as bad block
management, FTL extensions to support atomic IOs, or metadata
persistence are still handled by the device.

The implementation of LightNVM consists of two parts: core and
(multiple) targets. The core implements functionality shared across
targets. This is initialization, teardown and statistics. The targets
implement the interface that exposes physical flash to user-space
applications. Examples of such targets include key-value store,
object-store, as well as traditional block devices, which can be
application-specific.

Contributions in this patch from:

  Javier Gonzalez <javier at paletta.io>
  Jesper Madsen <jmad at itu.dk>

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 block/Kconfig             |  12 +
 block/Makefile            |   2 +-
 block/blk-mq.c            |  12 +-
 block/blk-nvm.c           | 722 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-sysfs.c         |  11 +
 block/blk.h               |  18 ++
 include/linux/bio.h       |   9 +
 include/linux/blk-mq.h    |   4 +-
 include/linux/blk_types.h |  12 +-
 include/linux/blkdev.h    | 218 ++++++++++++++
 include/linux/lightnvm.h  |  56 ++++
 include/uapi/linux/nvm.h  |  70 +++++
 12 files changed, 1140 insertions(+), 6 deletions(-)
 create mode 100644 block/blk-nvm.c
 create mode 100644 include/linux/lightnvm.h
 create mode 100644 include/uapi/linux/nvm.h

diff --git a/block/Kconfig b/block/Kconfig
index 161491d..a3fca8f 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -88,6 +88,18 @@ config BLK_DEV_INTEGRITY
 	T10/SCSI Data Integrity Field or the T13/ATA External Path
 	Protection.  If in doubt, say N.
 
+config BLK_DEV_NVM
+	bool "Block layer Open-Channel SSD support"
+	depends on BLK_DEV
+	default y
+	---help---
+	  Say Y here to get to enable support for Open-channel SSDs.
+
+	  Open-Channel SSDs expose direct access to the underlying non-volatile
+	  memory.
+
+	  This option is required by Open-Channel SSD target drivers.
+
 config BLK_DEV_THROTTLING
 	bool "Block layer bio throttling support"
 	depends on BLK_CGROUP=y
diff --git a/block/Makefile b/block/Makefile
index 00ecc97..66a5826 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -22,4 +22,4 @@ obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o
 obj-$(CONFIG_BLOCK_COMPAT)	+= compat_ioctl.o
 obj-$(CONFIG_BLK_CMDLINE_PARSER)	+= cmdline-parser.o
 obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o
-
+obj-$(CONFIG_BLK_DEV_NVM)  += blk-nvm.o
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f3dd028..58a8a71 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -221,6 +221,9 @@ static void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
 	rq->end_io = NULL;
 	rq->end_io_data = NULL;
 	rq->next_rq = NULL;
+#if CONFIG_BLK_DEV_NVM
+	rq->phys_sector = 0;
+#endif
 
 	ctx->rq_dispatched[rw_is_sync(rw_flags)]++;
 }
@@ -1445,6 +1448,7 @@ static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 	struct blk_mq_tags *tags;
 	unsigned int i, j, entries_per_page, max_order = 4;
 	size_t rq_size, left;
+	unsigned int cmd_size = set->cmd_size;
 
 	tags = blk_mq_init_tags(set->queue_depth, set->reserved_tags,
 				set->numa_node,
@@ -1462,11 +1466,14 @@ static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
 		return NULL;
 	}
 
+	if (set->flags & BLK_MQ_F_NVM)
+		cmd_size += sizeof(struct nvm_per_rq);
+
 	/*
 	 * rq_size is the size of the request plus driver payload, rounded
 	 * to the cacheline size
 	 */
-	rq_size = round_up(sizeof(struct request) + set->cmd_size,
+	rq_size = round_up(sizeof(struct request) + cmd_size,
 				cache_line_size());
 	left = rq_size * set->queue_depth;
 
@@ -1978,6 +1985,9 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 	if (!(set->flags & BLK_MQ_F_SG_MERGE))
 		q->queue_flags |= 1 << QUEUE_FLAG_NO_SG_MERGE;
 
+	if (set->flags & BLK_MQ_F_NVM)
+		q->queue_flags |= 1 << QUEUE_FLAG_NVM;
+
 	q->sg_reserved_size = INT_MAX;
 
 	INIT_WORK(&q->requeue_work, blk_mq_requeue_work);
diff --git a/block/blk-nvm.c b/block/blk-nvm.c
new file mode 100644
index 0000000..722821c
--- /dev/null
+++ b/block/blk-nvm.c
@@ -0,0 +1,722 @@
+/*
+ * blk-nvm.c - Block layer Open-channel SSD integration
+ *
+ * Copyright (C) 2015 IT University of Copenhagen
+ * Initial release: Matias Bjorling <mabj at itu.dk>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; see the file COPYING.  If not, write to
+ * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
+ * USA.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
+#include <linux/list.h>
+#include <linux/types.h>
+#include <linux/sem.h>
+#include <linux/bitmap.h>
+
+#include <linux/lightnvm.h>
+
+#include "blk.h"
+
+static LIST_HEAD(_targets);
+static DECLARE_RWSEM(_lock);
+
+struct nvm_target_type *nvm_find_target_type(const char *name)
+{
+	struct nvm_target_type *tt;
+
+	list_for_each_entry(tt, &_targets, list)
+		if (!strcmp(name, tt->name))
+			return tt;
+
+	return NULL;
+}
+
+int nvm_register_target(struct nvm_target_type *tt)
+{
+	int ret = 0;
+
+	down_write(&_lock);
+	if (nvm_find_target_type(tt->name))
+		ret = -EEXIST;
+	else
+		list_add(&tt->list, &_targets);
+	up_write(&_lock);
+
+	return ret;
+}
+
+void nvm_unregister_target(struct nvm_target_type *tt)
+{
+	if (!tt)
+		return;
+
+	down_write(&_lock);
+	list_del(&tt->list);
+	up_write(&_lock);
+}
+
+static void nvm_reset_block(struct nvm_lun *lun, struct nvm_block *block)
+{
+	spin_lock(&block->lock);
+	bitmap_zero(block->invalid_pages, lun->nr_pages_per_blk);
+	block->next_page = 0;
+	block->nr_invalid_pages = 0;
+	atomic_set(&block->data_cmnt_size, 0);
+	spin_unlock(&block->lock);
+}
+
+/* use blk_nvm_lun_[get/put]_block to administer the blocks in use for each lun.
+ * Whenever a block is in used by an append point, we store it within the
+ * used_list. We then move it back when its free to be used by another append
+ * point.
+ *
+ * The newly claimed block is always added to the back of used_list. As we
+ * assume that the start of used list is the oldest block, and therefore
+ * more likely to contain invalidated pages.
+ */
+struct nvm_block *blk_nvm_get_blk(struct nvm_lun *lun, int is_gc)
+{
+	struct nvm_block *block = NULL;
+
+	BUG_ON(!lun);
+
+	spin_lock(&lun->lock);
+
+	if (list_empty(&lun->free_list)) {
+		pr_err_ratelimited("nvm: lun %u have no free pages available",
+								lun->id);
+		spin_unlock(&lun->lock);
+		goto out;
+	}
+
+	while (!is_gc && lun->nr_free_blocks < lun->reserved_blocks) {
+		spin_unlock(&lun->lock);
+		goto out;
+	}
+
+	block = list_first_entry(&lun->free_list, struct nvm_block, list);
+	list_move_tail(&block->list, &lun->used_list);
+
+	lun->nr_free_blocks--;
+
+	spin_unlock(&lun->lock);
+
+	nvm_reset_block(lun, block);
+
+out:
+	return block;
+}
+EXPORT_SYMBOL(blk_nvm_get_blk);
+
+/* We assume that all valid pages have already been moved when added back to the
+ * free list. We add it last to allow round-robin use of all pages. Thereby
+ * provide simple (naive) wear-leveling.
+ */
+void blk_nvm_put_blk(struct nvm_block *block)
+{
+	struct nvm_lun *lun = block->lun;
+
+	spin_lock(&lun->lock);
+
+	list_move_tail(&block->list, &lun->free_list);
+	lun->nr_free_blocks++;
+
+	spin_unlock(&lun->lock);
+}
+EXPORT_SYMBOL(blk_nvm_put_blk);
+
+sector_t blk_nvm_alloc_addr(struct nvm_block *block)
+{
+	sector_t addr = ADDR_EMPTY;
+
+	spin_lock(&block->lock);
+	if (block_is_full(block))
+		goto out;
+
+	addr = block_to_addr(block) + block->next_page;
+
+	block->next_page++;
+out:
+	spin_unlock(&block->lock);
+	return addr;
+}
+EXPORT_SYMBOL(blk_nvm_alloc_addr);
+
+/* Send erase command to device */
+int blk_nvm_erase_blk(struct nvm_dev *dev, struct nvm_block *block)
+{
+	if (dev->ops->erase_block)
+		return dev->ops->erase_block(dev->q, block->id);
+
+	return 0;
+}
+EXPORT_SYMBOL(blk_nvm_erase_blk);
+
+static void nvm_blocks_free(struct nvm_dev *dev)
+{
+	struct nvm_lun *lun;
+	int i;
+
+	nvm_for_each_lun(dev, lun, i) {
+		if (!lun->blocks)
+			break;
+		vfree(lun->blocks);
+	}
+}
+
+static void nvm_luns_free(struct nvm_dev *dev)
+{
+	kfree(dev->luns);
+}
+
+static int nvm_luns_init(struct nvm_dev *dev)
+{
+	struct nvm_lun *lun;
+	struct nvm_id_chnl *chnl;
+	int i;
+
+	dev->luns = kcalloc(dev->nr_luns, sizeof(struct nvm_lun), GFP_KERNEL);
+	if (!dev->luns)
+		return -ENOMEM;
+
+	nvm_for_each_lun(dev, lun, i) {
+		chnl = &dev->identity.chnls[i];
+		pr_info("nvm: p %u qsize %u gr %u ge %u begin %llu end %llu\n",
+			i, chnl->queue_size, chnl->gran_read, chnl->gran_erase,
+			chnl->laddr_begin, chnl->laddr_end);
+
+		spin_lock_init(&lun->lock);
+
+		INIT_LIST_HEAD(&lun->free_list);
+		INIT_LIST_HEAD(&lun->used_list);
+
+		lun->id = i;
+		lun->dev = dev;
+		lun->chnl = chnl;
+		lun->reserved_blocks = 2; /* for GC only */
+		lun->nr_blocks =
+				(chnl->laddr_end - chnl->laddr_begin + 1) /
+				(chnl->gran_erase / chnl->gran_read);
+		lun->nr_free_blocks = lun->nr_blocks;
+		lun->nr_pages_per_blk = chnl->gran_erase / chnl->gran_write *
+					(chnl->gran_write / dev->sector_size);
+
+		dev->total_pages += lun->nr_blocks * lun->nr_pages_per_blk;
+		dev->total_blocks += lun->nr_blocks;
+
+		if (lun->nr_pages_per_blk >
+				MAX_INVALID_PAGES_STORAGE * BITS_PER_LONG) {
+			pr_err("nvm: number of pages per block too high.");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int nvm_block_map(u64 slba, u64 nlb, u64 *entries, void *private)
+{
+	struct nvm_dev *dev = private;
+	sector_t max_pages = dev->total_pages * (dev->sector_size >> 9);
+	u64 elba = slba + nlb;
+	struct nvm_lun *lun;
+	struct nvm_block *blk;
+	sector_t total_pgs_per_lun = /* each lun have the same configuration */
+		   dev->luns[0].nr_blocks * dev->luns[0].nr_pages_per_blk;
+	u64 i;
+	int lun_id;
+
+	if (unlikely(elba > dev->total_pages)) {
+		pr_err("nvm: L2P data from device is out of bounds!\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < nlb; i++) {
+		u64 pba = le64_to_cpu(entries[i]);
+
+		if (unlikely(pba >= max_pages && pba != U64_MAX)) {
+			pr_err("nvm: L2P data entry is out of bounds!\n");
+			return -EINVAL;
+		}
+
+		/* Address zero is a special one. The first page on a disk is
+		 * protected. As it often holds internal device boot
+		 * information. */
+		if (!pba)
+			continue;
+
+		/* resolve block from physical address */
+		lun_id = pba / total_pgs_per_lun;
+		lun = &dev->luns[lun_id];
+
+		/* Calculate block offset into lun */
+		pba = pba - (total_pgs_per_lun * lun_id);
+		blk = &lun->blocks[pba / lun->nr_pages_per_blk];
+
+		if (!blk->type) {
+			/* at this point, we don't know anything about the
+			 * block. It's up to the FTL on top to re-etablish the
+			 * block state */
+			list_move_tail(&blk->list, &lun->used_list);
+			blk->type = 1;
+			lun->nr_free_blocks--;
+		}
+	}
+
+	return 0;
+}
+
+static int nvm_blocks_init(struct nvm_dev *dev)
+{
+	struct nvm_lun *lun;
+	struct nvm_block *block;
+	sector_t lun_iter, block_iter, cur_block_id = 0;
+	int ret;
+
+	nvm_for_each_lun(dev, lun, lun_iter) {
+		lun->blocks = vzalloc(sizeof(struct nvm_block) *
+						lun->nr_blocks);
+		if (!lun->blocks)
+			return -ENOMEM;
+
+		lun_for_each_block(lun, block, block_iter) {
+			spin_lock_init(&block->lock);
+			INIT_LIST_HEAD(&block->list);
+
+			block->lun = lun;
+			block->id = cur_block_id++;
+
+			/* First block is reserved for device */
+			if (unlikely(lun_iter == 0 && block_iter == 0))
+				continue;
+
+			list_add_tail(&block->list, &lun->free_list);
+		}
+	}
+
+	/* Without bad block table support, we can use the mapping table to get
+	   restore the state of each block. */
+	if (dev->ops->get_l2p_tbl) {
+		ret = dev->ops->get_l2p_tbl(dev->q, 0, dev->total_pages,
+							nvm_block_map, dev);
+		if (ret) {
+			pr_err("nvm: could not read L2P table.\n");
+			pr_warn("nvm: default block initialization");
+		}
+	}
+
+	return 0;
+}
+
+static void nvm_core_free(struct nvm_dev *dev)
+{
+	kfree(dev->identity.chnls);
+	kfree(dev);
+}
+
+static int nvm_core_init(struct nvm_dev *dev, int max_qdepth)
+{
+	dev->nr_luns = dev->identity.nchannels;
+	dev->sector_size = EXPOSED_PAGE_SIZE;
+	INIT_LIST_HEAD(&dev->online_targets);
+
+	return 0;
+}
+
+static void nvm_free(struct nvm_dev *dev)
+{
+	if (!dev)
+		return;
+
+	nvm_blocks_free(dev);
+	nvm_luns_free(dev);
+	nvm_core_free(dev);
+}
+
+int nvm_validate_features(struct nvm_dev *dev)
+{
+	struct nvm_get_features gf;
+	int ret;
+
+	ret = dev->ops->get_features(dev->q, &gf);
+	if (ret)
+		return ret;
+
+	/* Only default configuration is supported.
+	 * I.e. L2P, No ondrive GC and drive performs ECC */
+	if (gf.rsp != 0x0 || gf.ext != 0x0)
+		return -EINVAL;
+
+	return 0;
+}
+
+int nvm_validate_responsibility(struct nvm_dev *dev)
+{
+	if (!dev->ops->set_responsibility)
+		return 0;
+
+	return dev->ops->set_responsibility(dev->q, 0);
+}
+
+int nvm_init(struct nvm_dev *dev)
+{
+	struct blk_mq_tag_set *tag_set = dev->q->tag_set;
+	int max_qdepth;
+	int ret = 0;
+
+	if (!dev->q || !dev->ops)
+		return -EINVAL;
+
+	if (dev->ops->identify(dev->q, &dev->identity)) {
+		pr_err("nvm: device could not be identified\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	max_qdepth = tag_set->queue_depth * tag_set->nr_hw_queues;
+
+	pr_debug("nvm dev: ver %u type %u chnls %u max qdepth: %i\n",
+			dev->identity.ver_id,
+			dev->identity.nvm_type,
+			dev->identity.nchannels,
+			max_qdepth);
+
+	ret = nvm_validate_features(dev);
+	if (ret) {
+		pr_err("nvm: disk features are not supported.");
+		goto err;
+	}
+
+	ret = nvm_validate_responsibility(dev);
+	if (ret) {
+		pr_err("nvm: disk responsibilities are not supported.");
+		goto err;
+	}
+
+	ret = nvm_core_init(dev, max_qdepth);
+	if (ret) {
+		pr_err("nvm: could not initialize core structures.\n");
+		goto err;
+	}
+
+	ret = nvm_luns_init(dev);
+	if (ret) {
+		pr_err("nvm: could not initialize luns\n");
+		goto err;
+	}
+
+	if (!dev->nr_luns) {
+		pr_err("nvm: device did not expose any luns.\n");
+		goto err;
+	}
+
+	ret = nvm_blocks_init(dev);
+	if (ret) {
+		pr_err("nvm: could not initialize blocks\n");
+		goto err;
+	}
+
+	pr_info("nvm: allocating %lu physical pages (%lu KB)\n",
+		dev->total_pages, dev->total_pages * dev->sector_size / 1024);
+	pr_info("nvm: luns: %u\n", dev->nr_luns);
+	pr_info("nvm: blocks: %lu\n", dev->total_blocks);
+	pr_info("nvm: target sector size=%d\n", dev->sector_size);
+
+	return 0;
+err:
+	nvm_free(dev);
+	pr_err("nvm: failed to initialize nvm\n");
+	return ret;
+}
+
+void nvm_exit(struct nvm_dev *dev)
+{
+	nvm_free(dev);
+
+	pr_info("nvm: successfully unloaded\n");
+}
+
+int blk_nvm_register(struct request_queue *q, struct nvm_dev_ops *ops)
+{
+	struct nvm_dev *dev;
+	int ret;
+
+	if (!ops->identify || !ops->get_features)
+		return -EINVAL;
+
+	/* does not yet support multi-page IOs. */
+	blk_queue_max_hw_sectors(q, queue_logical_block_size(q) >> 9);
+
+	dev = kzalloc(sizeof(struct nvm_dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->q = q;
+	dev->ops = ops;
+
+	ret = nvm_init(dev);
+	if (ret)
+		goto err_init;
+
+	q->nvm = dev;
+
+	return 0;
+err_init:
+	kfree(dev);
+	return ret;
+}
+EXPORT_SYMBOL(blk_nvm_register);
+
+void blk_nvm_unregister(struct request_queue *q)
+{
+	if (!blk_queue_nvm(q))
+		return;
+
+	nvm_exit(q->nvm);
+}
+
+static int nvm_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
+							unsigned long arg)
+{
+	return 0;
+}
+
+static int nvm_open(struct block_device *bdev, fmode_t mode)
+{
+	return 0;
+}
+
+static void nvm_release(struct gendisk *disk, fmode_t mode)
+{
+}
+
+static const struct block_device_operations nvm_fops = {
+	.owner		= THIS_MODULE,
+	.ioctl		= nvm_ioctl,
+	.open		= nvm_open,
+	.release	= nvm_release,
+};
+
+static int nvm_create_target(struct gendisk *qdisk, char *ttname, char *tname,
+						int lun_begin, int lun_end)
+{
+	struct request_queue *qqueue = qdisk->queue;
+	struct nvm_dev *qnvm = qqueue->nvm;
+	struct request_queue *tqueue;
+	struct gendisk *tdisk;
+	struct nvm_target_type *tt;
+	struct nvm_target *t;
+	void *targetdata;
+
+	tt = nvm_find_target_type(ttname);
+	if (!tt) {
+		pr_err("nvm: target type %s not found\n", ttname);
+		return -EINVAL;
+	}
+
+	down_write(&_lock);
+	list_for_each_entry(t, &qnvm->online_targets, list) {
+		if (!strcmp(tname, t->disk->disk_name)) {
+			pr_err("nvm: target name already exists.\n");
+			up_write(&_lock);
+			return -EINVAL;
+		}
+	}
+	up_write(&_lock);
+
+	t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
+	if (!t)
+		return -ENOMEM;
+
+	tqueue = blk_alloc_queue_node(GFP_KERNEL, qqueue->node);
+	if (!tqueue)
+		goto err_t;
+	blk_queue_make_request(tqueue, tt->make_rq);
+
+	tdisk = alloc_disk(0);
+	if (!tdisk)
+		goto err_queue;
+
+	sprintf(tdisk->disk_name, "%s", tname);
+	tdisk->flags = GENHD_FL_EXT_DEVT;
+	tdisk->major = 0;
+	tdisk->first_minor = 0;
+	tdisk->fops = &nvm_fops;
+	tdisk->queue = tqueue;
+
+	targetdata = tt->init(qqueue, tqueue, qdisk, tdisk, lun_begin, lun_end);
+	if (IS_ERR(targetdata))
+		goto err_init;
+
+	tdisk->private_data = targetdata;
+	tqueue->queuedata = targetdata;
+
+	blk_queue_prep_rq(qqueue, tt->prep_rq);
+	blk_queue_unprep_rq(qqueue, tt->unprep_rq);
+
+	set_capacity(tdisk, tt->capacity(targetdata));
+	add_disk(tdisk);
+
+	t->type = tt;
+	t->disk = tdisk;
+
+	down_write(&_lock);
+	list_add_tail(&t->list, &qnvm->online_targets);
+	up_write(&_lock);
+
+	return 0;
+err_init:
+	put_disk(tdisk);
+err_queue:
+	blk_cleanup_queue(tqueue);
+err_t:
+	kfree(t);
+	return -ENOMEM;
+}
+
+/* _lock must be taken */
+static void nvm_remove_target(struct nvm_target *t)
+{
+	struct nvm_target_type *tt = t->type;
+	struct gendisk *tdisk = t->disk;
+	struct request_queue *q = tdisk->queue;
+
+	del_gendisk(tdisk);
+	if (tt->exit)
+		tt->exit(tdisk->private_data);
+	blk_cleanup_queue(q);
+
+	put_disk(tdisk);
+
+	list_del(&t->list);
+	kfree(t);
+}
+
+static ssize_t free_blocks_show(struct device *d, struct device_attribute *attr,
+		char *page)
+{
+	struct gendisk *disk = dev_to_disk(d);
+	struct nvm_dev *dev = disk->queue->nvm;
+
+	char *page_start = page;
+	struct nvm_lun *lun;
+	unsigned int i;
+
+	nvm_for_each_lun(dev, lun, i)
+		page += sprintf(page, "%8u\t%u\n", i, lun->nr_free_blocks);
+
+	return page - page_start;
+}
+
+DEVICE_ATTR_RO(free_blocks);
+
+static ssize_t configure_store(struct device *d, struct device_attribute *attr,
+						const char *buf, size_t cnt)
+{
+	struct gendisk *disk = dev_to_disk(d);
+	struct nvm_dev *dev = disk->queue->nvm;
+	char name[255], ttname[255];
+	int lun_begin, lun_end, ret;
+
+	if (cnt >= 255)
+		return -EINVAL;
+
+	ret = sscanf(buf, "%s %s %u:%u", name, ttname, &lun_begin, &lun_end);
+	if (ret != 4) {
+		pr_err("nvm: configure must be in the format of \"name targetname lun_begin:lun_end\".\n");
+		return -EINVAL;
+	}
+
+	if (lun_begin > lun_end || lun_end > dev->nr_luns) {
+		pr_err("nvm: lun out of bound (%u:%u > %u)\n",
+					lun_begin, lun_end, dev->nr_luns);
+		return -EINVAL;
+	}
+
+	ret = nvm_create_target(disk, name, ttname, lun_begin, lun_end);
+	if (ret)
+		pr_err("nvm: configure disk failed\n");
+
+	return cnt;
+}
+DEVICE_ATTR_WO(configure);
+
+static ssize_t remove_store(struct device *d, struct device_attribute *attr,
+						const char *buf, size_t cnt)
+{
+	struct gendisk *disk = dev_to_disk(d);
+	struct nvm_dev *dev = disk->queue->nvm;
+	struct nvm_target *t = NULL;
+	char tname[255];
+	int ret;
+
+	if (cnt >= 255)
+		return -EINVAL;
+
+	ret = sscanf(buf, "%s", tname);
+	if (ret != 1) {
+		pr_err("nvm: remove use the following format \"targetname\".\n");
+		return -EINVAL;
+	}
+
+	down_write(&_lock);
+	list_for_each_entry(t, &dev->online_targets, list) {
+		if (!strcmp(tname, t->disk->disk_name)) {
+			nvm_remove_target(t);
+			ret = 0;
+			break;
+		}
+	}
+	up_write(&_lock);
+
+	if (ret)
+		pr_err("nvm: target \"%s\" doesn't exist.\n", tname);
+
+	return cnt;
+}
+
+DEVICE_ATTR_WO(remove);
+
+static struct attribute *nvm_attrs[] = {
+	&dev_attr_free_blocks.attr,
+	&dev_attr_configure.attr,
+	&dev_attr_remove.attr,
+	NULL,
+};
+
+static struct attribute_group nvm_attribute_group = {
+	.name = "nvm",
+	.attrs = nvm_attrs,
+};
+
+int blk_nvm_init_sysfs(struct device *dev)
+{
+	int ret;
+
+	ret = sysfs_create_group(&dev->kobj, &nvm_attribute_group);
+	if (ret)
+		return ret;
+
+	kobject_uevent(&dev->kobj, KOBJ_CHANGE);
+
+	return 0;
+}
+
+void blk_nvm_remove_sysfs(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &nvm_attribute_group);
+}
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index faaf36a..ad8cf2f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -568,6 +568,12 @@ int blk_register_queue(struct gendisk *disk)
 	if (ret)
 		return ret;
 
+	if (blk_queue_nvm(q)) {
+		ret = blk_nvm_init_sysfs(dev);
+		if (ret)
+			return ret;
+	}
+
 	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
 	if (ret < 0) {
 		blk_trace_remove_sysfs(dev);
@@ -601,6 +607,11 @@ void blk_unregister_queue(struct gendisk *disk)
 	if (WARN_ON(!q))
 		return;
 
+	if (blk_queue_nvm(q)) {
+		blk_nvm_unregister(q);
+		blk_nvm_remove_sysfs(disk_to_dev(disk));
+	}
+
 	if (q->mq_ops)
 		blk_mq_unregister_disk(disk);
 
diff --git a/block/blk.h b/block/blk.h
index 43b0361..3e4abee 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -281,4 +281,22 @@ static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
 #endif /* CONFIG_BLK_DEV_THROTTLING */
 
+#ifdef CONFIG_BLK_DEV_NVM
+struct nvm_target {
+	struct list_head list;
+	struct nvm_target_type *type;
+	struct gendisk *disk;
+};
+
+struct nvm_dev_ops;
+
+extern void blk_nvm_unregister(struct request_queue *);
+extern int blk_nvm_init_sysfs(struct device *);
+extern void blk_nvm_remove_sysfs(struct device *);
+#else
+static void blk_nvm_unregister(struct request_queue *q) { }
+static int blk_nvm_init_sysfs(struct device *) { return 0; }
+static void blk_nvm_remove_sysfs(struct device *) { }
+#endif /* CONFIG_BLK_DEV_NVM */
+
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/bio.h b/include/linux/bio.h
index da3a127..ace0b23 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -354,6 +354,15 @@ static inline void bip_set_seed(struct bio_integrity_payload *bip,
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+#if defined(CONFIG_BLK_DEV_NVM)
+
+/* bio open-channel ssd payload */
+struct bio_nvm_payload {
+	void *private;
+};
+
+#endif /* CONFIG_BLK_DEV_NVM */
+
 extern void bio_trim(struct bio *bio, int offset, int size);
 extern struct bio *bio_split(struct bio *bio, int sectors,
 			     gfp_t gfp, struct bio_set *bs);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d7b39af..75e1497 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -140,13 +140,15 @@ enum {
 	BLK_MQ_RQ_QUEUE_OK	= 0,	/* queued fine */
 	BLK_MQ_RQ_QUEUE_BUSY	= 1,	/* requeue IO for later */
 	BLK_MQ_RQ_QUEUE_ERROR	= 2,	/* end IO with error */
-	BLK_MQ_RQ_QUEUE_DONE	= 3,	/* IO is already handled */
+	BLK_MQ_RQ_QUEUE_DONE	= 3,	/* IO handled by prep */
 
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
 	BLK_MQ_F_SYSFS_UP	= 1 << 3,
 	BLK_MQ_F_DEFER_ISSUE	= 1 << 4,
+	BLK_MQ_F_NVM		= 1 << 5,
+
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index a1b25e3..a619844 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -83,7 +83,10 @@ struct bio {
 		struct bio_integrity_payload *bi_integrity; /* data integrity */
 #endif
 	};
-
+#if defined(CONFIG_BLK_DEV_NVM)
+	struct bio_nvm_payload *bi_nvm; /* open-channel ssd
+								     support */
+#endif
 	unsigned short		bi_vcnt;	/* how many bio_vec's */
 
 	/*
@@ -193,6 +196,8 @@ enum rq_flag_bits {
 	__REQ_HASHED,		/* on IO scheduler merge hash */
 	__REQ_MQ_INFLIGHT,	/* track inflight for MQ */
 	__REQ_NO_TIMEOUT,	/* requests may never expire */
+	__REQ_NVM_MAPPED,	/* NVM mapped this request */
+	__REQ_NVM_NO_INFLIGHT,	/* request should not use inflight protection */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -213,7 +218,7 @@ enum rq_flag_bits {
 #define REQ_COMMON_MASK \
 	(REQ_WRITE | REQ_FAILFAST_MASK | REQ_SYNC | REQ_META | REQ_PRIO | \
 	 REQ_DISCARD | REQ_WRITE_SAME | REQ_NOIDLE | REQ_FLUSH | REQ_FUA | \
-	 REQ_SECURE | REQ_INTEGRITY)
+	 REQ_SECURE | REQ_INTEGRITY | REQ_NVM_NO_INFLIGHT)
 #define REQ_CLONE_MASK		REQ_COMMON_MASK
 
 #define BIO_NO_ADVANCE_ITER_MASK	(REQ_DISCARD|REQ_WRITE_SAME)
@@ -247,5 +252,6 @@ enum rq_flag_bits {
 #define REQ_HASHED		(1ULL << __REQ_HASHED)
 #define REQ_MQ_INFLIGHT		(1ULL << __REQ_MQ_INFLIGHT)
 #define REQ_NO_TIMEOUT		(1ULL << __REQ_NO_TIMEOUT)
-
+#define REQ_NVM_MAPPED		(1ULL << __REQ_NVM_MAPPED)
+#define REQ_NVM_NO_INFLIGHT	(1ULL << __REQ_NVM_NO_INFLIGHT)
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7f9a516..d416fd5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -209,6 +209,9 @@ struct request {
 
 	/* for bidi */
 	struct request *next_rq;
+#if CONFIG_BLK_DEV_NVM
+	sector_t phys_sector;
+#endif
 };
 
 static inline unsigned short req_get_ioprio(struct request *req)
@@ -309,6 +312,10 @@ struct queue_limits {
 	unsigned char		raid_partial_stripes_expensive;
 };
 
+#ifdef CONFIG_BLK_DEV_NVM
+struct nvm_dev;
+#endif
+
 struct request_queue {
 	/*
 	 * Together with queue_head for cacheline sharing
@@ -455,6 +462,9 @@ struct request_queue {
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace	*blk_trace;
 #endif
+#ifdef CONFIG_BLK_DEV_NVM
+	struct nvm_dev *nvm;
+#endif
 	/*
 	 * for flush operations
 	 */
@@ -513,6 +523,7 @@ struct request_queue {
 #define QUEUE_FLAG_INIT_DONE   20	/* queue is initialized */
 #define QUEUE_FLAG_NO_SG_MERGE 21	/* don't attempt to merge SG segments*/
 #define QUEUE_FLAG_SG_GAPS     22	/* queue doesn't support SG gaps */
+#define QUEUE_FLAG_NVM         23	/* open-channel SSD managed queue */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
@@ -601,6 +612,7 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_flags)
 #define blk_queue_secdiscard(q)	(blk_queue_discard(q) && \
 	test_bit(QUEUE_FLAG_SECDISCARD, &(q)->queue_flags))
+#define blk_queue_nvm(q)	test_bit(QUEUE_FLAG_NVM, &(q)->queue_flags)
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
@@ -822,6 +834,7 @@ extern int sg_scsi_ioctl(struct request_queue *, struct gendisk *, fmode_t,
 			 struct scsi_ioctl_command __user *);
 
 extern void blk_queue_bio(struct request_queue *q, struct bio *bio);
+extern void blk_init_request_from_bio(struct request *req, struct bio *bio);
 
 /*
  * A queue has just exitted congestion.  Note this in the global counter of
@@ -902,6 +915,11 @@ static inline unsigned int blk_rq_cur_sectors(const struct request *rq)
 	return blk_rq_cur_bytes(rq) >> 9;
 }
 
+static inline sector_t blk_rq_phys_pos(const struct request *rq)
+{
+	return rq->phys_sector;
+}
+
 static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 						     unsigned int cmd_flags)
 {
@@ -1504,6 +1522,8 @@ extern bool blk_integrity_merge_bio(struct request_queue *, struct request *,
 static inline
 struct blk_integrity *bdev_get_integrity(struct block_device *bdev)
 {
+	if (unlikely(!bdev))
+		return NULL;
 	return bdev->bd_disk->integrity;
 }
 
@@ -1598,6 +1618,204 @@ static inline bool blk_integrity_is_initialized(struct gendisk *g)
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+#ifdef CONFIG_BLK_DEV_NVM
+
+#include <uapi/linux/nvm.h>
+
+typedef int (nvm_l2p_update_fn)(u64, u64, u64 *, void *);
+typedef int (nvm_id_fn)(struct request_queue *, struct nvm_id *);
+typedef int (nvm_get_features_fn)(struct request_queue *,
+				  struct nvm_get_features *);
+typedef int (nvm_set_rsp_fn)(struct request_queue *, u64);
+typedef int (nvm_get_l2p_tbl_fn)(struct request_queue *, u64, u64,
+				 nvm_l2p_update_fn *, void *);
+typedef int (nvm_erase_blk_fn)(struct request_queue *, sector_t);
+
+struct nvm_dev_ops {
+	nvm_id_fn		*identify;
+	nvm_get_features_fn	*get_features;
+	nvm_set_rsp_fn		*set_responsibility;
+	nvm_get_l2p_tbl_fn	*get_l2p_tbl;
+
+	nvm_erase_blk_fn	*erase_block;
+};
+
+struct nvm_blocks;
+
+/*
+ * We assume that the device exposes its channels as a linear address
+ * space. A lun therefore have a phy_addr_start and phy_addr_end that
+ * denotes the start and end. This abstraction is used to let the
+ * open-channel SSD (or any other device) expose its read/write/erase
+ * interface and be administrated by the host system.
+ */
+struct nvm_lun {
+	struct nvm_dev *dev;
+
+	/* lun block lists */
+	struct list_head used_list;	/* In-use blocks */
+	struct list_head free_list;	/* Not used blocks i.e. released
+					 *  and ready for use */
+
+	struct {
+		spinlock_t lock;
+	} ____cacheline_aligned_in_smp;
+
+	struct nvm_block *blocks;
+	struct nvm_id_chnl *chnl;
+
+	int id;
+	int reserved_blocks;
+
+	unsigned int nr_blocks;		/* end_block - start_block. */
+	unsigned int nr_free_blocks;	/* Number of unused blocks */
+
+	int nr_pages_per_blk;
+};
+
+struct nvm_block {
+	/* Management structures */
+	struct list_head list;
+	struct nvm_lun *lun;
+
+	spinlock_t lock;
+
+#define MAX_INVALID_PAGES_STORAGE 8
+	/* Bitmap for invalid page intries */
+	unsigned long invalid_pages[MAX_INVALID_PAGES_STORAGE];
+	/* points to the next writable page within a block */
+	unsigned int next_page;
+	/* number of pages that are invalid, wrt host page size */
+	unsigned int nr_invalid_pages;
+
+	unsigned int id;
+	int type;
+	/* Persistent data structures */
+	atomic_t data_cmnt_size; /* data pages committed to stable storage */
+};
+
+struct nvm_dev {
+	struct nvm_dev_ops *ops;
+	struct request_queue *q;
+
+	struct nvm_id identity;
+
+	struct list_head online_targets;
+
+	/* Open-channel SSD stores extra data after the private driver data */
+	unsigned int drv_cmd_size;
+
+	int nr_luns;
+	struct nvm_lun *luns;
+
+	/*int nr_blks_per_lun;
+	int nr_pages_per_blk;*/
+	/* Calculated/Cached values. These do not reflect the actual usuable
+	 * blocks at run-time. */
+	unsigned long total_pages;
+	unsigned long total_blocks;
+
+	uint32_t sector_size;
+};
+
+/* Logical to physical mapping */
+struct nvm_addr {
+	sector_t addr;
+	struct nvm_block *block;
+};
+
+/* Physical to logical mapping */
+struct nvm_rev_addr {
+	sector_t addr;
+};
+
+struct rrpc_inflight_rq {
+	struct list_head list;
+	sector_t l_start;
+	sector_t l_end;
+};
+
+struct nvm_per_rq {
+	struct rrpc_inflight_rq inflight_rq;
+	struct nvm_addr *addr;
+	unsigned int flags;
+};
+
+typedef void (nvm_tgt_make_rq)(struct request_queue *, struct bio *);
+typedef int (nvm_tgt_prep_rq)(struct request_queue *, struct request *);
+typedef void (nvm_tgt_unprep_rq)(struct request_queue *, struct request *);
+typedef sector_t (nvm_tgt_capacity)(void *);
+typedef void *(nvm_tgt_init_fn)(struct request_queue *, struct request_queue *,
+				struct gendisk *, struct gendisk *, int, int);
+typedef void (nvm_tgt_exit_fn)(void *);
+
+struct nvm_target_type {
+	const char *name;
+	unsigned int version[3];
+
+	/* target entry points */
+	nvm_tgt_make_rq *make_rq;
+	nvm_tgt_prep_rq *prep_rq;
+	nvm_tgt_unprep_rq *unprep_rq;
+	nvm_tgt_capacity *capacity;
+
+	/* module-specific init/teardown */
+	nvm_tgt_init_fn *init;
+	nvm_tgt_exit_fn *exit;
+
+	/* For open-channel SSD internal use */
+	struct list_head list;
+};
+
+extern struct nvm_target_type *nvm_find_target_type(const char *name);
+extern int nvm_register_target(struct nvm_target_type *tt);
+extern void nvm_unregister_target(struct nvm_target_type *tt);
+extern int blk_nvm_register(struct request_queue *,
+						struct nvm_dev_ops *);
+extern struct nvm_block *blk_nvm_get_blk(struct nvm_lun *, int);
+extern void blk_nvm_put_blk(struct nvm_block *block);
+extern int blk_nvm_erase_blk(struct nvm_dev *, struct nvm_block *);
+extern sector_t blk_nvm_alloc_addr(struct nvm_block *);
+static inline struct nvm_dev *blk_nvm_get_dev(struct request_queue *q)
+{
+	return q->nvm;
+}
+#else
+struct nvm_dev_ops;
+struct nvm_lun;
+struct nvm_block;
+struct nvm_target_type;
+
+struct nvm_target_type *nvm_find_target_type(const char *)
+{
+	return NULL;
+}
+int nvm_register_target(struct nvm_target_type *tt) { return -EINVAL; }
+void nvm_unregister_target(struct nvm_target_type *tt) {}
+static inline int blk_nvm_register(struct request_queue *,
+						struct nvm_dev_ops *)
+{
+	return -EINVAL;
+}
+static inline struct nvm_block *blk_nvm_get_blk(struct nvm_lun *, int)
+{
+	return NULL;
+}
+static inline void blk_nvm_put_blk(struct nvm_block *) {}
+static inline int blk_nvm_erase_blk(struct nvm_dev *, struct nvm_block *)
+{
+	return -EINVAL;
+}
+static inline int blk_nvm_get_dev(struct request_queue *)
+{
+	return NULL;
+}
+static inline sector_t blk_nvm_alloc_addr(struct nvm_block *block)
+{
+	return 0;
+}
+#endif /* CONFIG_BLK_DEV_NVM */
+
 struct block_device_operations {
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
new file mode 100644
index 0000000..888d994
--- /dev/null
+++ b/include/linux/lightnvm.h
@@ -0,0 +1,56 @@
+#ifndef NVM_H
+#define NVM_H
+
+#include <linux/blkdev.h>
+#include <linux/types.h>
+
+#define nvm_for_each_lun(dev, lun, i) \
+		for ((i) = 0, lun = &(dev)->luns[0]; \
+			(i) < (dev)->nr_luns; (i)++, lun = &(dev)->luns[(i)])
+
+#define lun_for_each_block(p, b, i) \
+		for ((i) = 0, b = &(p)->blocks[0]; \
+			(i) < (p)->nr_blocks; (i)++, b = &(p)->blocks[(i)])
+
+#define block_for_each_page(b, p) \
+		for ((p)->addr = block_to_addr((b)), (p)->block = (b); \
+			(p)->addr < block_to_addr((b)) \
+				+ (b)->lun->dev->nr_pages_per_blk; \
+			(p)->addr++)
+
+/* We currently assume that we the lightnvm device is accepting data in 512
+ * bytes chunks. This should be set to the smallest command size available for a
+ * given device.
+ */
+#define NVM_SECTOR 512
+#define EXPOSED_PAGE_SIZE 4096
+
+#define NR_PHY_IN_LOG (EXPOSED_PAGE_SIZE / NVM_SECTOR)
+
+#define NVM_MSG_PREFIX "nvm"
+#define ADDR_EMPTY (~0ULL)
+#define LTOP_POISON 0xD3ADB33F
+
+/* core.c */
+
+static inline int block_is_full(struct nvm_block *block)
+{
+	struct nvm_lun *lun = block->lun;
+
+	return block->next_page == lun->nr_pages_per_blk;
+}
+
+static inline sector_t block_to_addr(struct nvm_block *block)
+{
+	struct nvm_lun *lun = block->lun;
+
+	return block->id * lun->nr_pages_per_blk;
+}
+
+static inline struct nvm_lun *paddr_to_lun(struct nvm_dev *dev,
+							sector_t p_addr)
+{
+	return &dev->luns[p_addr / (dev->total_pages / dev->nr_luns)];
+}
+
+#endif
diff --git a/include/uapi/linux/nvm.h b/include/uapi/linux/nvm.h
new file mode 100644
index 0000000..fb95cf5
--- /dev/null
+++ b/include/uapi/linux/nvm.h
@@ -0,0 +1,70 @@
+/*
+ * Definitions for the LightNVM interface
+ * Copyright (c) 2015, IT University of Copenhagen
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef _UAPI_LINUX_LIGHTNVM_H
+#define _UAPI_LINUX_LIGHTNVM_H
+
+#include <linux/types.h>
+
+enum {
+	/* HW Responsibilities */
+	NVM_RSP_L2P	= 0x00,
+	NVM_RSP_GC	= 0x01,
+	NVM_RSP_ECC	= 0x02,
+
+	/* Physical NVM Type */
+	NVM_NVMT_BLK	= 0,
+	NVM_NVMT_BYTE	= 1,
+
+	/* Internal IO Scheduling algorithm */
+	NVM_IOSCHED_CHANNEL	= 0,
+	NVM_IOSCHED_CHIP	= 1,
+
+	/* Status codes */
+	NVM_SUCCESS		= 0,
+	NVM_RSP_NOT_CHANGEABLE	= 1,
+};
+
+struct nvm_id_chnl {
+	u64	laddr_begin;
+	u64	laddr_end;
+	u32	oob_size;
+	u32	queue_size;
+	u32	gran_read;
+	u32	gran_write;
+	u32	gran_erase;
+	u32	t_r;
+	u32	t_sqr;
+	u32	t_w;
+	u32	t_sqw;
+	u32	t_e;
+	u16	chnl_parallelism;
+	u8	io_sched;
+	u8	res[133];
+};
+
+struct nvm_id {
+	u8	ver_id;
+	u8	nvm_type;
+	u16	nchannels;
+	struct nvm_id_chnl *chnls;
+};
+
+struct nvm_get_features {
+	u64	rsp;
+	u64	ext;
+};
+
+#endif /* _UAPI_LINUX_LIGHTNVM_H */
+
-- 
1.9.1
