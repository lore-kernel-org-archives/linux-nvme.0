From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Fri,  7 Aug 2015 16:29:47 +0200
Subject: [PATCH v7 1/5] lightnvm: Support for Open-Channel SSDs
In-Reply-To: <1438957791-24632-1-git-send-email-mb@lightnvm.io>
References: <1438957791-24632-1-git-send-email-mb@lightnvm.io>
Message-ID: <1438957791-24632-2-git-send-email-mb@lightnvm.io>

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

  Javier Gonzalez <jg at lightnvm.io>
  Jesper Madsen <jmad at itu.dk>

Signed-off-by: Matias Bj?rling <mb at lightnvm.io>
---
 MAINTAINERS               |   8 +
 drivers/Kconfig           |   2 +
 drivers/Makefile          |   5 +
 drivers/lightnvm/Kconfig  |  16 ++
 drivers/lightnvm/Makefile |   5 +
 drivers/lightnvm/core.c   | 590 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/lightnvm.h  | 335 ++++++++++++++++++++++++++
 7 files changed, 961 insertions(+)
 create mode 100644 drivers/lightnvm/Kconfig
 create mode 100644 drivers/lightnvm/Makefile
 create mode 100644 drivers/lightnvm/core.c
 create mode 100644 include/linux/lightnvm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d3d55c..d149104 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6162,6 +6162,14 @@ S:	Supported
 F:	drivers/nvdimm/pmem.c
 F:	include/linux/pmem.h
 
+LIGHTNVM PLATFORM SUPPORT
+M:	Matias Bjorling <mb at lightnvm.io>
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
index 6e973b8..3992902 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -42,6 +42,8 @@ source "drivers/net/Kconfig"
 
 source "drivers/isdn/Kconfig"
 
+source "drivers/lightnvm/Kconfig"
+
 # input before char - char/joystick depends on it. As does USB.
 
 source "drivers/input/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index b64b49f..75978ab 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -63,6 +63,10 @@ obj-$(CONFIG_FB_I810)           += video/fbdev/i810/
 obj-$(CONFIG_FB_INTEL)          += video/fbdev/intelfb/
 
 obj-$(CONFIG_PARPORT)		+= parport/
+
+# lightnvm/ comes before block to initialize bm before usage
+obj-$(CONFIG_NVM)		+= lightnvm/
+
 obj-y				+= base/ block/ misc/ mfd/ nfc/
 obj-$(CONFIG_LIBNVDIMM)		+= nvdimm/
 obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
@@ -165,3 +169,4 @@ obj-$(CONFIG_RAS)		+= ras/
 obj-$(CONFIG_THUNDERBOLT)	+= thunderbolt/
 obj-$(CONFIG_CORESIGHT)		+= hwtracing/coresight/
 obj-$(CONFIG_ANDROID)		+= android/
