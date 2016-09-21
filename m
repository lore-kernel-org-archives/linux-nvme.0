From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Sep 2016 14:19:27 -0700
Subject: [PATCH] nvmet: Make dsm number of ranges zero based
Message-ID: <1474492767-8364-1-git-send-email-sagi@grimberg.me>

From: Alexander Solganik <sashas@lightbitslabs.com>

This caused the nvmet request data length to be
incorrect.

Signed-off-by: Alexander Solganik <sashas at lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/io-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 4132b6b98182..4a96c2049b7b 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -206,7 +206,7 @@ int nvmet_parse_io_cmd(struct nvmet_req *req)
 		return 0;
 	case nvme_cmd_dsm:
 		req->execute = nvmet_execute_dsm;
-		req->data_len = le32_to_cpu(cmd->dsm.nr) *
+		req->data_len = le32_to_cpu(cmd->dsm.nr + 1) *
 			sizeof(struct nvme_dsm_range);
 		return 0;
 	default:
-- 
1.9.1
