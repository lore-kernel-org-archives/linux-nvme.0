From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 2 Aug 2017 10:32:20 +0200
Subject: [PATCH 2/2] lpfc: support nvmet_fc defer_rcv callback
In-Reply-To: <20170801221240.31723-3-jsmart2021@gmail.com>
References: <20170801221240.31723-1-jsmart2021@gmail.com>
 <20170801221240.31723-3-jsmart2021@gmail.com>
Message-ID: <20170802083220.GE4256@linux-x5ow.site>

On Tue, Aug 01, 2017@03:12:40PM -0700, James Smart wrote:
> This patch is intended to enter the kernel through the nvme block
> tree which pulls in the nvmet_fc api change at the same time. It is
> not to be merged via the scsi trees without the latest nvme support
> in it.

This should be placed below the '---' separator, so git won't pick it up and
preserve it in the history.

[...]

>  
>  		len += snprintf(buf+len, PAGE_SIZE-len,
> -				"FCP: Rcv %08x Release %08x Drop %08x\n",
> +				"FCP: Rcv %08x Defer %08x Release %08x "
> +				"Drop %08x\n",

Please don't split the string across lines, it makes grepping hard.
Checkpatch actually warns you about that.

>  				atomic_read(&tgtp->rcv_fcp_cmd_in),
> +				atomic_read(&tgtp->rcv_fcp_cmd_defer),
>  				atomic_read(&tgtp->xmt_fcp_release),
>  				atomic_read(&tgtp->rcv_fcp_cmd_drop));
>  
> diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
> index 5cc8b0f7d885..744f3f395b64 100644
> --- a/drivers/scsi/lpfc/lpfc_debugfs.c
> +++ b/drivers/scsi/lpfc/lpfc_debugfs.c
> @@ -782,8 +782,11 @@ lpfc_debugfs_nvmestat_data(struct lpfc_vport *vport, char *buf, int size)
>  				atomic_read(&tgtp->xmt_ls_rsp_error));
>  
>  		len += snprintf(buf + len, size - len,
> -				"FCP: Rcv %08x Drop %08x\n",
> +				"FCP: Rcv %08x Defer %08x Release %08x "
> +				"Drop %08x\n",
>  				atomic_read(&tgtp->rcv_fcp_cmd_in),
> +				atomic_read(&tgtp->rcv_fcp_cmd_defer),
> +				atomic_read(&tgtp->xmt_fcp_release),
>  				atomic_read(&tgtp->rcv_fcp_cmd_drop));

Ditto.


[...]

> +	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;

No need to cast from void *

[...]

> +	/* Processing of FCP command is deferred */
> +	if (rc == -EOVERFLOW) {
> +		lpfc_nvmeio_data(phba,
> +				 "NVMET RCV BUSY: xri x%x sz %d from %06x\n",
> +				 oxid, size, sid);
> +		/* defer reposting rcv buffer till .defer_rcv callback */
> +		ctxp->rqb_buffer = (void *)nvmebuf;

nvmebuf is a 'struct rqb_dmabuf *' and ctxp->rqb_buffer expects 'struct
rqb_dmabuf *', why do you need a void * cast here?


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
