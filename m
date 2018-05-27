From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:11 +0300
Subject: [PATCH 06/17] nvme: Add WARN in case fabrics ctrl was set with wrong
 metadata caps
In-Reply-To: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
Message-ID: <1527436222-15494-7-git-send-email-maxg@mellanox.com>

An extended LBA is a larger LBA that is created when metadata associated
with the LBA is transferred contiguously with the LBA data (AKA interleaved).
The metadata may be either transferred as part of the LBA (creating an extended
LBA) or it may be transferred as a separate contiguous buffer of data. According
to the NVMEoF spec, a fabrics ctrl supports only an Extended LBA format. add WARN
in case we have a spec violation. Also init the integrity profile for the block
device for fabrics ctrl.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d8254b4..c605bb3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1419,9 +1419,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_physical_block_size(disk->queue, bs);
 	blk_queue_io_min(disk->queue, bs);
 
-	if (ns->ms && !ns->ext &&
-	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
-		nvme_init_integrity(disk, ns->ms, ns->pi_type);
+	if (ns->ms && (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)) {
+		if ((ns->ctrl->ops->flags & NVME_F_FABRICS) || !ns->ext)
+			nvme_init_integrity(disk, ns->ms, ns->pi_type);
+	}
 	if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
 		capacity = 0;
 	set_capacity(disk, capacity);
@@ -1445,6 +1446,18 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	ns->noiob = le16_to_cpu(id->noiob);
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
 	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
+
+	/*
+	 * For Fabrics, only metadata as part of extended data LBA is supported.
+	 * Reduce the metadata size in case of a spec violation.
+	 */
+	if (ns->ms && (ns->ctrl->ops->flags & NVME_F_FABRICS)) {
+		if (!ns->ext) {
+			WARN_ON_ONCE(1);
+			ns->ms = 0;
+		}
+	}
+
 	/* the PI implementation requires metadata equal t10 pi tuple size */
 	if (ns->ms == sizeof(struct t10_pi_tuple))
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
-- 
1.8.3.1
