From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Apr 2017 14:15:26 +0300
Subject: [PATCH 4/5] nvmet_fc: Rework target side abort handling
In-Reply-To: <20170324034321.8719-5-jsmart2021@gmail.com>
References: <20170324034321.8719-1-jsmart2021@gmail.com>
 <20170324034321.8719-5-jsmart2021@gmail.com>
Message-ID: <a38fcb8a-a304-e83e-27e1-dfd5374e5abe@grimberg.me>



On 24/03/17 06:43, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
>
> target transport:
> ----------------------
> There are cases when there is a need to abort in-progress target
> operations (writedata) so that controller termination or errors can
> clean up. That can't happen currently as the abort is another target
> op type, so it can't be used till the running one finishes (and it may
> not).  Solve by removing the abort op type and creating a separate
> downcall from the transport to the lldd to request an io to be aborted.
>
> The transport will abort ios on queue teardown or io errors. In general
> the transport tries to call the lldd abort only when the io state is
> idle. Meaning: ops that transmit data (readdata or rsp) will always
> finish their transmit (or the lldd will see a state on the
> link or initiator port that fails the transmit) and the done call for
> the operation will occur. The transport will wait for the op done
> upcall before calling the abort function, and as the io is idle, the
> io can be cleaned up immediately after the abort call; Similarly, ios
> that are not waiting for data or transmitting data must be in the nvmet
> layer being processed. The transport will wait for the nvmet layer
> completion before calling the abort function, and as the io is idle,
> the io can be cleaned up immediately after the abort call; As for ops
> that are waiting for data (writedata), they may be outstanding
> indefinitely if the lldd doesn't see a condition where the initiatior
> port or link is bad. In those cases, the transport will call the abort
> function and wait for the lldd's op done upcall for the operation, where
> it will then clean up the io.
>
> Additionally, if a lldd receives an ABTS and matches it to an outstanding
> request in the transport, A new new transport upcall was created to abort
> the outstanding request in the transport. The transport expects any
> outstanding op call (readdata or writedata) will completed by the lldd and
> the operation upcall made. The transport doesn't act on the reported
> abort (e.g. clean up the io) until an op done upcall occurs, a new op is
> attempted, or the nvmet layer completes the io processing.
>
> fcloop:
> ----------------------
> Updated to support the new target apis.
> On fcp io aborts from the initiator, the loopback context is updated to
> NULL out the half that has completed. The initiator side is immediately
> called after the abort request with an io completion (abort status).
> On fcp io aborts from the target, the io is stopped and the initiator side
> sees it as an aborted io. Target side ops, perhaps in progress while the
> initiator side is done, continue but noop the data movement as there's no
> structure on the initiator side to reference.
>
> patch also contains:
> ----------------------
> Revised lpfc to support the new abort api
>
> commonized rsp buffer syncing and nulling of private data based on
> calling paths.

Would have been better to split this.

