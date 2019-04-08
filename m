From: emilne@redhat.com (Ewan D. Milne)
Date: Mon, 08 Apr 2019 17:04:02 -0400
Subject: [PATCH] nvme-fc: correct csn initialization and increments on
 error
In-Reply-To: <20190408181519.14086-1-jsmart2021@gmail.com>
References: <20190408181519.14086-1-jsmart2021@gmail.com>
Message-ID: <64d15879674dbdbda2015d0982edba565eb64f04.camel@redhat.com>

On Mon, 2019-04-08@11:15 -0700, James Smart wrote:
> This patch fixes a long-standing bug that initialized the FC-NVME
> cmnd iu CSN value to 1. Early FC-NVME specs had the connection starting
> with CSN=1. By the time the spec reached approval, the language had
> changed to state a connection should start with CSN=0.  This patch
> corrects the initialization value for FC-NVME connections.
> 
> Additionally, in reviewing the transport, the CSN value is assigned to
> the new IU early in the start routine. It's possible that a later dma
> map request may fail, causing the command to never be sent to the
> controller.  Change the location of the assignment so that it is
> immediately prior to calling the lldd. Add a comment block to explain
> the impacts if the lldd were to additionally fail sending the command.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
>  drivers/nvme/host/fc.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index f3b9d91ba0df..1f30984b2d31 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1845,7 +1845,7 @@ nvme_fc_init_queue(struct nvme_fc_ctrl *ctrl, int idx)
>  	memset(queue, 0, sizeof(*queue));
>  	queue->ctrl = ctrl;
>  	queue->qnum = idx;
> -	atomic_set(&queue->csn, 1);
> +	atomic_set(&queue->csn, 0);
>  	queue->dev = ctrl->dev;
>  
>  	if (idx > 0)
> @@ -1887,7 +1887,7 @@ nvme_fc_free_queue(struct nvme_fc_queue *queue)
>  	 */
>  
>  	queue->connection_id = 0;
> -	atomic_set(&queue->csn, 1);
> +	atomic_set(&queue->csn, 0);
>  }
>  
>  static void
> @@ -2198,8 +2198,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>  
>  	/* format the FC-NVME CMD IU and fcp_req */
>  	cmdiu->connection_id = cpu_to_be64(queue->connection_id);
> -	csn = atomic_inc_return(&queue->csn);
> -	cmdiu->csn = cpu_to_be32(csn);
>  	cmdiu->data_len = cpu_to_be32(data_len);
>  	switch (io_dir) {
>  	case NVMEFC_FCP_WRITE:
> @@ -2257,11 +2255,28 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>  	if (!(op->flags & FCOP_FLAGS_AEN))
>  		blk_mq_start_request(op->rq);
>  
> +	csn = atomic_inc_return(&queue->csn);
> +	cmdiu->csn = cpu_to_be32(csn);
> +
>  	ret = ctrl->lport->ops->fcp_io(&ctrl->lport->localport,
>  					&ctrl->rport->remoteport,
>  					queue->lldd_handle, &op->fcp_req);
>  
>  	if (ret) {
> +		/*
> +		 * If the lld fails to send the command is there an issue
> +		 * with the csn value ?  If the command that fails is the
> +		 * Connect, no - as the connection won't be live. If it's
> +		 * a command post-connect, it's possible a gap in csn may
> +		 * be created. Does this matter? As linux initiators don't
> +		 * send fused commands, no. The gap would exist, but as
> +		 * there's nothing that depends on csn order to be delivered
> +		 * on the target side, it shouldn't hurt. It would be
> +		 * difficult for a target to even detect the csn gap as
> +		 * it has no idea when the cmd with the csn was supposed
> +		 * to arrive.
> +		 */
> +
>  		opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
>  		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
>  

Reviewed-by: Ewan D. Milne <emilne at redhat.com>
