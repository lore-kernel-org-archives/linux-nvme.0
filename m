From: james.smart@broadcom.com (James Smart)
Date: Mon, 19 Nov 2018 16:15:50 -0800
Subject: [PATCH v4 3/5] qla2xxx_nvmet: Add FC-NVMe Target handling
In-Reply-To: <20181031164059.6286-4-himanshu.madhani@cavium.com>
References: <20181031164059.6286-1-himanshu.madhani@cavium.com>
 <20181031164059.6286-4-himanshu.madhani@cavium.com>
Message-ID: <4fcc5b1f-7d75-2c98-0fd1-6481ed2da69f@broadcom.com>



On 10/31/2018 9:40 AM, Himanshu Madhani wrote:
> From: Anil Gurumurthy <anil.gurumurthy at cavium.com>
>
> This patch Adds following code in the driver to
> support FC-NVMe Target
>
> - Updated ql2xenablenvme to allow FC-NVMe Target operation
> - Added Link Service Request handling for NVMe Target
> - Added passthru IOCB for LS4 request
> - Added CTIO for sending response to FW
> - Added FC4 Registration for FC-NVMe Target
> - Added PUREX IOCB support for login processing in FC-NVMe Target mode
> - Added Continuation IOCB for PUREX
> - Added Session creation with PUREX IOCB in FC-NVMe Target mode
> - To enable FC-NVMe Target mode use ql2xnvmeenable=2 while loading driver
>
> Signed-off-by: Anil Gurumurthy <anil.gurumurthy at cavium.com>
> Signed-off-by: Giridhar Malavali <giridhar.malavali at cavium.com>
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> ---
>
>   /* Values for srb_ctx type */
>   #define SRB_LOGIN_CMD	1
>   #define SRB_LOGOUT_CMD	2
> @@ -518,6 +526,8 @@ struct srb_iocb {
>   #define SRB_NVME_ELS_RSP 24
>   #define SRB_NVMET_LS   25
>   #define SRB_NVMET_FCP  26
> +#define SRB_NVMET_ABTS	27
> +#define SRB_NVMET_SEND_ABTS	28
Given that patch2 wouldn't have compiled without these two SRB_NVMET_xxx 
definitions, I recommend moving this to the prior patch, as well as any 
other dependencies.

> diff --git a/drivers/scsi/qla2xxx/qla_fw.h b/drivers/scsi/qla2xxx/qla_fw.h
> index 50c1e6c62e31..67a42d153f64 100644
> --- a/drivers/scsi/qla2xxx/qla_fw.h
> +++ b/drivers/scsi/qla2xxx/qla_fw.h
> @@ -723,6 +723,269 @@ struct ct_entry_24xx {
>   	uint32_t dseg_1_len;		/* Data segment 1 length. */
>   };
>   
> +/* NVME-T changes */
> +/*
> + * Fibre Channel Header
> + * Little Endian format.  As received in PUREX and PURLS
> + */
> +struct __fc_hdr {
> +	uint16_t	did_lo;
> +	uint8_t		did_hi;
> +	uint8_t		r_ctl;
> +	uint16_t	sid_lo;
> +	uint8_t		sid_hi;
> +	uint8_t		cs_ctl;
> +	uint16_t	f_ctl_lo;
> +	uint8_t		f_ctl_hi;
> +	uint8_t		type;
> +	uint16_t	seq_cnt;
> +	uint8_t		df_ctl;
> +	uint8_t		seq_id;
> +	uint16_t	rx_id;
> +	uint16_t	ox_id;
> +	uint32_t	param;
> +};
> +
> +/*
> + * Fibre Channel LOGO acc
> + * In big endian format
> + */
> +struct __fc_logo_acc {
> +	uint8_t	op_code;
> +	uint8_t	reserved[3];
> +};
> +
> +struct __fc_lsrjt {
> +	uint8_t	op_code;
> +	uint8_t	reserved[3];
> +	uint8_t	reserved2;
> +	uint8_t	reason;
> +	uint8_t	exp;
> +	uint8_t	vendor;
> +};
> +
> +/*
> + * Fibre Channel LOGO Frame
> + * Little Endian format. As received in PUREX
> + */
> +struct __fc_logo {
> +	struct __fc_hdr	hdr;
> +	uint16_t	reserved;
> +	uint8_t		reserved1;
> +	uint8_t		op_code;
> +	uint16_t	sid_lo;
> +	uint8_t		sid_hi;
> +	uint8_t		reserved2;
> +	uint8_t		pname[8];
> +};
> +
> +/*
> + * Fibre Channel PRLI Frame
> + * Little Endian format. As received in PUREX
> + */
> +struct __fc_prli {
> +	struct  __fc_hdr	hdr;
> +	uint16_t		pyld_length;  /* word 0 of prli */
> +	uint8_t		page_length;
> +	uint8_t		op_code;
> +	uint16_t	common;/* word 1.  1st word of SP page */
> +	uint8_t		type_ext;
> +	uint8_t		prli_type;
> +#define PRLI_TYPE_FCP  0x8
> +#define PRLI_TYPE_NVME 0x28
> +	union {
> +		struct {
> +			uint32_t	reserved[2];
> +			uint32_t	sp_info;
> +		} fcp;
> +		struct {
> +			uint32_t	reserved[2];
> +			uint32_t	sp_info;
> +#define NVME_PRLI_DISC BIT_3
> +#define NVME_PRLI_TRGT BIT_4
> +#define NVME_PRLI_INIT BIT_5
> +#define NVME_PRLI_CONFIRMATION BIT_7
> +			uint32_t	reserved1;
> +		} nvme;
> +	};
> +};
> +
> +/*
> + * Fibre Channel PLOGI Frame
> + * Little Endian format.  As received in PUREX
> + */
> +struct __fc_plogi {
> +	uint16_t        did_lo;
> +	uint8_t         did_hi;
> +	uint8_t         r_ctl;
> +	uint16_t        sid_lo;
> +	uint8_t         sid_hi;
> +	uint8_t         cs_ctl;
> +	uint16_t        f_ctl_lo;
> +	uint8_t         f_ctl_hi;
> +	uint8_t         type;
> +	uint16_t        seq_cnt;
> +	uint8_t         df_ctl;
> +	uint8_t         seq_id;
> +	uint16_t        rx_id;
> +	uint16_t        ox_id;
> +	uint32_t        param;
> +	uint8_t         rsvd[3];
> +	uint8_t         op_code;
> +	uint32_t        cs_params[4]; /* common service params */
> +	uint8_t         pname[8];     /* port name */
> +	uint8_t         nname[8];     /* node name */
> +	uint32_t        class1[4];    /* class 1 service params */
> +	uint32_t        class2[4];    /* class 2 service params */
> +	uint32_t        class3[4];    /* class 3 service params */
> +	uint32_t        class4[4];
> +	uint32_t        vndr_vers[4];
> +};

Don't redefine all these standard structures.? For new code, use the 
definitions from include/uapi/scsi/fc

Same comment on prli's any anything else "standard".? If we need to add 
a nvme prli format to the headers, we can, and I'll get lpfc to follow 
suite.


> @@ -691,6 +693,10 @@ qla2x00_rff_id(scsi_qla_host_t *vha, u8 type)
>   		return (QLA_SUCCESS);
>   	}
>   
> +	/* only single mode for now */
> +	if ((vha->flags.nvmet_enabled) && (type == FC4_TYPE_FCP_SCSI))
> +		return (QLA_SUCCESS);
> +

