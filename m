From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 25 Apr 2019 01:00:46 +0000
Subject: [PATCH 1/3] drivers: nvme: target: core: fix build break
References: <1556102081-11820-1-git-send-email-info@metux.net>
 <1556102081-11820-2-git-send-email-info@metux.net>
Message-ID: <SN6PR04MB452772B2864B2074DDB018ED863D0@SN6PR04MB4527.namprd04.prod.outlook.com>

Thanks for the fix Enrico. I'm still wondering on what platform
you got this error ?

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 04/24/2019 03:35 AM, Enrico Weigelt, metux IT consult wrote:
> Build breaks:
>
>      drivers/nvme/target/core.c: In function 'nvmet_req_alloc_sgl':
>      drivers/nvme/target/core.c:939:12: error: implicit declaration of \
> function 'sgl_alloc'; did you mean 'bio_alloc'? \
> [-Werror=implicit-function-declaration]
>        req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
>                  ^~~~~~~~~
>                  bio_alloc
>      drivers/nvme/target/core.c:939:10: warning: assignment makes pointer \
> from integer without a cast [-Wint-conversion]
>        req->sg = sgl_alloc(req->transfer_len, GFP_KERNEL, &req->sg_cnt);
>                ^
>      drivers/nvme/target/core.c: In function 'nvmet_req_free_sgl':
>      drivers/nvme/target/core.c:952:3: error: implicit declaration of \
> function 'sgl_free'; did you mean 'ida_free'? [-Werror=implicit-function-declaration]
>         sgl_free(req->sg);
>         ^~~~~~~~
>         ida_free
>
> Cause:
>
>      1. missing include to <linux/scatterlist.h>
>      2. SGL_ALLOC needs to be enabled
>
> Therefore adding the missing include, as well as Kconfig dependency.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info at metux.net>
> ---
>   drivers/nvme/target/Kconfig | 1 +
>   drivers/nvme/target/core.c  | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
> index d94f25c..3ef0a4e 100644
> --- a/drivers/nvme/target/Kconfig
> +++ b/drivers/nvme/target/Kconfig
> @@ -3,6 +3,7 @@ config NVME_TARGET
>   	tristate "NVMe Target support"
>   	depends on BLOCK
>   	depends on CONFIGFS_FS
> +	select SGL_ALLOC
>   	help
>   	  This enabled target side support for the NVMe protocol, that is
>   	  it allows the Linux kernel to implement NVMe subsystems and
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index b3e765a..08851f5 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -8,6 +8,7 @@
>   #include <linux/random.h>
>   #include <linux/rculist.h>
>   #include <linux/pci-p2pdma.h>
> +#include <linux/scatterlist.h>
>
>   #include "nvmet.h"
>
>
