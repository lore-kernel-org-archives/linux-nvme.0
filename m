From: keith.busch@intel.com (Keith Busch)
Date: Fri, 30 Jan 2015 19:11:57 -0700
Subject: [PATCH] NVMe: Metadata and PI format support
Message-ID: <1422670317-23420-1-git-send-email-keith.busch@intel.com>

Adds support for NVMe metadata formats and exposes block devices for all
namespaces regardless of their format. Namespace formats that are unusable
will have disk capacity set to 0, but a handle to the block device is
created to simplify device management. A namespace is not usable when
format requires host interleave block and metadata in single buffer,
has no provisioned storage, or failed to register with blk integrity.

The namespace has to be scanned in two phases to support separate
metadata formats. The first establishes the sector size and capacity
prior to invoking add_disk. If metadata is required, the capacity will
be temporarilly set to 0 until it can be revalidated and registered with
the integrity extenstions after add_disk completes.

The driver relies on the integrity extensions to provide the metadata
buffer. NVMe requires this be a single physically contiguous region,
so only one segment is allowed per command.

If the metadata is used for T10 PI, the driver provides mappings to
save and restore the reftag physical block translation. If metadata is
not used for PI, the driver provides no-op functions for generate and
verify. This way the setup is always provided by the block layer.

If a received command does not supply a required metadata buffer, the
command is failed with bad address. This could only happen if a user
manually disables verify/generate on such a disk. The only exception to
where this is okay is if the controller is capable of stripping/generating
the metadata, which is possible on some types of formats.

The metadata scatter gather list now occupies the spot in the nvme_iod
that used to be used to link retryable IOD's, but we don't do that
anymore, so the field was unused.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
This makes this patch obsolete:

  http://lists.infradead.org/pipermail/linux-nvme/2015-January/001483.html

And borrows a lot of logic and comments from scsi/sd.c and scsi/sd_dif.c.

I lack hardware capable of all the formats this patch intends to
support. I tested by hacking firmware to report certain capabilities,
but the controller never actually made use of the metadata at all,
so PI checks always failed.

I did verify the mapped integrity scatter gather list was correct in
length, and automatically updated as I changed the physical block sizes
from 512 to 4k, and metadata from 8, 16, and 64 bytes.

This removes all the driver logic used to decide if a disk should be
created or not, and almost removes my need to allow arbitrary NSIDs on
the passthrough commands (almost; I still have a need).

 drivers/block/nvme-core.c |  295 +++++++++++++++++++++++++++++++++++----------
 include/linux/nvme.h      |    3 +-
 include/uapi/linux/nvme.h |   16 +++
 3 files changed, 247 insertions(+), 67 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index d826bf3..36912d1 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -37,6 +37,7 @@
 #include <linux/ptrace.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/t10-pi.h>
 #include <linux/types.h>
 #include <scsi/sg.h>
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
@@ -420,6 +421,61 @@ static int nvme_error_status(u16 status)
 	}
 }
 
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
+ * The virtual start sector is the one that was originally submitted by the
+ * block layer. Due to partitioning, MD/DM cloning, etc. the actual physical
+ * start sector may be different. Remap protection information to match the
+ * physical LBA on writes, and back to the original seed on reads.
+ *
+ * Type 0 and 3 do not have a ref tag, so no remapping required.
+ */
+static void nvme_dif_remap(struct request *req,
+			void (*dif_swap)(u32 p, u32 v, struct t10_pi_tuple *pi))
+{
+	struct nvme_ns *ns = req->rq_disk->private_data;
+	struct bio_integrity_payload *bip;
+	struct t10_pi_tuple *pi;
+	void *p;
+	u32 i, nlb, ts, phys, virt;
+
+	if (!ns->pi_type || ns->pi_type == NVME_NS_DPS_PI_TYPE3)
+		return;
+
+	bip = bio_integrity(req->bio);
+	if (!bip)
+		return;
+
+	p = kmap_atomic(bip->bip_vec->bv_page);
+	if (!p)
+		return;
+
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
+	kunmap_atomic(pi);
+}
+
 static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
@@ -450,9 +506,16 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 			"completing aborted command with status:%04x\n",
 			status);
 
