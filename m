From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Fri,  5 Jun 2015 14:54:30 +0200
Subject: [PATCH v4 8/8] nvme: LightNVM support
In-Reply-To: <1433508870-28251-1-git-send-email-m@bjorling.me>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
Message-ID: <1433508870-28251-9-git-send-email-m@bjorling.me>

The first generation of Open-Channel SSDs will be based on NVMe. The
integration requires that a NVMe device exposes itself as a LightNVM
device. The way this is done currently is by hooking into the
Controller Capabilities (CAP register) and a bit in NSFEAT for each
namespace.

After detection, vendor specific codes are used to identify the device
and enumerate supported features.

Signed-off-by: Javier Gonz?lez <jg at lightnvm.io>
Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/block/Makefile        |   2 +-
 drivers/block/nvme-core.c     | 113 +++++++++++++--
 drivers/block/nvme-lightnvm.c | 320 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h          |   9 ++
 include/uapi/linux/nvme.h     | 131 +++++++++++++++++
 5 files changed, 564 insertions(+), 11 deletions(-)
 create mode 100644 drivers/block/nvme-lightnvm.c

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 9cc6c18..37f7b3b 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -45,6 +45,6 @@ obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 obj-$(CONFIG_ZRAM) += zram/
 
-nvme-y		:= nvme-core.o nvme-scsi.o
+nvme-y		:= nvme-core.o nvme-scsi.o nvme-lightnvm.o
 skd-y		:= skd_main.o
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 6e433b1..be6e67d 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <linux/t10-pi.h>
 #include <linux/types.h>
+#include <linux/lightnvm.h>
 #include <scsi/sg.h>
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
 
@@ -134,6 +135,11 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_hb_rw) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_l2ptbl) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_bbtbl) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_set_resp) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_nvm_erase_blk) != 64);
 }
 
 typedef void (*nvme_completion_fn)(struct nvme_queue *, void *,
@@ -408,6 +414,7 @@ static inline void iod_init(struct nvme_iod *iod, unsigned nbytes,
 	iod->npages = -1;
 	iod->length = nbytes;
 	iod->nents = 0;
+	nvm_init_rq_data(&iod->nvm_rqdata);
 }
 
 static struct nvme_iod *
@@ -634,6 +641,8 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 	}
 	nvme_free_iod(nvmeq->dev, iod);
 
+	nvm_unprep_rq(req, &iod->nvm_rqdata);
+
 	blk_mq_complete_request(req);
 }
 
@@ -717,8 +726,8 @@ static int nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
 	return total_len;
 }
 
-static void nvme_submit_priv(struct nvme_queue *nvmeq, struct request *req,
-		struct nvme_iod *iod)
+static void nvme_submit_priv(struct nvme_queue *nvmeq, struct nvme_ns *ns,
+		struct request *req, struct nvme_iod *iod)
 {
 	struct nvme_command *cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
 
@@ -727,6 +736,9 @@ static void nvme_submit_priv(struct nvme_queue *nvmeq, struct request *req,
 	if (req->nr_phys_segments) {
 		cmnd->rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
 		cmnd->rw.prp2 = cpu_to_le64(iod->first_dma);
+
+		if (ns && ns->type == NVME_NS_NVM)
+			nvme_nvm_prep_internal_rq(req, ns, cmnd, iod);
 	}
 
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
@@ -778,6 +790,46 @@ static void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	writel(nvmeq->sq_tail, nvmeq->q_db);
 }
 
+static int nvme_nvm_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
+							struct nvme_ns *ns)
+{
+#ifdef CONFIG_NVM
+	struct request *req = iod_get_private(iod);
+	struct nvme_command *cmnd;
+	u16 control = 0;
+	u32 dsmgmt = 0;
+
+	if (req->cmd_flags & REQ_FUA)
+		control |= NVME_RW_FUA;
+	if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
+		control |= NVME_RW_LR;
+
+	cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
+	memset(cmnd, 0, sizeof(*cmnd));
+
+	cmnd->nvm_hb_rw.opcode = (rq_data_dir(req) ?
+				nvme_nvm_cmd_hb_write : nvme_nvm_cmd_hb_read);
+	cmnd->nvm_hb_rw.command_id = req->tag;
+	cmnd->nvm_hb_rw.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->nvm_hb_rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+	cmnd->nvm_hb_rw.prp2 = cpu_to_le64(iod->first_dma);
+	cmnd->nvm_hb_rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+	cmnd->nvm_hb_rw.length = cpu_to_le16(
+			(blk_rq_bytes(req) >> ns->lba_shift) - 1);
+	cmnd->nvm_hb_rw.control = cpu_to_le16(control);
+	cmnd->nvm_hb_rw.dsmgmt = cpu_to_le32(dsmgmt);
+	cmnd->nvm_hb_rw.phys_addr =
+			cpu_to_le64(nvme_block_nr(ns,
+						iod->nvm_rqdata.phys_sector));
+
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+	writel(nvmeq->sq_tail, nvmeq->q_db);
+#endif /* CONFIG_NVM */
+
+	return 0;
+}
+
 static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 							struct nvme_ns *ns)
 {
@@ -909,14 +961,31 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		}
 	}
 
