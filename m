From: james.smart@broadcom.com (James Smart)
Date: Mon, 19 Nov 2018 15:11:45 -0800
Subject: [PATCH v4 2/5] qla2xxx_nvmet: Add files for FC-NVMe Target support
In-Reply-To: <20181031164059.6286-3-himanshu.madhani@cavium.com>
References: <20181031164059.6286-1-himanshu.madhani@cavium.com>
 <20181031164059.6286-3-himanshu.madhani@cavium.com>
Message-ID: <f043452b-7d1c-8b28-3a9b-241a0d986fbc@broadcom.com>



On 10/31/2018 9:40 AM, Himanshu Madhani wrote:
> From: Anil Gurumurthy <anil.gurumurthy at cavium.com>
>
> This patch adds files to enable NVMe Target Support
>
> Signed-off-by: Anil Gurumurthy <anil.gurumurthy at cavium.com>
> Signed-off-by: Giridhar Malavali <giridhar.malavali at cavium.com>
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> ---
>   drivers/scsi/qla2xxx/qla_nvmet.c | 795 +++++++++++++++++++++++++++++++++++++++
>   drivers/scsi/qla2xxx/qla_nvmet.h | 129 +++++++
>   2 files changed, 924 insertions(+)
>   create mode 100644 drivers/scsi/qla2xxx/qla_nvmet.c
>   create mode 100644 drivers/scsi/qla2xxx/qla_nvmet.h
>
> diff --git a/drivers/scsi/qla2xxx/qla_nvmet.c b/drivers/scsi/qla2xxx/qla_nvmet.c
> new file mode 100644
> index 000000000000..caf72d5d627b
> --- /dev/null
> +++ b/drivers/scsi/qla2xxx/qla_nvmet.c
> @@ -0,0 +1,795 @@
> +/*
> + * QLogic Fibre Channel HBA Driver
> + * Copyright (c)  2003-2017 QLogic Corporation

Copyrights are out of date - general comment for the patches.

> + *
> + * See LICENSE.qla2xxx for copyright and licensing details.

Where does one find such a file ?? How does one know this is GPL ? same 
for other patches (and seems to apply to existing files).


> + */
> +static void
> +qla_nvmet_targetport_delete(struct nvmet_fc_target_port *targetport)
> +{
> +	struct qla_nvmet_tgtport *tport = targetport->private;
> +
> +	if (!IS_ENABLED(CONFIG_NVME_TARGET_FC))
> +		return;

little odd to check enablement this way - but ok....

>
> +/*
> + * qla_nvmet_ls_rsp -
> + * Invoked by the nvme-t to complete the LS req.
> + * Prepare and send a response CTIO to the firmware.
> + */
> +static int
> +qla_nvmet_ls_rsp(struct nvmet_fc_target_port *tgtport,
> +			struct nvmefc_tgt_ls_req *rsp)
> +{
> +	struct qla_nvmet_cmd *tgt_cmd =
> +		container_of(rsp, struct qla_nvmet_cmd, cmd.ls_req);
> +	struct scsi_qla_host *vha = tgt_cmd->vha;
> +	struct srb_iocb   *nvme;
> +	int     rval = QLA_FUNCTION_FAILED;
> +	srb_t *sp;
> +
> +	ql_dbg(ql_dbg_nvme + ql_dbg_buffer, vha, 0x11002,
> +		"Dumping the NVMET-LS response buffer\n");
> +	ql_dump_buffer(ql_dbg_nvme + ql_dbg_buffer, vha, 0x2075,
> +		(uint8_t *)rsp->rspbuf, rsp->rsplen);
> +
> +	/* Alloc SRB structure */
> +	sp = qla2x00_get_sp(vha, NULL, GFP_ATOMIC);

interesting you're doing atomic allocations in these places. I didn't 
think you were in interrupt context. same comment holds for other 
routines that may alloc.

> +/*
> + * qla_nvmet_fcp_op -
> + * Invoked by the nvme-t to complete the IO.
> + * Prepare and send a response CTIO to the firmware.
> + */
> +static int
> +qla_nvmet_fcp_op(struct nvmet_fc_target_port *tgtport,
> +			struct nvmefc_tgt_fcp_req *rsp)
> +{
> +	struct qla_nvmet_cmd *tgt_cmd =
> +		container_of(rsp, struct qla_nvmet_cmd, cmd.fcp_req);
> +	struct scsi_qla_host *vha = tgt_cmd->vha;
> +
> +	if (!IS_ENABLED(CONFIG_NVME_TARGET_FC))
> +		return 0;

I would think you would at least return a -EINVAL or something. I would 
think this code could never be executed as the registration would never 
occur as the enablement checks would stop it. So the check is 
meaningless. Kinda pointing out why the checks seem odd. Same comment 
holds for other places.

> +
> +	/* Prepare and send CTIO 82h */
> +	qla_nvmet_send_resp_ctio(vha->qpair, tgt_cmd, rsp);

I'm surprised this can't return an error....

 ?...
> +/*
> + * qla_nvmet_fcp_abort -
> + * Invoked by the nvme-t to abort an IO
> + * Send an abort to the firmware
> + */
> +static void
> +qla_nvmet_fcp_abort(struct nvmet_fc_target_port *tgtport,
> +			struct nvmefc_tgt_fcp_req *req)
> +{
> +	struct qla_nvmet_cmd *tgt_cmd =
> +		container_of(req, struct qla_nvmet_cmd, cmd.fcp_req);
> +	struct scsi_qla_host *vha = tgt_cmd->vha;
> +	struct qla_hw_data *ha = vha->hw;
> +	srb_t *sp;
> +
> +	if (!IS_ENABLED(CONFIG_NVME_TARGET_FC))
> +		return;
> +
> +	/* Alloc SRB structure */
> +	sp = qla2x00_get_sp(vha, NULL, GFP_KERNEL);
> +	if (!sp) {
> +		ql_log(ql_log_info, vha, 0x11005, "Failed to allocate SRB\n");
> +		return;

There is more that needs to be done on this failure.... somehow? you 
need to terminate the exchange on the wire/in the adapter. If there was 
an op outstanding, it needs to complete somehow (consider an io timeout 
because target isn't responding, yet is still present) for anything to 
free up and allow recovery.

> +	}
> +
> +	sp->type = SRB_NVMET_SEND_ABTS;
> +	sp->done = qla_nvmet_fcp_abort_done;
> +	sp->vha = vha;
> +	sp->fcport = tgt_cmd->fcport;
> +
> +	ha->isp_ops->abort_command(sp);
always successful ?


...
> +/*
> + * qla_nvmet_handle_ls -
> + * Handle a link service request from the initiator.
> + * Get the LS payload from the ATIO queue, invoke
> + * nvmet_fc_rcv_ls_req to pass the LS req to nvmet.
> + */
> +int qla_nvmet_handle_ls(struct scsi_qla_host *vha,
> +	struct pt_ls4_rx_unsol *pt_ls4, void *buf)
> +{
> +	...
> +
> +	ret = nvmet_fc_rcv_ls_req(vha->targetport,
> +		&tgt_cmd->cmd.ls_req, buf, size);
> +
> +	if (ret == 0) {
> +		ql_dbg(ql_dbg_nvme, vha, 0x11008,
> +		    "LS req handled successfully\n");
> +		return 0;
> +	}
> +
> +	ql_log(ql_log_warn, vha, 0x11009, "LS req failed\n");
Something should be here to abort/cleanup the exchange.. or is the port 
looking like it just dropped the frame on the floor?

> +
> +	return ret;
> +}
> +
> +/*
> + * qla_nvmet_process_cmd -
> + * Handle NVME cmd request from the initiator.
> + * Get the NVME payload from the ATIO queue, invoke
> + * nvmet_fc_rcv_ls_req to pass the LS req to nvmet.
> + * On a failure send an abts to the initiator?
> + */
> +int qla_nvmet_process_cmd(struct scsi_qla_host *vha,
> +	struct qla_nvmet_cmd *tgt_cmd)
> +{
> +	int ret;
> +	struct atio7_nvme_cmnd *nvme_cmd;
> +
> +	if (!IS_ENABLED(CONFIG_NVME_TARGET_FC))
> +		return 0;
> +
> +	nvme_cmd = (struct atio7_nvme_cmnd *)&tgt_cmd->nvme_cmd_iu;
> +
> +	ret = nvmet_fc_rcv_fcp_req(vha->targetport, &tgt_cmd->cmd.fcp_req,
> +			nvme_cmd, tgt_cmd->cmd_len);
> +	if (ret != 0) {
> +		ql_log(ql_log_warn, vha, 0x1100a,
> +			"%s-%d - Failed (ret: %#x) to process NVME command\n",
> +				__func__, __LINE__, ret);
> +		/* Send ABTS to initator ? */
yes, the exchange should be aborted and cleaned up with the initiator.

Note: lpfc has seen that command structures in the transport, allocated 
by queue size, some times were "overrun" - meaning, the xmt of the rsp 
went out, the initiator received it, and the initiator sent back a new 
command - such that the new command arrived before the driver had 
finished processed the rsp completion from it's hw and called nvmet to 
free up the job structure. Thus it looked like the host had sent too 
many cmds.? Thus the -EOVERFLOW and defer_rcv callback was put in so the 
transport could hold onto the cmd buffer longer than the call to 
rcv_fcp_req().

...

> +/*
> + * qla_nvmet_send_resp_ctio
> + * Send the response CTIO to the firmware
> + */
> +static void qla_nvmet_send_resp_ctio(struct qla_qpair *qpair,
> +	struct qla_nvmet_cmd *cmd, struct nvmefc_tgt_fcp_req *rsp_buf)
> +{
> +	struct atio_from_isp *atio = &cmd->atio;
> +	struct ctio_nvme_to_27xx *ctio;
> +	struct scsi_qla_host *vha = cmd->vha;
> +	struct qla_hw_data *ha = vha->hw;
> +	struct fcp_hdr *fchdr = &atio->u.nvme_isp27.fcp_hdr;
> +	srb_t *sp;
> +	unsigned long flags;
> +	uint16_t temp, c_flags = 0;
> +	struct req_que *req = vha->hw->req_q_map[0];
> +	uint32_t req_cnt = 1;
> +	uint32_t *cur_dsd;
> +	uint16_t avail_dsds;
> +	uint16_t tot_dsds, i, cnt;
> +	struct scatterlist *sgl, *sg;
> +
> +	spin_lock_irqsave(&ha->hardware_lock, flags);
> +
> +	/* Alloc SRB structure */
> +	sp = qla2x00_get_sp(vha, cmd->fcport, GFP_ATOMIC);
> +	if (!sp) {
> +		ql_log(ql_log_info, vha, 0x1100c, "Failed to allocate SRB\n");
> +		spin_unlock_irqrestore(&ha->hardware_lock, flags);
> +		return;
should return an error value - same comment for rest of routine. Same 
for qla_nvmet_send_abts_ctio()

> +	}
> +
> +	sp->type = SRB_NVMET_FCP;
> +	sp->name = "nvmet_fcp";
> +	sp->done = qla_nvmet_fcp_done;
> +	sp->u.iocb_cmd.u.nvme.desc = rsp_buf;
> +	sp->u.iocb_cmd.u.nvme.cmd = cmd;
> +
> +	ctio = (struct ctio_nvme_to_27xx *)qla2x00_alloc_iocbs(vha, sp);
> +	if (!ctio) {
> +		ql_dbg(ql_dbg_nvme, vha, 0x3067,
> +		    "qla2x00t(%ld): %s failed: unable to allocate request packet",
> +		    vha->host_no, __func__);
> +		spin_unlock_irqrestore(&ha->hardware_lock, flags);
> +		return;
> +	}
> +
> +	ctio->entry_type = CTIO_NVME;
> +	ctio->entry_count = 1;
> +	ctio->handle = sp->handle;
> +	ctio->nport_handle = cpu_to_le16(cmd->fcport->loop_id);
> +	ctio->timeout = cpu_to_le16(QLA_TGT_TIMEOUT);
is there a reason you're using your own timeout and not the 
rsp_buf->timeout value ??? I could see that if timeout was zero, but 
otherwise, I would think the transports timeout value should be honored.

...
> +		if (rsp_buf->op == NVMET_FCOP_READDATA_RSP) {
> +			if (rsp_buf->rsplen == 12) {
> +				ctio->flags |=
> +					NVMET_CTIO_STS_MODE0 |
> +					NVMET_CTIO_SEND_STATUS;
> +			} else if (rsp_buf->rsplen == 32) {
> +				struct nvme_fc_ersp_iu *ersp =
> +				    rsp_buf->rspaddr;
> +				uint32_t iter = 4, *inbuf, *outbuf;
> +
> +				ctio->flags |=
> +					NVMET_CTIO_STS_MODE1 |
> +					NVMET_CTIO_SEND_STATUS;
> +				inbuf = (uint32_t *)
> +					&((uint8_t *)rsp_buf->rspaddr)[16];
> +				outbuf = (uint32_t *)
> +				    ctio->u.nvme_status_mode1.nvme_comp_q_entry;
> +				for (; iter; iter--)
> +					*outbuf++ = cpu_to_be32(*inbuf++);
> +
> +				ctio->u.nvme_status_mode1.rsp_seq_num =
> +					cpu_to_be32(ersp->rsn);
> +				ctio->u.nvme_status_mode1.transfer_len =
> +					cpu_to_be32(ersp->xfrd_len);
> +			} else {
> +				ql_log(ql_log_warn, vha, 0x1100d,
> +				    "unhandled resp len = %x\n", rsp_buf->rsplen);
> +			}

there's a couple minor style issues on parens - using curly braces 
around a single statement in a block.

...
> +	union {
> +		struct {
> +			uint8_t reserved1[8];
> +			uint32_t relative_offset;
> +			uint8_t	reserved2[4];
> +			uint32_t transfer_len;
> +			uint8_t reserved3[4];
> +			uint32_t dsd0[2];
> +			uint32_t dsd0_len;
> +		} nvme_status_mode0;
> +		struct {
> +			uint8_t nvme_comp_q_entry[16];
> +			uint32_t transfer_len;
> +			uint32_t rsp_seq_num;
> +			uint32_t dsd0[2];
> +			uint32_t dsd0_len;
> +		} nvme_status_mode1;
> +		struct {
> +			uint32_t reserved4[4];
> +			uint32_t transfer_len;
> +			uint32_t reserved5;
> +			uint32_t rsp_dsd[2];
> +			uint32_t rsp_dsd_len;
> +		} nvme_status_mode2;

for reserved fields, it's typically desired to use 
"reserved<byteoffset>" rather than "reserved<#>". A couple more 
instances of this.

--james
