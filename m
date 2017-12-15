From: jeff.lien@wdc.com (Jeff Lien)
Date: Fri, 15 Dec 2017 16:15:39 -0600
Subject: [PATCH v2] NVMe: Format fix when going from 4k sector size to 512
 bytes
Message-ID: <20171215221539.4427-1-jeff.lien@wdc.com>

    If you format a device with a 4k sector size back to 512 bytes,
    the queue limit values for physical block size and IO sizes were
    not getting updated; only the logical block size was being
    updated.  This patch adds code to update the physical block
    and IO sizes.

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f837d666cbd4..f289d30584c1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1336,6 +1336,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 {
 	sector_t capacity = le64_to_cpup(&id->nsze) << (ns->lba_shift - 9);
 	unsigned stream_alignment = 0;
+	unsigned short bs;
 
 	if (ns->ctrl->nr_streams && ns->sws && ns->sgs)
 		stream_alignment = ns->sws * ns->sgs;
@@ -1343,7 +1344,11 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_mq_freeze_queue(disk->queue);
 	blk_integrity_unregister(disk);
 
-	blk_queue_logical_block_size(disk->queue, 1 << ns->lba_shift);
+	bs = 1 << ns->lba_shift;
+	blk_queue_logical_block_size(disk->queue, bs);
+	blk_queue_physical_block_size(disk->queue, bs);
+	blk_queue_io_min(disk->queue, bs);
+
 	if (ns->ms && !ns->ext &&
 	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		nvme_init_integrity(disk, ns->ms, ns->pi_type);
-- 
2.14.2.746.g8fb8a94
