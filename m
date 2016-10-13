From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 13 Oct 2016 02:51:24 -0700
Subject: [PATCH 5/7 v2] nvme-fabrics: Add host FC transport support
In-Reply-To: <432f5e3f-46bc-9309-3df8-a8dea043152c@broadcom.com>
References: <57f82b12.se5DjK6l/GWAoAxA%james.smart@broadcom.com>
 <20161012092411.GF12972@infradead.org>
 <432f5e3f-46bc-9309-3df8-a8dea043152c@broadcom.com>
Message-ID: <20161013095124.GB16162@infradead.org>

On Wed, Oct 12, 2016@12:54:02PM -0700, James Smart wrote:
> > > +enum nvme_fcctrl_state {
> > > +        FCCTRL_INIT             = 0,
> > > +	FCCTRL_ACTIVE           = 1,
> > > +	FCCTRL_DELETING         = 2,
> > > +	FCCTRL_DELETED          = 3,
> > > +};
> > Please integrate the FC controller state with the generic controller
> > state in core.c
> 
> I'm not sure about this. I believe there are things about the fc nvme ctlr
> struct, which has to wait on interactions from the FC LLDD before it cleans
> things up - that are not part of the nvme ctrl state.  Thus the distinction
> between DELETING (e.g. stopping, waiting for nvme to call us back after it's
> last put) vs DELETED (we've received NVME's callback, so can now act on our
> own ref counts).

I would much prefer to just have an additional state in the common
state machine, with comments on the specific, e.g.
NVME_CTRL_RECONNECTING is not used by PCIe.  That being said the state
machine could use some more documentation, I'll look into it.

> I've noticed RDMA and loop cut a lot of corners on teardown of commands, etc
> - as they are mostly memory references with very quick hw context teardown
> that isn't necessarily the case with FC where we have real hw contexts in
> the LLDD and perhaps line traffic. I would assume most of the references in
> the LLDD come back to the blk request thus nvme ctrl, so your assumption
> that they are close in state to each other should be true, but I need to
> review the paths again.

I'd be happy to get a review of the RDMA code in that respect.  Note
that PCIe shouldn't be all that different from FC in this respect.

> Well, its not specified in the api. It's up to the context of the LLD when
> it calls the nvmefc_fcp_req->done routine, which is nvme_fc_fcpio_done()
> routine, which you're looking at here. The routine does make the
> blk_mq_complete_request() call without changing context.  So whether it's
> true IRQ or not - depends on the driver and whether it calls from the real
> IRQ or from a DPC-like thread.  Any recommendations ?

But nvme_fc_fcpio_done doesn't actually use any locks, that's why
I'm wondering.  I think it's perfectly fine to call the fast path
completion handler from irq context, but I'd try to avoid dragging
irq safe locks into the rest of the code.

> FC-NVME uses existing hw definitions for FCP RSP's which allow a short all
> zeros's response frame to be passed on the wire for good completions (lots
> of specific rules in order to do so).  As such we don't have CQE content, so
> the transport has to create it (SQ ID, SQHD, Command Id, and status=0).  So
> we can't avoid this fudging. NVME fabrics group was well aware of this.

I'm fine with that concept.  I think you're doing way to much work in
the implementation, though..

Unless it's a REQ_TYPE_DRV_PRIV request, and rq->special points to the
CQE there is no point in faking up a CQE at all, as no one is going to
look at it ever. This is especially true for the fast path case you
mention above.  See the untested incremental patch at the end of the
mail on how I'd handle this.

> FC-NVME also has a requirement to deliver ERSP's in order so that SQHD goes
> base in "order". So it's goodness as that linux doesn't care as I can ignore
> this requirement. But, I will at least want a comment in the code to state
> why that functionality isn't present.

Sure, comments are always good..


diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 35ea164..67984572 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -974,7 +974,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	struct nvme_fc_ctrl *ctrl = op->ctrl;
 	struct nvme_fc_queue *queue = op->queue;
 	struct nvme_completion *cqe = &op->rsp_iu.cqe;
-	int status, llddstatus = freq->status;
+	int status;
 
 	dma_sync_single_for_cpu(ctrl->lport->dev, op->fcp_req.rspdma,
 				sizeof(op->rsp_iu), DMA_FROM_DEVICE);
@@ -983,73 +983,65 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	 * if we aborted the op, the routines that invoked the abort
 	 * set the desired status on the request (namely DNR bits as
 	 * well as NVME_SC_ABORT_REQ). Thus, use those values for
-	 * the llddstatus which gets put into cQEs.
+	 * the status which gets put into CQEs.
 	 */
 	if (atomic_read(&op->state) == FCPOP_STATE_ABORTED)
