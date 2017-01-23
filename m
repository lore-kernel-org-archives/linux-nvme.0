From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 23 Jan 2017 11:01:12 +0200
Subject: [PATCH 1/1] nvmet: avoid dereferencing nvmet_req
Message-ID: <1485162072-10335-1-git-send-email-maxg@mellanox.com>

No need to dereference req twice to get the cmd when we already
have it stored in a local variable.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Parav Pandit <parav at mellanox.com>
---
 drivers/nvme/target/fabrics-cmd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index f408819..11c6682 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -220,7 +220,7 @@ int nvmet_parse_connect_cmd(struct nvmet_req *req)
 
 	req->ns = NULL;
 
-	if (req->cmd->common.opcode != nvme_fabrics_command) {
+	if (cmd->common.opcode != nvme_fabrics_command) {
 		pr_err("invalid command 0x%x on unconnected queue.\n",
 			cmd->fabrics.opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
-- 
1.7.1
