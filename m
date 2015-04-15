From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 15 Apr 2015 14:34:44 +0200
Subject: [PATCH 5/5 v2] nvme: LightNVM support
In-Reply-To: <1429101284-19490-1-git-send-email-m@bjorling.me>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
Message-ID: <1429101284-19490-6-git-send-email-m@bjorling.me>

The first generation of Open-Channel SSDs will be based on NVMe. The
integration requires that a NVMe device exposes itself as a LightNVM
device. The way this is done currently is by hooking into the
Controller Capabilities (CAP register) and a bit in NSFEAT for each
namespace.

After detection, vendor specific codes are used to identify the device
and enumerate supported features.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/block/nvme-core.c | 380 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/nvme.h      |   2 +
 include/uapi/linux/nvme.h | 116 ++++++++++++++
 3 files changed, 497 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e23be20..cbbf728 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <linux/t10-pi.h>
 #include <linux/types.h>
+#include <linux/lightnvm.h>
 #include <scsi/sg.h>
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
 
@@ -134,6 +135,8 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
+	BUILD_BUG_ON(sizeof(struct nvme_lnvm_hb_write_command) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_lnvm_l2ptbl_command) != 64);
 }
 
 typedef void (*nvme_completion_fn)(struct nvme_queue *, void *,
@@ -591,6 +594,30 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 }
 #endif
 
+static struct nvme_iod *nvme_get_dma_iod(struct nvme_dev *dev, void *buf,
+								unsigned length)
+{
+	struct scatterlist *sg;
+	struct nvme_iod *iod;
+	struct device *ddev = &dev->pci_dev->dev;
+
+	if (!length || length > INT_MAX - PAGE_SIZE)
+		return ERR_PTR(-EINVAL);
+
+	iod = __nvme_alloc_iod(1, length, dev, 0, GFP_KERNEL);
+	if (!iod)
+		goto err;
+
+	sg = iod->sg;
+	sg_init_one(sg, buf, length);
+	iod->nents = 1;
+	dma_map_sg(ddev, sg, iod->nents, DMA_FROM_DEVICE);
+
+	return iod;
+err:
+	return ERR_PTR(-ENOMEM);
+}
+
 static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
@@ -760,6 +787,46 @@ static void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	writel(nvmeq->sq_tail, nvmeq->q_db);
 }
 
+static int nvme_submit_lnvm_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
+							struct nvme_ns *ns)
+{
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
+	if (req->cmd_flags & REQ_RAHEAD)
+		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
+
+	cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
+	memset(cmnd, 0, sizeof(*cmnd));
+
+	cmnd->lnvm_hb_w.opcode = (rq_data_dir(req) ?
+				lnvm_cmd_hybrid_write : lnvm_cmd_hybrid_read);
+	cmnd->lnvm_hb_w.command_id = req->tag;
+	cmnd->lnvm_hb_w.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->lnvm_hb_w.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+	cmnd->lnvm_hb_w.prp2 = cpu_to_le64(iod->first_dma);
+	cmnd->lnvm_hb_w.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+	cmnd->lnvm_hb_w.length = cpu_to_le16(
+			(blk_rq_bytes(req) >> ns->lba_shift) - 1);
+	cmnd->lnvm_hb_w.control = cpu_to_le16(control);
+	cmnd->lnvm_hb_w.dsmgmt = cpu_to_le32(dsmgmt);
+	cmnd->lnvm_hb_w.phys_addr =
+			cpu_to_le64(nvme_block_nr(ns, req->phys_sector));
+
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+	writel(nvmeq->sq_tail, nvmeq->q_db);
+
+	return 0;
+}
+
 static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 							struct nvme_ns *ns)
 {
@@ -895,6 +962,8 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		nvme_submit_discard(nvmeq, ns, req, iod);
 	else if (req->cmd_flags & REQ_FLUSH)
 		nvme_submit_flush(nvmeq, ns, req->tag);
+	else if (req->cmd_flags & REQ_NVM_MAPPED)
+		nvme_submit_lnvm_iod(nvmeq, iod, ns);
 	else
 		nvme_submit_iod(nvmeq, iod, ns);
 
@@ -1156,6 +1225,84 @@ static int adapter_delete_sq(struct nvme_dev *dev, u16 sqid)
 	return adapter_delete_queue(dev, nvme_admin_delete_sq, sqid);
 }
 