-		llddstatus = rq->errors;
-
-	/*
-	 * If successful and ERSP, use the returned CQE
-	 *
-	 * Otherwise, there isn't a CQE or it may not have valid content.
-	 * FC-NVME will need to fudge one up. We also need to fudge up
-	 * CQE's for LLDD/transport errors.
-	 */
-
-	/*
-	 * if length of the received response is 0 or 12 and llddstatus is 0,
-	 * then a successful response is assumed.  But, need to create a CQE.
-	 */
-	if (!llddstatus && (!freq->rcv_rsplen ||
-			  (freq->rcv_rsplen == NVME_FC_SIZEOF_ZEROS_RSP))) {
-
-		memset(cqe, 0, sizeof(*cqe));
-		cqe->sq_head = cpu_to_le16(queue->sqhd);
-		cqe->command_id = cpu_to_le16(op->rqno);
-		goto validation_done;
-	}
-
-	/* successful ersp */
-	if ((!llddstatus) &&
-			(freq->rcv_rsplen == sizeof(struct nvme_fc_ersp_iu))) {
-		/* validate it */
+		status = rq->errors;
+	else
+		status = freq->status;
+
+	if (status)
+		goto done;
+
+	switch (freq->rcv_rsplen) {
+	case 0:
+	case NVME_FC_SIZEOF_ZEROS_RSP:
+		/* fasth path for successful operations without result */
+		if (unlikely(rq->cmd_type == REQ_TYPE_DRV_PRIV &&
+				rq->special)) {
+			struct nvme_completion *cqe = rq->special;
+
+			memset(cqe, 0, sizeof(*cqe));
+			cqe->sq_head = cpu_to_le16(queue->sqhd);
+			cqe->command_id = cpu_to_le16(op->rqno);
+			cqe->status = cpu_to_le16(status << 1);
+		}
+		break;
+	case sizeof(struct nvme_fc_ersp_iu):
+		/* successful ersp */
 		if (unlikely(be16_to_cpu(op->rsp_iu.iu_len) !=
-				(freq->rcv_rsplen/4)))
-			llddstatus = NVME_SC_FC_FORMAT;
-		else if (unlikely(op->rqno != le16_to_cpu(cqe->command_id)))
-			llddstatus = NVME_SC_FC_CMDID_MISMATCH;
-		else {
-			/* passed validation, use the cqe */
-			/* TODO: fix sqhd - deal with out of order */
-			queue->sqhd = le16_to_cpu(cqe->sq_head);
-			queue->seqno = be32_to_cpu(op->rsp_iu.rsn);
-			goto validation_done;
+				freq->rcv_rsplen / 4)) {
+			status = -EIO;
+			goto done;
 		}
-		/* if error - will fall thru below */
 
-	/* if a bad length */
-	} else if (!llddstatus)
-		llddstatus = NVME_SC_FC_FORMAT;
+		if (unlikely(op->rqno != le16_to_cpu(cqe->command_id))) {
+			status = -EIO;
+			break;
+		}
 
-	/* we have validation errors or a lldd/transport error */
-	memset(cqe, 0, sizeof(*cqe));
-	cqe->sq_head = cpu_to_le16(queue->sqhd);
-	cqe->command_id = cpu_to_le16(op->rqno);
-	cqe->status = cpu_to_le16(llddstatus << 1);
+		/* passed validation, use the cqe */
+		/* TODO: fix sqhd - deal with out of order */
+		queue->sqhd = le16_to_cpu(cqe->sq_head);
+		queue->seqno = be32_to_cpu(op->rsp_iu.rsn);
+	
+		if (!queue->qnum && IS_AEN_COMMAND(cqe->command_id)) {
+			nvme_complete_async_event(&queue->ctrl->ctrl, cqe);
+			return;
+		}
 
-validation_done:
+		if (rq->cmd_type == REQ_TYPE_DRV_PRIV && rq->special)
+			memcpy(rq->special, cqe, sizeof(*cqe));
 
-	if (!queue->qnum && IS_AEN_COMMAND(cqe->command_id)) {
-		nvme_complete_async_event(&queue->ctrl->ctrl, cqe);
-		return;
+		status = le16_to_cpu(cqe->status) >> 1;
+		break;
+	default:
+		/* invalid size */
+		status = -EIO;
+		break;
 	}
 
-	status = le16_to_cpu(cqe->status);
-	status >>= 1;
-
-	if (rq->cmd_type == REQ_TYPE_DRV_PRIV && rq->special)
-		memcpy(rq->special, cqe, sizeof(*cqe));
-
+done:
 	blk_mq_complete_request(rq, status);
 }
 
