From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 22 Apr 2015 16:26:52 +0200
Subject: [PATCH v3 3/7] lightnvm: Support for Open-Channel SSDs
In-Reply-To: <1429712816-10336-1-git-send-email-m@bjorling.me>
References: <1429712816-10336-1-git-send-email-m@bjorling.me>
Message-ID: <1429712816-10336-4-git-send-email-m@bjorling.me>

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
 MAINTAINERS                   |   8 +
 drivers/Kconfig               |   2 +
 drivers/Makefile              |   2 +
 drivers/lightnvm/Kconfig      |  16 +
 drivers/lightnvm/Makefile     |   5 +
 drivers/lightnvm/core.c       | 804 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/genhd.h         |   3 +
 include/linux/lightnvm.h      | 312 ++++++++++++++++
 include/uapi/linux/lightnvm.h |  70 ++++
 9 files changed, 1222 insertions(+)
 create mode 100644 drivers/lightnvm/Kconfig
 create mode 100644 drivers/lightnvm/Makefile
 create mode 100644 drivers/lightnvm/core.c
 create mode 100644 include/linux/lightnvm.h
 create mode 100644 include/uapi/linux/lightnvm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index efbcb50..259c755 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5852,6 +5852,14 @@ M:	Sasha Levin <sasha.levin at oracle.com>
 S:	Maintained
 F:	tools/lib/lockdep/
 
+LIGHTNVM PLATFORM SUPPORT
+M:	Matias Bjorling <m at bjorling.me>
+W:	http://github/OpenChannelSSD
+S:	Maintained
+F:	drivers/lightnvm/
+F:	include/linux/lightnvm.h
+F:	include/uapi/linux/lightnvm.h
+
 LINUX FOR IBM pSERIES (RS/6000)
 M:	Paul Mackerras <paulus at au.ibm.com>
 W:	http://www.ibm.com/linux/ltc/projects/ppc
diff --git a/drivers/Kconfig b/drivers/Kconfig
index c0cc96b..da47047 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -42,6 +42,8 @@ source "drivers/net/Kconfig"
 
 source "drivers/isdn/Kconfig"
 
+source "drivers/lightnvm/Kconfig"
+
 # input before char - char/joystick depends on it. As does USB.
 
 source "drivers/input/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 527a6da..6b6928a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -165,3 +165,5 @@ obj-$(CONFIG_RAS)		+= ras/
 obj-$(CONFIG_THUNDERBOLT)	+= thunderbolt/
 obj-$(CONFIG_CORESIGHT)		+= coresight/
 obj-$(CONFIG_ANDROID)		+= android/