+
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
index 0000000..6499922
--- /dev/null
+++ b/drivers/lightnvm/core.c
@@ -0,0 +1,590 @@
+/*
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
+#include <linux/module.h>
+
+#include <linux/lightnvm.h>
+
+static LIST_HEAD(nvm_targets);
+static LIST_HEAD(nvm_bms);
+static LIST_HEAD(nvm_devices);
+static DECLARE_RWSEM(nvm_lock);
+
+struct nvm_tgt_type *nvm_find_target_type(const char *name)
+{
+	struct nvm_tgt_type *tt;
+
+	list_for_each_entry(tt, &nvm_targets, list)
+		if (!strcmp(name, tt->name))
+			return tt;
+
+	return NULL;
+}
+
+int nvm_register_target(struct nvm_tgt_type *tt)
+{
+	int ret = 0;
+
+	down_write(&nvm_lock);
+	if (nvm_find_target_type(tt->name))
+		ret = -EEXIST;
+	else
+		list_add(&tt->list, &nvm_targets);
+	up_write(&nvm_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(nvm_register_target);
+
+void nvm_unregister_target(struct nvm_tgt_type *tt)
+{
+	if (!tt)
+		return;
+
+	down_write(&nvm_lock);
+	list_del(&tt->list);
+	up_write(&nvm_lock);
+}
+EXPORT_SYMBOL(nvm_unregister_target);
+
+void *nvm_alloc_ppalist(struct nvm_dev *dev, gfp_t mem_flags,
+							dma_addr_t *dma_handler)
+{
+	return dev->ops->alloc_ppalist(dev->q, dev->ppalist_pool, mem_flags,
+								dma_handler);
+}
+EXPORT_SYMBOL(nvm_alloc_ppalist);
+
+void nvm_free_ppalist(struct nvm_dev *dev, void *ppa_list,
+							dma_addr_t dma_handler)
+{
+	dev->ops->free_ppalist(dev->ppalist_pool, ppa_list, dma_handler);
+}
+EXPORT_SYMBOL(nvm_free_ppalist);
+
+struct nvm_bm_type *nvm_find_bm_type(const char *name)
+{
+	struct nvm_bm_type *bt;
+
+	list_for_each_entry(bt, &nvm_bms, list)
+		if (!strcmp(name, bt->name))
+			return bt;
+
+	return NULL;
+}
+
+int nvm_register_bm(struct nvm_bm_type *bt)
+{
+	int ret = 0;
+
+	down_write(&nvm_lock);
+	if (nvm_find_bm_type(bt->name))
+		ret = -EEXIST;
+	else
+		list_add(&bt->list, &nvm_bms);
+	up_write(&nvm_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(nvm_register_bm);
+
+void nvm_unregister_bm(struct nvm_bm_type *bt)
+{
+	if (!bt)
+		return;
+
+	down_write(&nvm_lock);
+	list_del(&bt->list);
+	up_write(&nvm_lock);
+}
+EXPORT_SYMBOL(nvm_unregister_bm);
+
+struct nvm_dev *nvm_find_nvm_dev(const char *name)
+{
+	struct nvm_dev *dev;
+
+	list_for_each_entry(dev, &nvm_devices, devices)
+		if (!strcmp(name, dev->name))
+			return dev;
+
+	return NULL;
+}
+
+struct nvm_block *nvm_get_blk(struct nvm_dev *dev, struct nvm_lun *lun,
+							unsigned long flags)
+{
+	return dev->bm->get_blk(dev, lun, flags);
+}
+EXPORT_SYMBOL(nvm_get_blk);
+
+/* Assumes that all valid pages have already been moved on release to bm */
+void nvm_put_blk(struct nvm_dev *dev, struct nvm_block *blk)
+{
+	return dev->bm->put_blk(dev, blk);
+}
+EXPORT_SYMBOL(nvm_put_blk);
+
+int nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
+{
+	return dev->ops->submit_io(dev->q, rqd);
+}
+EXPORT_SYMBOL(nvm_submit_io);
+
+/* Send erase command to device */
+int nvm_erase_blk(struct nvm_dev *dev, struct nvm_block *blk)
+{
+	return dev->bm->erase_blk(dev, blk);
+}
+EXPORT_SYMBOL(nvm_erase_blk);
+
+static void nvm_core_free(struct nvm_dev *dev)
+{
+	kfree(dev->identity.chnls);
+	kfree(dev);
+}
+
+static int nvm_core_init(struct nvm_dev *dev)
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
+	if (dev->bm)
+		dev->bm->unregister_bm(dev);
+
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
+	dev->features = gf;
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
+	struct nvm_bm_type *bt;
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
+	pr_debug("nvm dev: ver %u type %u chnls %u\n",
+			dev->identity.ver_id,
+			dev->identity.nvm_type,
+			dev->identity.nchannels);
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
+	ret = nvm_core_init(dev);
+	if (ret) {
+		pr_err("nvm: could not initialize core structures.\n");
+		goto err;
+	}
+
+	if (!dev->nr_luns) {
+		pr_err("nvm: device did not expose any luns.\n");
+		goto err;
+	}
+
+	/* register with device with a supported BM */
+	list_for_each_entry(bt, &nvm_bms, list) {
+		ret = bt->register_bm(dev);
+		if (ret < 0)
+			goto err; /* initialization failed */
+		if (ret > 0) {
+			dev->bm = bt;
+			break; /* successfully initialized */
+		}
+	}
+
+	if (!ret) {
+		pr_info("nvm: no compatible bm was found.\n");
+		return 0;
+	}
+
+	pr_info("nvm: registered %s with luns: %u blocks: %lu sector size: %d\n",
+		dev->name, dev->nr_luns, dev->total_blocks, dev->sector_size);
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
+	if (dev->ppalist_pool)
+		dev->ops->destroy_ppa_pool(dev->ppalist_pool);
+	nvm_free(dev);
+
+	pr_info("nvm: successfully unloaded\n");
+}
+
+static const struct block_device_operations nvm_fops = {
+	.owner		= THIS_MODULE,
+};
+
+static int nvm_create_target(struct nvm_dev *dev, char *ttname, char *tname,
+						int lun_begin, int lun_end)
+{
+	struct request_queue *tqueue;
+	struct gendisk *tdisk;
+	struct nvm_tgt_type *tt;
+	struct nvm_target *t;
+	void *targetdata;
+
+	tt = nvm_find_target_type(ttname);
+	if (!tt) {
+		pr_err("nvm: target type %s not found\n", ttname);
+		return -EINVAL;
+	}
+
+	down_write(&nvm_lock);
+	list_for_each_entry(t, &dev->online_targets, list) {
+		if (!strcmp(tname, t->disk->disk_name)) {
+			pr_err("nvm: target name already exists.\n");
+			up_write(&nvm_lock);
+			return -EINVAL;
+		}
+	}
+	up_write(&nvm_lock);
+
+	t = kmalloc(sizeof(struct nvm_target), GFP_KERNEL);
+	if (!t)
+		return -ENOMEM;
+
+	tqueue = blk_alloc_queue_node(GFP_KERNEL, dev->q->node);
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
+	targetdata = tt->init(dev, tdisk, lun_begin, lun_end);
+	if (IS_ERR(targetdata))
+		goto err_init;
+
+	tdisk->private_data = targetdata;
+	tqueue->queuedata = targetdata;
+
+	blk_queue_max_hw_sectors(tqueue, 8 * dev->ops->max_phys_sect);
+
+	set_capacity(tdisk, tt->capacity(targetdata));
+	add_disk(tdisk);
+
+	t->type = tt;
+	t->disk = tdisk;
+
+	down_write(&nvm_lock);
+	list_add_tail(&t->list, &dev->online_targets);
+	up_write(&nvm_lock);
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
+static void nvm_remove_target(struct nvm_target *t)
+{
+	struct nvm_tgt_type *tt = t->type;
+	struct gendisk *tdisk = t->disk;
+	struct request_queue *q = tdisk->queue;
+
+	lockdep_assert_held(&nvm_lock);
+
+	del_gendisk(tdisk);
+	if (tt->exit)
+		tt->exit(tdisk->private_data);
+
+	blk_cleanup_queue(q);
+
+	put_disk(tdisk);
+
+	list_del(&t->list);
+	kfree(t);
+}
+
+static int nvm_configure_show(const char *val)
+{
+	struct nvm_dev *dev;
+	char opcode, devname[DISK_NAME_LEN];
+	int ret;
+
+	ret = sscanf(val, "%c %s", &opcode, devname);
+	if (ret != 2) {
+		pr_err("nvm: invalid command. Use \"opcode devicename\".\n");
+		return -EINVAL;
+	}
+
+	dev = nvm_find_nvm_dev(devname);
+	if (!dev) {
+		pr_err("nvm: device not found\n");
+		return -EINVAL;
+	}
+
+	if (!dev->bm)
+		return 0;
+
+	dev->bm->free_blocks_print(dev);
+
+	return 0;
+}
+
+static int nvm_configure_del(const char *val)
+{
+	struct nvm_target *t = NULL;
+	struct nvm_dev *dev;
+	char opcode, tname[255];
+	int ret;
+
+	ret = sscanf(val, "%c %s", &opcode, tname);
+	if (ret != 2) {
+		pr_err("nvm: invalid command. Use \"d targetname\".\n");
+		return -EINVAL;
+	}
+
+	down_write(&nvm_lock);
+	list_for_each_entry(dev, &nvm_devices, devices)
+		list_for_each_entry(t, &dev->online_targets, list) {
+			if (!strcmp(tname, t->disk->disk_name)) {
+				nvm_remove_target(t);
+				ret = 0;
+				break;
+			}
+		}
+	up_write(&nvm_lock);
+
+	if (ret) {
+		pr_err("nvm: target \"%s\" doesn't exist.\n", tname);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nvm_configure_add(const char *val)
+{
+	struct nvm_dev *dev;
+	char opcode, devname[DISK_NAME_LEN], tgtengine[255], tname[255];
+	int lun_begin, lun_end, ret;
+
+	ret = sscanf(val, "%c %s %s %s %u:%u", &opcode, devname, tgtengine,
+						tname, &lun_begin, &lun_end);
+	if (ret != 6) {
+		pr_err("nvm: invalid command. Use \"opcode device name tgtengine lun_begin:lun_end\".\n");
+		return -EINVAL;
+	}
+
+	dev = nvm_find_nvm_dev(devname);
+	if (!dev) {
+		pr_err("nvm: device not found\n");
+		return -EINVAL;
+	}
+
+	if (lun_begin > lun_end || lun_end > dev->nr_luns) {
+		pr_err("nvm: lun out of bound (%u:%u > %u)\n",
+					lun_begin, lun_end, dev->nr_luns);
+		return -EINVAL;
+	}
+
+	return nvm_create_target(dev, tname, tgtengine, lun_begin, lun_end);
+}
+
+/* Exposes administrative interface through /sys/module/lnvm/configure_by_str */
+static int nvm_configure_by_str_event(const char *val,
+					const struct kernel_param *kp)
+{
+	char opcode;
+	int ret;
+
+	ret = sscanf(val, "%c", &opcode);
+	if (ret != 1) {
+		pr_err("nvm: configure must be in the format of \"opcode ...\"\n");
+		return -EINVAL;
+	}
+
+	switch (opcode) {
+	case 'a':
+		return nvm_configure_add(val);
+	case 'd':
+		return nvm_configure_del(val);
+	case 's':
+		return nvm_configure_show(val);
+	default:
+		pr_err("nvm: invalid opcode.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nvm_configure_get(char *buf, const struct kernel_param *kp)
+{
+	int sz = 0;
+	char *buf_start = buf;
+	struct nvm_dev *dev;
+
+	buf += sprintf(buf, "available devices:\n");
+	down_write(&nvm_lock);
+	list_for_each_entry(dev, &nvm_devices, devices) {
+		if (sz > 4095 - DISK_NAME_LEN)
+			break;
+		buf += sprintf(buf, " %s\n", dev->name);
+	}
+	up_write(&nvm_lock);
+
+	return buf - buf_start - 1;
+}
+
+static const struct kernel_param_ops nvm_configure_by_str_event_param_ops = {
+	.set	= nvm_configure_by_str_event,
+	.get	= nvm_configure_get,
+};
+
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX	"lnvm."
+
+module_param_cb(configure_debug, &nvm_configure_by_str_event_param_ops, NULL,
+									0644);
+
+int nvm_register(struct request_queue *q, char *disk_name,
+							struct nvm_dev_ops *ops)
+{
+	struct nvm_dev *dev;
+	int ret;
+
+	if (!ops->identify || !ops->get_features)
+		return -EINVAL;
+
+	dev = kzalloc(sizeof(struct nvm_dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->q = q;
+	dev->ops = ops;
+	strncpy(dev->name, disk_name, DISK_NAME_LEN);
+
+	ret = nvm_init(dev);
+	if (ret)
+		goto err_init;
+
+	down_write(&nvm_lock);
+	list_add(&dev->devices, &nvm_devices);
+	up_write(&nvm_lock);
+
+	if (dev->ops->max_phys_sect > 256) {
+		pr_info("nvm: maximum number of sectors supported in target is 255. max_phys_sect set to 255\n");
+		dev->ops->max_phys_sect = 255;
+	}
+
+	if (dev->ops->max_phys_sect > 1) {
+		dev->ppalist_pool = dev->ops->create_ppa_pool(dev->q);
+		if (!dev->ppalist_pool) {
+			pr_err("nvm: could not create ppa pool\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+err_init:
+	kfree(dev);
+	return ret;
+}
+EXPORT_SYMBOL(nvm_register);
+
+void nvm_unregister(char *disk_name)
+{
+	struct nvm_dev *dev = nvm_find_nvm_dev(disk_name);
+
+	if (!dev) {
+		pr_err("nvm: could not find device %s on unregister\n",
+								disk_name);
+		return;
+	}
+
+	nvm_exit(dev);
+
+	down_write(&nvm_lock);
+	list_del(&dev->devices);
+	up_write(&nvm_lock);
+}
+EXPORT_SYMBOL(nvm_unregister);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
new file mode 100644
index 0000000..9654354
--- /dev/null
+++ b/include/linux/lightnvm.h
@@ -0,0 +1,335 @@
+#ifndef NVM_H
+#define NVM_H
+
+enum {
+	NVM_IO_OK = 0,
+	NVM_IO_REQUEUE = 1,
+	NVM_IO_DONE = 2,
+	NVM_IO_ERR = 3,
+
+	NVM_IOTYPE_NONE = 0,
+	NVM_IOTYPE_GC = 1,
+};
+
+#ifdef CONFIG_NVM
+
+#include <linux/blkdev.h>
+#include <linux/types.h>
+#include <linux/file.h>
+#include <linux/dmapool.h>
+
+enum {
+	/* HW Responsibilities */
+	NVM_RSP_L2P	= 1 << 0,
+	NVM_RSP_GC	= 1 << 1,
+	NVM_RSP_ECC	= 1 << 2,
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
+struct nvm_target {
+	struct list_head list;
+	struct nvm_tgt_type *type;
+	struct gendisk *disk;
+};
+
+struct nvm_tgt_instance {
+	struct nvm_tgt_type *tt;
+};
+
+struct nvm_rq {
+	struct nvm_tgt_instance *ins;
+	struct bio *bio;
+	union {
+		sector_t ppa;
+		sector_t *ppa_list;
+	};
+	/*DMA handler to be used by underlying devices supporting DMA*/
+	dma_addr_t dma_ppa_list;
+	uint8_t npages;
+};
+
+static inline struct nvm_rq *nvm_rq_from_pdu(void *pdu)
+{
+	return pdu - sizeof(struct nvm_rq);
+}
+
+static inline void *nvm_rq_to_pdu(struct nvm_rq *rqdata)
+{
+	return rqdata + 1;
+}
+
+struct nvm_block;
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
+typedef int (nvm_submit_io_fn)(struct request_queue *, struct nvm_rq *);
+typedef int (nvm_erase_blk_fn)(struct request_queue *, sector_t);
+typedef void *(nvm_create_ppapool_fn)(struct request_queue *);
+typedef void (nvm_destroy_ppapool_fn)(void *);
+typedef void *(nvm_alloc_ppalist_fn)(struct request_queue *, void *, gfp_t,
+								dma_addr_t*);
+typedef void (nvm_free_ppalist_fn)(void *, void*, dma_addr_t);
+
+struct nvm_dev_ops {
+	nvm_id_fn		*identify;
+	nvm_get_features_fn	*get_features;
+	nvm_set_rsp_fn		*set_responsibility;
+	nvm_get_l2p_tbl_fn	*get_l2p_tbl;
+	nvm_op_bb_tbl_fn	*set_bb_tbl;
+	nvm_op_bb_tbl_fn	*get_bb_tbl;
+
+	nvm_submit_io_fn	*submit_io;
+	nvm_erase_blk_fn	*erase_block;
+
+	nvm_create_ppapool_fn	*create_ppa_pool;
+	nvm_destroy_ppapool_fn	*destroy_ppa_pool;
+	nvm_alloc_ppalist_fn	*alloc_ppalist;
+	nvm_free_ppalist_fn	*free_ppalist;
+
+	uint8_t			max_phys_sect;
+};
+
+struct nvm_lun {
+	int id;
+
+	int nr_pages_per_blk;
+	unsigned int nr_blocks;		/* end_block - start_block. */
+	unsigned int nr_free_blocks;	/* Number of unused blocks */
+
+	struct nvm_block *blocks;
+
+	spinlock_t lock;
+};
+
+struct nvm_block {
+	struct list_head list;
+	struct nvm_lun *lun;
+	unsigned long long id;
+
+	void *priv;
+	int type;
+};
+
+struct nvm_dev {
+	struct nvm_dev_ops *ops;
+
+	struct list_head devices;
+	struct list_head online_targets;
+
+	/* Block manager */
+	struct nvm_bm_type *bm;
+	void *bmp;
+
+	/* Target information */
+	int nr_luns;
+
+	/* Calculated/Cached values. These do not reflect the actual usable
+	 * blocks at run-time. */
+	unsigned long total_pages;
+	unsigned long total_blocks;
+	unsigned max_pages_per_blk;
+
+	uint32_t sector_size;
+
+	void *ppalist_pool;
+
+	/* Identity */
+	struct nvm_id identity;
+	struct nvm_get_features features;
+
+	/* Backend device */
+	struct request_queue *q;
+	char name[DISK_NAME_LEN];
+};
+
+typedef void (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
+typedef sector_t (nvm_tgt_capacity_fn)(void *);
+typedef void (nvm_tgt_end_io_fn)(struct nvm_rq *, int);
+typedef void *(nvm_tgt_init_fn)(struct nvm_dev *, struct gendisk *, int, int);
+typedef void (nvm_tgt_exit_fn)(void *);
+
+struct nvm_tgt_type {
+	const char *name;
+	unsigned int version[3];
+
+	/* target entry points */
+	nvm_tgt_make_rq_fn *make_rq;
+	nvm_tgt_capacity_fn *capacity;
+	nvm_tgt_end_io_fn *end_io;
+
+	/* module-specific init/teardown */
+	nvm_tgt_init_fn *init;
+	nvm_tgt_exit_fn *exit;
+
+	/* For internal use */
+	struct list_head list;
+};
+
+extern int nvm_register_target(struct nvm_tgt_type *);
+extern void nvm_unregister_target(struct nvm_tgt_type *);
+
+extern void *nvm_alloc_ppalist(struct nvm_dev *, gfp_t, dma_addr_t *);
+extern void nvm_free_ppalist(struct nvm_dev *, void *, dma_addr_t);
+
+typedef int (nvm_bm_register_fn)(struct nvm_dev *);
+typedef void (nvm_bm_unregister_fn)(struct nvm_dev *);
+typedef struct nvm_block *(nvm_bm_get_blk_fn)(struct nvm_dev *,
+					      struct nvm_lun *, unsigned long);
+typedef void (nvm_bm_put_blk_fn)(struct nvm_dev *, struct nvm_block *);
+typedef int (nvm_bm_open_blk_fn)(struct nvm_dev *, struct nvm_block *);
+typedef int (nvm_bm_close_blk_fn)(struct nvm_dev *, struct nvm_block *);
+typedef void (nvm_bm_flush_blk_fn)(struct nvm_dev *, struct nvm_block *);
+typedef int (nvm_bm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
+typedef void (nvm_bm_end_io_fn)(struct nvm_rq *, int);
+typedef int (nvm_bm_erase_blk_fn)(struct nvm_dev *, struct nvm_block *);
+typedef int (nvm_bm_register_prog_err_fn)(struct nvm_dev *,
+	     void (prog_err_fn)(struct nvm_dev *, struct nvm_block *));
+typedef int (nvm_bm_save_state_fn)(struct file *);
+typedef int (nvm_bm_restore_state_fn)(struct file *);
+typedef struct nvm_lun *(nvm_bm_get_luns_fn)(struct nvm_dev *, int, int);
+typedef void (nvm_bm_free_blocks_print_fn)(struct nvm_dev *);
+
+struct nvm_bm_type {
+	const char *name;
+	unsigned int version[3];
+
+	nvm_bm_register_fn *register_bm;
+	nvm_bm_unregister_fn *unregister_bm;
+
+	/* Block administration callbacks */
+	nvm_bm_get_blk_fn *get_blk;
+	nvm_bm_put_blk_fn *put_blk;
+	nvm_bm_open_blk_fn *open_blk;
+	nvm_bm_close_blk_fn *close_blk;
+	nvm_bm_flush_blk_fn *flush_blk;
+
+	nvm_bm_submit_io_fn *submit_io;
+	nvm_bm_end_io_fn *end_io;
+	nvm_bm_erase_blk_fn *erase_blk;
+
+	/* State management for debugging purposes */
+	nvm_bm_save_state_fn *save_state;
+	nvm_bm_restore_state_fn *restore_state;
+
+	/* Configuration management */
+	nvm_bm_get_luns_fn *get_luns;
+
+	/* Statistics */
+	nvm_bm_free_blocks_print_fn *free_blocks_print;
+	struct list_head list;
+};
+
+extern int nvm_register_bm(struct nvm_bm_type *);
+extern void nvm_unregister_bm(struct nvm_bm_type *);
+
+extern struct nvm_block *nvm_get_blk(struct nvm_dev *, struct nvm_lun *,
+								unsigned long);
+extern void nvm_put_blk(struct nvm_dev *, struct nvm_block *);
+extern int nvm_erase_blk(struct nvm_dev *, struct nvm_block *);
+
+extern int nvm_register(struct request_queue *, char *,
+						struct nvm_dev_ops *);
+extern void nvm_unregister(char *);
+
+extern int nvm_submit_io(struct nvm_dev *, struct nvm_rq *);
+
+/* We currently assume that we the lightnvm device is accepting data in 512
+ * bytes chunks. This should be set to the smallest command size available for a
+ * given device.
+ */
+#define NVM_SECTOR (512)
+#define EXPOSED_PAGE_SIZE (4096)
+
+#define NR_PHY_IN_LOG (EXPOSED_PAGE_SIZE / NVM_SECTOR)
+
+#define NVM_MSG_PREFIX "nvm"
+#define ADDR_EMPTY (~0ULL)
+
+static inline unsigned long nvm_get_rq_flags(struct request *rq)
+{
+	return (unsigned long)rq->cmd;
+}
+
+#else /* CONFIG_NVM */
+
+struct nvm_dev_ops;
+struct nvm_dev;
+struct nvm_lun;
+struct nvm_block;
+struct nvm_rq {
+};
+struct nvm_tgt_type;
+struct nvm_tgt_instance;
+
+static inline struct nvm_tgt_type *nvm_find_target_type(const char *c)
+{
+	return NULL;
+}
+static inline int nvm_register(struct request_queue *q, char *disk_name,
+							struct nvm_dev_ops *ops)
+{
+	return -EINVAL;
+}
+static inline void nvm_unregister(char *disk_name) {}
+static inline struct nvm_block *nvm_get_blk(struct nvm_dev *dev,
+				struct nvm_lun *lun, unsigned long flags)
+{
+	return NULL;
+}
+static inline void nvm_put_blk(struct nvm_dev *dev, struct nvm_block *blk) {}
+static inline int nvm_erase_blk(struct nvm_dev *dev, struct nvm_block *blk)
+{
+	return -EINVAL;
+}
+
+#endif /* CONFIG_NVM */
+#endif /* LIGHTNVM.H */
-- 
2.1.4
