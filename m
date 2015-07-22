From: mb@lightnvm.io (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 22 Jul 2015 19:51:04 +0200
Subject: [PATCH v5 5/5] nvme: LightNVM support
In-Reply-To: <1437587464-7964-1-git-send-email-mb@lightnvm.io>
References: <1437587464-7964-1-git-send-email-mb@lightnvm.io>
Message-ID: <1437587464-7964-6-git-send-email-mb@lightnvm.io>

The first generation of Open-Channel SSDs will be based on NVMe. The
integration requires that a NVMe device exposes itself as a LightNVM
device. The way this is done currently is by hooking into the
Controller Capabilities (CAP register) and a bit in NSFEAT for each
namespace.

After detection, vendor specific codes are used to identify the device
and enumerate supported features.

Signed-off-by: Javier Gonz?lez <jg at lightnvm.io>
Signed-off-by: Matias Bj?rling <mb at lightnvm.io>
---
 drivers/block/Makefile        |   2 +-
 drivers/block/nvme-core.c     |  22 +-
 drivers/block/nvme-lightnvm.c | 504 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h          |   6 +
 include/uapi/linux/nvme.h     |   3 +
 5 files changed, 533 insertions(+), 4 deletions(-)
 create mode 100644 drivers/block/nvme-lightnvm.c

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 02b688d..a01d7d8 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -44,6 +44,6 @@ obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 obj-$(CONFIG_ZRAM) += zram/
 
-nvme-y		:= nvme-core.o nvme-scsi.o
+nvme-y		:= nvme-core.o nvme-scsi.o nvme-lightnvm.o
 skd-y		:= skd_main.o
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 666e994..ab799b0 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/t10-pi.h>
 #include <linux/types.h>
+#include <linux/lightnvm.h>
 #include <scsi/sg.h>
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
 
@@ -1751,7 +1752,8 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 
 	dev->page_size = 1 << page_shift;
 
-	dev->ctrl_config = NVME_CC_CSS_NVM;
+	dev->ctrl_config = NVME_CAP_LIGHTNVM(cap) ?
+					NVME_CC_CSS_LIGHTNVM : NVME_CC_CSS_NVM;
 	dev->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
 	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
 	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
@@ -1997,6 +1999,16 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		return -ENODEV;
 	}
 
+	if ((dev->ctrl_config & NVME_CC_CSS_LIGHTNVM) &&
+		id->nsfeat & NVME_NS_FEAT_NVM && ns->type != NVME_NS_NVM) {
+		if (nvme_nvm_register(ns->queue, disk)) {
+			dev_warn(dev->dev,
+				    "%s: LightNVM init failure\n", __func__);
+			return -ENODEV;
+		}
+		ns->type = NVME_NS_NVM;
+	}
+
 	old_ms = ns->ms;
 	lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
 	ns->lba_shift = id->lbaf[lbaf].ds;
@@ -2028,7 +2040,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 								!ns->ext)
 		nvme_init_integrity(ns);
 
-	if (ns->ms && !blk_get_integrity(disk))
+	if ((ns->ms && !blk_get_integrity(disk)) || ns->type == NVME_NS_NVM)
 		set_capacity(disk, 0);
 	else
 		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
@@ -2146,7 +2158,8 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	if (nvme_revalidate_disk(ns->disk))
 		goto out_free_disk;
 
