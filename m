From: james.smart@broadcom.com (James Smart)
Date: Mon, 11 Feb 2019 11:19:51 -0800
Subject: [PATCH] scsi: lpfc: fix calls to dma_set_mask_and_coherent()
In-Reply-To: <20190211150502.9999-1-emilne@redhat.com>
References: <20190211150502.9999-1-emilne@redhat.com>
Message-ID: <313fc267-4954-76ef-2102-f15da7ddad36@broadcom.com>

On 2/11/2019 7:05 AM, Ewan D. Milne wrote:
> The change to use dma_set_mask_and_coherent() incorrectly made a second
> call with the 32 bit DMA mask value when the call with the 64 bit DMA
> mask value succeeded.  This resulted in NVMe/FC connections failing due
> to corrupted data buffers, and various other SCSI/FCP I/O errors.
>
> Fixes: f30e1bfd6154 ("scsi: lpfc: use dma_set_mask_and_coherent")
> Cc: <stable at vger.kernel.org>
> Suggested-by: Don Dutile <ddutile at redhat.com>
> Signed-off-by: Ewan D. Milne <emilne at redhat.com>
> ---
>   drivers/scsi/lpfc/lpfc_init.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index bede11e..60c178d 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -7367,9 +7367,9 @@ struct lpfc_rpi_hdr *
>   		return error;
>   
>   	/* Set the device DMA mask size */
> -	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) ||
> -	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))
> -		return error;
> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) != 0)
> +		if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0)
> +			return error;
>   
>   	/* Get the bus address of Bar0 and Bar2 and the number of bytes
>   	 * required by each mapping.
> @@ -9745,9 +9745,9 @@ struct lpfc_cq_event *
>   		return error;
>   
>   	/* Set the device DMA mask size */
> -	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) ||
> -	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))
> -		return error;
> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) != 0)
> +		if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0)
> +			return error;
>   
>   	/*
>   	 * The BARs and register set definitions and offset locations are

Thanks Ewan.


Signed-off-by:? James Smart? <james.smart at broadcom.com>

-- james
