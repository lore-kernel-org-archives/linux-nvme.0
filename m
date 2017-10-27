From: hare@suse.de (Hannes Reinecke)
Date: Fri, 27 Oct 2017 09:16:17 +0200
Subject: [PATCH] nvme-fc: Zero out SGL before submitting AEN
Message-ID: <1509088577-7342-1-git-send-email-hare@suse.de>

nvme_fc_start_fc_op() will be updating the SGL entries of the
sqe, so we need to zero those before resubmitting a received
AEN. Otherwise we trigger the WARN_ON() in nvme_fc_start_fc_op().

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b600c07..db0a7f6 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2181,6 +2181,7 @@ enum {
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(arg);
 	struct nvme_fc_fcp_op *aen_op;
+	struct nvme_command *sqe;
 	unsigned long flags;
 	bool terminating = false;
 	blk_status_t ret;
@@ -2197,6 +2198,8 @@ enum {
 		return;
 
 	aen_op = &ctrl->aen_ops[aer_idx];
+	sqe = &aen_op->cmd_iu.sqe;
+	memset(&sqe->common.dptr, 0, sizeof(union nvme_data_ptr));
 
 	ret = nvme_fc_start_fcp_op(ctrl, aen_op->queue, aen_op, 0,
 					NVMEFC_FCP_NODATA);
-- 
1.8.5.6
