From: keith.busch@intel.com (Keith Busch)
Date: Thu, 21 Mar 2013 11:52:07 -0600
Subject: [PATCH v2 7/7] NVMe: End-to-end data protection
In-Reply-To: <1363888327-7420-1-git-send-email-keith.busch@intel.com>
References: <1363888327-7420-1-git-send-email-keith.busch@intel.com>
Message-ID: <1363888327-7420-8-git-send-email-keith.busch@intel.com>

Registers a DIF capable nvme namespace with block integrity.

If the namepsace meta-data is a separate buffer, the driver will use the
appropriate block integrity template to generate and verify the protection
information on writes and reads and supply a meta-data pointer in the
command buffer for this.

If the namespace is formatted with meta-data but not with protection
information, a no-op block integrity template is used to create the
unused meta-data buffer.

If the meta-data is interleaved and formatted for data-protection, the
NVMe PRACT field is set to have the controller generate DIF on writes
and strip it on reads.

LBA formats that the driver cannot deal with will not create a block
device for that namespace.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |  135 ++++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/nvme.h |   28 +++++++++--
 2 files changed, 153 insertions(+), 10 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 86c7f28..182d0b4 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -94,6 +94,9 @@ struct nvme_ns {
 
 	int ns_id;
 	int lba_shift;
+	int pi_type;
+	int extended;
+	u16 ms;
 };
 
 /*
@@ -307,6 +310,7 @@ struct nvme_iod {
 	int nents;		/* Used in scatterlist */
 	int length;		/* Of data, in bytes */
 	dma_addr_t first_dma;
+	dma_addr_t meta_dma;
 	struct scatterlist sg[0];
 };
 
@@ -367,10 +371,14 @@ static void bio_completion(struct nvme_dev *dev, void *ctx,
 	struct nvme_iod *iod = ctx;
 	struct bio *bio = iod->private;
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
+	enum dma_data_direction dma_dir = bio_data_dir(bio) ? DMA_TO_DEVICE :
+ 								DMA_FROM_DEVICE;
 
 	if (iod->nents)
-		dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
-			bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+		dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents, dma_dir);
+	if (bio_integrity(bio))
+		dma_unmap_single(&dev->pci_dev->dev, iod->meta_dma,
+					bio->bi_integrity->bip_size, dma_dir);
 
 	nvme_free_iod(dev, iod);
 	if (status)
@@ -464,6 +472,7 @@ static int nvme_setup_prps(struct nvme_dev *dev,
 struct nvme_bio_pair {
 	struct bio b1, b2, *parent;
 	struct bio_vec *bv1, *bv2;
+	struct bio_integrity_payload bip1, bip2;
 	int err;
 	atomic_t cnt;
 };
@@ -532,6 +541,23 @@ static struct nvme_bio_pair *nvme_bio_split(struct bio *bio, int idx,
 	} else
 		bp->bv1 = bp->bv2 = NULL;
 
+	if (bio_integrity(bio)) {
+		struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
+		unsigned int bip_split_len =
+				(len / bdev_logical_block_size(bio->bi_bdev)) *
+					bi->tuple_size;
+
+		bp->bip1.bip_buf = bio->bi_integrity->bip_buf;
+		bp->bip1.bip_size = bip_split_len;
+
+		bp->bip2.bip_buf = bio->bi_integrity->bip_buf + bip_split_len;
+		bp->bip2.bip_size = bio->bi_integrity->bip_size - bip_split_len;
+
+		bp->b1.bi_integrity = &bp->bip1;
+		bp->b2.bi_integrity = &bp->bip2;
+
+ 	}
+
 	bp->b1.bi_private = bp;
 	bp->b2.bi_private = bp;
 
@@ -692,6 +718,29 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 								GFP_ATOMIC);
 	cmnd->rw.slba = cpu_to_le64(bio->bi_sector >> (ns->lba_shift - 9));
 	cmnd->rw.length = cpu_to_le16((length >> ns->lba_shift) - 1);
