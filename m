From: brking@linux.vnet.ibm.com (Brian King)
Date: Wed, 02 Oct 2013 14:31:25 -0500
Subject: [PATCH RFC 36/77] ipr: Enable MSI-X when IPR_USE_MSIX type is
 set, not IPR_USE_MSI
In-Reply-To: <2d4272136269f3cb3b1a5ac53b12aa45c7ea65c0.1380703263.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <2d4272136269f3cb3b1a5ac53b12aa45c7ea65c0.1380703263.git.agordeev@redhat.com>
Message-ID: <524C748D.8080803@linux.vnet.ibm.com>

On 10/02/2013 05:48 AM, Alexander Gordeev wrote:
> Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
> ---
>  drivers/scsi/ipr.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
> index fb57e21..762a93e 100644
> --- a/drivers/scsi/ipr.c
> +++ b/drivers/scsi/ipr.c
> @@ -9527,7 +9527,7 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
>  		ipr_number_of_msix = IPR_MAX_MSIX_VECTORS;
>  	}
> 
> -	if (ioa_cfg->ipr_chip->intr_type == IPR_USE_MSI &&
> +	if (ioa_cfg->ipr_chip->intr_type == IPR_USE_MSIX &&
>  			ipr_enable_msix(ioa_cfg) == 0)
>  		ioa_cfg->intr_flag = IPR_USE_MSIX;
>  	else if (ioa_cfg->ipr_chip->intr_type == IPR_USE_MSI &&
> 

Nack. ioa_cfg->ipr_chip->intr_type gets initialized from the ipr_chip table
at the top of the driver which never sets intr_type to IPR_USE_MSIX, so this
will break MSI-X support for ipr. 

We indicate at the chip level only whether we want to force LSI or whether
we want to enable MSI / MSI-X and then try enabling MSI-X and fall back to
MSI if MSI-X is not available or does not work. We then set intr_flag to indicate
what we are actually using on the specific adapter.

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
