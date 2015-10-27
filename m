From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Tue, 27 Oct 2015 15:55:15 +0100
Subject: [PATCH v12 1/5] lightnvm: Support for Open-Channel SSDs
In-Reply-To: <1445957719-5368-1-git-send-email-m@bjorling.me>
References: <1445957719-5368-1-git-send-email-m@bjorling.me>
Message-ID: <1445957719-5368-2-git-send-email-m@bjorling.me>

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
  Dongsheng Yang <yangds.fnst at cn.fujitsu.com>
  Jesper Madsen <jmad at itu.dk>

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 Documentation/ioctl/ioctl-number.txt |   1 +
 MAINTAINERS                          |   8 +
 drivers/Kconfig                      |   2 +
 drivers/Makefile                     |   1 +
 drivers/lightnvm/Kconfig             |  28 ++
 drivers/lightnvm/Makefile            |   5 +
 drivers/lightnvm/core.c              | 829 +++++++++++++++++++++++++++++++++++
 include/linux/lightnvm.h             | 536 ++++++++++++++++++++++
 include/uapi/linux/lightnvm.h        | 130 ++++++
 9 files changed, 1540 insertions(+)
 create mode 100644 drivers/lightnvm/Kconfig
 create mode 100644 drivers/lightnvm/Makefile
 create mode 100644 drivers/lightnvm/core.c
 create mode 100644 include/linux/lightnvm.h
 create mode 100644 include/uapi/linux/lightnvm.h

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index df1b25e..8a44d44 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -149,6 +149,7 @@ Code  Seq#(hex)	Include File		Comments
 'K'	all	linux/kd.h
 'L'	00-1F	linux/loop.h		conflict!
 'L'	10-1F	drivers/scsi/mpt2sas/mpt2sas_ctl.h	conflict!
+'L'	20-2F	linux/lightnvm.h
 'L'	E0-FF	linux/ppdd.h		encrypted disk device driver
 					<http://linux01.gwdg.de/~alatham/ppdd.html>
 'M'	all	linux/soundcard.h	conflict!
