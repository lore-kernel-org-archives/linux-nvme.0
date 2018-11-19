From: james.smart@broadcom.com (James Smart)
Date: Mon, 19 Nov 2018 15:28:49 -0800
Subject: [PATCH v4 2/5] qla2xxx_nvmet: Add files for FC-NVMe Target support
In-Reply-To: <20181031164059.6286-3-himanshu.madhani@cavium.com>
References: <20181031164059.6286-1-himanshu.madhani@cavium.com>
 <20181031164059.6286-3-himanshu.madhani@cavium.com>
Message-ID: <632ecde6-3c56-90fe-38db-ed2f9959fdfd@broadcom.com>

a couple more comments

On 10/31/2018 9:40 AM, Himanshu Madhani wrote:
> +/*
> + * qla_nvmet_handle_abts
> + * Handle an abort from the initiator
> + * Invoke nvmet_fc_rcv_fcp_abort to pass the abts to the nvmet
> + */
> +int qla_nvmet_handle_abts(struct scsi_qla_host *vha,
> +	struct abts_recv_from_24xx *abts)
> +{
> +	uint16_t ox_id = cpu_to_be16(abts->fcp_hdr_le.ox_id);
> +	unsigned long flags;
> +	struct qla_nvmet_cmd *cmd = NULL;
> +
> +	if (!IS_ENABLED(CONFIG_NVME_TARGET_FC))
> +		return 0;
> +
> +	/* Retrieve the cmd from cmd list */
> +	spin_lock_irqsave(&vha->cmd_list_lock, flags);
> +	list_for_each_entry(cmd, &vha->qla_cmd_list, cmd_list) {
> +		if (cmd->ox_id == ox_id)
> +			break; /* Found the cmd */
> +	}
> +	spin_unlock_irqrestore(&vha->cmd_list_lock, flags);
> +	if (!cmd) {
> +		ql_log(ql_log_warn, vha, 0x1100b,
> +		    "%s-%d - Command not found\n", __func__, __LINE__);
> +		/* Send a RJT */
> +		qla_nvmet_send_abts_ctio(vha, abts, 0);
> +		return 0;
> +	}
> +
> +	nvmet_fc_rcv_fcp_abort(vha->targetport, &cmd->cmd.fcp_req);
> +	/* Send an ACC */
> +	qla_nvmet_send_abts_ctio(vha, abts, 1);
> +
> +	return 0;
> +}

The ACC shouldn't go back until the nvmet layer finishes the io through 
a call to req_release.? Things could still be changing on the back-end 
media in during the window and a new (retried io) to the same lba area 
could be problematic.

...

> +/*
> + * qla_nvmet_send_resp_ctio
> + * Send the response CTIO to the firmware
> + */
> +static void qla_nvmet_send_resp_ctio(struct qla_qpair *qpair,
> +	struct qla_nvmet_cmd *cmd, struct nvmefc_tgt_fcp_req *rsp_buf)
> +{
> ...
> +	case NVMET_FCOP_READDATA:
> +	case NVMET_FCOP_READDATA_RSP:
> +		/* Populate the CTIO resp with the SGL present in the rsp */
> +		ql_dbg(ql_dbg_nvme, vha, 0x1100c,
> +		    "op: %#x, ox_id=%x c_flags=%x transfer_length: %#x req_cnt: %#x, tot_dsds: %#x\n",
> +		    rsp_buf->op, ctio->ox_id, c_flags,
> +		    rsp_buf->transfer_length, req_cnt, tot_dsds);
> +
> +		avail_dsds = 1;
> +		cur_dsd = (uint32_t *)
> +				&ctio->u.nvme_status_mode0.dsd0[0];
> +		sgl = rsp_buf->sg;
> +
> +		/* Load data segments */
> +		for_each_sg(sgl, sg, tot_dsds, i) {
> +			dma_addr_t      sle_dma;
> +			cont_a64_entry_t *cont_pkt;
> +
> +			/* Allocate additional continuation packets? */
> +			if (avail_dsds == 0) {
> ...
> +			}
> +
> +			sle_dma = sg_dma_address(sg);
> +			*cur_dsd++ = cpu_to_le32(LSD(sle_dma));
> +			*cur_dsd++ = cpu_to_le32(MSD(sle_dma));

There was a recent patch to convert drivers from using their own 
upper/lower 32-bit addr masks and instead use the system version of it. 
I would assume that should apply to these' LSD/MSD references - both 
here and other places in the patch.

See
https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=4.21/scsi-queue&id=3d5ca1e6fdfeb4bc9d0b2eb4e35717198af03d78

-- james
