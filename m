From: hare@suse.de (Hannes Reinecke)
Date: Wed, 18 Jan 2017 08:17:30 +0100
Subject: [PATCH 04/17] lpfc: NVME Initiator: Base modifications Part C
In-Reply-To: <587ec2ef.Y/y2qvlPHm64sAst%jsmart2021@gmail.com>
References: <587ec2ef.Y/y2qvlPHm64sAst%jsmart2021@gmail.com>
Message-ID: <0d7410a8-f7a5-cf97-5c03-c0c2c329f38a@suse.de>

On 01/18/2017 02:20 AM, James Smart wrote:
> 
> NVME Initiator: Base modifications
> 
> This is part C of parts A..F.
> 
> Part C is the 1st half of the mods to lpfc_init.c. This is the location
> of most of changes for the following:
> - sli3 ring vs sli4 wq splits
> - buffer pools are allocated/freed
> - sgl pools allocated/freed
> - adapter resources split up
> - queue config decided and enacted
> - receive buffer management
> 
> *********
> 
> Refer to Part A for a description of base modifications
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
[ .. ]
> @@ -3315,16 +3421,121 @@ lpfc_sli4_xri_sgl_update(struct lpfc_hba *phba)
[ .. ]
> +	if (phba->sli4_hba.nvme_xri_cnt > phba->sli4_hba.nvme_xri_max) {
> +		/* max nvme xri shrunk below the allocated nvme buffers */
> +		nvme_xri_cnt = phba->sli4_hba.nvme_xri_cnt -
> +					phba->sli4_hba.nvme_xri_max;
> +		/* release the extra allocated nvme buffers */
> +		for (i = 0; i < nvme_xri_cnt; i++) {
> +			list_remove_head(&nvme_sgl_list, lpfc_ncmd,
> +					 struct lpfc_nvme_buf, list);
> +			if (lpfc_ncmd) {
> +				pci_pool_free(phba->lpfc_sg_dma_buf_pool,
> +					      lpfc_ncmd->data,
> +					      lpfc_ncmd->dma_handle);
> +				kfree(lpfc_ncmd);
> +			}
> +		}
> +		spin_lock_irq(&phba->nvme_buf_list_get_lock);
> +		phba->sli4_hba.nvme_xri_cnt -= nvme_xri_cnt;
> +		spin_unlock_irq(&phba->nvme_buf_list_get_lock);
> +	}
> +
Unsafe.
'nvme_xri_cnt' is updated under the lock, but not tested with the lock
held. Please fix.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
