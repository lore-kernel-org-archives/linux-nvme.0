From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Mar 2019 18:55:06 +0100
Subject: [PATCH 13/17] nvme: remove nvme_ns_config_oncs
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
Message-ID: <20190313175510.20725-14-hch@lst.de>

Just opencode the two function calls in the caller.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Tested-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 951e9f31b57c..26ae805fc958 100644
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
@@ -1611,7 +1605,9 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		capacity = 0;
 
 	set_capacity(disk, capacity);
-	nvme_ns_config_oncs(ns);
+
+	nvme_config_discard(ns);
+	nvme_config_write_zeroes(ns);
 
 	if (id->nsattr & (1 << 0))
 		set_disk_ro(disk, true);
-- 
2.20.1
