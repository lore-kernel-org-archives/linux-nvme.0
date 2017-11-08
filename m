From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  8 Nov 2017 12:00:30 +0200
Subject: [PATCH 3/3] nvmet: remove redundant local variable
In-Reply-To: <20171108100030.25745-1-sagi@grimberg.me>
References: <20171108100030.25745-1-sagi@grimberg.me>
Message-ID: <20171108100030.25745-4-sagi@grimberg.me>

the status is either success or some status id and
we don't need a local variable for it.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/admin-cmd.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 871c2e5e17a0..6b921c253618 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -35,17 +35,14 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd)
 static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		struct nvme_smart_log *slog)
 {
-	u16 status;
 	struct nvmet_ns *ns;
 	u64 host_reads, host_writes, data_units_read, data_units_written;
 
-	status = NVME_SC_SUCCESS;
 	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->get_log_page.nsid);
 	if (!ns) {
-		status = NVME_SC_INVALID_NS;
 		pr_err("nvmet : Could not find namespace id : %d\n",
 				le32_to_cpu(req->cmd->get_log_page.nsid));
-		goto out;
+		return NVME_SC_INVALID_NS;
 	}
 
 	host_reads = part_stat_read(ns->bdev->bd_part, ios[READ]);
@@ -58,20 +55,18 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 	put_unaligned_le64(host_writes, &slog->host_writes[0]);
 	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
 	nvmet_put_namespace(ns);
-out:
-	return status;
+
+	return NVME_SC_SUCCESS;
 }
 
 static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 		struct nvme_smart_log *slog)
 {
-	u16 status;
 	u64 host_reads = 0, host_writes = 0;
 	u64 data_units_read = 0, data_units_written = 0;
 	struct nvmet_ns *ns;
 	struct nvmet_ctrl *ctrl;
 
-	status = NVME_SC_SUCCESS;
 	ctrl = req->sq->ctrl;
 
 	rcu_read_lock();
@@ -91,7 +86,7 @@ static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
 	put_unaligned_le64(host_writes, &slog->host_writes[0]);
 	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
 
-	return status;
+	return NVME_SC_SUCCESS;
 }
 
 static u16 nvmet_get_smart_log(struct nvmet_req *req,
-- 
2.14.1
