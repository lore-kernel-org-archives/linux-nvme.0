From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue,  8 May 2018 02:02:33 -0400
Subject: [PATCH] nvmet: make the error message more generic
Message-ID: <20180508060233.4541-1-chaitanya.kulkarni@wdc.com>

"nvmet_check_ctrl_status()" is called from admin-cmd.c along
with io-cmd.c, make the error message more generic.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e95424f172fd..4a9908bb7de0 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -710,13 +710,13 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd)
 {
 	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
-		pr_err("got io cmd %d while CC.EN == 0 on qid = %d\n",
+		pr_err("got cmd %d while CC.EN == 0 on qid = %d\n",
 		       cmd->common.opcode, req->sq->qid);
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
 
 	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
-		pr_err("got io cmd %d while CSTS.RDY == 0 on qid = %d\n",
+		pr_err("got cmd %d while CSTS.RDY == 0 on qid = %d\n",
 		       cmd->common.opcode, req->sq->qid);
 		req->ns = NULL;
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
-- 
2.14.1
