From: m@bjorling.me (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Tue, 9 Feb 2016 13:46:37 +0100
Subject: [PATCH 1/4] nvme: move timeout variables to core.c and export it
In-Reply-To: <1454970284-29543-2-git-send-email-mlin@kernel.org>
References: <1454970284-29543-1-git-send-email-mlin@kernel.org>
 <1454970284-29543-2-git-send-email-mlin@kernel.org>
Message-ID: <56B9DFAD.10809@bjorling.me>

On 02/08/2016 11:24 PM, Ming Lin wrote:
> Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
> ---
>  drivers/nvme/host/core.c | 14 ++++++++++++++
>  drivers/nvme/host/pci.c  | 12 ------------
>  2 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c5bf001..3faed20 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -33,6 +33,20 @@
>  
>  #define NVME_MINORS		(1U << MINORBITS)
>  
> +unsigned char admin_timeout = 60;
> +module_param(admin_timeout, byte, 0644);
> +MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
> +EXPORT_SYMBOL_GPL(admin_timeout);
> +
> +unsigned char nvme_io_timeout = 30;
> +module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
> +MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
> +EXPORT_SYMBOL_GPL(nvme_io_timeout);


Can these be exported without _GPL? There might be a couple of drivers
out of tree which would like to access these variables.
