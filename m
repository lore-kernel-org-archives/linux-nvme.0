From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon,  6 Mar 2017 00:30:38 +0200
Subject: [PATCH 1/1] nvmet: use symbolic constants for log identifiers
Message-ID: <1488753038-26188-1-git-send-email-maxg@mellanox.com>

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Parav Pandit <parav at mellanox.com>
---
 drivers/nvme/target/admin-cmd.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index a7bcff4..7502269 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -121,7 +121,7 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	}
 
 	switch (req->cmd->get_log_page.lid) {
-	case 0x01:
+	case NVME_LOG_ERROR:
 		/*
 		 * We currently never set the More bit in the status field,
 		 * so all error log entries are invalid and can be zeroed out.
@@ -129,7 +129,7 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		 * mandatory log page.
 		 */
 		break;
-	case 0x02:
+	case NVME_LOG_SMART:
 		/*
 		 * XXX: fill out actual smart log
 		 *
@@ -149,7 +149,7 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 			goto err;
 		}
 		break;
-	case 0x03:
+	case NVME_LOG_FW_SLOT:
 		/*
 		 * We only support a single firmware slot which always is
 		 * active, so we can zero out the whole firmware slot log and
@@ -502,9 +502,9 @@ int nvmet_parse_admin_cmd(struct nvmet_req *req)
 		req->data_len = nvmet_get_log_page_len(cmd);
 
 		switch (cmd->get_log_page.lid) {
-		case 0x01:
-		case 0x02:
-		case 0x03:
+		case NVME_LOG_ERROR:
+		case NVME_LOG_SMART:
+		case NVME_LOG_FW_SLOT:
 			req->execute = nvmet_execute_get_log_page;
 			return 0;
 		}
-- 
1.7.1