-	if (iod->nents)
+	if (iod->nents) {
 		dma_unmap_sg(&nvmeq->dev->pci_dev->dev, iod->sg, iod->nents,
 			rq_data_dir(req) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+		if (blk_integrity_rq(req)) {
+			if (!rq_data_dir(req))
+				nvme_dif_remap(req, nvme_dif_complete);
+			dma_unmap_sg(&nvmeq->dev->pci_dev->dev, iod->meta_sg, 1,
+				rq_data_dir(req) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+		}
+	}
 	nvme_free_iod(nvmeq->dev, iod);
 
 	blk_mq_complete_request(req);
@@ -608,6 +671,24 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	cmnd->rw.prp2 = cpu_to_le64(iod->first_dma);
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+
+	if (blk_integrity_rq(req)) {
+		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(iod->meta_sg));
+		switch (ns->pi_type) {
+		case NVME_NS_DPS_PI_TYPE3:
+			control |= NVME_RW_PRINFO_PRCHK_GUARD;
+			break;
+		case NVME_NS_DPS_PI_TYPE1:
+		case NVME_NS_DPS_PI_TYPE2:
+			control |= NVME_RW_PRINFO_PRCHK_GUARD |
+					NVME_RW_PRINFO_PRCHK_REF;
+			cmnd->rw.reftag = cpu_to_le32(
+					nvme_block_nr(ns, blk_rq_pos(req)));
+			break;
+		}
+	} else if (ns->ms)
+		control |= NVME_RW_PRINFO_PRACT;
+
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
 
@@ -631,6 +712,19 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	unsigned size = !(req->cmd_flags & REQ_DISCARD) ? blk_rq_bytes(req) :
 						sizeof(struct nvme_dsm_range);
 
+	/*
+	 * If formated with metadata, require the block layer provide a buffer
+	 * unless this namespace is formated such that the metadata can be
+	 * stripped/generated by the controller with PRACT=1.
+	 */
+	if (ns->ms && !blk_integrity_rq(req)) {
+		if (!(ns->pi_type && ns->ms == 8)) {
+			req->errors = -EFAULT;
+			blk_mq_complete_request(req);
+			return BLK_MQ_RQ_QUEUE_OK;
+		}
+	}
+
 	iod = nvme_alloc_iod(psegs, size, ns->dev, GFP_ATOMIC);
 	if (!iod)
 		return BLK_MQ_RQ_QUEUE_BUSY;
@@ -668,6 +762,21 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 					iod->nents, dma_dir);
 			goto retry_cmd;
 		}
+		if (blk_integrity_rq(req)) {
+			if (blk_rq_count_integrity_sg(req->q, req->bio) != 1)
+				goto error_cmd;
+
+			sg_init_table(iod->meta_sg, 1);
+			if (blk_rq_map_integrity_sg(
+					req->q, req->bio, iod->meta_sg) != 1)
+				goto error_cmd;
+
+			if (rq_data_dir(req))
+				nvme_dif_remap(req, nvme_dif_prep);
+
+			if (!dma_map_sg(nvmeq->q_dmadev, iod->meta_sg, 1, dma_dir))
+				goto error_cmd;
+		}
 	}
 
 	nvme_set_info(cmd, iod, req_completion);
@@ -1825,13 +1934,61 @@ static int nvme_getgeo(struct block_device *bd, struct hd_geometry *geo)
 	return 0;
 }
 
+static void nvme_config_discard(struct nvme_ns *ns)
+{
+	u32 logical_block_size = queue_logical_block_size(ns->queue);
+	ns->queue->limits.discard_zeroes_data = 0;
+	ns->queue->limits.discard_alignment = logical_block_size;
+	ns->queue->limits.discard_granularity = logical_block_size;
+	ns->queue->limits.max_discard_sectors = 0xffffffff;
+	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
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
+
 static int nvme_revalidate_disk(struct gendisk *disk)
 {
 	struct nvme_ns *ns = disk->private_data;
 	struct nvme_dev *dev = ns->dev;
 	struct nvme_id_ns *id;
 	dma_addr_t dma_addr;
-	int lbaf;
+	int lbaf, pi_type, old_ms;
+	unsigned short bs;
 
 	id = dma_alloc_coherent(&dev->pci_dev->dev, 4096, &dma_addr,
 								GFP_KERNEL);
@@ -1840,16 +1997,50 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 								__func__);
 		return 0;
 	}
+	if (nvme_identify(dev, ns->ns_id, 0, dma_addr)) {
+		dev_warn(&dev->pci_dev->dev,
+			"identify failed ns:%d, setting capacity to 0\n",
+			ns->ns_id);
+		memset(id, 0, sizeof(*id));
+	}
 
-	if (nvme_identify(dev, ns->ns_id, 0, dma_addr))
-		goto free;
-
-	lbaf = id->flbas & 0xf;
+	old_ms = ns->ms;
+	lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
 	ns->lba_shift = id->lbaf[lbaf].ds;
