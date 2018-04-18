From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 14:59:52 -0400
Subject: [PATCH 01/20] nvmet: add block device guard for smart-log
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-2-chaitanya.kulkarni@wdc.com>

Only use block device backed namespaces to compute target
side smart log. This is a preparation patch for implementing
file backed namespaces.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 90dcdc40ac71..602995f7a1b3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -45,6 +45,10 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		return NVME_SC_INVALID_NS;
 	}
 
+	/* for file backed ns just return */
+	if (!ns->bdev)
+		goto out;
+
 	host_reads = part_stat_read(ns->bdev->bd_part, ios[READ]);
 	data_units_read = part_stat_read(ns->bdev->bd_part, sectors[READ]);
 	host_writes = part_stat_read(ns->bdev->bd_part, ios[WRITE]);
@@ -54,6 +58,7 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
 	put_unaligned_le64(host_writes, &slog->host_writes[0]);
 	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
+out:
 	nvmet_put_namespace(ns);
 
 	return NVME_SC_SUCCESS;
@@ -71,6 +76,9 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
+		/* for file backed ns just return */
+		if (!ns->bdev)
+			continue;
 		host_reads += part_stat_read(ns->bdev->bd_part, ios[READ]);
 		data_units_read +=
 			part_stat_read(ns->bdev->bd_part, sectors[READ]);
-- 
2.14.1
