From: tomwu@mellanox.com (Tom Wu)
Date: Thu,  8 Aug 2019 02:22:36 +0000
Subject: [PATCH] nvmet: fix data units read and written counters in SMART log
Message-ID: <1565230956-28982-1-git-send-email-tomwu@mellanox.com>

In nvme spec 1.3 there is a definition for data write/read counters
from SMART log, (See section 5.14.1.2):
	This value is reported in thousands (i.e., a value of 1
	corresponds to 1000 units of 512 bytes read) and is rounded up.

However, in nvme target where value is reported with actual units,
but not thousands of units as the spec requires.

Signed-off-by: Tom Wu <tomwu at mellanox.com>
Reviewed-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/admin-cmd.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 9f72d51..4099093 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -81,9 +81,11 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		goto out;
 
 	host_reads = part_stat_read(ns->bdev->bd_part, ios[READ]);
-	data_units_read = part_stat_read(ns->bdev->bd_part, sectors[READ]);
+	data_units_read = DIV_ROUND_UP(part_stat_read(ns->bdev->bd_part,
+		sectors[READ]), 1000);
 	host_writes = part_stat_read(ns->bdev->bd_part, ios[WRITE]);
-	data_units_written = part_stat_read(ns->bdev->bd_part, sectors[WRITE]);
+	data_units_written = DIV_ROUND_UP(part_stat_read(ns->bdev->bd_part,
+		sectors[WRITE]), 1000);
 
 	put_unaligned_le64(host_reads, &slog->host_reads[0]);
 	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
@@ -111,11 +113,11 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 		if (!ns->bdev)
 			continue;
 		host_reads += part_stat_read(ns->bdev->bd_part, ios[READ]);
-		data_units_read +=
-			part_stat_read(ns->bdev->bd_part, sectors[READ]);
+		data_units_read += DIV_ROUND_UP(
+			part_stat_read(ns->bdev->bd_part, sectors[READ]), 1000);
 		host_writes += part_stat_read(ns->bdev->bd_part, ios[WRITE]);
-		data_units_written +=
-			part_stat_read(ns->bdev->bd_part, sectors[WRITE]);
+		data_units_written += DIV_ROUND_UP(
+			part_stat_read(ns->bdev->bd_part, sectors[WRITE]), 1000);
 
 	}
 	rcu_read_unlock();
-- 
1.8.4.3
