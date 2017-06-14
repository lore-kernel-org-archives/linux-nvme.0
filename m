From: scott.bauer@intel.com (Scott Bauer)
Date: Wed, 14 Jun 2017 10:37:53 -0600
Subject: [RESEND-nvme-4.13] nvme: Implement NS Optimal IO Boundary from 1.3
 Spec
Message-ID: <20170614163753.5215-1-scott.bauer@intel.com>

The NVMe 1.3 spec introduces Namespace Optimal IO Boundaries (NOIOB),
which standardizes the stripe mechanism we currently have quirks for.
This patch implements the necessary logic to handle this new feature.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
Reviewed-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 8 ++++++++
 drivers/nvme/host/nvme.h | 1 +
 include/linux/nvme.h     | 2 +-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d33f829c3ab7..d22ec0d9d5be 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -971,12 +971,14 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	u8 lbaf, pi_type;
 	u16 old_ms;
 	unsigned short bs;
+	unsigned int iob;
 
 	old_ms = ns->ms;
 	lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
 	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
+	ns->noiob = le16_to_cpu(id->noiob);
 
 	/*
 	 * If identify namespace failed, use default 512 byte block size so
@@ -998,6 +1000,12 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 
 	ns->pi_type = pi_type;
 	blk_queue_logical_block_size(ns->queue, bs);
+	if (ns->noiob) {
+		/* Convert from controller logical blocks to 512 sectors. */
+		iob = (((unsigned int)ns->noiob) << ns->lba_shift) >> 9;
+		iob = rounddown_pow_of_two(iob);
+		blk_queue_chunk_sectors(ns->queue, iob);
+	}
 
 	if (ns->ms && !blk_get_integrity(disk) && !ns->ext)
 		nvme_init_integrity(ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a317461c21d3..2fe41a68ebc4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -196,6 +196,7 @@ struct nvme_ns {
 	bool ext;
 	u8 pi_type;
 	unsigned long flags;
+	u16 noiob;
 
 #define NVME_NS_REMOVING 0
 #define NVME_NS_DEAD     1
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9061780b141f..4f607fbc41f9 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -273,7 +273,7 @@ struct nvme_id_ns {
 	__le16			nabsn;
 	__le16			nabo;
 	__le16			nabspf;
-	__u16			rsvd46;
+	__le16			noiob;
 	__u8			nvmcap[16];
 	__u8			rsvd64[40];
 	__u8			nguid[16];
-- 
2.11.0
