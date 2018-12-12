From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 12 Dec 2018 15:11:48 -0800
Subject: [PATCH V2 12/12] nvmet: update smart log with num err log entries
In-Reply-To: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
References: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181212231148.4107-13-chaitanya.kulkarni@wdc.com>

Now that we have error log page implementation update smart log command
handler to provide number of error log entries in the lifetime of the
controller field.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 00956b4106a8..11baeb14c388 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -135,6 +135,7 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 {
 	struct nvme_smart_log *log;
 	u16 status = NVME_SC_INTERNAL;
+	unsigned long flags;
 
 	if (req->data_len != sizeof(*log))
 		goto out;
@@ -150,6 +151,11 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	if (status)
 		goto out_free_log;
 
+	spin_lock_irqsave(&req->sq->ctrl->error_lock, flags);
+	put_unaligned_le64(req->sq->ctrl->err_counter,
+			&log->num_err_log_entries);
+	spin_unlock_irqrestore(&req->sq->ctrl->error_lock, flags);
+
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 out_free_log:
 	kfree(log);
-- 
2.17.0
