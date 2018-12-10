From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun,  9 Dec 2018 21:50:11 -0800
Subject: [PATCH 12/12] nvmet: update smart log with num err log entries
In-Reply-To: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181210055011.3146-13-chaitanya.kulkarni@wdc.com>

Now that we have error log page implementation update smart log command
handler to provide number of error log entries in the lifetime of the
controller field.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f22c0ff8f163..2824c3edb96e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -135,6 +135,7 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 {
 	struct nvme_smart_log *log;
 	u16 status = NVME_SC_INTERNAL;
+	unsigned long flags;
 
 	if (req->data_len != sizeof(*log))
 		goto out;
@@ -150,6 +151,10 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	if (status)
 		goto out_free_log;
 
+	spin_lock_irqsave(&req->sq->ctrl->error_lock, flags);
+	put_unaligned_le64(req->sq->ctrl->counter, &log->num_err_log_entries);
+	spin_unlock_irqrestore(&req->sq->ctrl->error_lock, flags);
+
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 out_free_log:
 	kfree(log);
-- 
2.17.0
