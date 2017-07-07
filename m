From: keith.busch@intel.com (Keith Busch)
Date: Fri,  7 Jul 2017 12:22:55 -0400
Subject: [PATCH 1/7] nvme/fc: There is only one AEN request
In-Reply-To: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
Message-ID: <1499444581-28268-2-git-send-email-keith.busch@intel.com>

This patch removes the multiple AEN request handling. There can be
only one.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/fc.c | 145 +++++++++++++++++++++----------------------------
 1 file changed, 61 insertions(+), 84 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d666ada..8355937 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -165,7 +165,7 @@ struct nvme_fc_ctrl {
 	u32			iocnt;
 	wait_queue_head_t	ioabort_wait;
 
-	struct nvme_fc_fcp_op	aen_ops[NVME_FC_NR_AEN_COMMANDS];
+	struct nvme_fc_fcp_op	aen_op;
 
 	struct nvme_ctrl	ctrl;
 };
@@ -1192,39 +1192,33 @@ __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
 }
 
 static void
-nvme_fc_abort_aen_ops(struct nvme_fc_ctrl *ctrl)
+nvme_fc_abort_aen_op(struct nvme_fc_ctrl *ctrl)
 {
-	struct nvme_fc_fcp_op *aen_op = ctrl->aen_ops;
 	unsigned long flags;
-	int i, ret;
 
-	for (i = 0; i < NVME_FC_NR_AEN_COMMANDS; i++, aen_op++) {
-		if (atomic_read(&aen_op->state) != FCPOP_STATE_ACTIVE)
-			continue;
+	if (atomic_read(&ctrl->aen_op.state) != FCPOP_STATE_ACTIVE)
+		return;
 
+	spin_lock_irqsave(&ctrl->lock, flags);
+	if (ctrl->flags & FCCTRL_TERMIO) {
+		ctrl->iocnt++;
+		ctrl->aen_op.flags |= FCOP_FLAGS_TERMIO;
+	}
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+
+	if (__nvme_fc_abort_op(ctrl, &ctrl->aen_op)) {
+		/*
+		 * if __nvme_fc_abort_op failed the io wasn't
+		 * active. Thus this call path is running in
+		 * parallel to the io complete. Treat as non-error.
+		 */
+
+		/* back out the flags/counters */
 		spin_lock_irqsave(&ctrl->lock, flags);
-		if (ctrl->flags & FCCTRL_TERMIO) {
-			ctrl->iocnt++;
-			aen_op->flags |= FCOP_FLAGS_TERMIO;
-		}
+		if (ctrl->flags & FCCTRL_TERMIO)
+			ctrl->iocnt--;
+		ctrl->aen_op.flags &= ~FCOP_FLAGS_TERMIO;
 		spin_unlock_irqrestore(&ctrl->lock, flags);
-
-		ret = __nvme_fc_abort_op(ctrl, aen_op);
-		if (ret) {
-			/*
-			 * if __nvme_fc_abort_op failed the io wasn't
-			 * active. Thus this call path is running in
-			 * parallel to the io complete. Treat as non-error.
-			 */
-
-			/* back out the flags/counters */
-			spin_lock_irqsave(&ctrl->lock, flags);
-			if (ctrl->flags & FCCTRL_TERMIO)
-				ctrl->iocnt--;
-			aen_op->flags &= ~FCOP_FLAGS_TERMIO;
-			spin_unlock_irqrestore(&ctrl->lock, flags);
-			return;
-		}
 	}
 }
 
@@ -1454,59 +1448,49 @@ nvme_fc_init_request(struct blk_mq_tag_set *set, struct request *rq,
 }
 
 static int
-nvme_fc_init_aen_ops(struct nvme_fc_ctrl *ctrl)
+nvme_fc_init_aen_op(struct nvme_fc_ctrl *ctrl)
 {
-	struct nvme_fc_fcp_op *aen_op;
 	struct nvme_fc_cmd_iu *cmdiu;
 	struct nvme_command *sqe;
 	void *private;
-	int i, ret;
-
-	aen_op = ctrl->aen_ops;
-	for (i = 0; i < NVME_FC_NR_AEN_COMMANDS; i++, aen_op++) {
-		private = kzalloc(ctrl->lport->ops->fcprqst_priv_sz,
-						GFP_KERNEL);
-		if (!private)
-			return -ENOMEM;
-
-		cmdiu = &aen_op->cmd_iu;
-		sqe = &cmdiu->sqe;
-		ret = __nvme_fc_init_request(ctrl, &ctrl->queues[0],
-				aen_op, (struct request *)NULL,
-				(AEN_CMDID_BASE + i));
-		if (ret) {
-			kfree(private);
-			return ret;
-		}
+	int ret;
 
-		aen_op->flags = FCOP_FLAGS_AEN;
-		aen_op->fcp_req.first_sgl = NULL; /* no sg list */
-		aen_op->fcp_req.private = private;
+	private = kzalloc(ctrl->lport->ops->fcprqst_priv_sz,
+					GFP_KERNEL);
+	if (!private)
+		return -ENOMEM;
 
-		memset(sqe, 0, sizeof(*sqe));
-		sqe->common.opcode = nvme_admin_async_event;
-		/* Note: core layer may overwrite the sqe.command_id value */
-		sqe->common.command_id = AEN_CMDID_BASE + i;
+	cmdiu = &ctrl->aen_op.cmd_iu;
+	sqe = &cmdiu->sqe;
+	ret = __nvme_fc_init_request(ctrl, &ctrl->queues[0],
+			&ctrl->aen_op, (struct request *)NULL,
+			AEN_CMDID_BASE);
+	if (ret) {
+		kfree(private);
+		return ret;
 	}
+
+	ctrl->aen_op.flags = FCOP_FLAGS_AEN;
+	ctrl->aen_op.fcp_req.first_sgl = NULL; /* no sg list */
+	ctrl->aen_op.fcp_req.private = private;
+
+	memset(sqe, 0, sizeof(*sqe));
+	sqe->common.opcode = nvme_admin_async_event;
+	sqe->common.command_id = AEN_CMDID_BASE;
+
 	return 0;
 }
 
 static void
-nvme_fc_term_aen_ops(struct nvme_fc_ctrl *ctrl)
+nvme_fc_term_aen_op(struct nvme_fc_ctrl *ctrl)
 {
-	struct nvme_fc_fcp_op *aen_op;
-	int i;
-
-	aen_op = ctrl->aen_ops;
-	for (i = 0; i < NVME_FC_NR_AEN_COMMANDS; i++, aen_op++) {
-		if (!aen_op->fcp_req.private)
-			continue;
+	if (!ctrl->aen_op.fcp_req.private)
+		return;
 
-		__nvme_fc_exit_request(ctrl, aen_op);
+	__nvme_fc_exit_request(ctrl, &ctrl->aen_op);
 
-		kfree(aen_op->fcp_req.private);
-		aen_op->fcp_req.private = NULL;
-	}
+	kfree(ctrl->aen_op.fcp_req.private);
+	ctrl->aen_op.fcp_req.private = NULL;
 }
 
 static inline void
@@ -2041,10 +2025,8 @@ static void
 nvme_fc_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(arg);
-	struct nvme_fc_fcp_op *aen_op;
 	unsigned long flags;
 	bool terminating = false;
-	blk_status_t ret;
 
 	if (aer_idx > NVME_FC_NR_AEN_COMMANDS)
 		return;
@@ -2056,14 +2038,9 @@ nvme_fc_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 
 	if (terminating)
 		return;
-
-	aen_op = &ctrl->aen_ops[aer_idx];
-
-	ret = nvme_fc_start_fcp_op(ctrl, aen_op->queue, aen_op, 0,
-					NVMEFC_FCP_NODATA);
-	if (ret)
-		dev_err(ctrl->ctrl.device,
-			"failed async event work [%d]\n", aer_idx);
+	if (nvme_fc_start_fcp_op(ctrl, &ctrl->queues[0], &ctrl->aen_op, 0,
+						NVMEFC_FCP_NODATA))
+		dev_err(ctrl->ctrl.device, "failed async event work\n");
 }
 
 static void
@@ -2376,9 +2353,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		opts->queue_size = ctrl->ctrl.maxcmd;
 	}
 
