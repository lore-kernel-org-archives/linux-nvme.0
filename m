From: parav@mellanox.com (Parav Pandit)
Date: Wed,  8 Feb 2017 15:57:19 -0600
Subject: [PATCH] nvmet: Fixed avoided printing nvmet: twice in error logs.
Message-ID: <1486591039-1177-1-git-send-email-parav@mellanox.com>

This patch avoids printing "nvmet:" twice in error logs as its already
coming through pr_fmt macro.
It makes some of the logs more verbose by including qid to it.
It avoid code duplication for checking controller status for admin and
io queue by having common function for both that further can be reused
by other transports.
Fixed typo reported by Max Gurtovoy.

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Parav Pandit <parav at mellanox.com>
---
 drivers/nvme/target/admin-cmd.c | 19 +++++++------------
 drivers/nvme/target/core.c      | 18 +++++++++++++++++-
 drivers/nvme/target/discovery.c | 12 +++++-------
 drivers/nvme/target/io-cmd.c    | 20 +++++++-------------
 drivers/nvme/target/nvmet.h     |  1 +
 5 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f376dc4..b8f066b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -41,7 +41,7 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->get_log_page.nsid);
 	if (!ns) {
 		status = NVME_SC_INVALID_NS;
-		pr_err("nvmet : Counld not find namespace id : %d\n",
+		pr_err("Could not find namespace id : %d\n",
 				le32_to_cpu(req->cmd->get_log_page.nsid));
 		goto out;
 	}
@@ -481,19 +481,13 @@ static void nvmet_execute_keep_alive(struct nvmet_req *req)
 int nvmet_parse_admin_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
+	int ret;
 
 	req->ns = NULL;
 
-	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
-		pr_err("nvmet: got admin cmd %d while CC.EN == 0\n",
-				cmd->common.opcode);
-		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
-	}
-	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
-		pr_err("nvmet: got admin cmd %d while CSTS.RDY == 0\n",
-				cmd->common.opcode);
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
 
-	pr_err("nvmet: unhandled cmd %d\n", cmd->common.opcode);
+	pr_err("unhandled cmd %d on qid %d\n",
+		cmd->common.opcode, req->sq->qid);
 	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 }
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e55d650..466f4ac 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -270,7 +270,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	ns->bdev = blkdev_get_by_path(ns->device_path, FMODE_READ | FMODE_WRITE,
 			NULL);
 	if (IS_ERR(ns->bdev)) {
-		pr_err("nvmet: failed to open block device %s: (%ld)\n",
+		pr_err("failed to open block device %s: (%ld)\n",
 			ns->device_path, PTR_ERR(ns->bdev));
 		ret = PTR_ERR(ns->bdev);
 		ns->bdev = NULL;
@@ -645,6 +645,22 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 	return status;
 }
 
+int nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd)
+{
+	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
+		pr_err("got io cmd %d while CC.EN == 0 on qid %d\n",
+				cmd->common.opcode, req->sq->qid);
+		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+	}
+
+	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
+		pr_err("got io cmd %d while CSTS.RDY == 0 on qid %d\n",
+				cmd->common.opcode, req->sq->qid);
+		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+	}
+	return 0;
+}
+
 static bool __nvmet_host_allowed(struct nvmet_subsys *subsys,
 		const char *hostnqn)
 {
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index af8aabf..3044e2f 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -166,8 +166,7 @@ int nvmet_parse_discovery_cmd(struct nvmet_req *req)
 	req->ns = NULL;
 
 	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
-		pr_err("nvmet: got cmd %d while not ready\n",
-				cmd->common.opcode);
+		pr_err("got cmd %d while not ready\n", cmd->common.opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 
@@ -180,7 +179,7 @@ int nvmet_parse_discovery_cmd(struct nvmet_req *req)
 			req->execute = nvmet_execute_get_disc_log_page;
 			return 0;
 		default:
-			pr_err("nvmet: unsupported get_log_page lid %d\n",
+			pr_err("unsupported get_log_page lid %d\n",
 				cmd->get_log_page.lid);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
@@ -192,17 +191,16 @@ int nvmet_parse_discovery_cmd(struct nvmet_req *req)
 				nvmet_execute_identify_disc_ctrl;
 			return 0;
 		default:
-			pr_err("nvmet: unsupported identify cns %d\n",
+			pr_err("unsupported identify cns %d\n",
 				cmd->identify.cns);
 			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
 	default:
-		pr_err("nvmet: unsupported cmd %d\n",
-				cmd->common.opcode);
+		pr_err("unsupported cmd %d\n", cmd->common.opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 
-	pr_err("nvmet: unhandled cmd %d\n", cmd->common.opcode);
+	pr_err("unhandled cmd %d\n", cmd->common.opcode);
 	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 }
 
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index e6a3a8a..18e08cf 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -194,23 +194,16 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 int nvmet_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
+	int ret;
 
-	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
-		pr_err("nvmet: got io cmd %d while CC.EN == 0\n",
-				cmd->common.opcode);
+	ret = nvmet_check_ctrl_status(req, cmd);
+	if (unlikely(ret)) {
 		req->ns = NULL;
-		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
-	}
-
-	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
-		pr_err("nvmet: got io cmd %d while CSTS.RDY == 0\n",
-				cmd->common.opcode);
-		req->ns = NULL;
-		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+		return ret;
 	}
 
 	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
-	if (!req->ns)
+	if (unlikely(!req->ns))
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 
 	switch (cmd->common.opcode) {
@@ -232,7 +225,8 @@ int nvmet_parse_io_cmd(struct nvmet_req *req)
 		req->execute = nvmet_execute_write_zeroes;
 		return 0;
 	default:
-		pr_err("nvmet: unhandled cmd %d\n", cmd->common.opcode);
+		pr_err("unhandled cmd %d on qid %d\n",
+				cmd->common.opcode, req->sq->qid);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 48486c2..cd82c3b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -275,6 +275,7 @@ static inline void nvmet_req_link_to_nvme_queues(struct nvmet_req *req,
 bool nvmet_req_init(struct nvmet_req *req);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
 
+int nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd);
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
 		u16 size);
 void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, u16 qid,
-- 
1.8.3.1
