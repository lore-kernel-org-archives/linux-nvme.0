From: hch@lst.de (Christoph Hellwig)
Date: Sat, 20 May 2017 15:14:45 +0200
Subject: [PATCH 3/3] nvme: only setup block integrity if supported by the
 driver
In-Reply-To: <20170520131445.16078-1-hch@lst.de>
References: <20170520131445.16078-1-hch@lst.de>
Message-ID: <20170520131445.16078-3-hch@lst.de>

Currently only the PCIe driver supports metadata, so we should not claim
integrity support for the other drivers.  This prevents nasty crashes
with targets that advertise metadata support on fabrics.

Also use the opportunity to factor out some code into a separate helper
that isn't even compiled if CONFIG_BLK_DEV_INTEGRITY is disabled.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 50 ++++++++++++++++++++++++++++++------------------
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  1 +
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79b78bd67b07..f6dd4fed56a4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -925,6 +925,29 @@ static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
+static void nvme_prep_integrity(struct gendisk *disk, struct nvme_id_ns *id,
+		u16 bs)
+{
+	struct nvme_ns *ns = disk->private_data;
+	u16 old_ms = ns->ms;
+	u8 pi_type = 0;
+
+	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
+	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
+
+	/* PI implementation requires metadata equal t10 pi tuple size */
+	if (ns->ms == sizeof(struct t10_pi_tuple))
+		pi_type = id->dps & NVME_NS_DPS_PI_MASK;
+
+	if (blk_get_integrity(disk) &&
+	    (ns->pi_type != pi_type || ns->ms != old_ms ||
+	     bs != queue_logical_block_size(disk->queue) ||
+	     (ns->ms && ns->ext)))
+		blk_integrity_unregister(disk);
+
+	ns->pi_type = pi_type;
+}
+
 static void nvme_init_integrity(struct nvme_ns *ns)
 {
 	struct blk_integrity integrity;
@@ -951,6 +974,10 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 	blk_queue_max_integrity_segments(ns->queue, 1);
 }
 #else
+static void nvme_prep_integrity(struct gendisk *disk, struct nvme_id_ns *id,
+		u16 bs)
+{
+}
 static void nvme_init_integrity(struct nvme_ns *ns)
 {
 }
@@ -997,37 +1024,22 @@ static int nvme_revalidate_ns(struct nvme_ns *ns, struct nvme_id_ns **id)
 static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	struct nvme_ns *ns = disk->private_data;
-	u8 lbaf, pi_type;
-	u16 old_ms;
-	unsigned short bs;
-
-	old_ms = ns->ms;
-	lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
-	ns->lba_shift = id->lbaf[lbaf].ds;
-	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
-	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
+	u16 bs;
 
 	/*
 	 * If identify namespace failed, use default 512 byte block size so
 	 * block layer can use before failing read/write for 0 capacity.
 	 */
+	ns->lba_shift = id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ds;
 	if (ns->lba_shift == 0)
 		ns->lba_shift = 9;
 	bs = 1 << ns->lba_shift;
-	/* XXX: PI implementation requires metadata equal t10 pi tuple size */
-	pi_type = ns->ms == sizeof(struct t10_pi_tuple) ?
-					id->dps & NVME_NS_DPS_PI_MASK : 0;
 
 	blk_mq_freeze_queue(disk->queue);
-	if (blk_get_integrity(disk) && (ns->pi_type != pi_type ||
-				ns->ms != old_ms ||
-				bs != queue_logical_block_size(disk->queue) ||
-				(ns->ms && ns->ext)))
-		blk_integrity_unregister(disk);
 
-	ns->pi_type = pi_type;
+	if (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)
+		nvme_prep_integrity(disk, id, bs);
 	blk_queue_logical_block_size(ns->queue, bs);
-
 	if (ns->ms && !blk_get_integrity(disk) && !ns->ext)
 		nvme_init_integrity(ns);
 	if (ns->ms && !(ns->ms == 8 && ns->pi_type) && !blk_get_integrity(disk))
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7c4b0f6636c5..9d6a070d4391 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -210,6 +210,7 @@ struct nvme_ctrl_ops {
 	struct module *module;
 	unsigned int flags;
 #define NVME_F_FABRICS			(1 << 0)
+#define NVME_F_METADATA_SUPPORTED	(1 << 1)
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a150b2dd7851..283efc2e8921 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2041,6 +2041,7 @@ static int nvme_pci_reset_ctrl(struct nvme_ctrl *ctrl)
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
+	.flags			= NVME_F_METADATA_SUPPORTED,
 	.reg_read32		= nvme_pci_reg_read32,
 	.reg_write32		= nvme_pci_reg_write32,
 	.reg_read64		= nvme_pci_reg_read64,
-- 
2.11.0
