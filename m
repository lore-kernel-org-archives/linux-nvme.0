From: aeasi@marvell.com (Arun Easi)
Date: Tue, 14 May 2019 12:04:14 -0700
Subject: [PATCH 6/7] lpfc: Add support for translating an RSCN rcv into
 a discovery rescan
In-Reply-To: <20190513224314.24169-7-jsmart2021@gmail.com>
References: <20190513224314.24169-1-jsmart2021@gmail.com>
 <20190513224314.24169-7-jsmart2021@gmail.com>
Message-ID: <alpine.LRH.2.21.9999.1905141202325.19585@mvluser05.qlc.com>

On Mon, 13 May 2019, 3:43pm, James Smart wrote:

> This patch updates RSCN receive processing to check for the remote
> port being an NVME port, and if so, invoke the nvme_fc callback to
> rescan the remote port.  The rescan will generate a discovery udev
> event.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
>  drivers/scsi/lpfc/lpfc_crtn.h |  2 ++
>  drivers/scsi/lpfc/lpfc_els.c  |  5 +++++
>  drivers/scsi/lpfc/lpfc_nvme.c | 44 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
> index 4b8eb9107b85..866374801140 100644
> --- a/drivers/scsi/lpfc/lpfc_crtn.h
> +++ b/drivers/scsi/lpfc/lpfc_crtn.h
> @@ -557,6 +557,8 @@ void lpfc_ras_stop_fwlog(struct lpfc_hba *phba);
>  int lpfc_check_fwlog_support(struct lpfc_hba *phba);
>  
>  /* NVME interfaces. */
> +void lpfc_nvme_rescan_port(struct lpfc_vport *vport,
> +			   struct lpfc_nodelist *ndlp);
>  void lpfc_nvme_unregister_port(struct lpfc_vport *vport,
>  			struct lpfc_nodelist *ndlp);
>  int lpfc_nvme_register_port(struct lpfc_vport *vport,
> diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
> index c9a40e05edcc..c8b305c1aafb 100644
> --- a/drivers/scsi/lpfc/lpfc_els.c
> +++ b/drivers/scsi/lpfc/lpfc_els.c
> @@ -6329,6 +6329,8 @@ lpfc_rscn_recovery_check(struct lpfc_vport *vport)
>  			continue;
>  		}
>  
> +		if (ndlp->nlp_fc4_type & NLP_FC4_NVME)
> +			lpfc_nvme_rescan_port(vport, ndlp);
>  
>  		lpfc_disc_state_machine(vport, ndlp, NULL,
>  					NLP_EVT_DEVICE_RECOVERY);
> @@ -6440,6 +6442,9 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>  				 "2024 pt2pt RSCN %08x Data: x%x x%x\n",
>  				 *lp, vport->fc_flag, payload_len);
>  		lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb, ndlp, NULL);
> +
> +		if (ndlp->nlp_fc4_type & NLP_FC4_NVME)
> +			lpfc_nvme_rescan_port(vport, ndlp);
>  		return 0;
>  	}
>  
> diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
> index 1aa00d2c3f74..6f179de44fc7 100644
> --- a/drivers/scsi/lpfc/lpfc_nvme.c
> +++ b/drivers/scsi/lpfc/lpfc_nvme.c
> @@ -2399,6 +2399,50 @@ lpfc_nvme_register_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
>  #endif
>  }
>  
> +/**
> + * lpfc_nvme_rescan_port - Check to see if we should rescan this remoteport
> + *
> + * If the ndlp represents an NVME Target, that we are logged into,
> + * ping the NVME FC Transport layer to initiate a device rescan
> + * on this remote NPort.
> + */
> +void
> +lpfc_nvme_rescan_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
> +{
> +#if (IS_ENABLED(CONFIG_NVME_FC))
> +	struct lpfc_nvme_rport *rport;
> +	struct nvme_fc_remote_port *remoteport;
> +
> +	rport = ndlp->nrport;
> +
> +	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
> +			 "6170 Rescan NPort DID x%06x type x%x "
> +			 "state x%x rport %p\n",
> +			 ndlp->nlp_DID, ndlp->nlp_type, ndlp->nlp_state, rport);
> +	if (!rport)
> +		goto input_err;
> +	remoteport = rport->remoteport;
> +	if (!remoteport)
> +		goto input_err;
> +
> +	/* Only rescan if we are an NVME target in the MAPPED state */
> +	if (remoteport->port_role & FC_PORT_ROLE_NVME_TARGET &&

Should not the check above be for a NVME_DISCOVERY role?

Regards,
-arun

> +	    ndlp->nlp_state == NLP_STE_MAPPED_NODE) {
> +		nvme_fc_rescan_remoteport(remoteport);
> +
> +		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC,
> +				 "6172 NVME rescanned DID x%06x "
> +				 "port_state x%x\n",
> +				 ndlp->nlp_DID, remoteport->port_state);
> +	}
> +	return;
> +input_err:
> +	lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC,
> +			 "6169 State error: lport %p, rport%p FCID x%06x\n",
> +			 vport->localport, ndlp->rport, ndlp->nlp_DID);
> +#endif
> +}
> +
>  /* lpfc_nvme_unregister_port - unbind the DID and port_role from this rport.
>   *
>   * There is no notion of Devloss or rport recovery from the current
> 
