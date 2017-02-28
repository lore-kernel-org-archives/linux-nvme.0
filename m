From: parav@mellanox.com (Parav Pandit)
Date: Mon, 27 Feb 2017 23:21:33 -0600
Subject: [PATCHv1 2/2] nvmet: Introduced helper routine for controller status
 check.
Message-ID: <1488259293-62414-1-git-send-email-parav@mellanox.com>

This patch introduces helper function for checking controller
status during admin and io command processing which returns u16
status. As to bring consistency on returning status, other
friend functions also now return u16 status instead of int
to match the spec.

As part of the theseerror log prints in also prints qid on
which command error occured.

Signed-off-by: Parav Pandit <parav at mellanox.com>
---
 drivers/nvme/target/admin-cmd.c   | 19 +++++++------------
 drivers/nvme/target/core.c        | 17 +++++++++++++++++
 drivers/nvme/target/discovery.c   |  2 +-
 drivers/nvme/target/fabrics-cmd.c |  4 ++--
 drivers/nvme/target/io-cmd.c      | 22 ++++++++--------------
 drivers/nvme/target/nvmet.h       | 11 ++++++-----
 6 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index c9f0a32..85abf38 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -478,22 +478,16 @@ static void nvmet_execute_keep_alive(struct nvmet_req *req)
 	nvmet_req_complete(req, 0);
 }
 
-int nvmet_parse_admin_cmd(struct nvmet_req *req)
+u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
+	u16 ret;
 
 	req->ns = NULL;
 
-	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
-		pr_err("got admin cmd %d while CC.EN == 0\n",
-		       cmd->common.opcode);
-		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
-	}
-	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
-		pr_err("got admin cmd %d while CSTS.RDY == 0\n",
-		       cmd->common.opcode);
-		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
-	}
+	ret = nvmet_check_ctrl_status(req, cmd);
+	if (unlikely(ret))
+		return ret;
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_get_log_page:
@@ -543,6 +537,7 @@ int nvmet_parse_admin_cmd(struct nvmet_req *req)
 		return 0;
 	}
 
-	pr_err("unhandled cmd %d\n", cmd->common.opcode);
+	pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
+	       req->sq->qid);
 	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 }
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e1d00ba..2fb7897 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -650,6 +650,23 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 	return status;
 }
 
+u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd)
+{
+	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
+		pr_err("got io cmd %d while CC.EN == 0 on qid = %d\n",
+		       cmd->common.opcode, req->sq->qid);
+		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+	}
+
+	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
+		pr_err("got io cmd %d while CSTS.RDY == 0 on qid = %d\n",
+		       cmd->common.opcode, req->sq->qid);
+		req->ns = NULL;
+		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+	}
+	return 0;
+}
+
 static bool __nvmet_host_allowed(struct nvmet_subsys *subsys,
 		const char *hostnqn)
 {
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 745f26f..1aaf597 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -159,7 +159,7 @@ static void nvmet_execute_identify_disc_ctrl(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-int nvmet_parse_discovery_cmd(struct nvmet_req *req)
+u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
 
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 8bd022af..2a3c15b 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -73,7 +73,7 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-int nvmet_parse_fabrics_cmd(struct nvmet_req *req)
+u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
 
@@ -214,7 +214,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	goto out;
 }
 
-int nvmet_parse_connect_cmd(struct nvmet_req *req)
+u16 nvmet_parse_connect_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
 
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 190b687..27623f2 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -196,26 +196,19 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
-int nvmet_parse_io_cmd(struct nvmet_req *req)
+u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
+	u16 ret;
 
-	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
-		pr_err("got io cmd %d while CC.EN == 0\n",
-		       cmd->common.opcode);
+	ret = nvmet_check_ctrl_status(req, cmd);
+	if (unlikely(ret)) {
 		req->ns = NULL;
-		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
-	}
-
-	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
-		pr_err("got io cmd %d while CSTS.RDY == 0\n",
-		       cmd->common.opcode);
-		req->ns = NULL;
-		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+		return ret;
 	}
 
 	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
-	if (!req->ns)
+	if (unlikely(!req->ns))
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 
 	switch (cmd->common.opcode) {
@@ -237,7 +230,8 @@ int nvmet_parse_io_cmd(struct nvmet_req *req)
 		req->execute = nvmet_execute_write_zeroes;
 		return 0;
 	default:
-		pr_err("unhandled cmd %d\n", cmd->common.opcode);
+		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
+		       req->sq->qid);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 1370eee..6898231 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -252,11 +252,11 @@ struct nvmet_async_event {
 	u8			log_page;
 };
 
-int nvmet_parse_connect_cmd(struct nvmet_req *req);
-int nvmet_parse_io_cmd(struct nvmet_req *req);
-int nvmet_parse_admin_cmd(struct nvmet_req *req);
-int nvmet_parse_discovery_cmd(struct nvmet_req *req);
-int nvmet_parse_fabrics_cmd(struct nvmet_req *req);
+u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
+u16 nvmet_parse_io_cmd(struct nvmet_req *req);
+u16 nvmet_parse_admin_cmd(struct nvmet_req *req);
+u16 nvmet_parse_discovery_cmd(struct nvmet_req *req);
+u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req);
 
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		struct nvmet_sq *sq, struct nvmet_fabrics_ops *ops);
@@ -277,6 +277,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 		struct nvmet_req *req, struct nvmet_ctrl **ret);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
+u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd);
 
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		enum nvme_subsys_type type);
-- 
1.8.3.1