+int nvme_nvm_identify_cmd(struct nvme_dev *dev, u32 chnl_off,
+							dma_addr_t dma_addr)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = lnvm_admin_identify;
+	c.common.nsid = cpu_to_le32(chnl_off);
+	c.common.prp1 = cpu_to_le64(dma_addr);
+
+	return nvme_submit_admin_cmd(dev, &c, NULL);
+}
+
+int nvme_nvm_get_features_cmd(struct nvme_dev *dev, unsigned nsid,
+							dma_addr_t dma_addr)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = lnvm_admin_get_features;
+	c.common.nsid = cpu_to_le32(nsid);
+	c.common.prp1 = cpu_to_le64(dma_addr);
+
+	return nvme_submit_admin_cmd(dev, &c, NULL);
+}
+
+int nvme_nvm_set_responsibility_cmd(struct nvme_dev *dev, unsigned nsid,
+								u64 resp)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = lnvm_admin_set_responsibility;
+	c.common.nsid = cpu_to_le32(nsid);
+	c.lnvm_resp.resp = cpu_to_le64(resp);
+
+	return nvme_submit_admin_cmd(dev, &c, NULL);
+}
+
+int nvme_nvm_get_l2p_tbl_cmd(struct nvme_dev *dev, unsigned nsid, u64 slba,
+				u32 nlb, u16 dma_npages, struct nvme_iod *iod)
+{
+	struct nvme_command c;
+	unsigned length;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = lnvm_admin_get_l2p_tbl;
+	c.common.nsid = cpu_to_le32(nsid);
+
+	c.lnvm_l2p.slba = cpu_to_le64(slba);
+	c.lnvm_l2p.nlb = cpu_to_le32(nlb);
+	c.lnvm_l2p.prp1_len = cpu_to_le16(dma_npages);
+
+	length = nvme_setup_prps(dev, iod, iod->length, GFP_KERNEL);
+	if ((length >> 12) != dma_npages)
+		return -ENOMEM;
+
+	c.common.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+	c.common.prp2 = cpu_to_le64(iod->first_dma);
+
+	return nvme_submit_admin_cmd(dev, &c, NULL);
+}
+
+int nvme_nvm_erase_block_cmd(struct nvme_dev *dev, struct nvme_ns *ns,
+						sector_t block_id)
+{
+	struct nvme_command c;
+	int nsid = ns->ns_id;
+	int res;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = lnvm_cmd_erase_sync;
+	c.common.nsid = cpu_to_le32(nsid);
+	c.lnvm_erase.blk_addr = cpu_to_le64(block_id);
+
+	return nvme_submit_io_cmd(dev, ns, &c, &res);
+}
+
 int nvme_identify(struct nvme_dev *dev, unsigned nsid, unsigned cns,
 							dma_addr_t dma_addr)
 {
@@ -1551,6 +1698,185 @@ static int nvme_shutdown_ctrl(struct nvme_dev *dev)
 	return 0;
 }
 