+	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
+
+	/*
+	 * If identify namespace failed, use default 512 byte block size so
+	 * block layer can use before failing read/write for 0 capacity.
+	 */
+	if (ns->lba_shift == 0)
+		ns->lba_shift = 9;
+	bs = 1 << ns->lba_shift;
+
+	/* XXX: PI implementation requires metadata equal t10 pi tuple size */
+	pi_type = ns->ms == sizeof(struct t10_pi_tuple) ?
+					id->dps & NVME_NS_DPS_PI_MASK : 0;
+
+	if (disk->integrity && (ns->pi_type != pi_type || ns->ms != old_ms ||
+				bs != queue_logical_block_size(disk->queue) ||
+				(ns->ms && id->flbas & NVME_NS_FLBAS_META_EXT)))
+		blk_integrity_unregister(disk);
+
+	ns->pi_type = pi_type;
+	blk_queue_logical_block_size(ns->queue, bs);
+
+	if (ns->ms && !disk->integrity && (disk->flags & GENHD_FL_UP) &&
+				!(id->flbas & NVME_NS_FLBAS_META_EXT))
+		nvme_init_integrity(ns);
+
+	if (id->ncap == 0 || (ns->ms && !disk->integrity))
+		set_capacity(disk, 0);
+	else
+		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
+
+	if (dev->oncs & NVME_CTRL_ONCS_DSM)
+		nvme_config_discard(ns);
 
-	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
-	set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
- free:
 	dma_free_coherent(&dev->pci_dev->dev, 4096, id, dma_addr);
 	return 0;
 }
@@ -1906,30 +2097,16 @@ static int nvme_kthread(void *data)
 	return 0;
 }
 
-static void nvme_config_discard(struct nvme_ns *ns)
-{
-	u32 logical_block_size = queue_logical_block_size(ns->queue);
-	ns->queue->limits.discard_zeroes_data = 0;
-	ns->queue->limits.discard_alignment = logical_block_size;
-	ns->queue->limits.discard_granularity = logical_block_size;
-	ns->queue->limits.max_discard_sectors = 0xffffffff;
-	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
-}
-
-static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
-			struct nvme_id_ns *id, struct nvme_lba_range_type *rt)
+static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 {
 	struct nvme_ns *ns;
 	struct gendisk *disk;
 	int node = dev_to_node(&dev->pci_dev->dev);
-	int lbaf;
-
-	if (rt->attributes & NVME_LBART_ATTRIB_HIDE)
-		return NULL;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
-		return NULL;
+		return;
+
 	ns->queue = blk_mq_init_queue(&dev->tagset);
 	if (IS_ERR(ns->queue))
 		goto out_free_ns;
@@ -1945,9 +2122,9 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 
 	ns->ns_id = nsid;
 	ns->disk = disk;
-	lbaf = id->flbas & 0xf;
-	ns->lba_shift = id->lbaf[lbaf].ds;
-	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
+	ns->lba_shift = 9; /* set to a default value for 512 until disk is validated */
+	list_add_tail(&ns->list, &dev->namespaces);
+
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	if (dev->max_hw_sectors)
 		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
@@ -1964,18 +2141,23 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 	disk->driverfs_dev = &dev->pci_dev->dev;
 	disk->flags = GENHD_FL_EXT_DEVT;
 	sprintf(disk->disk_name, "nvme%dn%d", dev->instance, nsid);
-	set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
 
-	if (dev->oncs & NVME_CTRL_ONCS_DSM)
-		nvme_config_discard(ns);
-
-	return ns;
+	/*
+	 * Initialize capacity to 0 until we establish the namespace format and
+	 * setup integrity extentions if necessary. The revalidate_disk after
+	 * add_disk allows the driver to register with integrity if the format
+	 * requires it.
+	 */
+	set_capacity(disk, 0);
+	nvme_revalidate_disk(ns->disk);
+	add_disk(ns->disk);
+	revalidate_disk(ns->disk);
 
+	return;
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
 	kfree(ns);
-	return NULL;
 }
 
 static void nvme_create_io_queues(struct nvme_dev *dev)
@@ -2100,22 +2282,20 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	struct pci_dev *pdev = dev->pci_dev;
 	int res;
 	unsigned nn, i;
-	struct nvme_ns *ns;
 	struct nvme_id_ctrl *ctrl;
-	struct nvme_id_ns *id_ns;
 	void *mem;
 	dma_addr_t dma_addr;
 	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
 
-	mem = dma_alloc_coherent(&pdev->dev, 8192, &dma_addr, GFP_KERNEL);
+	mem = dma_alloc_coherent(&pdev->dev, 4096, &dma_addr, GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
 
 	res = nvme_identify(dev, 0, 1, dma_addr);
 	if (res) {
 		dev_err(&pdev->dev, "Identify Controller failed (%d)\n", res);
-		res = -EIO;
-		goto out;
+		dma_free_coherent(&dev->pci_dev->dev, 4096, mem, dma_addr);
+		return -EIO;
 	}
 
 	ctrl = mem;
@@ -2141,6 +2321,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		} else
 			dev->max_hw_sectors = max_hw_sectors;
 	}
