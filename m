From: jsmart2021@gmail.com (James Smart)
Date: Thu, 21 Sep 2017 08:13:49 -0700
Subject: [PATCH] nvme: fix sqhd reference when admin queue connect fails
Message-ID: <20170921151349.18234-1-jsmart2021@gmail.com>

Fix bug in sqhd patch.

It wasn't the sq that was at risk. In the case where the admin queue
Connect command fails, the sq->size field is not set. Therefore, this
becomes a divide by zero error.

Add a quick check to bypass under this failure condition.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8c86c258d2e8..8b6175d0531a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -390,7 +390,8 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 	if (status)
 		nvmet_set_status(req, status);
 
-	req->sq->sqhd = (req->sq->sqhd + 1) % req->sq->size;
+	if (req->sq->size)
+		req->sq->sqhd = (req->sq->sqhd + 1) % req->sq->size;
 	req->rsp->sq_head = cpu_to_le16(req->sq->sqhd);
 	req->rsp->sq_id = cpu_to_le16(req->sq->qid);
 	req->rsp->command_id = req->cmd->common.command_id;
-- 
2.13.1