+static int init_chnls(struct nvme_dev *dev, struct nvm_id *nvm_id,
+			struct nvme_lnvm_id *dma_buf, dma_addr_t dma_addr)
+{
+	struct nvme_lnvm_id_chnl *src = dma_buf->chnls;
+	struct nvm_id_chnl *dst = nvm_id->chnls;
+	unsigned int len = nvm_id->nchannels;
+	int i, end, off = 0;
+
+	while (len) {
+		end = min_t(u32, NVME_LNVM_CHNLS_PR_REQ, len);
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
+		if (nvme_nvm_identify_cmd(dev, off, dma_addr))
+			return -EIO;
+
+		src = dma_buf->chnls;
+	}
+	return 0;
+}
+
+static int nvme_nvm_identify(struct request_queue *q, struct nvm_id *nvm_id)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_dev *dev = ns->dev;
+	struct pci_dev *pdev = dev->pci_dev;
+	struct nvme_lnvm_id *ctrl;
+	dma_addr_t dma_addr;
+	unsigned int ret;
+
+	ctrl = dma_alloc_coherent(&pdev->dev, 4096, &dma_addr, GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	ret = nvme_nvm_identify_cmd(dev, 0, dma_addr);
+	if (ret) {
+		ret = -EIO;
+		goto out;
+	}
+
+	nvm_id->ver_id = ctrl->ver_id;
+	nvm_id->nvm_type = ctrl->nvm_type;
+	nvm_id->nchannels = le16_to_cpu(ctrl->nchannels);
+
+	if (!nvm_id->chnls)
+		nvm_id->chnls = kmalloc(sizeof(struct nvm_id_chnl)
+					* nvm_id->nchannels, GFP_KERNEL);
+
+	if (!nvm_id->chnls) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = init_chnls(dev, nvm_id, ctrl, dma_addr);
+out:
+	dma_free_coherent(&pdev->dev, 4096, ctrl, dma_addr);
+	return ret;
+}
+
+static int nvme_nvm_get_features(struct request_queue *q,
+						struct nvm_get_features *gf)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_dev *dev = ns->dev;
+	struct pci_dev *pdev = dev->pci_dev;
+	dma_addr_t dma_addr;
+	int ret = 0;
+	u64 *mem;
+
+	mem = (u64 *)dma_alloc_coherent(&pdev->dev,
+					sizeof(struct nvm_get_features),
+							&dma_addr, GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	ret = nvme_nvm_get_features_cmd(dev, ns->ns_id, dma_addr);
+	if (ret)
+		goto finish;
+
+	gf->rsp = le64_to_cpu(mem[0]);
+	gf->ext = le64_to_cpu(mem[1]);
+
+finish:
+	dma_free_coherent(&pdev->dev, sizeof(struct nvm_get_features), mem,
+								dma_addr);
+	return ret;
+}
+
+static int nvme_nvm_set_responsibility(struct request_queue *q, u64 resp)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_dev *dev = ns->dev;
+
+	return nvme_nvm_set_responsibility_cmd(dev, ns->ns_id, resp);
+}
+
+static int nvme_nvm_get_l2p_tbl(struct request_queue *q, u64 slba, u64 nlb,
+				nvm_l2p_update_fn *update_l2p, void *private)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_dev *dev = ns->dev;
+	struct pci_dev *pdev = dev->pci_dev;
+	static const u16 dma_npages = 256U;
+	static const u32 length = dma_npages * PAGE_SIZE;
+	u64 nlb_pr_dma = length / sizeof(u64);
+	struct nvme_iod *iod;
+	u64 cmd_slba = slba;
+	dma_addr_t dma_addr;
+	void *entries;
+	int res = 0;
+
+	entries = dma_alloc_coherent(&pdev->dev, length, &dma_addr, GFP_KERNEL);
+	if (!entries)
+		return -ENOMEM;
+
+	iod = nvme_get_dma_iod(dev, entries, length);
+	if (!iod) {
+		res = -ENOMEM;
+		goto out;
+	}
+
+	while (nlb) {
+		u64 cmd_nlb = min_t(u64, nlb_pr_dma, nlb);
+
+		res = nvme_nvm_get_l2p_tbl_cmd(dev, ns->ns_id, cmd_slba,
+						(u32)cmd_nlb, dma_npages, iod);
+		if (res) {
+			dev_err(&pdev->dev, "L2P table transfer failed (%d)\n",
+									res);
+			res = -EIO;
+			goto free_iod;
+		}
+
+		if (update_l2p(cmd_slba, cmd_nlb, entries, private)) {
+			res = -EINTR;
+			goto free_iod;
+		}
+
+		cmd_slba += cmd_nlb;
+		nlb -= cmd_nlb;
+	}
+
+free_iod:
+	dma_unmap_sg(&pdev->dev, iod->sg, 1, DMA_FROM_DEVICE);
+	nvme_free_iod(dev, iod);
+out:
+	dma_free_coherent(&pdev->dev, PAGE_SIZE * dma_npages, entries,
+								dma_addr);
+	return res;
+}
+
+static int nvme_nvm_erase_block(struct request_queue *q, sector_t block_id)
+{
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_dev *dev = ns->dev;
+
+	return nvme_nvm_erase_block_cmd(dev, ns, block_id);
+}
+
 static struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_admin_queue_rq,
 	.map_queue	= blk_mq_map_queue,
