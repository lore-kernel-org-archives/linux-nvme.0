From: jay.e.sternberg@intel.com (Jay Sternberg)
Date: Thu,  4 Oct 2018 08:49:23 -0700
Subject: [PATCH 03/11] nvmet: Allow Keep Alive for Discovery controller
In-Reply-To: <1538668171-232344-1-git-send-email-jay.e.sternberg@intel.com>
References: <1538668171-232344-1-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <1538668171-232344-4-git-send-email-jay.e.sternberg@intel.com>

Per change to specification allowing Discovery controllers to have
explicit persistent connections, remove restriction on Discovery
controllers allowing kato on connect.

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/core.c      | 36 ++++++++++--------------------------
 drivers/nvme/target/discovery.c |  4 ++++
 drivers/nvme/target/nvmet.h     |  4 +++-
 4 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e50f88c..e69edd5 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -721,7 +721,7 @@ static void nvmet_execute_async_event(struct nvmet_req *req)
 	schedule_work(&ctrl->async_event_work);
 }
 
-static void nvmet_execute_keep_alive(struct nvmet_req *req)
+void nvmet_execute_keep_alive(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5773b74..f5cd31e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -990,31 +990,17 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	ctrl->cntlid = ret;
 
 	ctrl->ops = req->ops;
-	if (ctrl->subsys->type == NVME_NQN_DISC) {
-		/* Don't accept keep-alive timeout for discovery controllers */
-		if (kato) {
-			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-			goto out_remove_ida;
-		}
 
-		/*
-		 * Discovery controllers use some arbitrary high value in order
-		 * to cleanup stale discovery sessions
-		 *
-		 * From the latest base diff RC:
-		 * "The Keep Alive command is not supported by
-		 * Discovery controllers. A transport may specify a
-		 * fixed Discovery controller activity timeout value
-		 * (e.g., 2 minutes).  If no commands are received
-		 * by a Discovery controller within that time
-		 * period, the controller may perform the
-		 * actions for Keep Alive Timer expiration".
-		 */
-		ctrl->kato = NVMET_DISC_KATO;
-	} else {
-		/* keep-alive timeout in seconds */
-		ctrl->kato = DIV_ROUND_UP(kato, 1000);
-	}
+	/*
+	 * Discovery controllers may use some arbitrary high value
+	 * in order to cleanup stale discovery sessions
+	 */
+	if ((ctrl->subsys->type == NVME_NQN_DISC) && !kato)
+		kato = NVMET_DISC_KATO;
+
+	/* keep-alive timeout in seconds */
+	ctrl->kato = DIV_ROUND_UP(kato, 1000);
+
 	nvmet_start_keep_alive_timer(ctrl);
 
 	mutex_lock(&subsys->lock);
@@ -1024,8 +1010,6 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	*ctrlp = ctrl;
 	return 0;
 
-out_remove_ida:
-	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 out_free_sqs:
 	kfree(ctrl->sqs);
 out_free_cqs:
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index eae29f4..6689c56 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -194,6 +194,10 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 	}
 
 	switch (cmd->common.opcode) {
+	case nvme_admin_keep_alive:
+		req->execute = nvmet_execute_keep_alive;
+		req->data_len = 0;
+		return 0;
 	case nvme_admin_get_log_page:
 		req->data_len = nvmet_get_log_page_len(cmd);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5a56849..4910e83c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -352,6 +352,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 void nvmet_req_execute(struct nvmet_req *req);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
 
+void nvmet_execute_keep_alive(struct nvmet_req *req);
+
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
 		u16 size);
 void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, u16 qid,
@@ -422,7 +424,7 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf,
 #define NVMET_DEFAULT_ANA_GRPID	1
 
 #define NVMET_KAS		10
-#define NVMET_DISC_KATO		120
+#define NVMET_DISC_KATO		120000 /* ms */
 
 int __init nvmet_init_configfs(void);
 void __exit nvmet_exit_configfs(void);
-- 
1.8.3.1
