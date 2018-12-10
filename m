From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun,  9 Dec 2018 21:50:03 -0800
Subject: [PATCH 04/12] nvmet: add interface to update error-log page
In-Reply-To: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181210055011.3146-5-chaitanya.kulkarni@wdc.com>

This patch adds nvmet_req based interface to the nvmet-core so that
we can update the error log page. We update error log page in
the request completion path when status is not set to NVME_SC_SUCCESS.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c  | 31 ++++++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h |  5 -----
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4ed0022b8450..4fe70fc322b4 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -611,14 +611,43 @@ static void nvmet_update_sq_head(struct nvmet_req *req)
 	req->rsp->sq_head = cpu_to_le16(req->sq->sqhd & 0x0000FFFF);
 }
 
+static void nvmet_set_error(struct nvmet_req *req, u16 status)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvme_error_slot *new_error_slot;
+	unsigned long flags;
+
+	req->rsp->status = cpu_to_le16(status << 1);
+
+	if (!ctrl)
+		return;
+
+	spin_lock_irqsave(&ctrl->error_lock, flags);
+	ctrl->counter++;
+	new_error_slot = &ctrl->slots[ctrl->counter % NVMET_ERROR_LOG_SLOTS];
+
+	new_error_slot->error_count = cpu_to_le64(ctrl->counter);
+	new_error_slot->sqid = cpu_to_le16(req->sq->qid);
+	new_error_slot->cmdid = cpu_to_le16(req->cmd->common.command_id);
+	new_error_slot->status_field = cpu_to_le16(status << 1);
+	new_error_slot->param_error_location = cpu_to_le16(req->error_loc);
+	new_error_slot->lba = cpu_to_le64(req->error_slba);
+	new_error_slot->nsid = cpu_to_le32(req->cmd->common.nsid);
+	spin_unlock_irqrestore(&ctrl->error_lock, flags);
+
+	/* set the more bit for this request */
+	req->rsp->status |= cpu_to_le16(1 << 14);
+}
+
 static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
 	if (!req->sq->sqhd_disabled)
 		nvmet_update_sq_head(req);
 	req->rsp->sq_id = cpu_to_le16(req->sq->qid);
 	req->rsp->command_id = req->cmd->common.command_id;
+
 	if (unlikely(status))
-		nvmet_set_status(req, status);
+		nvmet_set_error(req, status);
 	if (req->ns)
 		nvmet_put_namespace(req->ns);
 	req->ops->queue_response(req);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5a19f64de891..662def80ff23 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -327,11 +327,6 @@ struct nvmet_req {
 
 extern struct workqueue_struct *buffered_io_wq;
 
-static inline void nvmet_set_status(struct nvmet_req *req, u16 status)
-{
-	req->rsp->status = cpu_to_le16(status << 1);
-}
-
 static inline void nvmet_set_result(struct nvmet_req *req, u32 result)
 {
 	req->rsp->result.u32 = cpu_to_le32(result);
-- 
2.17.0
