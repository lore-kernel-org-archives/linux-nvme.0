From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 15:00:10 -0400
Subject: [PATCH 19/20] nvmet: add check for ctrl processing paused status
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-20-chaitanya.kulkarni@wdc.com>

New ctrl status bit processing paused is checked
under nvmet_check_ctrl_status() which acts as a guard for
admin and IO commands.

Right now from the spec there is no way to differentiate
transport commands and storage commands so we can allow only
allow transport commands. Consider a scenario where we want
transport commands to work but the storage commands are disabled.

This allows to set processing paused status where we want to
allow a subset of the commands to work.

The example of above scenario is when implementing the file backed
namespaces we allow host to set volatile write cache feature
when connected. In this scenario, we cannot handle any incoming
admin and IO commands as we enable/disable the VWC but we need
to handle keep alive command in order to preserve the connection.
Also here we want a controller to be in ready state.

The check for new bit NVME_CSTS_PP allows us to execute subset
commands and deny others when ctrl is enabled and in a ready
status.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c  | 50 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h |  2 ++
 2 files changed, 52 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 36f0dacec042..0c5b69b638ed 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -802,6 +802,22 @@ u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd)
 		req->ns = NULL;
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
+
+	/*
+	 * We use processing paused state which allows subset of the commands
+	 * to work, e.g. we allow keep alive command when in a paused state.
+	 */
+
+	if (unlikely(req->sq->ctrl->csts & NVME_CSTS_PP)) {
+		switch (cmd->common.opcode) {
+		case nvme_admin_async_event:
+		case nvme_admin_keep_alive:
+		case nvme_admin_get_features:
+			break;
+		default:
+			return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+		}
+	}
 	return 0;
 }
 
@@ -989,6 +1005,40 @@ void nvmet_ctrl_put(struct nvmet_ctrl *ctrl)
 	kref_put(&ctrl->ref, nvmet_ctrl_free);
 }
 
+/*
+ * Right now from the spec there is no way to differentiate transport commands
+ * and storage commands. There could be a scenario where we want transport
+ * commands to work but the storage commands are disabled.
+ * We put ctrl in processing paused state where we want to allow
+ * subset of the commands to work. Please refer to the
+ * nvmet_check_ctrl_status().
+ */
+bool nvmet_ctrl_processing_pause(struct nvmet_ctrl *ctrl)
+{
+	bool ret = false;
+
+	mutex_lock(&ctrl->lock);
+	if (ctrl->cc & NVME_CC_ENABLE && ctrl->csts & NVME_CSTS_RDY) {
+		ctrl->csts |= NVME_CSTS_PP;
+		ret = true;
+	}
+	mutex_unlock(&ctrl->lock);
+	return ret;
+}
+
+bool nvmet_ctrl_processing_resume(struct nvmet_ctrl *ctrl)
+{
+	bool ret = false;
+
+	mutex_lock(&ctrl->lock);
+	if (ctrl->cc & NVME_CC_ENABLE && ctrl->csts & NVME_CSTS_RDY) {
+		ctrl->csts &= ~NVME_CSTS_PP;
+		ret = true;
+	}
+	mutex_unlock(&ctrl->lock);
+	return ret;
+}
+
 static void nvmet_fatal_error_handler(struct work_struct *work)
 {
 	struct nvmet_ctrl *ctrl =
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index acb9c266573b..bd9d5b8a6a30 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -297,6 +297,8 @@ void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, u16 qid,
 void nvmet_sq_destroy(struct nvmet_sq *sq);
 int nvmet_sq_init(struct nvmet_sq *sq);
 
+bool nvmet_ctrl_processing_pause(struct nvmet_ctrl *ctrl);
+bool nvmet_ctrl_processing_resume(struct nvmet_ctrl *ctrl);
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
 
 void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
-- 
2.14.1