+
+	if (ns->ms) {
+		if (ns->pi_type) {
+			control |= NVME_RW_PRINFO_PRCHK_GUARD;
+			if (ns->pi_type != NVME_NS_DPS_PI_TYPE3) {
+				control |= NVME_RW_PRINFO_PRCHK_REF;
+				cmnd->rw.reftag = cpu_to_le32(
+					(bio->bi_sector >> (ns->lba_shift - 9)) &
+					0xffffffff);
+			}
+		}
+		if (bio_integrity(bio)) {
+				iod->meta_dma =
+					dma_map_single(nvmeq->q_dmadev,
+						bio->bi_integrity->bip_buf,
+						bio->bi_integrity->bip_size,
+						dma_dir);
+				cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
+		} else {
+			control |= NVME_RW_PRINFO_PRACT;
+		}
+	}
+
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
 
@@ -1435,16 +1484,83 @@ static void nvme_put_ns_idx(int index)
 	spin_unlock(&dev_list_lock);
 }
 
+static void nvme_generate(struct blk_integrity_exchg *bix)
+{
+	return;
+}
+
+static int nvme_verify(struct blk_integrity_exchg *bix)
+{
+	return 0;
+}
+
+/*
+ * No-op integrity extension for namespace formats with meta-data but
+ * without protection settings.
+ */
+static struct blk_integrity nvme_no_dif = {
+	.name			= "T10-DIF-TYPE0",
+	.generate_fn		= &nvme_generate,
+	.verify_fn		= &nvme_verify,
+	.get_tag_fn		= NULL,
+	.set_tag_fn		= NULL,
+	.tuple_size		= 0,
+	.tag_size		= 0,
+};
+
+static void nvme_ns_register_pi(struct nvme_ns *ns)
+{
+	struct blk_integrity integrity;
+
+	if (ns->pi_type == NVME_NS_DPS_PI_TYPE3) {
+		integrity = sd_dif_get_type3_crc();
+		integrity.tag_size = sizeof(u16);
+	} else if (ns->pi_type) {
+		integrity = sd_dif_get_type1_crc();
+		integrity.tag_size = sizeof(u16) + sizeof(u32);
+	} else {
+		integrity = nvme_no_dif;
+	}
+	integrity.tuple_size = ns->ms;
+	blk_integrity_register(ns->disk, &integrity);
+}
+
+/*
+ * Formats with no meta-data or separate meta-data are all valid. Interleaved
+ * meta-data is not valid unless the controller can insert/strip it on
+ * writes/reads, which means the namespace has to be formatted with data
+ * protection settings and meta-data size equal to DIF size.
+ */
+static int nvme_check_pi_format(struct nvme_id_ns *id)
+{
+	int lbaf = id->flbas & NVME_NS_FLBAS_LBAF_MASK;
+	int ms = le16_to_cpu(id->lbaf[lbaf].ms);
+	int dps = id->dps & NVME_NS_DPS_PI_MASK;
+	int extended = id->flbas & NVME_NS_FLBAS_LBA_EXTENDED;
+
+	if (!extended && ms >= 8)
+		return dps;
+	if (dps && ms == 8)
+		return dps;
+	else if (ms)
+		return -1;
+	return 0;
+}
+
 static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, int nsid,
 			struct nvme_id_ns *id, struct nvme_lba_range_type *rt)
 {
 	struct nvme_ns *ns;
 	struct gendisk *disk;
-	int lbaf;
+	int lbaf, pi_type;
 
 	if (rt->attributes & NVME_LBART_ATTRIB_HIDE)
 		return NULL;
 
+	pi_type = nvme_check_pi_format(id);
+	if (pi_type < 0)
+		return NULL;
+
 	ns = kzalloc(sizeof(*ns), GFP_KERNEL);
 	if (!ns)
 		return NULL;
@@ -1458,6 +1574,9 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, int nsid,
 	blk_queue_make_request(ns->queue, nvme_make_request);
 	ns->dev = dev;
 	ns->queue->queuedata = ns;
+	ns->pi_type = pi_type;
+	if (pi_type)
+		ns->extended = id->flbas & NVME_NS_FLBAS_LBA_EXTENDED;
 
 	disk = alloc_disk(NVME_MINORS);
 	if (!disk)
@@ -1466,6 +1585,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, int nsid,
 	ns->disk = disk;
 	lbaf = id->flbas & 0xf;
 	ns->lba_shift = id->lbaf[lbaf].ds;
+	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	if (dev->max_hw_sectors)
 		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
@@ -1634,8 +1754,11 @@ static int __devinit nvme_dev_add(struct nvme_dev *dev)
 		if (ns)
 			list_add_tail(&ns->list, &dev->namespaces);
 	}