@@ -1560,6 +1886,14 @@ static struct blk_mq_ops nvme_mq_admin_ops = {
 	.timeout	= nvme_timeout,
 };
 
+static struct nvm_dev_ops nvme_nvm_dev_ops = {
+	.identify		= nvme_nvm_identify,
+	.get_features		= nvme_nvm_get_features,
+	.set_responsibility	= nvme_nvm_set_responsibility,
+	.get_l2p_tbl		= nvme_nvm_get_l2p_tbl,
+	.erase_block		= nvme_nvm_erase_block,
+};
+
 static struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.map_queue	= blk_mq_map_queue,
@@ -1744,6 +2078,26 @@ void nvme_unmap_user_pages(struct nvme_dev *dev, int write,
 		put_page(sg_page(&iod->sg[i]));
 }
 
+static int nvme_nvm_submit_io(struct nvme_ns *ns, struct nvme_user_io *io)
+{
+	struct nvme_command c;
+	struct nvme_dev *dev = ns->dev;
+
+	memset(&c, 0, sizeof(c));
+	c.rw.opcode = io->opcode;
+	c.rw.flags = io->flags;
+	c.rw.nsid = cpu_to_le32(ns->ns_id);
+	c.rw.slba = cpu_to_le64(io->slba);
+	c.rw.length = cpu_to_le16(io->nblocks);
+	c.rw.control = cpu_to_le16(io->control);
+	c.rw.dsmgmt = cpu_to_le32(io->dsmgmt);
+	c.rw.reftag = cpu_to_le32(io->reftag);
+	c.rw.apptag = cpu_to_le16(io->apptag);
+	c.rw.appmask = cpu_to_le16(io->appmask);
+
+	return nvme_submit_io_cmd(dev, ns, &c, NULL);
+}
+
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
 	struct nvme_dev *dev = ns->dev;
@@ -1769,6 +2123,10 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	case nvme_cmd_compare:
 		iod = nvme_map_user_pages(dev, io.opcode & 1, io.addr, length);
 		break;
+	case lnvm_admin_identify:
+	case lnvm_admin_get_features:
+	case lnvm_admin_set_responsibility:
+		return nvme_nvm_submit_io(ns, &io);
 	default:
 		return -EINVAL;
 	}
@@ -2073,6 +2431,17 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	if (dev->oncs & NVME_CTRL_ONCS_DSM)
 		nvme_config_discard(ns);
 
+	if (id->nsfeat & NVME_NS_FEAT_NVM) {
+		if (blk_nvm_register(ns->queue, &nvme_nvm_dev_ops)) {
+			dev_warn(&dev->pci_dev->dev,
+				 "%s: LightNVM init failure\n", __func__);
+			return 0;
+		}
+
+		/* FIXME: This will be handled later by ns */
+		ns->queue->nvm->drv_cmd_size = sizeof(struct nvme_cmd_info);
+	}
+
 	dma_free_coherent(&dev->pci_dev->dev, 4096, id, dma_addr);
 	return 0;
 }
@@ -2185,6 +2554,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	if (ns->ms)
 		revalidate_disk(ns->disk);
 	return;
+
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
@@ -2316,7 +2686,9 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	struct nvme_id_ctrl *ctrl;
 	void *mem;
 	dma_addr_t dma_addr;
-	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
+	u64 cap = readq(&dev->bar->cap);
+	int shift = NVME_CAP_MPSMIN(cap) + 12;
+	int nvm_cmdset = NVME_CAP_NVM(cap);
 
 	mem = dma_alloc_coherent(&pdev->dev, 4096, &dma_addr, GFP_KERNEL);
 	if (!mem)
@@ -2332,6 +2704,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	ctrl = mem;
 	nn = le32_to_cpup(&ctrl->nn);
 	dev->oncs = le16_to_cpup(&ctrl->oncs);
+	dev->oacs = le16_to_cpup(&ctrl->oacs);
 	dev->abort_limit = ctrl->acl + 1;
 	dev->vwc = ctrl->vwc;
 	dev->event_limit = min(ctrl->aerl + 1, 8);