+
+obj-$(CONFIG_NVM)		+= lightnvm/
diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
new file mode 100644
index 0000000..1f8412c
--- /dev/null
+++ b/drivers/lightnvm/Kconfig
@@ -0,0 +1,16 @@
+#
+# Open-Channel SSD NVM configuration
+#
+
+menuconfig NVM
+	bool "Open-Channel SSD target support"
+	depends on BLOCK
+	help
+	  Say Y here to get to enable Open-channel SSDs.
+
+	  Open-Channel SSDs implement a set of extension to SSDs, that
+	  exposes direct access to the underlying non-volatile memory.
+
+	  If you say N, all options in this submenu will be skipped and disabled
+	  only do this if you know what you are doing.
+
diff --git a/drivers/lightnvm/Makefile b/drivers/lightnvm/Makefile
new file mode 100644
index 0000000..38185e9
--- /dev/null
+++ b/drivers/lightnvm/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for Open-Channel SSDs.
+#
+
+obj-$(CONFIG_NVM)		:= core.o
diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
new file mode 100644
index 0000000..c2bd222
--- /dev/null
+++ b/drivers/lightnvm/core.c
@@ -0,0 +1,804 @@
+/*
+ * core.c - Open-channel SSD integration core
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
+EXPORT_SYMBOL(nvm_register_target);
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
+EXPORT_SYMBOL(nvm_unregister_target);
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
+/* use nvm_lun_[get/put]_block to administer the blocks in use for each lun.
+ * Whenever a block is in used by an append point, we store it within the
+ * used_list. We then move it back when its free to be used by another append
+ * point.
+ *
+ * The newly claimed block is always added to the back of used_list. As we
+ * assume that the start of used list is the oldest block, and therefore
+ * more likely to contain invalidated pages.
+ */
+struct nvm_block *nvm_get_blk(struct nvm_lun *lun, int is_gc)
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
+EXPORT_SYMBOL(nvm_get_blk);
+
+/* We assume that all valid pages have already been moved when added back to the
+ * free list. We add it last to allow round-robin use of all pages. Thereby
+ * provide simple (naive) wear-leveling.
+ */
+void nvm_put_blk(struct nvm_block *block)
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
+EXPORT_SYMBOL(nvm_put_blk);
+
+sector_t nvm_alloc_addr(struct nvm_block *block)
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
+EXPORT_SYMBOL(nvm_alloc_addr);
+
+/* Send erase command to device */
+int nvm_erase_blk(struct nvm_dev *dev, struct nvm_block *block)
+{
+	if (dev->ops->erase_block)
+		return dev->ops->erase_block(dev->q, block->id);
+
+	return 0;
+}
+EXPORT_SYMBOL(nvm_erase_blk);
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
+		INIT_LIST_HEAD(&lun->bb_list);
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
+static int nvm_block_bb(u32 lun_id, void *bb_bitmap, unsigned int nr_blocks,
+								void *private)
+{
+	struct nvm_dev *dev = private;
+	struct nvm_lun *lun = &dev->luns[lun_id];
+	struct nvm_block *block;
+	int i;
+
+	if (unlikely(bitmap_empty(bb_bitmap, nr_blocks)))
+		return 0;
+
+	i = -1;
+	while ((i = find_next_bit(bb_bitmap, nr_blocks, i + 1)) <
+			nr_blocks) {
+		block = &lun->blocks[i];
+		if (!block) {
+			pr_err("nvm: BB data is out of bounds!\n");
+			return -EINVAL;
+		}
+		list_move_tail(&block->list, &lun->bb_list);
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
+
+		if (dev->ops->get_bb_tbl) {
+			ret = dev->ops->get_bb_tbl(dev->q, lun->id,
+			lun->nr_blocks, nvm_block_bb, dev);
+			if (ret)
+				pr_err("nvm: could not read BB table\n");
+		}
+	}
+
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
+static int nvm_create_target(struct gendisk *bdisk, char *ttname, char *tname,
+						int lun_begin, int lun_end)
+{
+	struct request_queue *qqueue = bdisk->queue;
+	struct nvm_dev *qnvm = bdisk->nvm;
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
+	targetdata = tt->init(bdisk, tdisk, lun_begin, lun_end);
+	if (IS_ERR(targetdata))
+		goto err_init;
+
+	tdisk->private_data = targetdata;
+	tqueue->queuedata = targetdata;
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
+
+static ssize_t free_blocks_show(struct device *d, struct device_attribute *attr,
+		char *page)
+{
+	struct gendisk *disk = dev_to_disk(d);
+	struct nvm_dev *dev = disk->nvm;
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
+	struct nvm_dev *dev = disk->nvm;
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
+	struct nvm_dev *dev = disk->nvm;
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
+int nvm_attach_sysfs(struct gendisk *disk)
+{
+	struct device *dev = disk_to_dev(disk);
+	int ret;
+
+	if (!disk->nvm)
+		return 0;
+
+	ret = sysfs_update_group(&dev->kobj, &nvm_attribute_group);
+	if (ret)
+		return ret;
+
+	kobject_uevent(&dev->kobj, KOBJ_CHANGE);
+
+	return 0;
+}
+EXPORT_SYMBOL(nvm_attach_sysfs);
+
+void nvm_remove_sysfs(struct gendisk *disk)
+{
+	struct device *dev = disk_to_dev(disk);
+
+	sysfs_remove_group(&dev->kobj, &nvm_attribute_group);
+}
+
+int nvm_register(struct request_queue *q, struct gendisk *disk,
+							struct nvm_dev_ops *ops)
+{
+	struct nvm_dev *nvm;
+	int ret;
+
+	if (!ops->identify || !ops->get_features)
+		return -EINVAL;
+
+	/* does not yet support multi-page IOs. */
+	blk_queue_max_hw_sectors(q, queue_logical_block_size(q) >> 9);
+
+	nvm = kzalloc(sizeof(struct nvm_dev), GFP_KERNEL);
+	if (!nvm)
+		return -ENOMEM;
+
+	nvm->q = q;
+	nvm->ops = ops;
+
+	ret = nvm_init(nvm);
+	if (ret)
+		goto err_init;
+
+	disk->nvm = nvm;
+
+	return 0;
+err_init:
+	kfree(nvm);
+	return ret;
+}
+EXPORT_SYMBOL(nvm_register);
+
+void nvm_unregister(struct gendisk *disk)
+{
+	if (!disk->nvm)
+		return;
+
+	nvm_remove_sysfs(disk);
+
+	nvm_exit(disk->nvm);
+}
+EXPORT_SYMBOL(nvm_unregister);
+
+int nvm_prep_rq(struct request *rq, struct nvm_rq_data *rqdata)
+{
+	struct nvm_target_instance *ins;
+	struct bio *bio;
+
+	if (rqdata->phys_sector)
+		return 0;
+
+	bio = rq->bio;
+	if (unlikely(!bio))
+		return 0;
+
+	if (unlikely(!bio->bi_nvm)) {
+		if (bio_data_dir(bio) == WRITE) {
+			pr_warn("nvm: attempting to write without FTL.\n");
+			return NVM_PREP_ERROR;
+		}
+		return NVM_PREP_OK;
+	}
+
+	ins = container_of(bio->bi_nvm, struct nvm_target_instance, payload);
+	/* instance is resolved to the private data struct for target */
+	return ins->tt->prep_rq(rq, rqdata, ins);
+}
+EXPORT_SYMBOL(nvm_prep_rq);
+
+void nvm_unprep_rq(struct request *rq, struct nvm_rq_data *rqdata)
+{
+	struct nvm_target_instance *ins;
+	struct bio *bio;
+
+	if (!rqdata->phys_sector)
+		return;
+
+	bio = rq->bio;
+	if (unlikely(!bio))
+		return;
+
+	ins = container_of(bio->bi_nvm, struct nvm_target_instance, payload);
+	ins->tt->unprep_rq(rq, rqdata, ins);
+}
+EXPORT_SYMBOL(nvm_unprep_rq);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index ec274e0..7d7442e 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -199,6 +199,9 @@ struct gendisk {
 #ifdef  CONFIG_BLK_DEV_INTEGRITY
 	struct blk_integrity *integrity;
 #endif
+#ifdef CONFIG_NVM
+	struct nvm_dev *nvm;
+#endif
 	int node_id;
 };
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
new file mode 100644
index 0000000..be6dca4
--- /dev/null
+++ b/include/linux/lightnvm.h
@@ -0,0 +1,312 @@
+#ifndef NVM_H
+#define NVM_H
+
+enum {
+	NVM_PREP_OK = 0,
+	NVM_PREP_BUSY = 1,
+	NVM_PREP_REQUEUE = 2,
+	NVM_PREP_DONE = 3,
+	NVM_PREP_ERROR = 4,
+};
+
+#ifdef CONFIG_NVM
+
+#include <linux/blkdev.h>
+#include <linux/types.h>
+
+#include <uapi/linux/lightnvm.h>
+
+struct nvm_target {
+	struct list_head list;
+	struct nvm_target_type *type;
+	struct gendisk *disk;
+};
+
+extern void nvm_unregister(struct gendisk *);
+extern int nvm_attach_sysfs(struct gendisk *disk);
+
+typedef int (nvm_l2p_update_fn)(u64, u64, u64 *, void *);
+typedef int (nvm_bb_update_fn)(u32, void *, unsigned int, void *);
+typedef int (nvm_id_fn)(struct request_queue *, struct nvm_id *);
+typedef int (nvm_get_features_fn)(struct request_queue *,
+						struct nvm_get_features *);
+typedef int (nvm_set_rsp_fn)(struct request_queue *, u64);
+typedef int (nvm_get_l2p_tbl_fn)(struct request_queue *, u64, u64,
+				nvm_l2p_update_fn *, void *);
+typedef int (nvm_op_bb_tbl_fn)(struct request_queue *, int, unsigned int,
+				nvm_bb_update_fn *, void *);
+typedef int (nvm_erase_blk_fn)(struct request_queue *, sector_t);
+
+struct nvm_dev_ops {
+	nvm_id_fn		*identify;
+	nvm_get_features_fn	*get_features;
+	nvm_set_rsp_fn		*set_responsibility;
+	nvm_get_l2p_tbl_fn	*get_l2p_tbl;
+	nvm_op_bb_tbl_fn	*set_bb_tbl;
+	nvm_op_bb_tbl_fn	*get_bb_tbl;
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
+					 * and ready for use */
+	struct list_head bb_list;	/* Bad blocks. Mutually exclusive with
+					   free_list and used_list */
+
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
+struct nvm_rq_data {
+		sector_t phys_sector;
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
+typedef int (nvm_tgt_prep_rq)(struct request *, struct nvm_rq_data *, void *);
+typedef void (nvm_tgt_unprep_rq)(struct request *, struct nvm_rq_data *,
+									void *);
+typedef sector_t (nvm_tgt_capacity)(void *);
+typedef void *(nvm_tgt_init_fn)(struct gendisk *, struct gendisk *, int, int);
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
+struct nvm_target_instance {
+	struct bio_nvm_payload payload;
+	struct nvm_target_type *tt;
+};
+
+extern struct nvm_target_type *nvm_find_target_type(const char *);
+extern int nvm_register_target(struct nvm_target_type *);
+extern void nvm_unregister_target(struct nvm_target_type *);
+extern int nvm_register(struct request_queue *, struct gendisk *,
+							struct nvm_dev_ops *);
+extern void nvm_unregister(struct gendisk *);
+extern int nvm_prep_rq(struct request *, struct nvm_rq_data *);
+extern void nvm_unprep_rq(struct request *, struct nvm_rq_data *);
+extern struct nvm_block *nvm_get_blk(struct nvm_lun *, int);
+extern void nvm_put_blk(struct nvm_block *block);
+extern int nvm_erase_blk(struct nvm_dev *, struct nvm_block *);
+extern sector_t nvm_alloc_addr(struct nvm_block *);
+static inline struct nvm_dev *nvm_get_dev(struct gendisk *disk)
+{
+	return disk->nvm;
+}
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
+static inline void nvm_init_rq_data(struct nvm_rq_data *rqdata)
+{
+	rqdata->phys_sector = 0;
+}
+
+#else /* CONFIG_NVM */
+
+struct nvm_dev_ops;
+struct nvm_dev;
+struct nvm_lun;
+struct nvm_block;
+struct nvm_per_rq {
+};
+struct nvm_rq_data {
+};
+struct nvm_target_type;
+struct nvm_target_instance;
+
+static inline struct nvm_target_type *nvm_find_target_type(const char *c)
+{
+	return NULL;
+}
+static inline int nvm_register_target(struct nvm_target_type *tt)
+{
+	return -EINVAL;
+}
+static inline void nvm_unregister_target(struct nvm_target_type *tt) {}
+static inline int nvm_register(struct request_queue *q, struct gendisk *disk,
+							struct nvm_dev_ops *ops)
+{
+	return -EINVAL;
+}
+static inline void nvm_unregister(struct gendisk *disk) {}
+static inline int nvm_prep_rq(struct request *rq, struct nvm_rq_data *rqdata)
+{
+	return -EINVAL;
+}
+static inline void nvm_unprep_rq(struct request *rq, struct nvm_rq_data *rqdata)
+{
+}
+static inline struct nvm_block *nvm_get_blk(struct nvm_lun *lun, int is_gc)
+{
+	return NULL;
+}
+static inline void nvm_put_blk(struct nvm_block *blk) {}
+static inline int nvm_erase_blk(struct nvm_dev *dev, struct nvm_block *blk)
+{
+	return -EINVAL;
+}
+static inline sector_t nvm_alloc_addr(struct nvm_block *blk)
+{
+	return 0;
+}
+static inline struct nvm_dev *nvm_get_dev(struct gendisk *disk)
+{
+	return NULL;
+}
+static inline void nvm_init_rq_data(struct nvm_rq_data *rqdata) { }
+static inline int nvm_attach_sysfs(struct gendisk *dev) { return 0; }
+
+
+#endif /* CONFIG_NVM */
+#endif /* LIGHTNVM.H */
diff --git a/include/uapi/linux/lightnvm.h b/include/uapi/linux/lightnvm.h
new file mode 100644
index 0000000..fb95cf5
--- /dev/null
+++ b/include/uapi/linux/lightnvm.h
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
