From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 20 Apr 2017 09:42:10 +0200
Subject: [PATCH-v1 15/22] Fix driver load issues when MRQ=8
In-Reply-To: <20170420044641.10657-16-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
 <20170420044641.10657-16-jsmart2021@gmail.com>
Message-ID: <20170420074210.GP6217@linux-x5ow.site>

On Wed, Apr 19, 2017@09:46:34PM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> The symptom is that the driver will fail to login to the fabric.
> The reason is because it is out of iocb resources.
> 
> There is a one to one relationship between MRQs
> (receive buffers for NVMET-FC) and iocbs and the default number of
> IOCBs was not accounting for the number of MRQs that were being created.
> 
> This fix aligns the number of MRQ resources with the total resources so
> that it can handle fabric events when needed.
> 
> Also the initialization of ctxlock to be on FCP commands, NOT LS commands.
> And modified log messages so that the log output can be correlated with
> the analyzer trace.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_init.c  | 12 ++++++++----
>  drivers/scsi/lpfc/lpfc_nvme.c  | 23 ++++++++++++-----------
>  drivers/scsi/lpfc/lpfc_nvmet.c |  6 +++---
>  3 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index cca7f81..88977b8 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -11061,7 +11061,7 @@ lpfc_pci_probe_one_s4(struct pci_dev *pdev, const struct pci_device_id *pid)
>  	struct lpfc_hba   *phba;
>  	struct lpfc_vport *vport = NULL;
>  	struct Scsi_Host  *shost = NULL;
> -	int error;
> +	int error, cnt;
>  	uint32_t cfg_mode, intr_mode;
>  
>  	/* Allocate memory for HBA structure */
> @@ -11095,11 +11095,15 @@ lpfc_pci_probe_one_s4(struct pci_dev *pdev, const struct pci_device_id *pid)
>  		goto out_unset_pci_mem_s4;
>  	}
>  
> +	cnt = phba->cfg_iocb_cnt * 1024;
> +	if (phba->nvmet_support)
> +		cnt += (phba->cfg_nvmet_mrq_post * phba->cfg_nvmet_mrq);

Souperflous parenthesis ^

Otherwise,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
