From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 10 May 2018 02:46:30 -0400
Subject: [PATCH] nvmet: remove duplicate NULL initialization for ns
Message-ID: <20180510064630.25870-1-chaitanya.kulkarni@wdc.com>

This patch removes the duplicate NULL initialization for the 
req->ns. Following functions nvmet_parse_admin_cmd(),
nvmet_parse_io_cmd(), nvmet_parse_connect_cmd() and 
nvmet_parse_discovery_cmdi() are called from
nvmet_req_init(). In nvmet_req_init() we set req->ns to NULL,
so remove the duplicate NULL value initialization from above
functions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c   | 2 --
 drivers/nvme/target/discovery.c   | 2 --
 drivers/nvme/target/fabrics-cmd.c | 2 --
 drivers/nvme/target/io-cmd.c      | 4 +---
 4 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 5e0e9fc..d1afcfd 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -548,8 +548,6 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 	struct nvme_command *cmd = req->cmd;
 	u16 ret;
 
-	req->ns = NULL;
-
 	ret = nvmet_check_ctrl_status(req, cmd);
 	if (unlikely(ret))
 		return ret;
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 231e04e..08656b8 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -187,8 +187,6 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
 
-	req->ns = NULL;
-
 	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
 		pr_err("got cmd %d while not ready\n",
 		       cmd->common.opcode);
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 19e9e42..4c4651c 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -242,8 +242,6 @@ u16 nvmet_parse_connect_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
 
-	req->ns = NULL;
-
 	if (cmd->common.opcode != nvme_fabrics_command) {
 		pr_err("invalid command 0x%x on unconnected queue.\n",
 			cmd->fabrics.opcode);
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index cd23441..e5eb2db 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -195,10 +195,8 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	u16 ret;
 
 	ret = nvmet_check_ctrl_status(req, cmd);
-	if (unlikely(ret)) {
-		req->ns = NULL;
+	if (unlikely(ret))
 		return ret;
-	}
 
 	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
 	if (unlikely(!req->ns))
-- 
2.9.5
