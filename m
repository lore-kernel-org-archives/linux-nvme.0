From: keith.busch@intel.com (Keith Busch)
Date: Thu,  2 Aug 2012 12:59:04 -0600
Subject: [PATCH] NVMe: Add discard support for capable devices
Message-ID: <1343933944-32726-1-git-send-email-keith.busch@intel.com>

This adds discard support to block queues if the nvme device is capable
of deallocating blocks as indicated by the controller's optional command
support. A discard flagged bio request will submit an NVMe deallocate
Data Set Management command for the requested blocks.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h |   32 +++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 3278fbd..d8c1e96 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -79,6 +79,7 @@ struct nvme_dev {
 	char model[40];
 	char firmware_rev[8];
 	u32 max_hw_sectors;
+	u16 oncs;
 };
 
 /*
@@ -334,6 +335,7 @@ nvme_alloc_iod(unsigned nseg, unsigned nbytes, gfp_t gfp)
 		iod->offset = offsetof(struct nvme_iod, sg[nseg]);
 		iod->npages = -1;
 		iod->length = nbytes;
+		iod->nents = 0;
 	}
 
 	return iod;
@@ -505,6 +507,39 @@ static int nvme_map_bio(struct device *dev, struct nvme_iod *iod,
 	return length;
 }
 
+static int nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
+		struct bio *bio, struct nvme_iod *iod, int cmdid)
+{
+	struct nvme_dsm_range *range;
+	struct nvme_command *cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
+
+	range = dma_pool_alloc(nvmeq->dev->prp_small_pool, GFP_ATOMIC,
+							&iod->first_dma);
+	if (range == NULL)
+		return -ENOMEM;
+
+	iod_list(iod)[0] = (__le64 *)range;
+	iod->npages = 0;
+
+	range->cattr = cpu_to_le32(0);
+	range->nlb = cpu_to_le32(bio->bi_size >> ns->lba_shift);
+	range->slba = cpu_to_le64(bio->bi_sector >> (ns->lba_shift - 9));
+
+	memset(cmnd, 0, sizeof(*cmnd));
+	cmnd->dsm.opcode = nvme_cmd_dsm;
+	cmnd->dsm.command_id = cmdid;
+	cmnd->dsm.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->dsm.prp1 = cpu_to_le64(iod->first_dma);
+	cmnd->dsm.nr = 0;
+	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
+
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+	writel(nvmeq->sq_tail, nvmeq->q_db);
+
+	return 0;
+}
+
 static int nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 								int cmdid)
 {
@@ -562,6 +597,8 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	if (unlikely(cmdid < 0))
 		goto free_iod;
 
+	if (bio->bi_rw & REQ_DISCARD)
+		return nvme_submit_discard(nvmeq, ns, bio, iod, cmdid);
 	if ((bio->bi_rw & REQ_FLUSH) && !psegs)
 		return nvme_submit_flush(nvmeq, ns, cmdid);
 
@@ -1316,6 +1353,19 @@ static void nvme_put_ns_idx(int index)
 	spin_unlock(&dev_list_lock);
 }
 
+static void nvme_config_discard(struct nvme_ns *ns)
+{
+	u32 logical_block_size = queue_logical_block_size(ns->queue);
+	sector_t nr_sectors = get_capacity(ns->disk);
+
+	ns->queue->limits.discard_zeroes_data = 0;
+	ns->queue->limits.discard_alignment = logical_block_size;
+	ns->queue->limits.discard_granularity = logical_block_size;
+	ns->queue->limits.max_discard_sectors = (u32)min_t(u64, nr_sectors,
+								0xffffffff);
+	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
+}
+
 static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, int nsid,
 			struct nvme_id_ns *id, struct nvme_lba_range_type *rt)
 {
@@ -1361,6 +1411,9 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, int nsid,
 	sprintf(disk->disk_name, "nvme%dn%d", dev->instance, nsid);
 	set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
 
+	if (dev->oncs & NVME_CTRL_ONCS_DSM)
+		nvme_config_discard(ns);
+
 	return ns;
 
  out_free_queue:
@@ -1489,6 +1542,7 @@ static int __devinit nvme_dev_add(struct nvme_dev *dev)
 
 	ctrl = mem;
 	nn = le32_to_cpup(&ctrl->nn);
+	dev->oncs = le16_to_cpup(&ctrl->oncs);
 	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
 	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c25ccca..2af3ccd 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -107,6 +107,12 @@ struct nvme_id_ctrl {
 	__u8			vs[1024];
 };
 
+enum {
+	NVME_CTRL_ONCS_COMPARE			= 1 << 0,
+	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
+	NVME_CTRL_ONCS_DSM			= 1 << 2,
+};
+
 struct nvme_lbaf {
 	__le16			ms;
 	__u8			ds;
@@ -218,6 +224,31 @@ enum {
 	NVME_RW_DSM_COMPRESSED		= 1 << 7,
 };
 
+struct nvme_dsm_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2[2];
+	__le64			prp1;
+	__le64			prp2;
+	__le32			nr;
+	__le32			attributes;
+	__u32			rsvd12[4];
+};
+
+enum {
+	NVME_DSMGMT_IDR		= 1 << 0,
+	NVME_DSMGMT_IDW		= 1 << 1,
+	NVME_DSMGMT_AD		= 1 << 2,
+};
+
+struct nvme_dsm_range {
+	__le32			cattr;
+	__le32			nlb;
+	__le64			slba;
+};
+
 /* Admin commands */
 
 enum nvme_admin_opcode {
@@ -344,6 +375,7 @@ struct nvme_command {
 		struct nvme_create_sq create_sq;
 		struct nvme_delete_queue delete_queue;
 		struct nvme_download_firmware dlfw;
+		struct nvme_dsm_cmd dsm;
 	};
 };
 
-- 
1.7.0.4
