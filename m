From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 12 Dec 2018 15:11:47 -0800
Subject: [PATCH V2 11/12] nvmet: add error log page cmd handler
In-Reply-To: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
References: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181212231148.4107-12-chaitanya.kulkarni@wdc.com>

Now that we have support for all the major parts of the target we add
a NVMe error log page handler so that host can read the log page.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 36 ++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index fa62db7a5e9e..00956b4106a8 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -37,6 +37,34 @@ static void nvmet_execute_get_log_page_noop(struct nvmet_req *req)
 	nvmet_req_complete(req, nvmet_zero_sgl(req, 0, req->data_len));
 }
 
+static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u16 status = NVME_SC_SUCCESS;
+	unsigned long flags;
+	off_t offset = 0;
+	u64 slot;
+	u64 i;
+
+	spin_lock_irqsave(&ctrl->error_lock, flags);
+	slot = ctrl->err_counter % NVMET_ERROR_LOG_SLOTS;
+
+	for (i = 0; i < NVMET_ERROR_LOG_SLOTS; i++) {
+		status = nvmet_copy_to_sgl(req, offset, &ctrl->slots[slot],
+				sizeof(struct nvme_error_slot));
+		if (status)
+			break;
+
+		if (slot == 0)
+			slot = NVMET_ERROR_LOG_SLOTS - 1;
+		else
+			slot--;
+		offset += sizeof(struct nvme_error_slot);
+	}
+	spin_unlock_irqrestore(&ctrl->error_lock, flags);
+	nvmet_req_complete(req, status);
+}
+
 static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		struct nvme_smart_log *slog)
 {
@@ -789,13 +817,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 
 		switch (cmd->get_log_page.lid) {
 		case NVME_LOG_ERROR:
-			/*
-			 * We currently never set the More bit in the status
-			 * field, so all error log entries are invalid and can
-			 * be zeroed out.  This is called a minum viable
-			 * implementation (TM) of this mandatory log page.
-			 */
-			req->execute = nvmet_execute_get_log_page_noop;
+			req->execute = nvmet_execute_get_log_page_error;
 			return 0;
 		case NVME_LOG_SMART:
 			req->execute = nvmet_execute_get_log_page_smart;
-- 
2.17.0
