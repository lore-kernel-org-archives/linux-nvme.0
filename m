From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 28 May 2019 02:53:44 +0900
Subject: [RFC PATCH 3/5] nvme: Introduce nvme_is_fabrics to check fabrics cmd
In-Reply-To: <20190527175346.29972-1-minwoo.im.dev@gmail.com>
References: <20190527175346.29972-1-minwoo.im.dev@gmail.com>
Message-ID: <20190527175346.29972-4-minwoo.im.dev@gmail.com>

This patch introduce a nvme_is_fabrics() inline function to check
whether or not the given command structure is for fabrics.

Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: James Smart <james.smart at broadcom.com>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/fabrics.c       | 2 +-
 drivers/nvme/target/core.c        | 2 +-
 drivers/nvme/target/fabrics-cmd.c | 2 +-
 drivers/nvme/target/fc.c          | 2 +-
 include/linux/nvme.h              | 7 ++++++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5838f7cd53ac..1994d5b42f94 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -578,7 +578,7 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	switch (ctrl->state) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_CONNECTING:
-		if (req->cmd->common.opcode == nvme_fabrics_command &&
+		if (nvme_is_fabrics(req->cmd) &&
 		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
 			return true;
 		break;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7734a6acff85..da2ea97042af 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -871,7 +871,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		status = nvmet_parse_connect_cmd(req);
 	else if (likely(req->sq->qid != 0))
 		status = nvmet_parse_io_cmd(req);
-	else if (req->cmd->common.opcode == nvme_fabrics_command)
+	else if (nvme_is_fabrics(req->cmd))
 		status = nvmet_parse_fabrics_cmd(req);
 	else if (req->sq->ctrl->subsys->type == NVME_NQN_DISC)
 		status = nvmet_parse_discovery_cmd(req);
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 3b9f79aba98f..d16b55ffe79f 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -268,7 +268,7 @@ u16 nvmet_parse_connect_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
 
-	if (cmd->common.opcode != nvme_fabrics_command) {
+	if (!nvme_is_fabrics(cmd)) {
 		pr_err("invalid command 0x%x on unconnected queue.\n",
 			cmd->fabrics.opcode);
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 508661af0f50..a59c5a013a5c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1806,7 +1806,7 @@ nvmet_fc_prep_fcp_rsp(struct nvmet_fc_tgtport *tgtport,
 	 */
 	rspcnt = atomic_inc_return(&fod->queue->zrspcnt);
 	if (!(rspcnt % fod->queue->ersp_ratio) ||
-	    sqe->opcode == nvme_fabrics_command ||
+	    nvme_is_fabrics((struct nvme_command *) sqe) ||
 	    xfr_length != fod->req.transfer_len ||
 	    (le16_to_cpu(cqe->status) & 0xFFFE) || cqewd[0] || cqewd[1] ||
 	    (sqe->flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND)) ||
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 8028adacaff3..7080923e78d1 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1165,6 +1165,11 @@ struct nvme_command {
 	};
 };
 
+static inline bool nvme_is_fabrics(struct nvme_command *cmd)
+{
+	return cmd->common.opcode == nvme_fabrics_command;
+}
+
 struct nvme_error_slot {
 	__le64		error_count;
 	__le16		sqid;
@@ -1186,7 +1191,7 @@ static inline bool nvme_is_write(struct nvme_command *cmd)
 	 *
 	 * Why can't we simply have a Fabrics In and Fabrics out command?
 	 */
-	if (unlikely(cmd->common.opcode == nvme_fabrics_command))
+	if (unlikely(nvme_is_fabrics(cmd)))
 		return cmd->fabrics.fctype & 1;
 	return cmd->common.opcode & 1;
 }
-- 
2.21.0