-	add_disk(ns->disk);
+	if (ns->type != NVME_NS_NVM)
+		add_disk(ns->disk);
 	if (ns->ms) {
 		struct block_device *bd = bdget_disk(ns->disk, 0);
 		if (!bd)
@@ -2345,6 +2358,9 @@ static void nvme_free_namespace(struct nvme_ns *ns)
 {
 	list_del(&ns->list);
 
+	if (ns->type == NVME_NS_NVM)
+		nvm_unregister(ns->disk);
+
 	spin_lock(&dev_list_lock);
 	ns->disk->private_data = NULL;
 	spin_unlock(&dev_list_lock);
diff --git a/drivers/block/nvme-lightnvm.c b/drivers/block/nvme-lightnvm.c
new file mode 100644
index 0000000..397a66e
--- /dev/null
+++ b/drivers/block/nvme-lightnvm.c
@@ -0,0 +1,504 @@
+/*
+ * nvme-lightnvm.c - LightNVM NVMe device
+ *
+ * Copyright (C) 2014-2015 IT University of Copenhagen
+ * Initial release: Matias Bjorling <mb at lightnvm.io>
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
+#include <linux/nvme.h>
+#include <linux/bitops.h>
+#include <linux/lightnvm.h>
+
+#ifdef CONFIG_NVM
+
+enum nvme_nvm_opcode {
+	nvme_nvm_cmd_hb_write	= 0x81,
+	nvme_nvm_cmd_hb_read	= 0x02,
+	nvme_nvm_cmd_phys_write	= 0x91,
+	nvme_nvm_cmd_phys_read	= 0x92,
+	nvme_nvm_cmd_erase	= 0x90,
+};
+
+enum nvme_nvm_admin_opcode {
+	nvme_nvm_admin_identify		= 0xe2,
+	nvme_nvm_admin_get_features	= 0xe6,
+	nvme_nvm_admin_set_resp		= 0xe5,
+	nvme_nvm_admin_get_l2p_tbl	= 0xea,
+	nvme_nvm_admin_get_bb_tbl	= 0xf2,
+	nvme_nvm_admin_set_bb_tbl	= 0xf1,
+};
+
+struct nvme_nvm_hb_rw {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2;
+	__le64			metadata;
+	__le64			prp1;
+	__le64			prp2;
+	__le64			slba;
+	__le16			length;
+	__le16			control;
+	__le32			dsmgmt;
+	__le64			phys_addr;
+};
+
+struct nvme_nvm_identify {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd[2];
+	__le64			prp1;
+	__le64			prp2;
+	__le32			chnl_off;
+	__u32			rsvd11[5];
+};
+
+struct nvme_nvm_l2ptbl {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le32			cdw2[4];
+	__le64			prp1;
+	__le64			prp2;
+	__le64			slba;
+	__le32			nlb;
+	__le16			cdw14[6];
+};
+
+struct nvme_nvm_bbtbl {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd[2];
+	__le64			prp1;
+	__le64			prp2;
+	__le32			prp1_len;
+	__le32			prp2_len;
+	__le32			lbb;
+	__u32			rsvd11[3];
+};
+
+struct nvme_nvm_set_resp {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd[2];
+	__le64			prp1;
+	__le64			prp2;
+	__le64			resp;
+	__u32			rsvd11[4];
+};
+
+struct nvme_nvm_erase_blk {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd[2];
+	__le64			prp1;
+	__le64			prp2;
+	__le64			blk_addr;
+	__u32			rsvd11[4];
+};
+
+struct nvme_nvm_command {
+	union {
+		struct nvme_common_command common;
+		struct nvme_nvm_identify nvm_identify;
+		struct nvme_nvm_hb_rw nvm_hb_rw;
+		struct nvme_nvm_l2ptbl nvm_l2p;
+		struct nvme_nvm_bbtbl nvm_get_bb;
+		struct nvme_nvm_bbtbl nvm_set_bb;
+		struct nvme_nvm_set_resp nvm_resp;
+		struct nvme_nvm_erase_blk nvm_erase;
+	};
+};
+
+/*
+ * Check we didin't inadvertently grow the command struct
+ */
+static inline void _nvme_nvm_check_size(void)
+{
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_identify) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_hb_rw) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_l2ptbl) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_bbtbl) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_set_resp) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_erase_blk) != 64);
+}
+
+struct nvme_nvm_id_chnl {
+	__le64			laddr_begin;
+	__le64			laddr_end;
+	__le32			oob_size;
+	__le32			queue_size;
+	__le32			gran_read;
+	__le32			gran_write;
+	__le32			gran_erase;
+	__le32			t_r;
+	__le32			t_sqr;
+	__le32			t_w;
+	__le32			t_sqw;
+	__le32			t_e;
+	__le16			chnl_parallelism;
+	__u8			io_sched;
+	__u8			reserved[133];
+} __packed;
+
+struct nvme_nvm_id {
+	__u8			ver_id;
+	__u8			nvm_type;
+	__le16			nchannels;
+	__u8			reserved[252];
+	struct nvme_nvm_id_chnl	chnls[];
+} __packed;
+
+#define NVME_NVM_CHNLS_PR_REQ ((4096U - sizeof(struct nvme_nvm_id)) \
+					/ sizeof(struct nvme_nvm_id_chnl))
+
+
+static int init_chnls(struct request_queue *q, struct nvm_id *nvm_id,
+						struct nvme_nvm_id *nvme_nvm_id)
+{
+	struct nvme_nvm_id_chnl *src = nvme_nvm_id->chnls;
+	struct nvm_id_chnl *dst = nvm_id->chnls;
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_nvm_command c = {
+		.nvm_identify.opcode = nvme_nvm_admin_identify,
+		.nvm_identify.nsid = cpu_to_le32(ns->ns_id),
+	};
+	unsigned int len = nvm_id->nchannels;
+	int i, end, ret, off = 0;
+
+	while (len) {
+		end = min_t(u32, NVME_NVM_CHNLS_PR_REQ, len);
+
+		for (i = 0; i < end; i++, dst++, src++) {
+			dst->laddr_begin = le64_to_cpu(src->laddr_begin);
+			dst->laddr_end = le64_to_cpu(src->laddr_end);
+			dst->oob_size = le32_to_cpu(src->oob_size);
+			dst->queue_size = le32_to_cpu(src->queue_size);
+			dst->gran_read = le32_to_cpu(src->gran_read);
+			dst->gran_write = le32_to_cpu(src->gran_write);
+			dst->gran_erase = le32_to_cpu(src->gran_erase);
+			dst->t_r = le32_to_cpu(src->t_r);
+			dst->t_sqr = le32_to_cpu(src->t_sqr);
+			dst->t_w = le32_to_cpu(src->t_w);
+			dst->t_sqw = le32_to_cpu(src->t_sqw);
+			dst->t_e = le32_to_cpu(src->t_e);
+			dst->io_sched = src->io_sched;
+		}
+
+		len -= end;
+		if (!len)
+			break;
+
+		off += end;
+
+		c.nvm_identify.chnl_off = off;
+
+		ret = nvme_submit_sync_cmd(q, (struct nvme_command *)&c,
+							nvme_nvm_id, 4096);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int nvme_nvm_identify(struct request_queue *q, struct nvm_id *nvm_id)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_nvm_id *nvme_nvm_id;
+	struct nvme_nvm_command c = {
+		.nvm_identify.opcode = nvme_nvm_admin_identify,
+		.nvm_identify.nsid = cpu_to_le32(ns->ns_id),
+		.nvm_identify.chnl_off = 0,
+	};
+	int ret;
+
+	nvme_nvm_id = kmalloc(4096, GFP_KERNEL);
+	if (!nvme_nvm_id)
+		return -ENOMEM;
+
+	ret = nvme_submit_sync_cmd(q, (struct nvme_command *)&c, nvme_nvm_id,
+									4096);
+	if (ret) {
+		ret = -EIO;
+		goto out;
+	}
+
+	nvm_id->ver_id = nvme_nvm_id->ver_id;
+	nvm_id->nvm_type = nvme_nvm_id->nvm_type;
+	nvm_id->nchannels = le16_to_cpu(nvme_nvm_id->nchannels);
+
+	if (!nvm_id->chnls)
+		nvm_id->chnls = kmalloc(sizeof(struct nvm_id_chnl)
+					* nvm_id->nchannels, GFP_KERNEL);
+	if (!nvm_id->chnls) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = init_chnls(q, nvm_id, nvme_nvm_id);
+out:
+	kfree(nvme_nvm_id);
+	return ret;
+}
+
+static int nvme_nvm_get_features(struct request_queue *q,
+						struct nvm_get_features *gf)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_nvm_command c = {
+		.common.opcode = nvme_nvm_admin_get_features,
+		.common.nsid = ns->ns_id,
+	};
+	int sz = sizeof(struct nvm_get_features);
+	int ret;
+	u64 *resp;
+
+	resp = kmalloc(sz, GFP_KERNEL);
+	if (!resp)
+		return -ENOMEM;
+
+	ret = nvme_submit_sync_cmd(q, (struct nvme_command *)&c, resp, sz);
+	if (ret)
+		goto done;
+
+	gf->rsp = le64_to_cpu(resp[0]);
+	gf->ext = le64_to_cpu(resp[1]);
+
+done:
+	kfree(resp);
+	return ret;
+}
+
+static int nvme_nvm_set_resp(struct request_queue *q, u64 resp)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_nvm_command c = {
+		.nvm_resp.opcode = nvme_nvm_admin_set_resp,
+		.nvm_resp.nsid = cpu_to_le32(ns->ns_id),
+		.nvm_resp.resp = cpu_to_le64(resp),
+	};
+
+	return nvme_submit_sync_cmd(q, (struct nvme_command *)&c, NULL, 0);
+}
+
+static int nvme_nvm_get_l2p_tbl(struct request_queue *q, u64 slba, u64 nlb,
+				nvm_l2p_update_fn *update_l2p, void *priv)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_nvm_command c = {
+		.nvm_l2p.opcode = nvme_nvm_admin_get_l2p_tbl,
+		.nvm_l2p.nsid = cpu_to_le32(ns->ns_id),
+	};
+	u32 len = queue_max_hw_sectors(q) << 9;
+	u64 nlb_pr_rq = len / sizeof(u64);
+	u64 cmd_slba = slba;
+	void *entries;
+	int ret = 0;
+
+	entries = kmalloc(len, GFP_KERNEL);
+	if (!entries)
+		return -ENOMEM;
+
+	while (nlb) {
+		u64 cmd_nlb = min_t(u64, nlb_pr_rq, nlb);
+
+		c.nvm_l2p.slba = cmd_slba;
+		c.nvm_l2p.nlb = cmd_nlb;
+
+		ret = nvme_submit_sync_cmd(q, (struct nvme_command *)&c,
+								entries, len);
+		if (ret) {
+			dev_err(dev->dev, "L2P table transfer failed (%d)\n",
+									ret);
+			ret = -EIO;
+			goto out;
+		}
+
+		if (update_l2p(cmd_slba, cmd_nlb, entries, priv)) {
+			ret = -EINTR;
+			goto out;
+		}
+
+		cmd_slba += cmd_nlb;
+		nlb -= cmd_nlb;
+	}
+
+out:
+	kfree(entries);
+	return ret;
+}
+
+static int nvme_nvm_set_bb_tbl(struct request_queue *q, int lunid,
+	unsigned int nr_blocks, nvm_bb_update_fn *update_bbtbl, void *priv)
+{
+	return 0;
+}
+
+static int nvme_nvm_get_bb_tbl(struct request_queue *q, int lunid,
+	unsigned int nr_blocks, nvm_bb_update_fn *update_bbtbl, void *priv)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_nvm_command c = {
+		.nvm_get_bb.opcode = nvme_nvm_admin_get_bb_tbl,
+		.nvm_get_bb.nsid = cpu_to_le32(ns->ns_id),
+		.nvm_get_bb.lbb = cpu_to_le32(lunid),
+	};
+	void *bb_bitmap;
+	u16 bb_bitmap_size;
+	int ret = 0;
+
+	bb_bitmap_size = ((nr_blocks >> 15) + 1) * PAGE_SIZE;
+	bb_bitmap = kmalloc(bb_bitmap_size, GFP_KERNEL);
+	if (!bb_bitmap)
+		return -ENOMEM;
+
+	bitmap_zero(bb_bitmap, nr_blocks);
+
+	ret = nvme_submit_sync_cmd(q, (struct nvme_command *)&c, bb_bitmap,
+								bb_bitmap_size);
+	if (ret) {
+		dev_err(dev->dev, "get bad block table failed (%d)\n", ret);
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = update_bbtbl(lunid, bb_bitmap, nr_blocks, priv);
+	if (ret) {
+		ret = -EINTR;
+		goto out;
+	}
+
+out:
+	kfree(bb_bitmap);
+	return ret;
+}
+
+static inline void nvme_nvm_rqtocmd(struct request *rq, struct nvm_rq *rqd,
+				struct nvme_ns *ns, struct nvme_nvm_command *c)
+{
+	c->nvm_hb_rw.opcode = (rq_data_dir(rq) ?
+				nvme_nvm_cmd_hb_write : nvme_nvm_cmd_hb_read);
+	c->nvm_hb_rw.nsid = cpu_to_le32(ns->ns_id);
+	c->nvm_hb_rw.slba = cpu_to_le64(nvme_block_nr(ns,
+						rqd->bio->bi_iter.bi_sector));
+	c->nvm_hb_rw.length = cpu_to_le16(
+		(blk_rq_bytes(rq) >> ns->lba_shift) - 1);
+	c->nvm_hb_rw.phys_addr =
+		cpu_to_le64(nvme_block_nr(ns, rqd->phys_sector));
+}
+
+static void nvme_nvm_end_io(struct request *rq, int error)
+{
+	struct nvm_rq *rqd = rq->end_io_data;
+	struct nvm_tgt_instance *ins = rqd->ins;
+
+	ins->tt->end_io(rq->end_io_data, error);
+
+	kfree(rq->cmd);
+	blk_mq_free_request(rq);
+}
+
+static int nvme_nvm_submit_io(struct request_queue *q, struct nvm_rq *rqd)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct request *rq;
+	struct bio *bio = rqd->bio;
+	struct nvme_nvm_command *cmd;
+
+	rq = blk_mq_alloc_request(q, bio_rw(bio), GFP_KERNEL, 0);
+	if (IS_ERR(rq))
+		return -ENOMEM;
+
+	cmd = kzalloc(sizeof(struct nvme_nvm_command), GFP_KERNEL);
+	if (!cmd) {
+		blk_mq_free_request(rq);
+		return -ENOMEM;
+	}
+
+	rq->cmd_type = REQ_TYPE_DRV_PRIV;
+	rq->ioprio = bio_prio(bio);
+
+	if (bio_has_data(bio))
+		rq->nr_phys_segments = bio_phys_segments(q, bio);
+
+	rq->__data_len = bio->bi_iter.bi_size;
+	rq->bio = rq->biotail = bio;
+
+	nvme_nvm_rqtocmd(rq, rqd, ns, cmd);
+
+	rq->cmd = (unsigned char *)cmd;
+	rq->cmd_len = sizeof(struct nvme_nvm_command);
+	rq->special = (void *)0;
+
+	rq->end_io_data = rqd;
+
+	blk_execute_rq_nowait(q, NULL, rq, 0, nvme_nvm_end_io);
+
+	return 0;
+}
+
+static int nvme_nvm_erase_block(struct request_queue *q, sector_t block_id)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_nvm_command c = {
+		.nvm_erase.opcode = nvme_nvm_cmd_erase,
+		.nvm_erase.nsid = cpu_to_le32(ns->ns_id),
+		.nvm_erase.blk_addr = cpu_to_le64(block_id),
+	};
+
+	return nvme_submit_sync_cmd(q, (struct nvme_command *)&c, NULL, 0);
+}
+
+static struct nvm_dev_ops nvme_nvm_dev_ops = {
+	.identify		= nvme_nvm_identify,
+
+	.get_features		= nvme_nvm_get_features,
+	.set_responsibility	= nvme_nvm_set_resp,
+
+	.get_l2p_tbl		= nvme_nvm_get_l2p_tbl,
+
+	.set_bb_tbl		= nvme_nvm_set_bb_tbl,
+	.get_bb_tbl		= nvme_nvm_get_bb_tbl,
+
+	.submit_io		= nvme_nvm_submit_io,
+	.erase_block		= nvme_nvm_erase_block,
+};
+
+int nvme_nvm_register(struct request_queue *q, struct gendisk *disk)
+{
+	return nvm_register(q, disk, &nvme_nvm_dev_ops);
+}
+#else
+int nvme_nvm_register(struct request_queue *q, struct gendisk *disk)
+{
+	return 0;
+}
+
+#endif /* CONFIG_NVM */
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index fa3fe16..fa58242 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/kref.h>
 #include <linux/blk-mq.h>
