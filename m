From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 27 Apr 2017 13:40:05 -0600
Subject: [PATCH] lpfc: fix compile error when CONFIG_NVME_TARGET_FC not
 enabled
In-Reply-To: <20170427193547.21553-1-jsmart2021@gmail.com>
References: <20170427193547.21553-1-jsmart2021@gmail.com>
Message-ID: <45c01ad4-5241-bb9f-1d0a-7749ae6ca5d9@kernel.dk>

On 04/27/2017 01:35 PM, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> fix compile error when CONFIG_NVME_TARGET_FC not enabled
> 
> return statement needs to be outside of ifdef
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
> Patch to be pulled in via block trees
> 
> Patch cut against nvme-4.12 tree
> 
> 
>  drivers/scsi/lpfc/lpfc_nvmet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
> index 90527e7..4da99db 100644
> --- a/drivers/scsi/lpfc/lpfc_nvmet.c
> +++ b/drivers/scsi/lpfc/lpfc_nvmet.c
> @@ -958,8 +958,8 @@ lpfc_nvmet_rcv_unsol_abort(struct lpfc_vport *vport,
>  
>  	/* Respond with BA_RJT accordingly */
>  	lpfc_sli4_seq_abort_rsp(vport, fc_hdr, 0);
> -	return 0;
>  #endif
> +	return 0;
>  }
>  
>  void
> 

I fixed this up already when I merged it, it's in the merge commit with
the block for-4.12/post-merge tree.

-- 
Jens Axboe
