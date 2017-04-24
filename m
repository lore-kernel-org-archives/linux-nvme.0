From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 24 Apr 2017 00:14:26 -0700
Subject: [PATCH 2/3] nvme_fc: add aen abort to teardown
In-Reply-To: <20170423153008.22795-3-jsmart2021@gmail.com>
References: <20170423153008.22795-1-jsmart2021@gmail.com>
 <20170423153008.22795-3-jsmart2021@gmail.com>
Message-ID: <20170424071426.GB17381@infradead.org>

On Sun, Apr 23, 2017@08:30:07AM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> Add abort support for aens. Commonized the op abort to apply to aen or
> real ios (caused some reorg/routine movement). Abort path sets termination
> flag in prep for next patch that will be watching i/o abort completion
> before proceeding with controller teardown.
> 
> Now that we're aborting aens, the "exit" code that simply cleared out
> their context no longer applies.
> 
> Also clarified how we detect an AEN vs a normal io - by a flag, not
> by whether a rq exists or the a rqno is out of range.
> 
> Note: saw some interesting cases where if the queues are stopped and
> we're waiting for the aborts, the core layer can call the complete_rq
> callback for the io. So the io completion synchronizes link side completion
> with possible blk layer completion under error.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/fc.c | 191 +++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 139 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index cccade5..a2a9ce6 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -65,6 +65,7 @@ enum nvme_fcop_flags {
>  	FCOP_FLAGS_TERMIO	= (1 << 0),
>  	FCOP_FLAGS_RELEASED	= (1 << 1),
>  	FCOP_FLAGS_COMPLETE	= (1 << 2),
> +	FCOP_FLAGS_AEN		= (1 << 3),
>  };
>  
>  struct nvmefc_ls_req_op {
> @@ -86,6 +87,7 @@ enum nvme_fcpop_state {
>  	FCPOP_STATE_IDLE	= 1,
>  	FCPOP_STATE_ACTIVE	= 2,
>  	FCPOP_STATE_ABORTED	= 3,
> +	FCPOP_STATE_COMPLETE	= 4,
>  };
>  
>  struct nvme_fc_fcp_op {
> @@ -104,6 +106,7 @@ struct nvme_fc_fcp_op {
>  	struct request		*rq;
>  
>  	atomic_t		state;
> +	u32			flags;
>  	u32			rqno;
>  	u32			nents;
>  
> @@ -1132,6 +1135,7 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
>  
>  /* *********************** NVME Ctrl Routines **************************** */
>  
> +static void __nvme_fc_final_op_cleanup(struct request *rq);
>  
>  static int
>  nvme_fc_reinit_request(void *data, struct request *rq)
> @@ -1169,20 +1173,74 @@ nvme_fc_exit_request(void *data, struct request *rq,
>  	return __nvme_fc_exit_request(data, op);
>  }
>  
> +static int
> +__nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
> +{
> +	int state;
> +
> +	state = atomic_xchg(&op->state, FCPOP_STATE_ABORTED);
> +	if (state != FCPOP_STATE_ACTIVE) {
> +		atomic_set(&op->state, state);
> +		return -ECANCELED;
> +	}
> +
> +	ctrl->lport->ops->fcp_abort(&ctrl->lport->localport,
> +					&ctrl->rport->remoteport,
> +					op->queue->lldd_handle,
> +					&op->fcp_req);
> +
> +	return 0;
> +}
> +
>  static void
> -nvme_fc_exit_aen_ops(struct nvme_fc_ctrl *ctrl)
> +nvme_fc_abort_aen_ops(struct nvme_fc_ctrl *ctrl)
>  {
>  	struct nvme_fc_fcp_op *aen_op = ctrl->aen_ops;
> -	int i;
> +	unsigned long flags;
> +	int i, ret;
>  
>  	for (i = 0; i < NVME_FC_NR_AEN_COMMANDS; i++, aen_op++) {
> -		if (atomic_read(&aen_op->state) == FCPOP_STATE_UNINIT)
> +		if (atomic_read(&aen_op->state) != FCPOP_STATE_ACTIVE)
>  			continue;
> -		__nvme_fc_exit_request(ctrl, aen_op);
> -		nvme_fc_ctrl_put(ctrl);
> +
> +		spin_lock_irqsave(&ctrl->lock, flags);
> +		aen_op->flags |= FCOP_FLAGS_TERMIO;
> +		spin_unlock_irqrestore(&ctrl->lock, flags);
> +
> +		ret = __nvme_fc_abort_op(ctrl, aen_op);
> +		if (ret) {
> +			/*
> +			 * if __nvme_fc_abort_op failed the io wasn't
> +			 * active. Thus this call path is running in
> +			 * parallel to the io complete. Treat as non-error.
> +			 */
> +
> +			/* back out the flags/counters */
> +			spin_lock_irqsave(&ctrl->lock, flags);
> +			aen_op->flags &= ~FCOP_FLAGS_TERMIO;
> +			spin_unlock_irqrestore(&ctrl->lock, flags);
> +			return;
> +		}
>  	}
>  }
>  
> +static inline int
> +__nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
> +		struct nvme_fc_fcp_op *op)
> +{
> +	unsigned long flags;
> +	bool complete_rq = false;
> +
> +	spin_lock_irqsave(&ctrl->lock, flags);
> +	if (op->flags & FCOP_FLAGS_RELEASED)
> +		complete_rq = true;
> +	else
> +		op->flags |= FCOP_FLAGS_COMPLETE;
> +	spin_unlock_irqrestore(&ctrl->lock, flags);
> +
> +	return complete_rq;
> +}
> +
>  void
>  nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>  {
> @@ -1195,6 +1253,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>  	struct nvme_command *sqe = &op->cmd_iu.sqe;
>  	__le16 status = cpu_to_le16(NVME_SC_SUCCESS << 1);
>  	union nvme_result result;
> +	bool complete_rq;
>  
>  	/*
>  	 * WARNING:
> @@ -1289,13 +1348,25 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>  	}
>  
>  done:
> -	if (!queue->qnum && op->rqno >= AEN_CMDID_BASE) {
> +	if (op->flags & FCOP_FLAGS_AEN) {
>  		nvme_complete_async_event(&queue->ctrl->ctrl, status, &result);
> +		complete_rq = __nvme_fc_fcpop_chk_teardowns(ctrl, op);
> +		atomic_set(&op->state, FCPOP_STATE_IDLE);
> +		op->flags = FCOP_FLAGS_AEN;	/* clear other flags */
>  		nvme_fc_ctrl_put(ctrl);
>  		return;
>  	}
>  
> -	nvme_end_request(rq, status, result);
> +	complete_rq = __nvme_fc_fcpop_chk_teardowns(ctrl, op);
> +	if (!complete_rq) {
> +		if (unlikely(op->flags & FCOP_FLAGS_TERMIO)) {
> +			status = NVME_SC_ABORT_REQ;
> +			if (blk_queue_dying(rq->q))
> +				status |= NVME_SC_DNR;

status is a little endian variable, and you're assigning host values
to it.  Please run sparse as that would have easily caught it.

I'll fix it up while applying the series.