+	if (ns && ns->type == NVME_NS_NVM) {
+		switch (nvm_prep_rq(req, &iod->nvm_rqdata)) {
+		case NVM_PREP_DONE:
+			goto done_cmd;
+		case NVM_PREP_REQUEUE:
+			blk_mq_requeue_request(req);
+			blk_mq_kick_requeue_list(hctx->queue);
+			goto done_cmd;
+		case NVM_PREP_BUSY:
+			goto retry_cmd;
+		case NVM_PREP_ERROR:
+			goto error_cmd;
+		}
+	}
+
 	nvme_set_info(cmd, iod, req_completion);
 	spin_lock_irq(&nvmeq->q_lock);
 	if (req->cmd_type == REQ_TYPE_DRV_PRIV)
-		nvme_submit_priv(nvmeq, req, iod);
+		nvme_submit_priv(nvmeq, ns, req, iod);
 	else if (req->cmd_flags & REQ_DISCARD)
 		nvme_submit_discard(nvmeq, ns, req, iod);
 	else if (req->cmd_flags & REQ_FLUSH)
 		nvme_submit_flush(nvmeq, ns, req->tag);
+	else if (ns && ns->type == NVME_NS_NVM)
+		nvme_nvm_submit_iod(nvmeq, iod, ns);
 	else
 		nvme_submit_iod(nvmeq, iod, ns);
 
@@ -924,6 +993,9 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	spin_unlock_irq(&nvmeq->q_lock);
 	return BLK_MQ_RQ_QUEUE_OK;
 
+ done_cmd:
+	nvme_free_iod(nvmeq->dev, iod);
+	return BLK_MQ_RQ_QUEUE_OK;
  error_cmd:
 	nvme_free_iod(dev, iod);
 	return BLK_MQ_RQ_QUEUE_ERROR;
@@ -1699,7 +1771,8 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 
 	dev->page_size = 1 << page_shift;
 
-	dev->ctrl_config = NVME_CC_CSS_NVM;
+	dev->ctrl_config = NVME_CAP_LIGHTNVM(cap) ?
+					NVME_CC_CSS_LIGHTNVM : NVME_CC_CSS_NVM;
 	dev->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
 	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
 	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
@@ -1932,6 +2005,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	u8 lbaf, pi_type;
 	u16 old_ms;
 	unsigned short bs;
