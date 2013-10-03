From: jon.mason@intel.com (Jon Mason)
Date: Wed, 2 Oct 2013 17:29:42 -0700
Subject: [PATCH RFC 77/77] vxge: Update MSI/MSI-X interrupts enablement
 code
In-Reply-To: <467ce10b1df795edf80ed222816ab739fee7b0ea.1380703263.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <467ce10b1df795edf80ed222816ab739fee7b0ea.1380703263.git.agordeev@redhat.com>
Message-ID: <20131003002941.GJ6768@jonmason-lab>

On Wed, Oct 02, 2013@12:49:33PM +0200, Alexander Gordeev wrote:
> As result of recent re-design of the MSI/MSI-X interrupts enabling
> pattern this driver has to be updated to use the new technique to
> obtain a optimal number of MSI/MSI-X interrupts required.
> 
> Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
> ---
>  drivers/net/ethernet/neterion/vxge/vxge-main.c |   36 ++++++++++-------------
>  1 files changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/neterion/vxge/vxge-main.c b/drivers/net/ethernet/neterion/vxge/vxge-main.c
> index b81ff8b..b4d40dd 100644
> --- a/drivers/net/ethernet/neterion/vxge/vxge-main.c
> +++ b/drivers/net/ethernet/neterion/vxge/vxge-main.c
> @@ -2297,7 +2297,21 @@ static int vxge_alloc_msix(struct vxgedev *vdev)
>  	int msix_intr_vect = 0, temp;
>  	vdev->intr_cnt = 0;
>  
> -start:
> +	ret = pci_msix_table_size(vdev->pdev);
> +	if (ret < 0)
> +		goto alloc_entries_failed;
> +
> +	if (ret < (vdev->no_of_vpath * 2 + 1)) {
> +		if ((max_config_vpath != VXGE_USE_DEFAULT) || (ret < 3)) {
> +			ret = -ENOSPC;
> +			goto alloc_entries_failed;
> +		}
> +		/* Try with less no of vector by reducing no of vpaths count */
> +		temp = (ret - 1)/2;
> +		vxge_close_vpaths(vdev, temp);
> +		vdev->no_of_vpath = temp;
> +	}

The original code was ugly (not my code, so I can say that).  I'd like
to see it a little stream lined.  Something like:


        vdev->intr_cnt = pci_msix_table_size(vdev->pdev);

        if (vdev->intr_cnt % 2 == 0)
                vdev->intr_cnt--;

        if (vdev->intr_cnt < 3 || max_config_vpath != VXGE_USE_DEFAULT)
                goto alloc_entries_failed;

        if (vdev->intr_cnt != vdev->no_of_vpath * 2 + 1) {
                vxge_close_vpaths(vdev, vdev->intr_cnt / 2);
                vdev->no_of_vpath = vdev->intr_cnt / 2;
        }


> +
>  	/* Tx/Rx MSIX Vectors count */
>  	vdev->intr_cnt = vdev->no_of_vpath * 2;
>  
> @@ -2347,25 +2361,7 @@ start:
>  	vdev->vxge_entries[j].in_use = 0;
>  
>  	ret = pci_enable_msix(vdev->pdev, vdev->entries, vdev->intr_cnt);
> -	if (ret > 0) {
> -		vxge_debug_init(VXGE_ERR,
> -			"%s: MSI-X enable failed for %d vectors, ret: %d",
> -			VXGE_DRIVER_NAME, vdev->intr_cnt, ret);
> -		if ((max_config_vpath != VXGE_USE_DEFAULT) || (ret < 3)) {
> -			ret = -ENOSPC;
> -			goto enable_msix_failed;
> -		}
> -
> -		kfree(vdev->entries);
> -		kfree(vdev->vxge_entries);
> -		vdev->entries = NULL;
> -		vdev->vxge_entries = NULL;
> -		/* Try with less no of vector by reducing no of vpaths count */
> -		temp = (ret - 1)/2;
> -		vxge_close_vpaths(vdev, temp);
> -		vdev->no_of_vpath = temp;
> -		goto start;
> -	} else if (ret < 0)
> +	if (ret)
>  		goto enable_msix_failed;

Nit, space here please.

>  	return 0;
>  
> -- 
> 1.7.7.6
> 
