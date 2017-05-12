From: scott.bauer@intel.com (Scott Bauer)
Date: Fri, 12 May 2017 14:29:05 -0600
Subject: [PATCH] nvme: Implement NS Optimial IO Boundary from 1.3 Spec
Message-ID: <1494620945-8061-1-git-send-email-scott.bauer@intel.com>

The NVMe 1.3 spec introduces Namespace Optimal IO Boundaries (NOIOB).
This feature standardizes the stripe mechanism we currently have quirks for.
This patch implements the necessary logic to handle this new feature.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 drivers/nvme/host/core.c | 7 +++++++
 include/linux/nvme.h     | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5e0906..69d2798 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1000,6 +1000,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	u8 lbaf, pi_type;
 	u16 old_ms;
 	unsigned short bs;
+	unsigned int iob;
 
 	old_ms = ns->ms;
 	lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
@@ -1027,6 +1028,12 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 
 	ns->pi_type = pi_type;
 	blk_queue_logical_block_size(ns->queue, bs);
+	if (ns->ctrl->vs >= NVME_VS(1, 3, 0) && le16_to_cpu(id->noiob)) {
+		/* Convert from controller logical blocks to 512 sectors. */
+		iob = ((unsigned int)le16_to_cpu(id->noiob)) << (ns->lba_shift - 9);
+		if (is_power_of_2(iob))
+			blk_queue_chunk_sectors(ns->queue, iob);
+	}
 
 	if (ns->ms && !blk_get_integrity(disk) && !ns->ext)
 		nvme_init_integrity(ns);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b625bac..d19b193 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -274,7 +274,7 @@ struct nvme_id_ns {
 	__le16			nabsn;
 	__le16			nabo;
 	__le16			nabspf;
-	__u16			rsvd46;
+	__le16			noiob;
 	__u8			nvmcap[16];
 	__u8			rsvd64[40];
 	__u8			nguid[16];
-- 
2.7.4
