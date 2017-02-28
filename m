From: parav@mellanox.com (Parav Pandit)
Date: Mon, 27 Feb 2017 23:21:02 -0600
Subject: [PATCHv1 1/2] nvmet: Fixed avoided printing nvmet: twice in error
 logs.
Message-ID: <1488259262-62372-1-git-send-email-parav@mellanox.com>

This patch avoids printing "nvmet:" twice in error logs as its already
coming through pr_fmt macro.

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Parav Pandit <parav at mellanox.com>
---
 drivers/nvme/target/admin-cmd.c | 10 +++++-----
 drivers/nvme/target/core.c      |  4 ++--
 drivers/nvme/target/discovery.c | 17 ++++++++---------
 drivers/nvme/target/io-cmd.c    | 10 +++++-----
 4 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 94e524f..c9f0a32 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -485,13 +485,13 @@ int nvmet_parse_admin_cmd(struct nvmet_req *req)
 	req->ns = NULL;
 
 	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
-		pr_err("nvmet: got admin cmd %d while CC.EN == 0\n",
-				cmd->common.opcode);
+		pr_err("got admin cmd %d while CC.EN == 0\n",
+		       cmd->common.opcode);
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
 	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
-		pr_err("nvmet: got admin cmd %d while CSTS.RDY == 0\n",
-				cmd->common.opcode);
+		pr_err("got admin cmd %d while CSTS.RDY == 0\n",
+		       cmd->common.opcode);
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
 
@@ -543,6 +543,6 @@ int nvmet_parse_admin_cmd(struct nvmet_req *req)
 		return 0;
 	}
 
-	pr_err("nvmet: unhandled cmd %d\n", cmd->common.opcode);
+	pr_err("unhandled cmd %d\n", cmd->common.opcode);
 	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 }
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5267ce2..e1d00ba 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -271,8 +271,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	ns->bdev = blkdev_get_by_path(ns->device_path, FMODE_READ | FMODE_WRITE,
 			NULL);
 	if (IS_ERR(ns->bdev)) {
-		pr_err("nvmet: failed to open block device %s: (%ld)\n",
-			ns->device_path, PTR_ERR(ns->bdev));
+		pr_err("failed to open block device %s: (%ld)\n",
+		       ns->device_path, PTR_ERR(ns->bdev));
 		ret = PTR_ERR(ns->bdev);
 		ns->bdev = NULL;
 		goto out_unlock;
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index af8aabf..745f26f 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -166,8 +166,8 @@ int nvmet_parse_discovery_cmd(struct nvmet_req *req)
 	req->ns = NULL;
 
 	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
-		pr_err("nvmet: got cmd %d while not ready\n",
-				cmd->common.opcode);
+		pr_err("got cmd %d while not ready\n",
+		       cmd->common.opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 
@@ -180,8 +180,8 @@ int nvmet_parse_discovery_cmd(struct nvmet_req *req)
 			req->execute = nvmet_execute_get_disc_log_page;
 			return 0;
 		default:
-			pr_err("nvmet: unsupported get_log_page lid %d\n",
-				cmd->get_log_page.lid);
+			pr_err("unsupported get_log_page lid %d\n",
+			       cmd->get_log_page.lid);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 		}
 	case nvme_admin_identify:
@@ -192,17 +192,16 @@ int nvmet_parse_discovery_cmd(struct nvmet_req *req)
 				nvmet_execute_identify_disc_ctrl;
 			return 0;
 		default:
-			pr_err("nvmet: unsupported identify cns %d\n",
-				cmd->identify.cns);
+			pr_err("unsupported identify cns %d\n",
+			       cmd->identify.cns);
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
index 4195115..190b687 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -201,15 +201,15 @@ int nvmet_parse_io_cmd(struct nvmet_req *req)
 	struct nvme_command *cmd = req->cmd;
 
 	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
-		pr_err("nvmet: got io cmd %d while CC.EN == 0\n",
-				cmd->common.opcode);
+		pr_err("got io cmd %d while CC.EN == 0\n",
+		       cmd->common.opcode);
 		req->ns = NULL;
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
 
 	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
-		pr_err("nvmet: got io cmd %d while CSTS.RDY == 0\n",
-				cmd->common.opcode);
+		pr_err("got io cmd %d while CSTS.RDY == 0\n",
+		       cmd->common.opcode);
 		req->ns = NULL;
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
@@ -237,7 +237,7 @@ int nvmet_parse_io_cmd(struct nvmet_req *req)
 		req->execute = nvmet_execute_write_zeroes;
 		return 0;
 	default:
-		pr_err("nvmet: unhandled cmd %d\n", cmd->common.opcode);
+		pr_err("unhandled cmd %d\n", cmd->common.opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 }
-- 
1.8.3.1