+	dma_free_coherent(&dev->pci_dev->dev, 4096, mem, dma_addr);
 
 	dev->tagset.ops = &nvme_mq_ops;
 	dev->tagset.nr_hw_queues = dev->online_queues - 1;
@@ -2153,33 +2334,12 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	dev->tagset.driver_data = dev;
 
 	if (blk_mq_alloc_tag_set(&dev->tagset))
-		goto out;
-
-	id_ns = mem;
-	for (i = 1; i <= nn; i++) {
-		res = nvme_identify(dev, i, 0, dma_addr);
-		if (res)
-			continue;
-
-		if (id_ns->ncap == 0)
-			continue;
-
-		res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
-							dma_addr + 4096, NULL);
-		if (res)
-			memset(mem + 4096, 0, 4096);
+		return 0;
 
-		ns = nvme_alloc_ns(dev, i, mem, mem + 4096);
-		if (ns)
-			list_add_tail(&ns->list, &dev->namespaces);
-	}
-	list_for_each_entry(ns, &dev->namespaces, list)
-		add_disk(ns->disk);
-	res = 0;
+	for (i = 1; i <= nn; i++)
+		nvme_alloc_ns(dev, i);
 
- out:
-	dma_free_coherent(&dev->pci_dev->dev, 8192, mem, dma_addr);
-	return res;
+	return 0;
 }
 
 static int nvme_dev_map(struct nvme_dev *dev)
@@ -2478,8 +2638,11 @@ static void nvme_dev_remove(struct nvme_dev *dev)
 	struct nvme_ns *ns;
 
 	list_for_each_entry(ns, &dev->namespaces, list) {
-		if (ns->disk->flags & GENHD_FL_UP)
+		if (ns->disk->flags & GENHD_FL_UP) {
+			if (ns->disk->integrity)
+				blk_integrity_unregister(ns->disk);
 			del_gendisk(ns->disk);
+		}
 		if (!blk_queue_dying(ns->queue)) {
 			blk_mq_abort_requeue_list(ns->queue);
 			blk_cleanup_queue(ns->queue);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 258945f..e1fcea0 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -121,6 +121,7 @@ struct nvme_ns {
 	unsigned ns_id;
 	int lba_shift;
 	int ms;
+	int pi_type;
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
 };
@@ -138,7 +139,7 @@ struct nvme_iod {
 	int nents;		/* Used in scatterlist */
 	int length;		/* Of data, in bytes */
 	dma_addr_t first_dma;
-	struct list_head node;
+	struct scatterlist meta_sg[1]; /* metadata requires single contiguous buffer */
 	struct scatterlist sg[0];
 };
 
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 26386cf..406bfc9 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -124,10 +124,22 @@ struct nvme_id_ns {
 
 enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
+	NVME_NS_FLBAS_LBA_MASK	= 0xf,
+	NVME_NS_FLBAS_META_EXT	= 0x10,
 	NVME_LBAF_RP_BEST	= 0,
 	NVME_LBAF_RP_BETTER	= 1,
 	NVME_LBAF_RP_GOOD	= 2,
 	NVME_LBAF_RP_DEGRADED	= 3,
+	NVME_NS_DPC_PI_LAST	= 1 << 4,
+	NVME_NS_DPC_PI_FIRST	= 1 << 3,
+	NVME_NS_DPC_PI_TYPE3	= 1 << 2,
+	NVME_NS_DPC_PI_TYPE2	= 1 << 1,
+	NVME_NS_DPC_PI_TYPE1	= 1 << 0,
+	NVME_NS_DPS_PI_FIRST	= 1 << 3,
+	NVME_NS_DPS_PI_MASK	= 0x7,
+	NVME_NS_DPS_PI_TYPE1	= 1,
+	NVME_NS_DPS_PI_TYPE2	= 2,
+	NVME_NS_DPS_PI_TYPE3	= 3,
 };
 
 struct nvme_smart_log {
@@ -261,6 +273,10 @@ enum {
 	NVME_RW_DSM_LATENCY_LOW		= 3 << 4,
 	NVME_RW_DSM_SEQ_REQ		= 1 << 6,
 	NVME_RW_DSM_COMPRESSED		= 1 << 7,
+	NVME_RW_PRINFO_PRCHK_REF	= 1 << 10,
+	NVME_RW_PRINFO_PRCHK_APP	= 1 << 11,
+	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
+	NVME_RW_PRINFO_PRACT		= 1 << 13,
 };
 
 struct nvme_dsm_cmd {
-- 
1.7.10.4
