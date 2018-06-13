From: jsmart2021@gmail.com (James Smart)
Date: Wed, 13 Jun 2018 14:07:36 -0700
Subject: [PATCH v4 1/4] nvme_fc: remove reinit_request routine
In-Reply-To: <20180613210739.3383-1-jsmart2021@gmail.com>
References: <20180613210739.3383-1-jsmart2021@gmail.com>
Message-ID: <20180613210739.3383-2-jsmart2021@gmail.com>

The reinit_request routine is not necessary. Remove support for the
op callback.

As all that nvme_reinit_tagset() does is itterate and call the
reinit routine, it too has no purpose. Remove the call.

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>

---
A separate effort will look at other areas in nvme that may be
able to remove the reinit interface as well.
---
 drivers/nvme/host/fc.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 99bb4672eb3d..0936b69aced5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1470,21 +1470,6 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
 
 static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
 
-static int
-nvme_fc_reinit_request(void *data, struct request *rq)
-{
-	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
-	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
-
-	memset(cmdiu, 0, sizeof(*cmdiu));
-	cmdiu->scsi_id = NVME_CMD_SCSI_ID;
-	cmdiu->fc_id = NVME_CMD_FC_ID;
-	cmdiu->iu_len = cpu_to_be16(sizeof(*cmdiu) / sizeof(u32));
-	memset(&op->rsp_iu, 0, sizeof(op->rsp_iu));
-
-	return 0;
-}
-
 static void
 __nvme_fc_exit_request(struct nvme_fc_ctrl *ctrl,
 		struct nvme_fc_fcp_op *op)
@@ -2501,10 +2486,6 @@ nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
 
 	nvme_fc_init_io_queues(ctrl);
 
-	ret = nvme_reinit_tagset(&ctrl->ctrl, ctrl->ctrl.tagset);
-	if (ret)
-		goto out_free_io_queues;
-
 	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
 	if (ret)
 		goto out_free_io_queues;
@@ -2916,7 +2897,6 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.submit_async_event	= nvme_fc_submit_async_event,
 	.delete_ctrl		= nvme_fc_delete_ctrl,
 	.get_address		= nvmf_get_address,
-	.reinit_request		= nvme_fc_reinit_request,
 };
 
 static void
-- 
2.13.1