+#include <linux/lightnvm.h>
 
 struct nvme_bar {
 	__u64			cap;	/* Controller Capabilities */
@@ -41,6 +42,7 @@ struct nvme_bar {
 #define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
 #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
 #define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
+#define NVME_CAP_LIGHTNVM(cap)	(((cap) >> 38) & 0x1)
 
 #define NVME_CMB_BIR(cmbloc)	((cmbloc) & 0x7)
 #define NVME_CMB_OFST(cmbloc)	(((cmbloc) >> 12) & 0xfffff)
@@ -56,6 +58,7 @@ struct nvme_bar {
 enum {
 	NVME_CC_ENABLE		= 1 << 0,
 	NVME_CC_CSS_NVM		= 0 << 4,
+	NVME_CC_CSS_LIGHTNVM	= 1 << 4,
 	NVME_CC_MPS_SHIFT	= 7,
 	NVME_CC_ARB_RR		= 0 << 11,
 	NVME_CC_ARB_WRRU	= 1 << 11,
@@ -138,6 +141,7 @@ struct nvme_ns {
 	u16 ms;
 	bool ext;
 	u8 pi_type;
+	int type;
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
 };
@@ -184,4 +188,6 @@ int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr);
 int nvme_sg_io32(struct nvme_ns *ns, unsigned long arg);
 int nvme_sg_get_version_num(int __user *ip);
 
+int nvme_nvm_register(struct request_queue *q, struct gendisk *disk);
+
 #endif /* _LINUX_NVME_H */
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 732b32e..0374f11 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -130,6 +130,7 @@ struct nvme_id_ns {
 
 enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
+	NVME_NS_FEAT_NVM	= 1 << 3,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
 	NVME_LBAF_RP_BEST	= 0,
@@ -146,6 +147,8 @@ enum {
 	NVME_NS_DPS_PI_TYPE1	= 1,
 	NVME_NS_DPS_PI_TYPE2	= 2,
 	NVME_NS_DPS_PI_TYPE3	= 3,
+
+	NVME_NS_NVM		= 1,
 };
 
 struct nvme_smart_log {
-- 
2.1.4