-	ret = nvme_fc_init_aen_ops(ctrl);
+	ret = nvme_fc_init_aen_op(ctrl);
 	if (ret)
-		goto out_term_aen_ops;
+		goto out_term_aen_op;
 
 	/*
 	 * Create the io queues
@@ -2390,7 +2367,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		else
 			ret = nvme_fc_reinit_io_queues(ctrl);
 		if (ret)
-			goto out_term_aen_ops;
+			goto out_term_aen_op;
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
@@ -2402,8 +2379,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 	return 0;	/* Success */
 
-out_term_aen_ops:
-	nvme_fc_term_aen_ops(ctrl);
+out_term_aen_op:
+	nvme_fc_term_aen_op(ctrl);
 out_disconnect_admin_queue:
 	/* send a Disconnect(association) LS to fc-nvme target */
 	nvme_fc_xmt_disconnect_assoc(ctrl);
@@ -2471,7 +2448,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 
 	/* kill the aens as they are a separate path */
-	nvme_fc_abort_aen_ops(ctrl);
+	nvme_fc_abort_aen_op(ctrl);
 
 	/* wait for all io that had to be aborted */
 	spin_lock_irqsave(&ctrl->lock, flags);
@@ -2479,7 +2456,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	ctrl->flags &= ~FCCTRL_TERMIO;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
-	nvme_fc_term_aen_ops(ctrl);
+	nvme_fc_term_aen_op(ctrl);
 
 	/*
 	 * send a Disconnect(association) LS to fc-nvme target
-- 
2.5.5