@@ -2364,6 +2737,11 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 	dev->tagset.driver_data = dev;
 
+	if (nvm_cmdset) {
+		dev->tagset.flags &= ~BLK_MQ_F_SHOULD_MERGE;
+		dev->tagset.flags |= BLK_MQ_F_NVM;
+	}
+
 	if (blk_mq_alloc_tag_set(&dev->tagset))
 		return 0;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 0adad4a..dc9c805 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -39,6 +39,7 @@ struct nvme_bar {
 #define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
 #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
 #define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
+#define NVME_CAP_NVM(cap)	(((cap) >> 38) & 0x1)
 
 enum {
 	NVME_CC_ENABLE		= 1 << 0,
@@ -100,6 +101,7 @@ struct nvme_dev {
 	u32 stripe_size;
 	u32 page_size;
 	u16 oncs;
+	u16 oacs;
 	u16 abort_limit;
 	u8 event_limit;
 	u8 vwc;
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index aef9a81..64c91a5 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -85,6 +85,35 @@ struct nvme_id_ctrl {
 	__u8			vs[1024];
 };
 
+struct nvme_lnvm_id_chnl {
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
+struct nvme_lnvm_id {
+	__u8				ver_id;
+	__u8				nvm_type;
+	__le16				nchannels;
+	__u8				reserved[252];
+	struct nvme_lnvm_id_chnl	chnls[];
+} __attribute__((packed));
+
+#define NVME_LNVM_CHNLS_PR_REQ ((4096U - sizeof(struct nvme_lnvm_id)) \
+					/ sizeof(struct nvme_lnvm_id_chnl))
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
@@ -231,6 +261,14 @@ enum nvme_opcode {
 	nvme_cmd_resv_release	= 0x15,
 };
 
+enum lnvme_opcode {
+	lnvm_cmd_hybrid_write	= 0x81,
+	lnvm_cmd_hybrid_read	= 0x02,
+	lnvm_cmd_phys_write	= 0x91,
+	lnvm_cmd_phys_read	= 0x92,
+	lnvm_cmd_erase_sync	= 0x90,
+};
+
 struct nvme_common_command {
 	__u8			opcode;
 	__u8			flags;
@@ -261,6 +299,60 @@ struct nvme_rw_command {
 	__le16			appmask;
 };
 
+struct nvme_lnvm_hb_write_command {
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
+struct nvme_lnvm_l2ptbl_command {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le32			cdw2[4];
+	__le64			prp1;
+	__le64			prp2;
+	__le64			slba;
+	__le32			nlb;
+	__u16			prp1_len;
+	__le16			cdw14[5];
+};
+
+struct nvme_lnvm_set_resp_command {
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
+struct nvme_lnvm_erase_block {
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
@@ -328,6 +420,13 @@ enum nvme_admin_opcode {
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
 	nvme_admin_security_recv	= 0x82,
+
+	lnvm_admin_identify		= 0xe2,
+	lnvm_admin_get_features		= 0xe6,
+	lnvm_admin_set_responsibility	= 0xe5,
+	lnvm_admin_get_l2p_tbl		= 0xea,
+	lnvm_admin_get_bb_tbl		= 0xf2,
+	lnvm_admin_set_bb_tbl		= 0xf1,
 };
 
 enum {
@@ -457,6 +556,18 @@ struct nvme_format_cmd {
 	__u32			rsvd11[5];
 };
 
+struct nvme_lnvm_identify {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd[2];
+	__le64			prp1;
+	__le64			prp2;
+	__le32			cns;
+	__u32			rsvd11[5];
+};
+
 struct nvme_command {
 	union {
 		struct nvme_common_command common;
@@ -470,6 +581,11 @@ struct nvme_command {
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
 		struct nvme_abort_cmd abort;
+		struct nvme_lnvm_identify lnvm_identify;
+		struct nvme_lnvm_hb_write_command lnvm_hb_w;
+		struct nvme_lnvm_l2ptbl_command lnvm_l2p;
+		struct nvme_lnvm_set_resp_command lnvm_resp;
+		struct nvme_lnvm_erase_block lnvm_erase;
 	};
 };
 
-- 
1.9.1
