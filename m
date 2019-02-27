From: kbusch@kernel.org (Keith Busch)
Date: Wed, 27 Feb 2019 08:37:10 -0700
Subject: [PATCH] NVMe-CLI WDC Plugin - add support for additional SN840
 device ID.
In-Reply-To: <1551281379-27317-1-git-send-email-jeff.lien@wdc.com>
References: <1551281379-27317-1-git-send-email-jeff.lien@wdc.com>
Message-ID: <20190227153709.GA19455@localhost.localdomain>

On Wed, Feb 27, 2019@03:29:53PM +0000, Jeffrey Lien wrote:
> Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
> ---
>  plugins/wdc/wdc-nvme.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
> index ba4d419..b131b1a 100644
> --- a/plugins/wdc/wdc-nvme.c
> +++ b/plugins/wdc/wdc-nvme.c
> @@ -61,6 +61,7 @@
>  #define WDC_NVME_SN630_DEV_ID				0x2200
>  #define WDC_NVME_SN630_DEV_ID_1				0x2201
>  #define WDC_NVME_SN840_DEV_ID				0x2300
> ++#define WDC_NVME_SN840_DEV_ID_1			0x2500

You've got a stray '+' there, but I fixed it up.
