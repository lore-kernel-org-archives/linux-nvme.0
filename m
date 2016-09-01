From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Thu,  1 Sep 2016 20:45:03 +0100
Subject: [PATCH] admin-cmd: Added smart-log command support.
Message-ID: <1472759103-16538-1-git-send-email-ckulkarnilinux@gmail.com>

This patch implements the support for smart-log command
(NVM Express 1.2.1-section 5.10.1.2 SMART / Health Information
(Log Identifier 02h)) on the target for NVMe over Fabric.

In current implementation host can retrieve following statistics:-
1. Data Units Read.
2. Data Units Written.
3. Host Read Commands.
4. Host Write Commands.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux at gmail.com>
---
 drivers/nvme/target/admin-cmd.c | 88 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 47c564b..7ab9c93 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <generated/utsrelease.h>
+#include <asm/unaligned.h>
 #include "nvmet.h"
 
 u32 nvmet_get_log_page_len(struct nvme_command *cmd)
@@ -29,8 +30,84 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd)
 	return len;
 }
 
+static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
+		struct nvme_smart_log *slog)
+{
+	u16 status;
+	struct nvmet_ns *ns;
+	u64 host_reads, host_writes, data_units_read, data_units_written;
+
+	status = NVME_SC_SUCCESS;
+	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->get_log_page.nsid);
+	if (!ns) {
+		status = NVME_SC_INVALID_NS;
+		pr_err("nvmet : Counld not find namespace id : %d\n",
+				le32_to_cpu(req->cmd->get_log_page.nsid));
+		goto out;
+	}
+
+	host_reads = part_stat_read(ns->bdev->bd_part, ios[READ]);
+	data_units_read = part_stat_read(ns->bdev->bd_part, sectors[READ]);
+	host_writes = part_stat_read(ns->bdev->bd_part, ios[WRITE]);
+	data_units_written = part_stat_read(ns->bdev->bd_part, sectors[WRITE]);
+
+	put_unaligned_le64(host_reads, &slog->host_reads[0]);
+	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
+	put_unaligned_le64(host_writes, &slog->host_writes[0]);
+	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
+	nvmet_put_namespace(ns);
+out:
+	return status;
+}
+
+static u16 nvmet_get_smart_log_all(struct nvmet_req *req,
+		struct nvme_smart_log *slog)
+{
+	u16 status;
+	u64 host_reads = 0, host_writes = 0;
+	u64 data_units_read = 0, data_units_written = 0;
+	struct nvmet_ns *ns;
+	struct nvmet_ctrl *ctrl;
+
+	status = NVME_SC_SUCCESS;
+	ctrl = req->sq->ctrl;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
+		host_reads += part_stat_read(ns->bdev->bd_part, ios[READ]);
+		data_units_read +=
+			part_stat_read(ns->bdev->bd_part, sectors[READ]);
+		host_writes += part_stat_read(ns->bdev->bd_part, ios[WRITE]);
+		data_units_written +=
+			part_stat_read(ns->bdev->bd_part, sectors[WRITE]);
+
+	}
+	rcu_read_unlock();
+
+	put_unaligned_le64(host_reads, &slog->host_reads[0]);
+	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
+	put_unaligned_le64(host_writes, &slog->host_writes[0]);
+	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
+
+	return status;
+}
+
+static u16 nvmet_get_smart_log(struct nvmet_req *req,
+		struct nvme_smart_log *slog)
+{
+	u16 status;
+
+	WARN_ON(req == NULL || slog == NULL);
+	if (req->cmd->get_log_page.nsid == 0xFFFFFFFF)
+		status = nvmet_get_smart_log_all(req, slog);
+	else
+		status = nvmet_get_smart_log_nsid(req, slog);
+	return status;
+}
+
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
+	struct nvme_smart_log *smart_log;
 	size_t data_len = nvmet_get_log_page_len(req->cmd);
 	void *buf;
 	u16 status = 0;
@@ -59,6 +136,16 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		 * available (e.g. units or commands read/written) those aren't
 		 * persistent over power loss.
 		 */
+		if (data_len != sizeof(*smart_log)) {
+			status = NVME_SC_INTERNAL;
+			goto err;
+		}
+		smart_log = buf;
+		status = nvmet_get_smart_log(req, smart_log);
+		if (status) {
+			memset(buf, '\0', data_len);
+			goto err;
+		}
 		break;
 	case 0x03:
 		/*
@@ -73,6 +160,7 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 
 	status = nvmet_copy_to_sgl(req, 0, buf, data_len);
 
+err:
 	kfree(buf);
 out:
 	nvmet_req_complete(req, status);
-- 
1.9.1
