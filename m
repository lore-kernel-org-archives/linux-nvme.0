From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Mar 2019 16:24:53 +0100
Subject: [PATCH 3/3] nvme: add proper write zeroes setup for the multipath
 device
In-Reply-To: <20190312152453.9550-1-hch@lst.de>
References: <20190312152453.9550-1-hch@lst.de>
Message-ID: <20190312152453.9550-4-hch@lst.de>

Add a gendisk argument to nvme_config_write_zeroes so that the call to
nvme_update_disk_info for the multipath device node updates the
proper request_queue.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b3c13a486423..5791e2ca2d2e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1526,7 +1526,7 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
-static inline void nvme_config_write_zeroes(struct nvme_ns *ns)
+static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 {
 	u32 max_sectors;
 	unsigned short bs = 1 << ns->lba_shift;
@@ -1549,7 +1549,7 @@ static inline void nvme_config_write_zeroes(struct nvme_ns *ns)
 	else
 		max_sectors = ((u32)(ns->ctrl->max_hw_sectors + 1) * bs) >> 9;
 
-	blk_queue_max_write_zeroes_sectors(ns->queue, max_sectors);
+	blk_queue_max_write_zeroes_sectors(disk->queue, max_sectors);
 }
 
 static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
@@ -1616,7 +1616,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity(disk, capacity);
 
 	nvme_config_discard(disk, ns);
-	nvme_config_write_zeroes(ns);
+	nvme_config_write_zeroes(disk, ns);
 
 	if (id->nsattr & (1 << 0))
 		set_disk_ro(disk, true);
-- 
2.20.1