+	int ret = 0;
 
 	if (nvme_identify_ns(dev, ns->ns_id, &id)) {
 		dev_warn(dev->dev, "%s: Identify failure\n", __func__);
@@ -1977,8 +2051,17 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	if (dev->oncs & NVME_CTRL_ONCS_DSM)
 		nvme_config_discard(ns);
 
+	if ((dev->ctrl_config & NVME_CC_CSS_LIGHTNVM) &&
+		id->nsfeat & NVME_NS_FEAT_NVM && ns->type != NVME_NS_NVM) {
+		ret = nvme_nvm_register(ns->queue, disk);
+		if (ret)
+			dev_warn(dev->dev,
+				    "%s: LightNVM init failure\n", __func__);
+		ns->type = NVME_NS_NVM;
+	}
+
 	kfree(id);
-	return 0;
+	return ret;
 }
 
 static const struct block_device_operations nvme_fops = {
@@ -2058,7 +2141,6 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	ns->ns_id = nsid;
 	ns->disk = disk;
 	ns->lba_shift = 9; /* set to a default value for 512 until disk is validated */
-	list_add_tail(&ns->list, &dev->namespaces);
 
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	if (dev->max_hw_sectors)
@@ -2072,7 +2154,6 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	disk->first_minor = 0;
 	disk->fops = &nvme_fops;
 	disk->private_data = ns;
-	disk->queue = ns->queue;
 	disk->driverfs_dev = dev->device;
 	disk->flags = GENHD_FL_EXT_DEVT;
 	sprintf(disk->disk_name, "nvme%dn%d", dev->instance, nsid);
@@ -2084,11 +2165,20 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	 * requires it.
 	 */
 	set_capacity(disk, 0);
-	nvme_revalidate_disk(ns->disk);
+	if (nvme_revalidate_disk(ns->disk))
+		goto out_put_disk;
+
+	list_add_tail(&ns->list, &dev->namespaces);
+
+	disk->queue = ns->queue;
 	add_disk(ns->disk);
+	nvm_attach_sysfs(ns->disk);
 	if (ns->ms)
 		revalidate_disk(ns->disk);
 	return;
+
+ out_put_disk:
+	put_disk(disk);
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
@@ -2217,7 +2307,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	int res;
 	unsigned nn, i;
 	struct nvme_id_ctrl *ctrl;
-	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
+	u64 cap = readq(&dev->bar->cap);
+	int shift = NVME_CAP_MPSMIN(cap) + 12;
 
 	res = nvme_identify_ctrl(dev, &ctrl);
 	if (res) {
@@ -2255,9 +2346,11 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	dev->tagset.queue_depth =
 				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
 	dev->tagset.cmd_size = nvme_cmd_size(dev);
-	dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 	dev->tagset.driver_data = dev;
 
+	if (!NVME_CAP_LIGHTNVM(cap))
+		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
+
 	if (blk_mq_alloc_tag_set(&dev->tagset))
 		return 0;
 
diff --git a/drivers/block/nvme-lightnvm.c b/drivers/block/nvme-lightnvm.c
new file mode 100644
index 0000000..1a57c1b8
--- /dev/null
+++ b/drivers/block/nvme-lightnvm.c
@@ -0,0 +1,320 @@
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
+static int init_chnls(struct request_queue *q, struct nvm_id *nvm_id,
+						struct nvme_nvm_id *nvme_nvm_id)
+{
+	struct nvme_nvm_id_chnl *src = nvme_nvm_id->chnls;
+	struct nvm_id_chnl *dst = nvm_id->chnls;
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_command c = {
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
+		ret = nvme_submit_sync_cmd(q, &c, nvme_nvm_id, 4096);
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
+	struct nvme_command c = {
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
+	ret = nvme_submit_sync_cmd(q, &c, nvme_nvm_id, 4096);
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
+	struct nvme_command c = {
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
+	ret = nvme_submit_sync_cmd(q, &c, resp, sz);
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
+	struct nvme_command c = {
+		.nvm_resp.opcode = nvme_nvm_admin_set_resp,
+		.nvm_resp.nsid = cpu_to_le32(ns->ns_id),
+		.nvm_resp.resp = cpu_to_le64(resp),
+	};
+
+	return nvme_submit_sync_cmd(q, &c, NULL, 0);
+}
+
+static int nvme_nvm_get_l2p_tbl(struct request_queue *q, u64 slba, u64 nlb,
+				nvm_l2p_update_fn *update_l2p, void *priv)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_dev *dev = ns->dev;
+	struct nvme_command c = {
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
+		ret = nvme_submit_sync_cmd(q, &c, entries, len);
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
+	struct nvme_command c = {
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
+	ret = nvme_submit_sync_cmd(q, &c, bb_bitmap, bb_bitmap_size);
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
+int nvme_nvm_prep_internal_rq(struct request *rq, struct nvme_ns *ns,
+				struct nvme_command *c, struct nvme_iod *iod)
+{
+	struct nvm_rq_data *rqdata = &iod->nvm_rqdata;
+	struct nvm_internal_cmd *cmd = rq->special;
+
+	if (!cmd)
+		return 0;
+
+	if (nvm_prep_rq(rq, rqdata))
+		dev_err(ns->dev->dev, "lightnvm: internal cmd failed\n");
+
+	c->nvm_hb_rw.length = cpu_to_le16(
+			(blk_rq_bytes(rq) >> ns->lba_shift) - 1);
+	c->nvm_hb_rw.nsid = cpu_to_le32(ns->ns_id);
+	c->nvm_hb_rw.slba = cpu_to_le64(cmd->phys_lba);
+	c->nvm_hb_rw.phys_addr =
+		cpu_to_le64(nvme_block_nr(ns, rqdata->phys_sector));
+
+	return 0;
+}
+
+static int nvme_nvm_internal_rw(struct request_queue *q,
+						struct nvm_internal_cmd *cmd)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+
+	c.nvm_hb_rw.opcode = (cmd->rw ?
+				nvme_nvm_cmd_hb_write : nvme_nvm_cmd_hb_read);
+
+	return __nvme_submit_sync_cmd(q, &c, cmd->buffer, NULL,
+						cmd->bufflen, NULL, 30, cmd);
+}
+
+static int nvme_nvm_erase_block(struct request_queue *q, sector_t block_id)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_command c = {
+		.nvm_erase.opcode = nvme_nvm_cmd_erase,
+		.nvm_erase.nsid = cpu_to_le32(ns->ns_id),
+		.nvm_erase.blk_addr = cpu_to_le64(block_id),
+	};
+
+	return nvme_submit_sync_cmd(q, &c, NULL, 0);
+}
+
+static struct nvm_dev_ops nvme_nvm_dev_ops = {
+	.identify		= nvme_nvm_identify,
+	.get_features		= nvme_nvm_get_features,
+	.set_responsibility	= nvme_nvm_set_resp,
+	.get_l2p_tbl		= nvme_nvm_get_l2p_tbl,
+	.set_bb_tbl		= nvme_nvm_set_bb_tbl,
+	.get_bb_tbl		= nvme_nvm_get_bb_tbl,
+	.internal_rw		= nvme_nvm_internal_rw,
+	.erase_block		= nvme_nvm_erase_block,
+};
+
+#else
+static struct nvm_dev_ops nvme_nvm_dev_ops;
+static nvm_data_rq;
+
+void nvme_nvm_prep_internal_rq(struct request *rq, struct nvme_ns *ns,
+			struct nvme_command *c, struct nvme_iod *iod)
+{
+}
+#endif /* CONFIG_NVM */
+
+int nvme_nvm_register(struct request_queue *q, struct gendisk *disk)
+{
+	return nvm_register(q, disk, &nvme_nvm_dev_ops);
+}
+
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index fce2090..8fbc7bf 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/kref.h>
 #include <linux/blk-mq.h>
+#include <linux/lightnvm.h>
 
 struct nvme_bar {
 	__u64			cap;	/* Controller Capabilities */
@@ -39,10 +40,12 @@ struct nvme_bar {
 #define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
 #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
 #define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
+#define NVME_CAP_LIGHTNVM(cap)	(((cap) >> 38) & 0x1)
 
 enum {
 	NVME_CC_ENABLE		= 1 << 0,
 	NVME_CC_CSS_NVM		= 0 << 4,
+	NVME_CC_CSS_LIGHTNVM	= 1 << 4,
 	NVME_CC_MPS_SHIFT	= 7,
 	NVME_CC_ARB_RR		= 0 << 11,
 	NVME_CC_ARB_WRRU	= 1 << 11,
@@ -120,6 +123,7 @@ struct nvme_ns {
 	u16 ms;
 	bool ext;
 	u8 pi_type;
+	int type;
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
 };
@@ -137,6 +141,7 @@ struct nvme_iod {
 	int nents;		/* Used in scatterlist */
 	int length;		/* Of data, in bytes */
 	dma_addr_t first_dma;
+	struct nvm_rq_data nvm_rqdata; /* Physical sectors description of the I/O */
 	struct scatterlist meta_sg[1]; /* metadata requires single contiguous buffer */
 	struct scatterlist sg[0];
 };
@@ -166,4 +171,8 @@ int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr);
 int nvme_sg_io32(struct nvme_ns *ns, unsigned long arg);
 int nvme_sg_get_version_num(int __user *ip);
 
+int nvme_nvm_register(struct request_queue *q, struct gendisk *disk);
+int nvme_nvm_prep_internal_rq(struct request *rq, struct nvme_ns *ns,
+				struct nvme_command *c, struct nvme_iod *iod);
+
 #endif /* _LINUX_NVME_H */
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index aef9a81..8adf845 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -85,6 +85,35 @@ struct nvme_id_ctrl {
 	__u8			vs[1024];
 };
 
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
+} __attribute__((packed));
+
+struct nvme_nvm_id {
+	__u8				ver_id;
+	__u8				nvm_type;
+	__le16				nchannels;
+	__u8				reserved[252];
+	struct nvme_nvm_id_chnl	chnls[];
+} __attribute__((packed));
+
+#define NVME_NVM_CHNLS_PR_REQ ((4096U - sizeof(struct nvme_nvm_id)) \
+					/ sizeof(struct nvme_nvm_id_chnl))
+
 enum {
 	NVME_CTRL_ONCS_COMPARE			= 1 << 0,
 	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
@@ -130,6 +159,7 @@ struct nvme_id_ns {
 
 enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
+	NVME_NS_FEAT_NVM	= 1 << 3,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
 	NVME_LBAF_RP_BEST	= 0,
@@ -146,6 +176,8 @@ enum {
 	NVME_NS_DPS_PI_TYPE1	= 1,
 	NVME_NS_DPS_PI_TYPE2	= 2,
 	NVME_NS_DPS_PI_TYPE3	= 3,
+
+	NVME_NS_NVM		= 1,
 };
 
 struct nvme_smart_log {
@@ -229,6 +261,12 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+
+	nvme_nvm_cmd_hb_write	= 0x81,
+	nvme_nvm_cmd_hb_read	= 0x02,
+	nvme_nvm_cmd_phys_write	= 0x91,
+	nvme_nvm_cmd_phys_read	= 0x92,
+	nvme_nvm_cmd_erase	= 0x90,
 };
 
 struct nvme_common_command {
@@ -261,6 +299,73 @@ struct nvme_rw_command {
 	__le16			appmask;
 };
 
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
 enum {
 	NVME_RW_LR			= 1 << 15,
 	NVME_RW_FUA			= 1 << 14,
@@ -328,6 +433,13 @@ enum nvme_admin_opcode {
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
 	nvme_admin_security_recv	= 0x82,
+
+	nvme_nvm_admin_identify		= 0xe2,
+	nvme_nvm_admin_get_features	= 0xe6,
+	nvme_nvm_admin_set_resp		= 0xe5,
+	nvme_nvm_admin_get_l2p_tbl	= 0xea,
+	nvme_nvm_admin_get_bb_tbl	= 0xf2,
+	nvme_nvm_admin_set_bb_tbl	= 0xf1,
 };
 
 enum {
@@ -457,6 +569,18 @@ struct nvme_format_cmd {
 	__u32			rsvd11[5];
 };
 
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
 struct nvme_command {
 	union {
 		struct nvme_common_command common;
@@ -470,6 +594,13 @@ struct nvme_command {
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
 		struct nvme_abort_cmd abort;
+		struct nvme_nvm_identify nvm_identify;
+		struct nvme_nvm_hb_rw nvm_hb_rw;
+		struct nvme_nvm_l2ptbl nvm_l2p;
+		struct nvme_nvm_bbtbl nvm_get_bb;
+		struct nvme_nvm_bbtbl nvm_set_bb;
+		struct nvme_nvm_set_resp nvm_resp;
+		struct nvme_nvm_erase_blk nvm_erase;
 	};
 };
 
-- 
2.1.4
