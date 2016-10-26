From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 26 Oct 2016 12:09:13 -0700
Subject: [PATCH v3 6/7] nvme-fabrics: Add target support for FC transport
In-Reply-To: <580d0ffe.SFprDuHa1JbmKoHU%james.smart@broadcom.com>
References: <580d0ffe.SFprDuHa1JbmKoHU%james.smart@broadcom.com>
Message-ID: <1477508953.3009.97.camel@linux.intel.com>


> +static void
> +nvmet_fc_xmt_fcp_op_done(struct nvmefc_tgt_fcp_req *fcpreq)
> +{
> +	struct nvmet_fc_fcp_iod *fod = fcpreq->nvmet_fc_private;
> +	struct nvmet_fc_tgtport *tgtport = fod->tgtport;
> +	struct nvme_fc_ersp_iu *ersp = &fod->rspiubuf;
> +	struct nvme_completion *cqe = &ersp->cqe;
> +
> +	switch (fcpreq->op) {
> +
> +	case NVMET_FCOP_WRITEDATA:
> +		if (fcpreq->fcp_error) {
> +			nvmet_req_complete(&fod->req, fcpreq-
> >fcp_error);
> +			return;
> +		}
> +		if (fcpreq->transferred_length != fcpreq-
> >transfer_length) {
> +			nvmet_req_complete(&fod->req,
> +					NVME_SC_FC_TRANSPORT_ERROR);
> +			return;
> +		}
> +
> +		fod->offset += fcpreq->transferred_length;
> +		if (fod->offset != fod->total_length) {
> +			/* transfer the next chunk */
> +			nvmet_fc_transfer_fcp_data(tgtport, fod,
> +						NVMET_FCOP_WRITEDATA
> );
> +			return;
> +		}
> +
> +		/* data transfer complete, resume with nvmet layer
> */
> +
> +		fod->req.execute(&fod->req);
> +
> +		break;
> +
> +	case NVMET_FCOP_READDATA:
> +		if (fcpreq->fcp_error) {
> +			/* overwrite the nvmet status */
> +			cqe->status = cpu_to_le16(fcpreq-
> >fcp_error);
> +		} else if (fcpreq->transferred_length !=
> +					fcpreq->transfer_length) {
> +			/* overwrite the nvmet status */
> +			cqe->status =
> cpu_to_le16(NVME_SC_FC_TRANSPORT_ERROR);
> +		} else {
> +			fod->offset += fcpreq->transferred_length;
> +			if (fod->offset != fod->total_length) {
> +				/* transfer the next chunk */
> +				nvmet_fc_transfer_fcp_data(tgtport,
> fod,
> +							NVMET_FCOP_R
> EADDATA);
> +				return;
> +			}
> +		}
> +
> +		/* data transfer complete, send response */
> +
> +		/* data no longer needed */
> +		nvmet_fc_free_tgt_pgs(fod);
> +
> +		if (unlikely(atomic_read(&fod->aborted)))
> +			nvmet_fc_abort_op(tgtport, fod->fcpreq);
> +		else
> +			nvmet_fc_xmt_fcp_rsp(tgtport, fod);
> +
> +		break;
> +
> +	case NVMET_FCOP_READDATA_RSP:
> +		if (fcpreq->fcp_error) {
> +			/* overwrite the nvmet status */
> +			cqe->status = cpu_to_le16(fcpreq-
> >fcp_error);
> +		} else if (fcpreq->transferred_length !=
> +					fcpreq->transfer_length) {
> +			/* overwrite the nvmet status */
> +			cqe->status =
> cpu_to_le16(NVME_SC_FC_TRANSPORT_ERROR);
> +		} else
> +			fod->offset += fcpreq->transferred_length;
> +
> +		/* data transfer complete, response complete as well
> */
> +
> +		/* data no longer needed */
> +		nvmet_fc_free_tgt_pgs(fod);
> +
> +		dma_sync_single_for_cpu(tgtport->dev, fod->rspdma,
> +				sizeof(fod->rspiubuf),
> DMA_TO_DEVICE);
> +		nvmet_fc_free_fcp_iod(tgtport, fod);
> +		nvmet_fc_tgt_q_put(fod->queue);
> +		break;
> +
> +	case NVMET_FCOP_RSP:
> +	case NVMET_FCOP_ABORT:
> +		dma_sync_single_for_cpu(tgtport->dev, fod->rspdma,
> +				sizeof(fod->rspiubuf),
> DMA_TO_DEVICE);
> +		nvmet_fc_free_fcp_iod(tgtport, fod);
> +		nvmet_fc_tgt_q_put(fod->queue);
> +		break;
> +
> +	default:
> +		atomic_set(&fod->aborted, 1);
> +		nvmet_fc_abort_op(tgtport, fod->fcpreq);

My brain zeroed in on the *abort() functionality, which I don't quite
understand. ?Apologies for the basic question here but is this correct
that nvmet_fc_abort_op() is *NOT* called for the NVMET_FCOP_ABORT case
but nvmet_fc_abort_op() *IS* called for the default case?

Other than that it looks ok,

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