diff --git a/MAINTAINERS b/MAINTAINERS
index d104ec9..77ca434 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6243,6 +6243,14 @@ F:	drivers/nvdimm/pmem.c
 F:	include/linux/pmem.h
 F:	arch/*/include/asm/pmem.h
 
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
index e69ec82..3a5ab4d 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -44,6 +44,8 @@ source "drivers/net/Kconfig"
 
 source "drivers/isdn/Kconfig"
 
+source "drivers/lightnvm/Kconfig"
+
 # input before char - char/joystick depends on it. As does USB.
 
 source "drivers/input/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 42f9dd5..7f1b7c5 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_NUBUS)		+= nubus/
 obj-y				+= macintosh/
 obj-$(CONFIG_IDE)		+= ide/
 obj-$(CONFIG_SCSI)		+= scsi/
+obj-$(CONFIG_NVM)		+= lightnvm/
 obj-y				+= nvme/
 obj-$(CONFIG_ATA)		+= ata/
 obj-$(CONFIG_TARGET_CORE)	+= target/
diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
new file mode 100644
index 0000000..d4f309f
--- /dev/null
+++ b/drivers/lightnvm/Kconfig
@@ -0,0 +1,28 @@
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
+if NVM
+
+config NVM_DEBUG
+	bool "Open-Channel SSD debugging support"
+	---help---
+	Exposes a debug management interface to create/remove targets at:
+
+	  /sys/module/lnvm/parameters/configure_debug
+
+	It is required to create/remove targets without IOCTLs.
+
+endif # NVM
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
index 0000000..0ff2e57
--- /dev/null
+++ b/drivers/lightnvm/core.c
@@ -0,0 +1,829 @@
+/*
+ * Copyright (C) 2015 IT University of Copenhagen. All rights reserved.
+ * Initial release: Matias Bjorling <m at bjorling.me>
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
+#include <linux/miscdevice.h>
+#include <linux/lightnvm.h>
+#include <uapi/linux/lightnvm.h>
+
+static LIST_HEAD(nvm_targets);
+static LIST_HEAD(nvm_mgrs);
+static LIST_HEAD(nvm_devices);
+static DECLARE_RWSEM(nvm_lock);
+
+static struct nvm_tgt_type *nvm_find_target_type(const char *name)
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
+void *nvm_dev_dma_alloc(struct nvm_dev *dev, gfp_t mem_flags,
+							dma_addr_t *dma_handler)
+{
+	return dev->ops->dev_dma_alloc(dev->q, dev->ppalist_pool, mem_flags,
+								dma_handler);
+}
+EXPORT_SYMBOL(nvm_dev_dma_alloc);
+
+void nvm_dev_dma_free(struct nvm_dev *dev, void *ppa_list,
+							dma_addr_t dma_handler)
+{
+	dev->ops->dev_dma_free(dev->ppalist_pool, ppa_list, dma_handler);
+}
+EXPORT_SYMBOL(nvm_dev_dma_free);
+
+static struct nvmm_type *nvm_find_mgr_type(const char *name)
+{
+	struct nvmm_type *mt;
+
+	list_for_each_entry(mt, &nvm_mgrs, list)
+		if (!strcmp(name, mt->name))
+			return mt;
+
+	return NULL;
+}
+
+int nvm_register_mgr(struct nvmm_type *mt)
+{
+	int ret = 0;
+
+	down_write(&nvm_lock);
+	if (nvm_find_mgr_type(mt->name))
+		ret = -EEXIST;
+	else
+		list_add(&mt->list, &nvm_mgrs);
+	up_write(&nvm_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(nvm_register_mgr);
+
+void nvm_unregister_mgr(struct nvmm_type *mt)
+{
+	if (!mt)
+		return;
+
+	down_write(&nvm_lock);
+	list_del(&mt->list);
+	up_write(&nvm_lock);
+}
+EXPORT_SYMBOL(nvm_unregister_mgr);
+
+static struct nvm_dev *nvm_find_nvm_dev(const char *name)
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
+	return dev->mt->get_blk(dev, lun, flags);
+}
+EXPORT_SYMBOL(nvm_get_blk);
+
+/* Assumes that all valid pages have already been moved on release to bm */
+void nvm_put_blk(struct nvm_dev *dev, struct nvm_block *blk)
+{
+	return dev->mt->put_blk(dev, blk);
+}
+EXPORT_SYMBOL(nvm_put_blk);
+
+int nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
+{
+	return dev->mt->submit_io(dev, rqd);
+}
+EXPORT_SYMBOL(nvm_submit_io);
+
+/* Send erase command to device */
+int nvm_erase_blk(struct nvm_dev *dev, struct nvm_block *blk)
+{
+	return dev->mt->erase_blk(dev, blk, 0);
+}
+EXPORT_SYMBOL(nvm_erase_blk);
+
+static void nvm_core_free(struct nvm_dev *dev)
+{
+	kfree(dev);
+}
+
+static int nvm_core_init(struct nvm_dev *dev)
+{
+	struct nvm_id *id = &dev->identity;
+	struct nvm_id_group *grp = &id->groups[0];
+
+	/* device values */
+	dev->nr_chnls = grp->num_ch;
+	dev->luns_per_chnl = grp->num_lun;
+	dev->pgs_per_blk = grp->num_pg;
+	dev->blks_per_lun = grp->num_blk;
+	dev->nr_planes = grp->num_pln;
+	dev->sec_size = grp->csecs;
+	dev->oob_size = grp->sos;
+	dev->sec_per_pg = grp->fpg_sz / grp->csecs;
+	dev->addr_mode = id->ppat;
+	dev->addr_format = id->ppaf;
+
+	dev->plane_mode = NVM_PLANE_SINGLE;
+	if (grp->mpos & 0x020202)
+		dev->plane_mode = NVM_PLANE_DOUBLE;
+	if (grp->mpos & 0x040404)
+		dev->plane_mode = NVM_PLANE_QUAD;
+
+	/* calculated values */
+	dev->sec_per_pl = dev->sec_per_pg * dev->nr_planes;
+	dev->sec_per_blk = dev->sec_per_pl * dev->pgs_per_blk;
+	dev->sec_per_lun = dev->sec_per_blk * dev->blks_per_lun;
+	dev->nr_luns = dev->luns_per_chnl * dev->nr_chnls;
+
+	dev->total_blocks = dev->nr_planes *
+				dev->blks_per_lun *
+				dev->luns_per_chnl *
+				dev->nr_chnls;
+	dev->total_pages = dev->total_blocks * dev->pgs_per_blk;
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
+	if (dev->mt)
+		dev->mt->unregister_mgr(dev);
+
+	nvm_core_free(dev);
+}
+
+static int nvm_init(struct nvm_dev *dev)
+{
+	struct nvmm_type *mt;
+	int ret = 0;
+
+	if (!dev->q || !dev->ops)
+		return -EINVAL;
+
+	if (dev->ops->identity(dev->q, &dev->identity)) {
+		pr_err("nvm: device could not be identified\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	pr_debug("nvm: ver:%x nvm_vendor:%x groups:%u\n",
+			dev->identity.ver_id, dev->identity.vmnt,
+							dev->identity.cgrps);
+
+	if (dev->identity.ver_id != 1) {
+		pr_err("nvm: device not supported by kernel.");
+		goto err;
+	}
+
+	if (dev->identity.cgrps != 1) {
+		pr_err("nvm: only one group configuration supported.");
+		goto err;
+	}
+
+	ret = nvm_core_init(dev);
+	if (ret) {
+		pr_err("nvm: could not initialize core structures.\n");
+		goto err;
+	}
+
+	/* register with device with a supported manager */
+	list_for_each_entry(mt, &nvm_mgrs, list) {
+		ret = mt->register_mgr(dev);
+		if (ret < 0)
+			goto err; /* initialization failed */
+		if (ret > 0) {
+			dev->mt = mt;
+			break; /* successfully initialized */
+		}
+	}
+
+	if (!ret) {
+		pr_info("nvm: no compatible manager found.\n");
+		return 0;
+	}
+
+	pr_info("nvm: registered %s [%u/%u/%u/%u/%u/%u]\n",
+			dev->name, dev->sec_per_pg, dev->nr_planes,
+			dev->pgs_per_blk, dev->blks_per_lun, dev->nr_luns,
+			dev->nr_chnls);
+	return 0;
+err:
+	nvm_free(dev);
+	pr_err("nvm: failed to initialize nvm\n");
+	return ret;
+}
+
+static void nvm_exit(struct nvm_dev *dev)
+{
+	if (dev->ppalist_pool)
+		dev->ops->destroy_dma_pool(dev->ppalist_pool);
+	nvm_free(dev);
+
+	pr_info("nvm: successfully unloaded\n");
+}
+
+int nvm_register(struct request_queue *q, char *disk_name,
+							struct nvm_dev_ops *ops)
+{
+	struct nvm_dev *dev;
+	int ret;
+
+	if (!ops->identity)
+		return -EINVAL;
+
+	dev = kzalloc(sizeof(struct nvm_dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->q = q;
+	dev->ops = ops;
+	dev->ops->dev_sector_size = DEV_EXPOSED_PAGE_SIZE;
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
+	if (dev->ops->max_phys_sect > 1) {
+		dev->ppalist_pool = dev->ops->create_dma_pool(dev->q,
+								"ppalist");
+		if (!dev->ppalist_pool) {
+			pr_err("nvm: could not create ppa pool\n");
+			return -ENOMEM;
+		}
+	} else if (dev->ops->max_phys_sect > 256) {
+		pr_info("nvm: max sectors supported by device are 256.\n");
+		return -EINVAL;
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
+
+static const struct block_device_operations nvm_fops = {
+	.owner		= THIS_MODULE,
+};
+
+static int nvm_create_target(struct nvm_dev *dev,
+						struct nvm_ioctl_create *create)
+{
+	struct nvm_ioctl_create_simple *s = &create->conf.s;
+	struct request_queue *tqueue;
+	struct nvmm_type *mt;
+	struct gendisk *tdisk;
+	struct nvm_tgt_type *tt;
+	struct nvm_target *t;
+	void *targetdata;
+	int ret = 0;
+
+	if (!dev->mt) {
+		/* register with device with a supported NVM manager */
+		list_for_each_entry(mt, &nvm_mgrs, list) {
+			ret = mt->register_mgr(dev);
+			if (ret < 0)
+				return ret; /* initialization failed */
+			if (ret > 0) {
+				dev->mt = mt;
+				break; /* successfully initialized */
+			}
+		}
+
+		if (!ret) {
+			pr_info("nvm: no compatible nvm manager found.\n");
+			return -ENODEV;
+		}
+	}
+
+	tt = nvm_find_target_type(create->tgttype);
+	if (!tt) {
+		pr_err("nvm: target type %s not found\n", create->tgttype);
+		return -EINVAL;
+	}
+
+	down_write(&nvm_lock);
+	list_for_each_entry(t, &dev->online_targets, list) {
+		if (!strcmp(create->tgtname, t->disk->disk_name)) {
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
+	sprintf(tdisk->disk_name, "%s", create->tgtname);
+	tdisk->flags = GENHD_FL_EXT_DEVT;
+	tdisk->major = 0;
+	tdisk->first_minor = 0;
+	tdisk->fops = &nvm_fops;
+	tdisk->queue = tqueue;
+
+	targetdata = tt->init(dev, tdisk, s->lun_begin, s->lun_end);
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
+static int __nvm_configure_create(struct nvm_ioctl_create *create)
+{
+	struct nvm_dev *dev;
+	struct nvm_ioctl_create_simple *s;
+
+	dev = nvm_find_nvm_dev(create->dev);
+	if (!dev) {
+		pr_err("nvm: device not found\n");
+		return -EINVAL;
+	}
+
+	if (create->conf.type != NVM_CONFIG_TYPE_SIMPLE) {
+		pr_err("nvm: config type not valid\n");
+		return -EINVAL;
+	}
+	s = &create->conf.s;
+
+	if (s->lun_begin > s->lun_end || s->lun_end > dev->nr_luns) {
+		pr_err("nvm: lun out of bound (%u:%u > %u)\n",
+			s->lun_begin, s->lun_end, dev->nr_luns);
+		return -EINVAL;
+	}
+
+	return nvm_create_target(dev, create);
+}
+
+static int __nvm_configure_remove(struct nvm_ioctl_remove *remove)
+{
+	struct nvm_target *t = NULL;
+	struct nvm_dev *dev;
+	int ret = -1;
+
+	down_write(&nvm_lock);
+	list_for_each_entry(dev, &nvm_devices, devices)
+		list_for_each_entry(t, &dev->online_targets, list) {
+			if (!strcmp(remove->tgtname, t->disk->disk_name)) {
+				nvm_remove_target(t);
+				ret = 0;
+				break;
+			}
+		}
+	up_write(&nvm_lock);
+
+	if (ret) {
+		pr_err("nvm: target \"%s\" doesn't exist.\n", remove->tgtname);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_NVM_DEBUG
+static int nvm_configure_show(const char *val)
+{
+	struct nvm_dev *dev;
+	char opcode, devname[DISK_NAME_LEN];
+	int ret;
+
+	ret = sscanf(val, "%c %32s", &opcode, devname);
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
+	if (!dev->mt)
+		return 0;
+
+	dev->mt->free_blocks_print(dev);
+
+	return 0;
+}
+
+static int nvm_configure_remove(const char *val)
+{
+	struct nvm_ioctl_remove remove;
+	char opcode;
+	int ret;
+
+	ret = sscanf(val, "%c %256s", &opcode, remove.tgtname);
+	if (ret != 2) {
+		pr_err("nvm: invalid command. Use \"d targetname\".\n");
+		return -EINVAL;
+	}
+
+	remove.flags = 0;
+
+	return __nvm_configure_remove(&remove);
+}
+
+static int nvm_configure_create(const char *val)
+{
+	struct nvm_ioctl_create create;
+	char opcode;
+	int lun_begin, lun_end, ret;
+
+	ret = sscanf(val, "%c %256s %256s %48s %u:%u", &opcode, create.dev,
+						create.tgtname, create.tgttype,
+						&lun_begin, &lun_end);
+	if (ret != 6) {
+		pr_err("nvm: invalid command. Use \"opcode device name tgttype lun_begin:lun_end\".\n");
+		return -EINVAL;
+	}
+
+	create.flags = 0;
+	create.conf.type = NVM_CONFIG_TYPE_SIMPLE;
+	create.conf.s.lun_begin = lun_begin;
+	create.conf.s.lun_end = lun_end;
+
+	return __nvm_configure_create(&create);
+}
+
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
+		return nvm_configure_create(val);
+	case 'd':
+		return nvm_configure_remove(val);
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
+		buf += sprintf(buf, " %32s\n", dev->name);
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
+#endif /* CONFIG_NVM_DEBUG */
+
+static long nvm_ioctl_info(struct file *file, void __user *arg)
+{
+	struct nvm_ioctl_info *info;
+	struct nvm_tgt_type *tt;
+	int tgt_iter = 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	info = kzalloc(sizeof(struct nvm_ioctl_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	if (copy_from_user(info, arg, sizeof(struct nvm_ioctl_info)))
+		return -EFAULT;
+
+	info->version[0] = NVM_VERSION_MAJOR;
+	info->version[1] = NVM_VERSION_MINOR;
+	info->version[2] = NVM_VERSION_PATCH;
+
+	down_write(&nvm_lock);
+	list_for_each_entry(tt, &nvm_targets, list) {
+		struct nvm_ioctl_info_tgt *tgt = &info->tgts[tgt_iter];
+
+		tgt->version[0] = tt->version[0];
+		tgt->version[1] = tt->version[1];
+		tgt->version[2] = tt->version[2];
+		strncpy(tgt->tgtname, tt->name, NVM_TTYPE_NAME_MAX);
+
+		tgt_iter++;
+	}
+
+	info->tgtsize = tgt_iter;
+	up_write(&nvm_lock);
+
+	if (copy_to_user(arg, info, sizeof(struct nvm_ioctl_info)))
+		return -EFAULT;
+
+	kfree(info);
+	return 0;
+}
+
+static long nvm_ioctl_get_devices(struct file *file, void __user *arg)
+{
+	struct nvm_ioctl_get_devices *devices;
+	struct nvm_dev *dev;
+	int i = 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	devices = kzalloc(sizeof(struct nvm_ioctl_get_devices), GFP_KERNEL);
+	if (!devices)
+		return -ENOMEM;
+
+	down_write(&nvm_lock);
+	list_for_each_entry(dev, &nvm_devices, devices) {
+		struct nvm_ioctl_device_info *info = &devices->info[i];
+
+		sprintf(info->devname, "%s", dev->name);
+		if (dev->mt) {
+			info->bmversion[0] = dev->mt->version[0];
+			info->bmversion[1] = dev->mt->version[1];
+			info->bmversion[2] = dev->mt->version[2];
+			sprintf(info->bmname, "%s", dev->mt->name);
+		} else {
+			sprintf(info->bmname, "none");
+		}
+
+		i++;
+		if (i > 31) {
+			pr_err("nvm: max 31 devices can be reported.\n");
+			break;
+		}
+	}
+	up_write(&nvm_lock);
+
+	devices->nr_devices = i;
+
+	if (copy_to_user(arg, devices, sizeof(struct nvm_ioctl_get_devices)))
+		return -EFAULT;
+
+	kfree(devices);
+	return 0;
+}
+
+static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
+{
+	struct nvm_ioctl_create create;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&create, arg, sizeof(struct nvm_ioctl_create)))
+		return -EFAULT;
+
+	create.dev[DISK_NAME_LEN - 1] = '\0';
+	create.tgttype[NVM_TTYPE_NAME_MAX - 1] = '\0';
+	create.tgtname[DISK_NAME_LEN - 1] = '\0';
+
+	if (create.flags != 0) {
+		pr_err("nvm: no flags supported\n");
+		return -EINVAL;
+	}
+
+	return __nvm_configure_create(&create);
+}
+
+static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
+{
+	struct nvm_ioctl_remove remove;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&remove, arg, sizeof(struct nvm_ioctl_remove)))
+		return -EFAULT;
+
+	remove.tgtname[DISK_NAME_LEN - 1] = '\0';
+
+	if (remove.flags != 0) {
+		pr_err("nvm: no flags supported\n");
+		return -EINVAL;
+	}
+
+	return __nvm_configure_remove(&remove);
+}
+
+static long nvm_ctl_ioctl(struct file *file, uint cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case NVM_INFO:
+		return nvm_ioctl_info(file, argp);
+	case NVM_GET_DEVICES:
+		return nvm_ioctl_get_devices(file, argp);
+	case NVM_DEV_CREATE:
+		return nvm_ioctl_dev_create(file, argp);
+	case NVM_DEV_REMOVE:
+		return nvm_ioctl_dev_remove(file, argp);
+	}
+	return 0;
+}
+
+static const struct file_operations _ctl_fops = {
+	.open = nonseekable_open,
+	.unlocked_ioctl = nvm_ctl_ioctl,
+	.owner = THIS_MODULE,
+	.llseek  = noop_llseek,
+};
+
+static struct miscdevice _nvm_misc = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= "lightnvm",
+	.nodename	= "lightnvm/control",
+	.fops		= &_ctl_fops,
+};
+
+MODULE_ALIAS_MISCDEV(MISC_DYNAMIC_MINOR);
+
+static int __init nvm_mod_init(void)
+{
+	int ret;
+
+	ret = misc_register(&_nvm_misc);
+	if (ret)
+		pr_err("nvm: misc_register failed for control device");
+
+	return ret;
+}
+
+static void __exit nvm_mod_exit(void)
+{
+	misc_deregister(&_nvm_misc);
+}
+
+MODULE_AUTHOR("Matias Bjorling <m at bjorling.me>");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("0.1");
+module_init(nvm_mod_init);
+module_exit(nvm_mod_exit);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
new file mode 100644
index 0000000..3a9fd37
--- /dev/null
+++ b/include/linux/lightnvm.h
@@ -0,0 +1,536 @@
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
+	NVM_RSP_ECC	= 1 << 1,
+
+	/* Physical Adressing Mode */
+	NVM_ADDRMODE_LINEAR	= 0,
+	NVM_ADDRMODE_CHANNEL	= 1,
+
+	/* Plane programming mode for LUN */
+	NVM_PLANE_SINGLE	= 0,
+	NVM_PLANE_DOUBLE	= 1,
+	NVM_PLANE_QUAD		= 2,
+
+	/* Status codes */
+	NVM_RSP_SUCCESS		= 0x0,
+	NVM_RSP_NOT_CHANGEABLE	= 0x1,
+	NVM_RSP_ERR_FAILWRITE	= 0x40ff,
+	NVM_RSP_ERR_EMPTYPAGE	= 0x42ff,
+
+	/* Device opcodes */
+	NVM_OP_HBREAD		= 0x02,
+	NVM_OP_HBWRITE		= 0x81,
+	NVM_OP_PWRITE		= 0x91,
+	NVM_OP_PREAD		= 0x92,
+	NVM_OP_ERASE		= 0x90,
+
+	/* PPA Command Flags */
+	NVM_IO_SNGL_ACCESS	= 0x0,
+	NVM_IO_DUAL_ACCESS	= 0x1,
+	NVM_IO_QUAD_ACCESS	= 0x2,
+
+	NVM_IO_SUSPEND		= 0x80,
+	NVM_IO_SLC_MODE		= 0x100,
+	NVM_IO_SCRAMBLE_DISABLE	= 0x200,
+};
+
+struct nvm_id_group {
+	u8	mtype;
+	u8	fmtype;
+	u16	res16;
+	u8	num_ch;
+	u8	num_lun;
+	u8	num_pln;
+	u16	num_blk;
+	u16	num_pg;
+	u16	fpg_sz;
+	u16	csecs;
+	u16	sos;
+	u32	trdt;
+	u32	trdm;
+	u32	tprt;
+	u32	tprm;
+	u32	tbet;
+	u32	tbem;
+	u32	mpos;
+	u16	cpar;
+	u8	res[913];
+} __packed;
+
+struct nvm_addr_format {
+	u8	ch_offset;
+	u8	ch_len;
+	u8	lun_offset;
+	u8	lun_len;
+	u8	pln_offset;
+	u8	pln_len;
+	u8	blk_offset;
+	u8	blk_len;
+	u8	pg_offset;
+	u8	pg_len;
+	u8	sect_offset;
+	u8	sect_len;
+	u8	res[4];
+};
+
+struct nvm_id {
+	u8	ver_id;
+	u8	vmnt;
+	u8	cgrps;
+	u8	res[5];
+	u32	cap;
+	u32	dom;
+	struct nvm_addr_format ppaf;
+	u8	ppat;
+	u8	resv[224];
+	struct nvm_id_group groups[4];
+} __packed;
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
+/* The minimum managed sector size is currently 4K. */
+#define DEV_EXPOSED_PAGE_SIZE (4096)
+
+#define NVM_MSG_PREFIX "nvm"
+#define ADDR_EMPTY (~0ULL)
+
+#define NVM_VERSION_MAJOR 1
+#define NVM_VERSION_MINOR 0
+#define NVM_VERSION_PATCH 0
+
+
+#define NVM_SEC_BITS (8)
+#define NVM_PL_BITS  (6)
+#define NVM_PG_BITS  (16)
+#define NVM_BLK_BITS (16)
+#define NVM_LUN_BITS (10)
+#define NVM_CH_BITS  (8)
+
+struct ppa_addr {
+	union {
+		/* Channel-based PPA format in nand 4x2x2x2x8x10 */
+		struct {
+			sector_t ch		: 4;
+			sector_t sec		: 2; /* 4 sectors per page */
+			sector_t pl		: 2; /* 4 planes per LUN */
+			sector_t lun		: 2; /* 4 LUNs per channel */
+			sector_t pg		: 8; /* 256 pages per block */
+			sector_t blk		: 10;/* 1024 blocks per plane */
+			sector_t resved		: 36;
+		} chnl;
+
+		/* Generic structure for all addresses */
+		struct {
+			sector_t sec		: NVM_SEC_BITS;
+			sector_t pl		: NVM_PL_BITS;
+			sector_t pg		: NVM_PG_BITS;
+			sector_t blk		: NVM_BLK_BITS;
+			sector_t lun		: NVM_LUN_BITS;
+			sector_t ch		: NVM_CH_BITS;
+		} g;
+
+		sector_t ppa;
+	};
+} __packed;
+
+struct nvm_rq {
+	struct nvm_tgt_instance *ins;
+	struct nvm_dev *dev;
+
+	struct bio *bio;
+
+	union {
+		struct ppa_addr ppa_addr;
+		dma_addr_t dma_ppa_list;
+	};
+
+	struct ppa_addr *ppa_list;
+
+	void *metadata;
+	dma_addr_t dma_metadata;
+
+	uint8_t opcode;
+	uint16_t nr_pages;
+	uint16_t flags;
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
+typedef int (nvm_l2p_update_fn)(u64, u32, __le64 *, void *);
+typedef int (nvm_bb_update_fn)(u32, void *, unsigned int, void *);
+typedef int (nvm_id_fn)(struct request_queue *, struct nvm_id *);
+typedef int (nvm_get_l2p_tbl_fn)(struct request_queue *, u64, u32,
+				nvm_l2p_update_fn *, void *);
+typedef int (nvm_op_bb_tbl_fn)(struct request_queue *, int, unsigned int,
+				nvm_bb_update_fn *, void *);
+typedef int (nvm_op_set_bb_fn)(struct request_queue *, struct nvm_rq *, int);
+typedef int (nvm_submit_io_fn)(struct request_queue *, struct nvm_rq *);
+typedef int (nvm_erase_blk_fn)(struct request_queue *, struct nvm_rq *);
+typedef void *(nvm_create_dma_pool_fn)(struct request_queue *, char *);
+typedef void (nvm_destroy_dma_pool_fn)(void *);
+typedef void *(nvm_dev_dma_alloc_fn)(struct request_queue *, void *, gfp_t,
+								dma_addr_t*);
+typedef void (nvm_dev_dma_free_fn)(void *, void*, dma_addr_t);
+
+struct nvm_dev_ops {
+	nvm_id_fn		*identity;
+	nvm_get_l2p_tbl_fn	*get_l2p_tbl;
+	nvm_op_bb_tbl_fn	*get_bb_tbl;
+	nvm_op_set_bb_fn	*set_bb;
+
+	nvm_submit_io_fn	*submit_io;
+	nvm_erase_blk_fn	*erase_block;
+
+	nvm_create_dma_pool_fn	*create_dma_pool;
+	nvm_destroy_dma_pool_fn	*destroy_dma_pool;
+	nvm_dev_dma_alloc_fn	*dev_dma_alloc;
+	nvm_dev_dma_free_fn	*dev_dma_free;
+
+	int			dev_sector_size;
+	uint8_t			max_phys_sect;
+};
+
+struct nvm_lun {
+	int id;
+
+	int lun_id;
+	int chnl_id;
+
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
+	/* Media manager */
+	struct nvmm_type *mt;
+	void *mp;
+
+	/* Device information */
+	int nr_chnls;
+	int nr_planes;
+	int luns_per_chnl;
+	int sec_per_pg; /* only sectors for a single page */
+	int pgs_per_blk;
+	int blks_per_lun;
+	int sec_size;
+	int oob_size;
+	int addr_mode;
+	int plane_mode;
+	struct nvm_addr_format addr_format;
+
+	/* Calculated/Cached values. These do not reflect the actual usable
+	 * blocks at run-time.
+	 */
+
+	int sec_per_pl; /* all sectors across planes */
+	int sec_per_blk;
+	int sec_per_lun;
+
+	unsigned long total_pages;
+	unsigned long total_blocks;
+	int nr_luns;
+	unsigned max_pages_per_blk;
+
+	void *ppalist_pool;
+
+	struct nvm_id identity;
+
+	/* Backend device */
+	struct request_queue *q;
+	char name[DISK_NAME_LEN];
+};
+
+/* fallback conversion */
+static struct ppa_addr __generic_to_linear_addr(struct nvm_dev *dev,
+							struct ppa_addr r)
+{
+	struct ppa_addr l;
+
+	l.ppa = r.g.sec +
+		r.g.pg  * dev->sec_per_pg +
+		r.g.blk * (dev->pgs_per_blk *
+				dev->sec_per_pg) +
+		r.g.lun * (dev->blks_per_lun *
+				dev->pgs_per_blk *
+				dev->sec_per_pg) +
+		r.g.ch * (dev->blks_per_lun *
+				dev->pgs_per_blk *
+				dev->luns_per_chnl *
+				dev->sec_per_pg);
+
+	return l;
+}
+
+/* fallback conversion */
+static struct ppa_addr __linear_to_generic_addr(struct nvm_dev *dev,
+							struct ppa_addr r)
+{
+	struct ppa_addr l;
+
+	l.ppa = 0;
+
+	l.g.sec = r.ppa % dev->sec_per_pg;
+	l.g.pg = (r.ppa / dev->sec_per_pg) % dev->pgs_per_blk;
+	l.g.blk = (r.ppa / (dev->pgs_per_blk *
+				dev->sec_per_pg)) % dev->blks_per_lun;
+	l.g.lun = (r.ppa / (dev->blks_per_lun *
+				dev->pgs_per_blk *
+				dev->sec_per_pg)) % dev->luns_per_chnl;
+	l.g.ch = r.ppa / (dev->blks_per_lun *
+				dev->pgs_per_blk *
+				dev->luns_per_chnl *
+				dev->sec_per_pg);
+
+	return l;
+}
+
+static struct ppa_addr __generic_to_chnl_addr(struct ppa_addr r)
+{
+	struct ppa_addr l;
+
+	l.ppa = 0;
+
+	l.chnl.sec = r.g.sec;
+	l.chnl.pl = r.g.pl;
+	l.chnl.pg = r.g.pg;
+	l.chnl.blk = r.g.blk;
+	l.chnl.lun = r.g.lun;
+	l.chnl.ch = r.g.ch;
+
+	return l;
+}
+
+static struct ppa_addr __chnl_to_generic_addr(struct ppa_addr r)
+{
+	struct ppa_addr l;
+
+	l.ppa = 0;
+
+	l.g.sec = r.chnl.sec;
+	l.g.pl = r.chnl.pl;
+	l.g.pg = r.chnl.pg;
+	l.g.blk = r.chnl.blk;
+	l.g.lun = r.chnl.lun;
+	l.g.ch = r.chnl.ch;
+
+	return l;
+}
+
+static inline struct ppa_addr addr_to_generic_mode(struct nvm_dev *dev,
+						struct ppa_addr gppa)
+{
+	switch (dev->addr_mode) {
+	case NVM_ADDRMODE_LINEAR:
+		return __linear_to_generic_addr(dev, gppa);
+	case NVM_ADDRMODE_CHANNEL:
+		return __chnl_to_generic_addr(gppa);
+	default:
+		BUG();
+	}
+	return gppa;
+}
+
+static inline struct ppa_addr generic_to_addr_mode(struct nvm_dev *dev,
+						struct ppa_addr gppa)
+{
+	switch (dev->addr_mode) {
+	case NVM_ADDRMODE_LINEAR:
+		return __generic_to_linear_addr(dev, gppa);
+	case NVM_ADDRMODE_CHANNEL:
+		return __generic_to_chnl_addr(gppa);
+	default:
+		BUG();
+	}
+	return gppa;
+}
+
+static inline int ppa_empty(struct ppa_addr ppa_addr)
+{
+	return (ppa_addr.ppa == ADDR_EMPTY);
+}
+
+static inline void ppa_set_empty(struct ppa_addr *ppa_addr)
+{
+	ppa_addr->ppa = ADDR_EMPTY;
+}
+
+static inline struct ppa_addr block_to_ppa(struct nvm_dev *dev,
+							struct nvm_block *blk)
+{
+	struct ppa_addr ppa;
+	struct nvm_lun *lun = blk->lun;
+
+	ppa.ppa = 0;
+	ppa.g.blk = blk->id % dev->blks_per_lun;
+	ppa.g.lun = lun->lun_id;
+	ppa.g.ch = lun->chnl_id;
+
+	return ppa;
+}
+
+typedef void (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
+typedef sector_t (nvm_tgt_capacity_fn)(void *);
+typedef int (nvm_tgt_end_io_fn)(struct nvm_rq *, int);
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
+extern void *nvm_dev_dma_alloc(struct nvm_dev *, gfp_t, dma_addr_t *);
+extern void nvm_dev_dma_free(struct nvm_dev *, void *, dma_addr_t);
+
+typedef int (nvmm_register_fn)(struct nvm_dev *);
+typedef void (nvmm_unregister_fn)(struct nvm_dev *);
+typedef struct nvm_block *(nvmm_get_blk_fn)(struct nvm_dev *,
+					      struct nvm_lun *, unsigned long);
+typedef void (nvmm_put_blk_fn)(struct nvm_dev *, struct nvm_block *);
+typedef int (nvmm_open_blk_fn)(struct nvm_dev *, struct nvm_block *);
+typedef int (nvmm_close_blk_fn)(struct nvm_dev *, struct nvm_block *);
+typedef void (nvmm_flush_blk_fn)(struct nvm_dev *, struct nvm_block *);
+typedef int (nvmm_submit_io_fn)(struct nvm_dev *, struct nvm_rq *);
+typedef int (nvmm_end_io_fn)(struct nvm_rq *, int);
+typedef int (nvmm_erase_blk_fn)(struct nvm_dev *, struct nvm_block *,
+								unsigned long);
+typedef int (nvmm_register_prog_err_fn)(struct nvm_dev *,
+	     void (prog_err_fn)(struct nvm_dev *, struct nvm_block *));
+typedef int (nvmm_save_state_fn)(struct file *);
+typedef int (nvmm_restore_state_fn)(struct file *);
+typedef struct nvm_lun *(nvmm_get_lun_fn)(struct nvm_dev *, int);
+typedef void (nvmm_free_blocks_print_fn)(struct nvm_dev *);
+
+struct nvmm_type {
+	const char *name;
+	unsigned int version[3];
+
+	nvmm_register_fn *register_mgr;
+	nvmm_unregister_fn *unregister_mgr;
+
+	/* Block administration callbacks */
+	nvmm_get_blk_fn *get_blk;
+	nvmm_put_blk_fn *put_blk;
+	nvmm_open_blk_fn *open_blk;
+	nvmm_close_blk_fn *close_blk;
+	nvmm_flush_blk_fn *flush_blk;
+
+	nvmm_submit_io_fn *submit_io;
+	nvmm_end_io_fn *end_io;
+	nvmm_erase_blk_fn *erase_blk;
+
+	/* State management for debugging purposes */
+	nvmm_save_state_fn *save_state;
+	nvmm_restore_state_fn *restore_state;
+
+	/* Configuration management */
+	nvmm_get_lun_fn *get_lun;
+
+	/* Statistics */
+	nvmm_free_blocks_print_fn *free_blocks_print;
+	struct list_head list;
+};
+
+extern int nvm_register_mgr(struct nvmm_type *);
+extern void nvm_unregister_mgr(struct nvmm_type *);
+
+extern struct nvm_block *nvm_get_blk(struct nvm_dev *, struct nvm_lun *,
+								unsigned long);
+extern void nvm_put_blk(struct nvm_dev *, struct nvm_block *);
+
+extern int nvm_register(struct request_queue *, char *,
+						struct nvm_dev_ops *);
+extern void nvm_unregister(char *);
+
+extern int nvm_submit_io(struct nvm_dev *, struct nvm_rq *);
+extern int nvm_erase_blk(struct nvm_dev *, struct nvm_block *);
+
+static inline unsigned long nvm_get_rq_flags(struct request *rq)
+{
+	return (unsigned long)rq->cmd;
+}
+
+#else /* CONFIG_NVM */
+
+struct nvm_dev_ops;
+
+static inline int nvm_register(struct request_queue *q, char *disk_name,
+							struct nvm_dev_ops *ops)
+{
+	return -EINVAL;
+}
+static inline void nvm_unregister(char *disk_name) {}
+
+#endif /* CONFIG_NVM */
+#endif /* LIGHTNVM.H */
diff --git a/include/uapi/linux/lightnvm.h b/include/uapi/linux/lightnvm.h
new file mode 100644
index 0000000..928f989
--- /dev/null
+++ b/include/uapi/linux/lightnvm.h
@@ -0,0 +1,130 @@
+/*
+ * Copyright (C) 2015 CNEX Labs.  All rights reserved.
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
+ */
+
+#ifndef _UAPI_LINUX_LIGHTNVM_H
+#define _UAPI_LINUX_LIGHTNVM_H
+
+#ifdef __KERNEL__
+#include <linux/kernel.h>
+#include <linux/ioctl.h>
+#else /* __KERNEL__ */
+#include <stdio.h>
+#include <sys/ioctl.h>
+#define DISK_NAME_LEN 32
+#endif /* __KERNEL__ */
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define NVM_TTYPE_NAME_MAX 48
+#define NVM_TTYPE_MAX 63
+
+#define NVM_CTRL_FILE "/dev/lightnvm/control"
+
+struct nvm_ioctl_info_tgt {
+	__u32 version[3];
+	__u32 reserved;
+	char tgtname[NVM_TTYPE_NAME_MAX];
+};
+
+struct nvm_ioctl_info {
+	__u32 version[3];	/* in/out - major, minor, patch */
+	__u16 tgtsize;		/* number of targets */
+	__u16 reserved16;	/* pad to 4K page */
+	__u32 reserved[12];
+	struct nvm_ioctl_info_tgt tgts[NVM_TTYPE_MAX];
+};
+
+enum {
+	NVM_DEVICE_ACTIVE = 1 << 0,
+};
+
+struct nvm_ioctl_device_info {
+	char devname[DISK_NAME_LEN];
+	char bmname[NVM_TTYPE_NAME_MAX];
+	__u32 bmversion[3];
+	__u32 flags;
+	__u32 reserved[8];
+};
+
+struct nvm_ioctl_get_devices {
+	__u32 nr_devices;
+	__u32 reserved[31];
+	struct nvm_ioctl_device_info info[31];
+};
+
+struct nvm_ioctl_create_simple {
+	__u32 lun_begin;
+	__u32 lun_end;
+};
+
+enum {
+	NVM_CONFIG_TYPE_SIMPLE = 0,
+};
+
+struct nvm_ioctl_create_conf {
+	__u32 type;
+	union {
+		struct nvm_ioctl_create_simple s;
+	};
+};
+
+struct nvm_ioctl_create {
+	char dev[DISK_NAME_LEN];		/* open-channel SSD device */
+	char tgttype[NVM_TTYPE_NAME_MAX];	/* target type name */
+	char tgtname[DISK_NAME_LEN];		/* dev to expose target as */
+
+	__u32 flags;
+
+	struct nvm_ioctl_create_conf conf;
+};
+
+struct nvm_ioctl_remove {
+	char tgtname[DISK_NAME_LEN];
+
+	__u32 flags;
+};
+
+
+/* The ioctl type, 'L', 0x20 - 0x2F documented in ioctl-number.txt */
+enum {
+	/* top level cmds */
+	NVM_INFO_CMD = 0x20,
+	NVM_GET_DEVICES_CMD,
+
+	/* device level cmds */
+	NVM_DEV_CREATE_CMD,
+	NVM_DEV_REMOVE_CMD,
+};
+
+#define NVM_IOCTL 'L' /* 0x4c */
+
+#define NVM_INFO		_IOWR(NVM_IOCTL, NVM_INFO_CMD, \
+						struct nvm_ioctl_info)
+#define NVM_GET_DEVICES		_IOR(NVM_IOCTL, NVM_GET_DEVICES_CMD, \
+						struct nvm_ioctl_get_devices)
+#define NVM_DEV_CREATE		_IOW(NVM_IOCTL, NVM_DEV_CREATE_CMD, \
+						struct nvm_ioctl_create)
+#define NVM_DEV_REMOVE		_IOW(NVM_IOCTL, NVM_DEV_REMOVE_CMD, \
+						struct nvm_ioctl_remove)
+
+#define NVM_VERSION_MAJOR	1
+#define NVM_VERSION_MINOR	0
+#define NVM_VERSION_PATCHLEVEL	0
+
+#endif
-- 
2.1.4
