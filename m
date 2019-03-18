From: kbusch@kernel.org (Keith Busch)
Date: Mon, 18 Mar 2019 09:29:24 -0600
Subject: [PATCH] [NVMe-CLI] WDC Plugins vs-internal-log command
 unsupported on SN340.
In-Reply-To: <1552922711-1364-1-git-send-email-jeff.lien@wdc.com>
References: <1552922711-1364-1-git-send-email-jeff.lien@wdc.com>
Message-ID: <20190318152923.GA23533@localhost.localdomain>

Applied, thanks.

On Mon, Mar 18, 2019@03:25:27PM +0000, Jeffrey Lien wrote:
> Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
> ---
>  plugins/wdc/wdc-nvme.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
> index 5da8587..984154e 100644
> --- a/plugins/wdc/wdc-nvme.c
> +++ b/plugins/wdc/wdc-nvme.c
> @@ -792,6 +792,7 @@ static __u64 wdc_get_drive_capabilities(int fd) {
>  			break;
>  		case WDC_NVME_SN340_DEV_ID:
>  			capabilities = WDC_DRIVE_CAP_SN340_DUI;
> +			break;
>  		default:
>  			capabilities = 0;
>  		}
> -- 
> 1.8.3.1
