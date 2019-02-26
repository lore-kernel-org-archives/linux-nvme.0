From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 26 Feb 2019 14:55:50 -0800
Subject: [PATCH] multipath: set discard and norot queue flags on the multipath
 stacking device
Message-ID: <20190226225550.30378-1-sagi@grimberg.me>

If the underlying device supports discard we set it and clear it otherwise.
Without this blkdiscard doesn't work on a multipath device node.

Also while we're at it, unconditionally set non rotational queue flag to
make schedulers do the right thing.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d29ff9b910d9..7321da21f8c9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1561,9 +1561,13 @@ static inline void nvme_config_write_zeroes(struct nvme_ns *ns)
 	blk_queue_max_write_zeroes_sectors(ns->queue, max_sectors);
 }
 
-static inline void nvme_ns_config_oncs(struct nvme_ns *ns)
+static inline void nvme_ns_config_oncs(struct gendisk *disk, struct nvme_ns *ns)
 {
 	nvme_config_discard(ns);
+	if (blk_queue_discard(ns->queue))
+		blk_queue_flag_set(QUEUE_FLAG_DISCARD, disk->queue);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, disk->queue);
 	nvme_config_write_zeroes(ns);
 }
 
@@ -1612,6 +1616,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_logical_block_size(disk->queue, bs);
 	blk_queue_physical_block_size(disk->queue, bs);
 	blk_queue_io_min(disk->queue, bs);
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 
 	if (ns->ms && !ns->ext &&
 	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
@@ -1620,7 +1625,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		capacity = 0;
 
 	set_capacity(disk, capacity);
-	nvme_ns_config_oncs(ns);
+	nvme_ns_config_oncs(disk, ns);
 
 	if (id->nsattr & (1 << 0))
 		set_disk_ro(disk, true);
-- 
2.17.1