minor style issue - too many unnecessary params.? should be "if 
(vha->flags.nvmet_enabled && type == FC4_TYPE_FCP_SCSI). may want to 
check for any more of this.

...

> +#define OPCODE_PLOGI_TMPLT 7
> +int
> +qla2x00_get_plogi_template(scsi_qla_host_t *vha, dma_addr_t buf,
> +	uint16_t length)
> +{
> +	mbx_cmd_t mc;
> +	mbx_cmd_t *mcp = &mc;
> +	int rval;
> +
> +	mcp->mb[0] = MBC_GET_RNID_PARAMS;
> +	mcp->mb[1] = OPCODE_PLOGI_TMPLT << 8;
> +	mcp->mb[2] = MSW(LSD(buf));
> +	mcp->mb[3] = LSW(LSD(buf));
> +	mcp->mb[6] = MSW(MSD(buf));
> +	mcp->mb[7] = LSW(MSD(buf));

same comment as on patch 2 - MSD/LSD vs common linux upper/lower routines.

> +/* NVMET */
> +static
> +void qla24xx_create_new_nvmet_sess(struct scsi_qla_host *vha,
> +	struct qla_work_evt *e)
> +{
> +	unsigned long flags;
> +	fc_port_t *fcport = NULL;
> +
> +	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
> +	fcport = qla2x00_find_fcport_by_wwpn(vha, e->u.new_sess.port_name, 1);
> +	if (fcport) {
> +		ql_log(ql_log_info, vha, 0x11020,
> +		    "Found fcport: %p for WWN: %8phC\n", fcport,
> +		    e->u.new_sess.port_name);
> +		fcport->d_id = e->u.new_sess.id;
> +
> +		/* Session existing with No loop_ID assigned */
> +		if (fcport->loop_id == FC_NO_LOOP_ID) {
> +			fcport->loop_id = qla2x00_find_new_loop_id(vha, fcport);
> +			ql_log(ql_log_info, vha, 0x11021,
> +			    "Allocated new loop_id: %#x for fcport: %p\n",
> +			    fcport->loop_id, fcport);
> +			fcport->fw_login_state = DSC_LS_PLOGI_PEND;
> +		}
> +	} else {
> +		fcport = qla2x00_alloc_fcport(vha, GFP_KERNEL);
> +		if (fcport) {
> +			fcport->d_id = e->u.new_sess.id;
> +			fcport->loop_id = qla2x00_find_new_loop_id(vha, fcport);
> +			ql_log(ql_log_info, vha, 0x11022,
> +			    "Allocated new loop_id: %#x for fcport: %p\n",
> +			    fcport->loop_id, fcport);
> +
> +			fcport->scan_state = QLA_FCPORT_FOUND;
> +			fcport->flags |= FCF_FABRIC_DEVICE;
> +			fcport->fw_login_state = DSC_LS_PLOGI_PEND;
> +
> +			memcpy(fcport->port_name, e->u.new_sess.port_name,
> +			    WWN_SIZE);
> +
> +			list_add_tail(&fcport->list, &vha->vp_fcports);
> +		}
this just returns without any kind of error notification ?

> +#define ELS_RJT 0x01
> +#define ELS_ACC 0x02

use the values in the standard headers: ELS_LS_RJT, ELS_LS_ACC.


> +
> +struct fc_port *qla_nvmet_find_sess_by_s_id(
> +	scsi_qla_host_t *vha,
> +	const uint32_t s_id)
> +{
> +	struct fc_port *sess = NULL, *other_sess;
> +	uint32_t other_sid;
> +
> +	list_for_each_entry(other_sess, &vha->vp_fcports, list) {
> +		other_sid = other_sess->d_id.b.domain << 16 |
> +				other_sess->d_id.b.area << 8 |
> +				other_sess->d_id.b.al_pa;
> +
> +		if (other_sid == s_id) {
> +			sess = other_sess;
> +			break;
> +		}
> +	}
> +	return sess;
> +}
> +
> +/* Send an ELS response */
> +int qlt_send_els_resp(srb_t *sp, struct __els_pt *els_pkt)
> +{
> +	struct purex_entry_24xx *purex = (struct purex_entry_24xx *)
> +					sp->u.snvme_els.ptr;
> +	dma_addr_t udma = sp->u.snvme_els.dma_addr;
> +	struct fc_port *fcport;
> +	port_id_t port_id;
> +	uint16_t loop_id;
> +
> +	port_id.b.domain = purex->s_id[2];
> +	port_id.b.area   = purex->s_id[1];
> +	port_id.b.al_pa  = purex->s_id[0];
> +	port_id.b.rsvd_1 = 0;
> +
> +	fcport = qla2x00_find_fcport_by_nportid(sp->vha, &port_id, 1);
> +	if (fcport)
> +		/* There is no session with the swt */
> +		loop_id = fcport->loop_id;
> +	else
> +		loop_id = 0xFFFF;
> +
> +	ql_log(ql_log_info, sp->vha, 0xfff9,
> +	    "sp: %p, purex: %p, udma: %pad, loop_id: 0x%x\n",
> +	    sp, purex, &udma, loop_id);
> +
> +	els_pkt->entry_type = ELS_IOCB_TYPE;
> +	els_pkt->entry_count = 1;
> +
> +	els_pkt->handle = sp->handle;
> +	els_pkt->nphdl = cpu_to_le16(loop_id);
> +	els_pkt->tx_dsd_cnt = cpu_to_le16(1);
> +	els_pkt->vp_index = purex->vp_idx;
> +	els_pkt->sof = EST_SOFI3;
> +	els_pkt->rcv_exchg_id = cpu_to_le32(purex->rx_xchg_addr);
> +	els_pkt->op_code = sp->cmd_type;
> +	els_pkt->did_lo = cpu_to_le16(purex->s_id[0] | (purex->s_id[1] << 8));
> +	els_pkt->did_hi = purex->s_id[2];
> +	els_pkt->sid_hi = purex->d_id[2];
> +	els_pkt->sid_lo = cpu_to_le16(purex->d_id[0] | (purex->d_id[1] << 8));
> +
> +	if (sp->gen2 == ELS_ACC)
> +		els_pkt->cntl_flags = cpu_to_le16(EPD_ELS_ACC);
> +	else
> +		els_pkt->cntl_flags = cpu_to_le16(EPD_ELS_RJT);
> +
> +	els_pkt->tx_bc = cpu_to_le32(sp->gen1);
> +	els_pkt->tx_dsd[0] = cpu_to_le32(LSD(udma));
> +	els_pkt->tx_dsd[1] = cpu_to_le32(MSD(udma));
> +	els_pkt->tx_dsd_len = cpu_to_le32(sp->gen1);
> +	/* Memory Barrier */
> +	wmb();
> +
> +	ql_log(ql_log_info, sp->vha, 0x11030, "Dumping PLOGI ELS\n");
> +	ql_dump_buffer(ql_dbg_disc + ql_dbg_buffer, sp->vha, 0xffff,
> +		(uint8_t *)els_pkt, sizeof(*els_pkt));
> +
> +	return 0;
> +}
> +
> +static void qlt_nvme_els_done(void *s, int res)
> +{
> +	struct srb *sp = s;
> +
> +	ql_log(ql_log_info, sp->vha, 0x11031,
> +	    "Done with NVME els command\n");
> +
> +	ql_log(ql_log_info, sp->vha, 0x11032,
> +	    "sp: %p vha: %p, dma_ptr: %p, dma_addr: %pad, len: %#x\n",
> +	    sp, sp->vha, sp->u.snvme_els.dma_ptr, &sp->u.snvme_els.dma_addr,
> +	    sp->gen1);
> +
> +	qla2x00_rel_sp(sp);
> +}
> +
> +static int qlt_send_plogi_resp(struct scsi_qla_host *vha, uint8_t op_code,
> +	struct purex_entry_24xx *purex, struct fc_port *fcport)
> +{
> +	int ret, rval, i;
> +	dma_addr_t plogi_ack_udma = vha->vha_tgt.qla_tgt->nvme_els_rsp;
> +	void *plogi_ack_buf = vha->vha_tgt.qla_tgt->nvme_els_ptr;
> +	uint8_t *tmp;
> +	uint32_t *opcode;
> +	srb_t *sp;
> +
> +	/* Alloc SRB structure */
> +	sp = qla2x00_get_sp(vha, fcport, GFP_KERNEL);
> +	if (!sp) {
> +		ql_log(ql_log_info, vha, 0x11033,
> +		    "Failed to allocate SRB\n");
> +		return -ENOMEM;
> +	}
> +
> +	sp->type = SRB_NVME_ELS_RSP;
> +	sp->done = qlt_nvme_els_done;
> +	sp->vha = vha;
> +
> +	ql_log(ql_log_info, vha, 0x11034,
> +	    "sp: %p, vha: %p, plogi_ack_buf: %p\n",
> +	    sp, vha, plogi_ack_buf);
> +
> +	sp->u.snvme_els.dma_addr = plogi_ack_udma;
> +	sp->u.snvme_els.dma_ptr = plogi_ack_buf;
> +	sp->gen1 = 116;
> +	sp->gen2 = ELS_ACC;
> +	sp->u.snvme_els.ptr = (struct purex_entry_24xx *)purex;
> +	sp->cmd_type = ELS_PLOGI;
> +
> +	tmp = (uint8_t *)plogi_ack_udma;
> +
> +	tmp += 4;	/* fw doesn't return 1st 4 bytes where opcode goes */
> +
> +	ret = qla2x00_get_plogi_template(vha, (dma_addr_t)tmp, (116/4 - 1));
> +	if (ret) {
> +		ql_log(ql_log_warn, vha, 0x11035,
> +		    "Failed to get plogi template\n");
> +		return -ENOMEM;
> +	}
> +
> +	opcode = (uint32_t *) plogi_ack_buf;
> +	*opcode = cpu_to_be32(ELS_ACC << 24);
> +
> +	for (i = 0; i < 0x1c; i++) {
> +		++opcode;
> +		*opcode = cpu_to_be32(*opcode);
> +	}
> +
> +	ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0xfff3,
> +	    "Dumping the PLOGI from fw\n");
> +	ql_dump_buffer(ql_dbg_disc + ql_dbg_verbose, vha, 0x70cf,
> +		(uint8_t *)plogi_ack_buf, 116);
> +
> +	rval = qla2x00_start_sp(sp);
> +	if (rval != QLA_SUCCESS)
> +		qla2x00_rel_sp(sp);
> +
> +	return 0;
> +}
> +
> +static struct qlt_purex_plogi_ack_t *
> +qlt_plogi_find_add(struct scsi_qla_host *vha, port_id_t *id,
> +		struct __fc_plogi *rcvd_plogi)
> +{
> +	struct qlt_purex_plogi_ack_t *pla;
> +
> +	list_for_each_entry(pla, &vha->plogi_ack_list, list) {
> +		if (pla->id.b24 == id->b24)
> +			return pla;
> +	}
> +
> +	pla = kmem_cache_zalloc(qla_tgt_purex_plogi_cachep, GFP_ATOMIC);
> +	if (!pla) {
> +		ql_dbg(ql_dbg_async, vha, 0x5088,
> +		       "qla_target(%d): Allocation of plogi_ack failed\n",
> +		       vha->vp_idx);
> +		return NULL;
> +	}
> +
> +	pla->id = *id;
> +	memcpy(&pla->rcvd_plogi, rcvd_plogi, sizeof(struct __fc_plogi));
> +	ql_log(ql_log_info, vha, 0xf101,
> +	    "New session(%p) created for port: %#x\n",
> +	    pla, pla->id.b24);
> +
> +	list_add_tail(&pla->list, &vha->plogi_ack_list);
> +
> +	return pla;
> +}
> +
> +static void __swap_wwn(uint8_t *ptr, uint32_t size)
> +{
> +	uint32_t *iptr = (uint32_t *)ptr;
> +	uint32_t *optr = (uint32_t *)ptr;
> +	uint32_t i = size >> 2;
> +
> +	for (; i ; i--)
> +		*optr++ = be32_to_cpu(*iptr++);
> +}

for the data elements you use beXX_to_cpu() or leXX_to_cpu() - you 
should be using data types of __beXX or __leXX, as I'm sure there's 
going to be some data checker to look for it.? example, uint32_t should 
be "__be32 *iptr;"

this comment can apply elsewhere in the patch as well.


> @@ -414,48 +1062,80 @@ static bool qlt_24xx_atio_pkt_all_vps(struct scsi_qla_host *vha,
>   	{
>   		struct abts_recv_from_24xx *entry =
>   			(struct abts_recv_from_24xx *)atio;
> -		struct scsi_qla_host *host = qlt_find_host_by_vp_idx(vha,
> -			entry->vp_index);
> -		unsigned long flags;
>   
> -		if (unlikely(!host)) {
> -			ql_dbg(ql_dbg_tgt, vha, 0xe00a,
> -			    "qla_target(%d): Response pkt (ABTS_RECV_24XX) "
> -			    "received, with unknown vp_index %d\n",
> -			    vha->vp_idx, entry->vp_index);
> +		if (unlikely(atio->u.nvme_isp27.fcnvme_hdr.scsi_fc_id ==
> +			NVMEFC_CMD_IU_SCSI_FC_ID)) {
> +			qla_nvmet_handle_abts(vha, entry);
> +			break;
> +		}
> +
> +		{
> +			struct abts_recv_from_24xx *entry =
> +				(struct abts_recv_from_24xx *)atio;
> +			struct scsi_qla_host *host = qlt_find_host_by_vp_idx
> +				(vha, entry->vp_index);
> +			unsigned long flags;

why were these moved into a subblock that then had the same data 
elements ? odd style.? Eliminate the new subblock parens.


> @@ -5660,6 +6349,101 @@ qlt_chk_qfull_thresh_hold(struct scsi_qla_host *vha, struct qla_qpair *qpair,
>   	return 1;
>   }
>   
> +/*
> + * Worker thread that dequeues the nvme cmd off the list and
> + * called nvme-t to process the cmd
> + */
> +static void qla_nvmet_work(struct work_struct *work)
> +{
> +	struct qla_nvmet_cmd *cmd =
> +		container_of(work, struct qla_nvmet_cmd, work);
> +	scsi_qla_host_t *vha = cmd->vha;
> +
> +	qla_nvmet_process_cmd(vha, cmd);
> +}
> +/*
> + * Handle the NVME cmd IU
> + */
> +static void qla_nvmet_handle_cmd(struct scsi_qla_host *vha,
> +		struct atio_from_isp *atio)
> +{
> +	struct qla_nvmet_cmd *tgt_cmd;
> +	unsigned long flags;
> +	struct qla_hw_data *ha = vha->hw;
> +	struct fc_port *fcport;
> +	struct fcp_hdr *fcp_hdr;
> +	uint32_t s_id = 0;
> +	void *next_pkt;
> +	uint8_t *nvmet_cmd_ptr;
> +	uint32_t nvmet_cmd_iulen = 0;
> +	uint32_t nvmet_cmd_iulen_min = 64;
> +
> +	/* Create an NVME cmd and queue it up to the work queue */
> +	tgt_cmd = kzalloc(sizeof(struct qla_nvmet_cmd), GFP_ATOMIC);
as in patch 2 - there's a lot of atomic allocations.
> +	if (tgt_cmd == NULL)
> +		return;

you don't do anything on error to clean up the exchange containing the cmd ?
same comment for other returns in routine.

> diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
> index 721da593b1bc..fcb4c9bb4fc1 100644
> --- a/drivers/scsi/qla2xxx/qla_target.h
> +++ b/drivers/scsi/qla2xxx/qla_target.h
> @@ -322,6 +322,67 @@ struct atio7_fcp_cmnd {
>   	/* uint32_t data_length; */
>   } __packed;
>   
> +struct fc_nvme_hdr {
> +	union {
> +		struct {
> +			uint8_t scsi_id;
> +#define NVMEFC_CMD_IU_SCSI_ID   0xfd
> +			uint8_t fc_id;
> +#define NVMEFC_CMD_IU_FC_ID     0x28
> +		};
> +		struct {
> +			uint16_t scsi_fc_id;
> +#define NVMEFC_CMD_IU_SCSI_FC_ID  0x28fd
> +		};
> +	};
> +	uint16_t iu_len;
> +	uint8_t rsv1[3];
> +	uint8_t flags;
> +#define NVMEFC_CMD_WRITE        0x1
> +#define NVMEFC_CMD_READ         0x2
> +	uint64_t conn_id;
> +	uint32_t        csn;
> +	uint32_t        dl;
> +} __packed;
> +
> +struct atio7_nvme_cmnd {
> +	struct fc_nvme_hdr fcnvme_hdr;
> +
> +	struct nvme_command nvme_cmd;
> +	uint32_t        rsv2[2];
> +} __packed;
> +

please use the definitions from include/linux/nvme-fc.h rather than 
redefining your own.

-- james