>  static void
> +nvmet_fc_abort_op(struct nvmet_fc_tgtport *tgtport,
> +				struct nvmet_fc_fcp_iod *fod)
> +{
> +	struct nvmefc_tgt_fcp_req *fcpreq = fod->fcpreq;
> +
> +	/* data no longer needed */
> +	nvmet_fc_free_tgt_pgs(fod);
> +
> +	/*
> +	 * if an ABTS was received or we issued the fcp_abort early
> +	 * don't call abort routine again.
> +	 */
> +	/* no need to take lock - lock was taken earlier to get here */

locking semantics is better documented at the function signature and/or
foo_locked() naming. Just a suggestion though.

> +	if (!fod->aborted)
> +		tgtport->ops->fcp_abort(&tgtport->fc_target_port, fcpreq);
> +
> +	nvmet_fc_free_fcp_iod(fod->queue, fod);
> +}
> +
> +static void
>  nvmet_fc_xmt_fcp_rsp(struct nvmet_fc_tgtport *tgtport,
>  				struct nvmet_fc_fcp_iod *fod)
>  {
> @@ -1730,7 +1757,7 @@ nvmet_fc_xmt_fcp_rsp(struct nvmet_fc_tgtport *tgtport,
>
>  	ret = tgtport->ops->fcp_op(&tgtport->fc_target_port, fod->fcpreq);
>  	if (ret)
> -		nvmet_fc_abort_op(tgtport, fod->fcpreq);
> +		nvmet_fc_abort_op(tgtport, fod);
>  }
>
>  static void
> @@ -1739,6 +1766,7 @@ nvmet_fc_transfer_fcp_data(struct nvmet_fc_tgtport *tgtport,
>  {
>  	struct nvmefc_tgt_fcp_req *fcpreq = fod->fcpreq;
>  	struct scatterlist *sg, *datasg;
> +	unsigned long flags;
>  	u32 tlen, sg_off;
>  	int ret;
>
> @@ -1803,10 +1831,13 @@ nvmet_fc_transfer_fcp_data(struct nvmet_fc_tgtport *tgtport,
>  		 */
>  		fod->abort = true;
>
> -		if (op == NVMET_FCOP_WRITEDATA)
> +		if (op == NVMET_FCOP_WRITEDATA) {
> +			spin_lock_irqsave(&fod->flock, flags);
> +			fod->writedataactive = false;
> +			spin_unlock_irqrestore(&fod->flock, flags);

Can wda be true with abort? or can this be converted to a state machine
which is easier to follow and less error prone?

>  			nvmet_req_complete(&fod->req,
>  					NVME_SC_FC_TRANSPORT_ERROR);
> -		else /* NVMET_FCOP_READDATA or NVMET_FCOP_READDATA_RSP */ {
> +		} else /* NVMET_FCOP_READDATA or NVMET_FCOP_READDATA_RSP */ {
>  			fcpreq->fcp_error = ret;
>  			fcpreq->transferred_length = 0;
>  			nvmet_fc_xmt_fcp_op_done(fod->fcpreq);
> @@ -1814,6 +1845,27 @@ nvmet_fc_transfer_fcp_data(struct nvmet_fc_tgtport *tgtport,
>  	}
>  }
>
> +static inline bool
> +__nvmet_fc_fod_op_abort(struct nvmet_fc_fcp_iod *fod, bool abort)
> +{
> +	struct nvmefc_tgt_fcp_req *fcpreq = fod->fcpreq;
> +	struct nvmet_fc_tgtport *tgtport = fod->tgtport;
> +
> +	/* if in the middle of an io and we need to tear down */
> +	if (abort) {
> +		if (fcpreq->op == NVMET_FCOP_WRITEDATA) {
> +			nvmet_req_complete(&fod->req,
> +					NVME_SC_FC_TRANSPORT_ERROR);
> +			return true;
> +		}
> +
> +		nvmet_fc_abort_op(tgtport, fod);
> +		return true;
> +	}
> +
> +	return false;
> +}

Why is this receiving an abort flag?

> +
>  /*
>   * actual done handler for FCP operations when completed by the lldd
>   */
> @@ -1827,22 +1879,20 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
>
>  	spin_lock_irqsave(&fod->flock, flags);
>  	abort = fod->abort;
> +	fod->writedataactive = false;
>  	spin_unlock_irqrestore(&fod->flock, flags);
>
> -	/* if in the middle of an io and we need to tear down */
> -	if (abort && fcpreq->op != NVMET_FCOP_ABORT) {
> -		/* data no longer needed */
> -		nvmet_fc_free_tgt_pgs(fod);
> -
> -		nvmet_req_complete(&fod->req, fcpreq->fcp_error);
> -		return;
> -	}
> -
>  	switch (fcpreq->op) {
>
>  	case NVMET_FCOP_WRITEDATA:
> +		if (__nvmet_fc_fod_op_abort(fod, abort))
> +			return;
>  		if (fcpreq->fcp_error ||
>  		    fcpreq->transferred_length != fcpreq->transfer_length) {
> +			spin_lock(&fod->flock);
> +			fod->abort = true;
> +			spin_unlock(&fod->flock);
> +
>  			nvmet_req_complete(&fod->req,
>  					NVME_SC_FC_TRANSPORT_ERROR);
>  			return;
> @@ -1850,6 +1900,10 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
>
>  		fod->offset += fcpreq->transferred_length;
>  		if (fod->offset != fod->total_length) {
> +			spin_lock_irqsave(&fod->flock, flags);
> +			fod->writedataactive = true;
> +			spin_unlock_irqrestore(&fod->flock, flags);
> +
>  			/* transfer the next chunk */
>  			nvmet_fc_transfer_fcp_data(tgtport, fod,
>  						NVMET_FCOP_WRITEDATA);
> @@ -1864,12 +1918,11 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
>
>  	case NVMET_FCOP_READDATA:
>  	case NVMET_FCOP_READDATA_RSP:
> +		if (__nvmet_fc_fod_op_abort(fod, abort))
> +			return;
>  		if (fcpreq->fcp_error ||
>  		    fcpreq->transferred_length != fcpreq->transfer_length) {
> -			/* data no longer needed */
> -			nvmet_fc_free_tgt_pgs(fod);
> -
> -			nvmet_fc_abort_op(tgtport, fod->fcpreq);
> +			nvmet_fc_abort_op(tgtport, fod);
>  			return;
>  		}
>
> @@ -1878,8 +1931,6 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
>  		if (fcpreq->op == NVMET_FCOP_READDATA_RSP) {
>  			/* data no longer needed */
>  			nvmet_fc_free_tgt_pgs(fod);
> -			fc_dma_sync_single_for_cpu(tgtport->dev, fod->rspdma,
> -					sizeof(fod->rspiubuf), DMA_TO_DEVICE);
>  			nvmet_fc_free_fcp_iod(fod->queue, fod);
>  			return;
>  		}
> @@ -1902,15 +1953,12 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
>  		break;
>
>  	case NVMET_FCOP_RSP:
> -	case NVMET_FCOP_ABORT:
> -		fc_dma_sync_single_for_cpu(tgtport->dev, fod->rspdma,
> -				sizeof(fod->rspiubuf), DMA_TO_DEVICE);
> +		if (__nvmet_fc_fod_op_abort(fod, abort))
> +			return;
>  		nvmet_fc_free_fcp_iod(fod->queue, fod);
>  		break;
>
>  	default:
> -		nvmet_fc_free_tgt_pgs(fod);
> -		nvmet_fc_abort_op(tgtport, fod->fcpreq);
>  		break;
>  	}
>  }
> @@ -1958,10 +2006,7 @@ __nvmet_fc_fcp_nvme_cmd_done(struct nvmet_fc_tgtport *tgtport,
>  		fod->queue->sqhd = cqe->sq_head;
>
>  	if (abort) {
> -		/* data no longer needed */
> -		nvmet_fc_free_tgt_pgs(fod);
> -
> -		nvmet_fc_abort_op(tgtport, fod->fcpreq);
> +		nvmet_fc_abort_op(tgtport, fod);
>  		return;
>  	}
>
> @@ -2057,8 +2102,8 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
>  				&fod->queue->nvme_cq,
>  				&fod->queue->nvme_sq,
>  				&nvmet_fc_tgt_fcp_ops);
> -	if (!ret) {	/* bad SQE content */
> -		nvmet_fc_abort_op(tgtport, fod->fcpreq);
> +	if (!ret) {	/* bad SQE content or invalid ctrl state */
> +		nvmet_fc_abort_op(tgtport, fod);
>  		return;
>  	}
>
> @@ -2098,7 +2143,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
>  	return;
>
>  transport_error:
> -	nvmet_fc_abort_op(tgtport, fod->fcpreq);
> +	nvmet_fc_abort_op(tgtport, fod);
>  }
>
>  /*
> @@ -2151,7 +2196,6 @@ nvmet_fc_rcv_fcp_req(struct nvmet_fc_target_port *target_port,
>  			(be16_to_cpu(cmdiu->iu_len) != (sizeof(*cmdiu)/4)))
>  		return -EIO;
>
> -
>  	queue = nvmet_fc_find_target_queue(tgtport,
>  				be64_to_cpu(cmdiu->connection_id));
>  	if (!queue)
> @@ -2190,6 +2234,59 @@ nvmet_fc_rcv_fcp_req(struct nvmet_fc_target_port *target_port,
>  }
>  EXPORT_SYMBOL_GPL(nvmet_fc_rcv_fcp_req);
>
> +/**
> + * nvmet_fc_rcv_fcp_abort - transport entry point called by an LLDD
> + *                       upon the reception of an ABTS for a FCP command
> + *
> + * Notify the transport that an ABTS has been received for a FCP command
> + * that had been given to the transport via nvmet_fc_rcv_fcp_req(). The
> + * LLDD believes the command is still being worked on
> + * (template_ops->fcp_req_release() has not been called).
> + *
> + * The transport will wait for any outstanding work (an op to the LLDD,
> + * which the lldd should complete with error due to the ABTS; or the
> + * completion from the nvmet layer of the nvme command), then will
> + * stop processing and call the nvmet_fc_rcv_fcp_req() callback to
> + * return the i/o context to the LLDD.  The LLDD may send the BA_ACC
> + * to the ABTS either after return from this function (assuming any
> + * outstanding op work has been terminated) or upon the callback being
> + * called.
> + *
> + * @target_port: pointer to the (registered) target port the FCP CMD IU
> + *              was received on.
> + * @fcpreq:     pointer to the fcpreq request structure that corresponds
> + *              to the exchange that received the ABTS.
> + */

nit: kernel-doc-nano-HOWTO advise a slightly different style.
