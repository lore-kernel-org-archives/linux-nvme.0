From: jon.mason@intel.com (Jon Mason)
Date: Wed, 2 Oct 2013 17:48:05 -0700
Subject: [PATCH RFC 54/77] ntb: Ensure number of MSIs on SNB is enough
 for the link interrupt
In-Reply-To: <5d9c5b2d3bbc444ff32bddeece7a239d046bd79c.1380703263.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <5d9c5b2d3bbc444ff32bddeece7a239d046bd79c.1380703263.git.agordeev@redhat.com>
Message-ID: <20131003004805.GL6768@jonmason-lab>

On Wed, Oct 02, 2013@12:49:10PM +0200, Alexander Gordeev wrote:
> Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
> ---
>  drivers/ntb/ntb_hw.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_hw.c b/drivers/ntb/ntb_hw.c
> index de2062c..eccd5e5 100644
> --- a/drivers/ntb/ntb_hw.c
> +++ b/drivers/ntb/ntb_hw.c
> @@ -1066,7 +1066,7 @@ static int ntb_setup_msix(struct ntb_device *ndev)
>  		/* On SNB, the link interrupt is always tied to 4th vector.  If
>  		 * we can't get all 4, then we can't use MSI-X.
>  		 */
> -		if (ndev->hw_type != BWD_HW) {
> +		if ((rc < SNB_MSIX_CNT) && (ndev->hw_type != BWD_HW)) {

Nack, this check is unnecessary.

Also, no comment in the commit on why it could be necessary.


>  			rc = -EIO;
>  			goto err1;
>  		}
> -- 
> 1.7.7.6
> 
