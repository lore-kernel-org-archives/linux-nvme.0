From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 1 Oct 2017 01:47:00 -0700
Subject: [PATCH] nvme_fc: correct io timeout behavior
In-Reply-To: <20170927041317.6575-1-jsmart2021@gmail.com>
References: <20170927041317.6575-1-jsmart2021@gmail.com>
Message-ID: <20171001084700.GB878@infradead.org>

> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1374,7 +1374,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>  				sizeof(op->rsp_iu), DMA_FROM_DEVICE);
>  
>  	if (atomic_read(&op->state) == FCPOP_STATE_ABORTED)
> -		status = cpu_to_le16((NVME_SC_ABORT_REQ | NVME_SC_DNR) << 1);
> +		status = cpu_to_le16(NVME_SC_ABORT_REQ << 1);

So the DNR bit goes away, ok.

> @@ -1445,15 +1445,22 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>  		goto check_error;
>  	}
>  
> +	if (unlikely(!status && op->flags & FCOP_FLAGS_TERMIO))
> +		status = cpu_to_le16(NVME_SC_ABORT_REQ << 1);

We grow another aborted case.  And btw, we really should not use
NVME_SC_ABORT_REQ here because the command never reched the controller
to actually get a nvme abort.  We might have to live with this for
now, but can you please review might addition of new status codes
for these host-internal cases in the latest ANA draft?

> +	/*
> +	 * Force failures of commands if we're killing the controller
> +	 * or have an error on a command used to create an new association
> +	 */
> +	if (status && (blk_queue_dying(rq->q) ||
> +			ctrl->ctrl.state == NVME_CTRL_NEW ||
> +			ctrl->ctrl.state == NVME_CTRL_RECONNECTING))
> +		status |= cpu_to_le16(NVME_SC_DNR << 1);

And here we add back the dnr bit based on a few conditions.
As a nitpick I think the way the conditionals are nested isn't very
readable, can we split the first line up, please?

	 if (status &&
	     (blk_queue_dying(rq->q) ||
	      ctrl->ctrl.state == NVME_CTRL_NEW ||
	      ctrl->ctrl.state == NVME_CTRL_RECONNECTING))
		status |= cpu_to_le16(NVME_SC_DNR << 1);

>  	complete_rq = __nvme_fc_fcpop_chk_teardowns(ctrl, op);
> +	if (!complete_rq)
>  		nvme_end_request(rq, status, result);
> +	else
>  		__nvme_fc_final_op_cleanup(rq);

avoid the unneeded invert and local variable:

	if (unlikely(__nvme_fc_fcpop_chk_teardowns(ctrl, op)))
		__nvme_fc_final_op_cleanup(rq);
	else
		nvme_end_request(rq, status, result);

and while we're at it: the AEN special case above assigns complete_rq,
but that value will never be read, so the complete_rq can be removed
entirely.

Can you split the reset handler bits into a separate patch with
a separate explanation?
