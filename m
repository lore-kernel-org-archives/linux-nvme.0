From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Mar 2019 16:24:51 +0100
Subject: [PATCH 1/3] nvme: remove nvme_ns_config_oncs
In-Reply-To: <20190312152453.9550-1-hch@lst.de>
References: <20190312152453.9550-1-hch@lst.de>
Message-ID: <20190312152453.9550-2-hch@lst.de>

Just opencode the two function calls in the caller.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 844cf84105b0..724ac6075901 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1552,12 +1552,6 @@ static inline void nvme_config_write_zeroes(struct nvme_ns *ns)
 	blk_queue_max_write_zeroes_sectors(ns->queue, max_sectors);
 }
 
-static inline void nvme_ns_config_oncs(struct nvme_ns *ns)
-{
-	nvme_config_discard(ns);
-	nvme_config_write_zeroes(ns);
-}
-
 static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
 		struct nvme_id_ns *id, struct nvme_ns_ids *ids)
 {
@@ -1620,7 +1614,9 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	}
 
 	set_capacity(disk, capacity);
-	nvme_ns_config_oncs(ns);
+
+	nvme_config_discard(ns);
+	nvme_config_write_zeroes(ns);
 
 	if (id->nsattr & (1 << 0))
 		set_disk_ro(disk, true);
-- 
2.20.1