-	list_for_each_entry(ns, &dev->namespaces, list)
+	list_for_each_entry(ns, &dev->namespaces, list) {
 		add_disk(ns->disk);
+		if (!ns->extended && ns->pi_type)
+			nvme_ns_register_pi(ns);
+	}
 
 	goto out;
 
@@ -1660,6 +1783,8 @@ static int nvme_dev_remove(struct nvme_dev *dev)
 
 	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
 		list_del(&ns->list);
+		if (!ns->extended && ns->pi_type)
+			blk_integrity_unregister(ns->disk);
 		del_gendisk(ns->disk);
 		nvme_ns_free(ns);
 	}
@@ -1891,6 +2016,6 @@ static void __exit nvme_exit(void)
 
 MODULE_AUTHOR("Matthew Wilcox <willy at linux.intel.com>");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("0.8");
+MODULE_VERSION("0.8Poop");
 module_init(nvme_init);
 module_exit(nvme_exit);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 4fa3b0b..f499455 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -130,11 +130,25 @@ struct nvme_id_ns {
 };
 
 enum {
-	NVME_NS_FEAT_THIN	= 1 << 0,
-	NVME_LBAF_RP_BEST	= 0,
-	NVME_LBAF_RP_BETTER	= 1,
-	NVME_LBAF_RP_GOOD	= 2,
-	NVME_LBAF_RP_DEGRADED	= 3,
+	NVME_NS_FEAT_THIN		= 1 << 0,
+	NVME_NS_MC_EXTENDED		= 1 << 0,
+	NVME_NS_MC_SEPARATE		= 1 << 1,
+	NVME_NS_FLBAS_LBA_EXTENDED	= 1 << 4,
+	NVME_NS_FLBAS_LBAF_MASK		= 0xf,
+	NVME_NS_DPC_PI_LAST		= 1 << 4,
+	NVME_NS_DPC_PI_FIRST		= 1 << 3,
+	NVME_NS_DPC_PI_TYPE3		= 1 << 2,
+	NVME_NS_DPC_PI_TYPE2		= 1 << 1,
+	NVME_NS_DPC_PI_TYPE1		= 1 << 0,
+	NVME_NS_DPS_PI_MASK		= 0x7,
+	NVME_NS_DPS_PI_TYPE1		= 1,
+	NVME_NS_DPS_PI_TYPE2		= 2,
+	NVME_NS_DPS_PI_TYPE3		= 3,
+	NVME_NS_DPS_PI_FIRST		= 8,
+	NVME_LBAF_RP_BEST		= 0,
+	NVME_LBAF_RP_BETTER		= 1,
+	NVME_LBAF_RP_GOOD		= 2,
+	NVME_LBAF_RP_DEGRADED		= 3,
 };
 
 struct nvme_smart_log {
@@ -244,6 +258,10 @@ enum {
 	NVME_RW_DSM_LATENCY_LOW		= 3 << 4,
 	NVME_RW_DSM_SEQ_REQ		= 1 << 6,
 	NVME_RW_DSM_COMPRESSED		= 1 << 7,
+	NVME_RW_PRINFO_PRACT		= 1 << 13,
+	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
+	NVME_RW_PRINFO_PRCHK_APP	= 1 << 11,
+	NVME_RW_PRINFO_PRCHK_REF	= 1 << 10,
 };
 
 /* Admin commands */
-- 
1.7.0.4
