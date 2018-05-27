From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:12 +0300
Subject: [PATCH 07/17] nvme: introduce max_integrity_segments ctrl attribute
In-Reply-To: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
Message-ID: <1527436222-15494-8-git-send-email-maxg@mellanox.com>

This patch doesn't change any logic, and is needed as a preparataion
for adding T10 support for fabrics drivers that will use an extended
LBA format for metadata.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 11 +++++++----
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  6 ++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c605bb3..197208a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1310,7 +1310,8 @@ static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
+static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
+		u32 max_integrity_segments)
 {
 	struct blk_integrity integrity;
 
@@ -1333,10 +1334,11 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
 	}
 	integrity.tuple_size = ms;
 	blk_integrity_register(disk, &integrity);
-	blk_queue_max_integrity_segments(disk->queue, 1);
+	blk_queue_max_integrity_segments(disk->queue, max_integrity_segments);
 }
 #else
-static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
+static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
+		u32 max_integrity_segments)
 {
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
@@ -1421,7 +1423,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	if (ns->ms && (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)) {
 		if ((ns->ctrl->ops->flags & NVME_F_FABRICS) || !ns->ext)
-			nvme_init_integrity(disk, ns->ms, ns->pi_type);
+			nvme_init_integrity(disk, ns->ms, ns->pi_type,
+					    ns->ctrl->max_integrity_segments);
 	}
 	if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
 		capacity = 0;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 061fecf..49759ca 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -164,6 +164,7 @@ struct nvme_ctrl {
 	u64 cap;
 	u32 page_size;
 	u32 max_hw_sectors;
+	u32 max_integrity_segments;
 	u16 oncs;
 	u16 oacs;
 	u16 nssa;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fbc71fa..0024fb2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2326,6 +2326,12 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	/*
+	 * NVMe PCI driver doesn't support Extended LBA format so using 1 integrity
+	 * segment should be enough for a separate contiguous buffer of metadata.
+	 */
+	dev->ctrl.max_integrity_segments = 1;
+
 	result = nvme_init_identify(&dev->ctrl);
 	if (result)
 		goto out;
-- 
1.8.3.1
