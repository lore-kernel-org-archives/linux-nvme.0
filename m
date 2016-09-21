From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Sep 2016 11:10:50 -0700
Subject: [PATCH] nvmet: Use direct IO for writes
Message-ID: <1474481450-5036-1-git-send-email-sagi@grimberg.me>

We're designed to work with high-end devices where
direct IO makes perfect sense. We noticed that we
context switch by scheduling kblockd instead of going
directly to the device without REQ_SYNC for writes.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/io-cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 2cd069b691ae..4132b6b98182 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -58,6 +58,7 @@ static void nvmet_execute_rw(struct nvmet_req *req)
 
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
 		op = REQ_OP_WRITE;
+		op_flags = WRITE_ODIRECT;
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
 			op_flags |= REQ_FUA;
 	} else {
-- 
1.9.1
