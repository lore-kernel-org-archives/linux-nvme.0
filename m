From: andrzej.jakowski@intel.com (Andrzej Jakowski)
Date: Wed, 20 Sep 2017 10:06:05 -0700
Subject: [PATCH] nvme: set physical block size to value discovered in Identify
 Namespace
Message-ID: <20170920170605.42161-1-andrzej.jakowski@intel.com>

In old implementation physical block size exported by NVMe driver defaulted to
logical block size. Existing NVMe SSDs very often
Musze naprawic zeby brac pod uwage relative performance.

Signed-off-by: Andrzej Jakowski <andrzej.jakowski at intel.com>
---
 drivers/nvme/host/core.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37046ac2c441..e20c5c6517fc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1194,11 +1194,36 @@ static int nvme_revalidate_ns(struct nvme_ns *ns, struct nvme_id_ns **id)
 	return 0;
 }
 
+static u32 calc_pbs(struct nvme_id_ns *id)
+{
+	struct nvme_lbaf *lbaf_used;
+	int i, max_id = 0;
+	u8 ds = 0;
+
+	lbaf_used = &id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK];
+	if (lbaf_used->rp == NVME_LBAF_RP_BEST)
+		return (((u32)1) << lbaf_used->ds);
+
+	for (i = 0; i < id->nlbaf; i++) {
+		if (id->lbaf[i].ms == 0 && id->lbaf[i].ds > ds &&
+			id->lbaf[i].rp < lbaf_used->rp && id->lbaf[i].ds <= PAGE_SHIFT)
+			max_id = i;
+
+		ds = id->lbaf[i].ds;
+	}
+
+	if (id->lbaf[max_id].ds)
+		return (((u32)1) << id->lbaf[max_id].ds);
+	else
+		return 0;
+}
+
 static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	struct nvme_ns *ns = disk->private_data;
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	u16 bs;
+	u32 pbs;
 
 	/*
 	 * If identify namespace failed, use default 512 byte block size so
@@ -1208,6 +1233,9 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->lba_shift == 0)
 		ns->lba_shift = 9;
 	bs = 1 << ns->lba_shift;
+	pbs = calc_pbs(id);
+	if (pbs == 0)
+		pbs = bs;
 	ns->noiob = le16_to_cpu(id->noiob);
 
 	blk_mq_freeze_queue(disk->queue);
@@ -1215,6 +1243,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)
 		nvme_prep_integrity(disk, id, bs);
 	blk_queue_logical_block_size(ns->queue, bs);
+	blk_queue_physical_block_size(ns->queue, pbs);
+
 	if (ns->noiob)
 		nvme_set_chunk_size(ns);
 	if (ns->ms && !blk_get_integrity(disk) && !ns->ext)
-- 
2.13.5
