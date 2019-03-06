From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 6 Mar 2019 19:51:53 +0000
Subject: [PATCH] drivers: nvme: Kconfig: pedantic cleanups
References: <1551897030-2219-1-git-send-email-info@metux.net>
Message-ID: <SN6PR04MB4527FD956498AD3A5959470C86730@SN6PR04MB4527.namprd04.prod.outlook.com>

On 3/6/19 10:31 AM, Enrico Weigelt, metux IT consult wrote:
> Signed-off-by: Enrico Weigelt, metux IT consult <info at metux.net>
> ---
>   drivers/nvme/host/Kconfig | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 0f345e2..ce361c9 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -17,10 +17,10 @@ config NVME_MULTIPATH
>   	bool "NVMe multipath support"
>   	depends on NVME_CORE
>   	---help---
> -	   This option enables support for multipath access to NVMe
> -	   subsystems.  If this option is enabled only a single
> -	   /dev/nvmeXnY device will show up for each NVMe namespaces,
> -	   even if it is accessible through multiple controllers.
> +	  This option enables support for multipath access to NVMe
> +	  subsystems.  If this option is enabled only a single
> +	  /dev/nvmeXnY device will show up for each NVMe namespaces,
> +	  even if it is accessible through multiple controllers.
>   
>   config NVME_FABRICS
>   	tristate
> 


Alignment looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
