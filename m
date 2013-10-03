From: jon.mason@intel.com (Jon Mason)
Date: Wed, 2 Oct 2013 17:49:28 -0700
Subject: [PATCH RFC 53/77] ntb: Fix missed call to pci_enable_msix()
In-Reply-To: <0590d63c3432229a3824bada71e07a08fb955498.1380703263.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <0590d63c3432229a3824bada71e07a08fb955498.1380703263.git.agordeev@redhat.com>
Message-ID: <20131003004928.GM6768@jonmason-lab>

On Wed, Oct 02, 2013@12:49:09PM +0200, Alexander Gordeev wrote:
> Current MSI-X enablement code assumes MSI-Xs were successfully
> allocated in case less than requested vectors were available.
> That assumption is wrong, since MSI-Xs should be enabled with
> a repeated call to pci_enable_msix(). This update fixes this.

Good catch, I'll pull it in for my next NTB release.

Thanks,
Jon

> 
> Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
> ---
>  drivers/ntb/ntb_hw.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_hw.c b/drivers/ntb/ntb_hw.c
> index 1cb6e51..de2062c 100644
> --- a/drivers/ntb/ntb_hw.c
> +++ b/drivers/ntb/ntb_hw.c
> @@ -1075,6 +1075,10 @@ static int ntb_setup_msix(struct ntb_device *ndev)
>  			 "Only %d MSI-X vectors.  Limiting the number of queues to that number.\n",
>  			 rc);
>  		msix_entries = rc;
> +
> +		rc = pci_enable_msix(pdev, ndev->msix_entries, msix_entries);
> +		if (rc)
> +			goto err1;
>  	}
>  
>  	for (i = 0; i < msix_entries; i++) {
> -- 
> 1.7.7.6
> 
