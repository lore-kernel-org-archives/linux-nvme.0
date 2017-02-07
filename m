From: parav@mellanox.com (Parav Pandit)
Date: Tue,  7 Feb 2017 17:35:57 -0600
Subject: [PATCH] nvmet: Do not check for sg_cnt being zero for read/write
 commands.
Message-ID: <1486510557-26831-1-git-send-email-parav@mellanox.com>

sg_cnt cannot be zero for inline or sge mode from the fabric drivers
because nvme read/write commands have minimum of one block to be
read or written. (nlb dw12 is 0 based value).
So sg_cnt check for 0 is not useful.

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Parav Pandit <parav at mellanox.com>
---
 drivers/nvme/target/io-cmd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 4195115..e6a3a8a 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -49,11 +49,6 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 	blk_qc_t cookie;
 	int op, op_flags = 0, i;
 
-	if (!req->sg_cnt) {
-		nvmet_req_complete(req, 0);
-		return;
-	}
-
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
 		op = REQ_OP_WRITE;
 		op_flags = REQ_SYNC | REQ_IDLE;
-- 
1.8.3.1
